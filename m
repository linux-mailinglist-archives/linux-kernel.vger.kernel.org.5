Return-Path: <linux-kernel+bounces-84791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2786AB9D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456F81F25978
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD57236124;
	Wed, 28 Feb 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrqIcg5H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C23339A8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113747; cv=none; b=b1k3qBjnFLxo84IHg/qdsIJNn8geE7NEhI4FLDwCfCWY3mrdpahzKqiRUAZws6mwzi22iFU/stTd0r1/GcpG8WVl85IUVcNevgWQFPf3Z4AS72F9sx1rckQl4UCscOTQ8xx6eA84As0Oa0g+cfa0STjfbE9sv3F6wsYXgmeYibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113747; c=relaxed/simple;
	bh=T0t86oQFgwU/6D1sA6cnsYfETMP6oTB26tdCLT9+p1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex84iFAhX4vCgceOTB9mhIKMI9iNK2gzyW1GchPj0DrcIBnlsNnY20GT8xEQPw5jIIc3lAYeDLIe3igRa6sFz1Xmo0Vs+QI+MyA3HgONEFk33qhxm00NZTaEQ0ZBabHfIIMQj0r+UUQ2NGCNzZEF1vLmMg+51HV1RlV4xBGS2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrqIcg5H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709113744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9nKpbWD7PWIAQiSbFlkEAYQLu3pKz1NjuSMp1lPSzag=;
	b=HrqIcg5HvGU9FxoDo/vvgQdhqnB1Dy1TWPt/MHlqI9hY8X7GugutWqXzv9WdNUuJc6JTcJ
	ugbd/WItN+OWfQFQb65yEZlozaqMH6Op6C0UvkKvblefVpygGeImC3eQxSh4zj57Wg1bGn
	nakGzHBdRg3xBD45u5HxHrRqjaSJgZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-mWLz3zXTNHWMHRhsrmaIeQ-1; Wed, 28 Feb 2024 04:48:58 -0500
X-MC-Unique: mWLz3zXTNHWMHRhsrmaIeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0B0D185A780;
	Wed, 28 Feb 2024 09:48:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6A82166B33;
	Wed, 28 Feb 2024 09:48:56 +0000 (UTC)
Date: Wed, 28 Feb 2024 17:48:53 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <Zd8BhUsh8sggG/RH@MiWiFi-R3L-srv>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-8-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 01/02/24 at 07:46pm, Uladzislau Rezki (Sony) wrote:
....snip...
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

This isn't true if the pool has less than 4 objects. If there are 3
objects, n_decay = 0.

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

                               Here, --n_decay will make n_decay 0xffffffffffffffff,
                               then all left objects are reclaimed.
> +			}
> +		}
> +
> +		/* Attach the pool back if it has been partly decayed. */
> +		if (!full_decay && !list_empty(&tmp_list)) {
> +			spin_lock(&vn->pool_lock);
> +			list_replace_init(&tmp_list, &vn->pool[i].head);
> +			spin_unlock(&vn->pool_lock);
> +		}
> +	}
> +
> +	reclaim_list_global(&decay_list);
> +}
.....snip


