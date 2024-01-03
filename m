Return-Path: <linux-kernel+bounces-15426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AAD822BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3493A1F23F42
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB818E10;
	Wed,  3 Jan 2024 11:09:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065A18E07
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.3])
	by sina.com (172.16.235.25) with ESMTP
	id 6595403A000027EE; Wed, 3 Jan 2024 19:08:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 63296334210320
X-SMAIL-UIID: 439AB0640BED4853B1F70BFA8D665C00-20240103-190844-1
From: Hillf Danton <hdanton@sina.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Date: Wed,  3 Jan 2024 19:08:32 +0800
Message-Id: <20240103110832.2711-1-hdanton@sina.com>
In-Reply-To: <20240102184633.748113-8-urezki@gmail.com>
References: <20240102184633.748113-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  2 Jan 2024 19:46:29 +0100 Uladzislau Rezki <urezki@gmail.com>
> +static void
> +decay_va_pool_node(struct vmap_node *vn, bool full_decay)
> +{
> +	struct vmap_area *va, *nva;
> +	struct list_head decay_list;
> +	struct rb_root decay_root;
> +	unsigned long n_decay;
> +	int i;
> +
> +	decay_root = RB_ROOT;
> +	INIT_LIST_HEAD(&decay_list);
> +
> +	for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
> +		struct list_head tmp_list;
> +
> +		if (list_empty(&vn->pool[i].head))
> +			continue;
> +
> +		INIT_LIST_HEAD(&tmp_list);
> +
> +		/* Detach the pool, so no-one can access it. */
> +		spin_lock(&vn->pool_lock);
> +		list_replace_init(&vn->pool[i].head, &tmp_list);
> +		spin_unlock(&vn->pool_lock);
> +
> +		if (full_decay)
> +			WRITE_ONCE(vn->pool[i].len, 0);
> +
> +		/* Decay a pool by ~25% out of left objects. */
> +		n_decay = vn->pool[i].len >> 2;
> +
> +		list_for_each_entry_safe(va, nva, &tmp_list, list) {
> +			list_del_init(&va->list);
> +			merge_or_add_vmap_area(va, &decay_root, &decay_list);
> +
> +			if (!full_decay) {
> +				WRITE_ONCE(vn->pool[i].len, vn->pool[i].len - 1);
> +
> +				if (!--n_decay)
> +					break;
> +			}
> +		}
> +
> +		/* Attach the pool back if it has been partly decayed. */
> +		if (!full_decay && !list_empty(&tmp_list)) {
> +			spin_lock(&vn->pool_lock);
> +			list_replace_init(&tmp_list, &vn->pool[i].head);
> +			spin_unlock(&vn->pool_lock);
> +		}

Failure of working out why list_splice() was not used here in case of
non-empty vn->pool[i].head, after staring ten minutes.
> +	}
> +
> +	reclaim_list_global(&decay_list);
> +}

