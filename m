Return-Path: <linux-kernel+bounces-132603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6E89971E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8CA1F21267
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A8D143888;
	Fri,  5 Apr 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoiavdWd"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC751428F8;
	Fri,  5 Apr 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303774; cv=none; b=eBSV1Pt+hyW3QwpQedV48R2ngdcru2tiB1r71+CnnZMGCfclzLfKtVYDolVr947ODWByCQwppSTnUDBxhMZdMDPHiOW8KBP5Q76wnt22RRXtOAAXp0UbMpUYf/6TL/vllhxCz8xNz5xAx6K3Ddas/EbEu0AAXzWRj3H17Vzpbyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303774; c=relaxed/simple;
	bh=5FR0ML8gIms8SXMu9qd0IXl0ZXkR1/9EGEn2Gx9HkT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Huh/gpxOcrb9V0oFPylrOm4ou9oqSEj8KUF0w1Odn8bQPvviIq9rZSRne0wm8mnDAN624b736twIKP3D5YsdMF3IS6Tc9+HN+qyB52wG1bPpJ7Qtm2G5C2cC7B4F+PYJZ+j4qszhBwdi5jxsspSNjqlNCiJhB1sufpiHKbebN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoiavdWd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso1420910a12.2;
        Fri, 05 Apr 2024 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712303772; x=1712908572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzVlWt4l7qxR/k/EhWDwFrSslFncuI6KSbSzKFf8xEw=;
        b=GoiavdWdYnmZFK1pWIURcuvw3fbxXZUuj+HqYnjDckH8vVZPSYSzXX8KxPD7kO0Emv
         L8kudC2ynot/y9wvJ5AaJAomB3XTJlOibmVqDi/vvKzxnipzbS9SqFDxS1qKY2vhsC/U
         3pYsJp9WPL0mRp3j2WBJ964LU25Hd/nSaGyhljf0mNuitIk0D6uHyw3rmnzXxE08eAxq
         gGsLaSpgKILgcj/gfADWb9A10mPWHoUdQPYxUNtObjiqeiKy1XX6d288t5fuU6/0NGoM
         oYC3McmdOL1xm7j0Ty5vogsUn3tHcHr+qFrGlQqvbFS0moKe3uZ6A7ChzHWgYR1ztBMe
         AMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712303772; x=1712908572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzVlWt4l7qxR/k/EhWDwFrSslFncuI6KSbSzKFf8xEw=;
        b=M8QKcnOWgUHDgxKzS4joQHVlJQt8MLj5J7fBuvsaMMRzxOke81N7xmMHT66JN+ES42
         WDU+DY2oz1GSAOOdlT6n3JxxOSd+744787lKwkqNhVRY5DHYioo8AouDQbgSmvit/6nu
         6jP/0SXU7ZQlz754+kcqv20nSCEGDG5eoykbjQMatklG8Wlku7/Nn5yh2XF3jzMEDAZa
         iYm/ME/o/9Hs6WOLXCrcUhNfxGSRQfBaAi0YZC7fPmfjQfdp7n5hgH7Yi/fn8PV0vGNm
         hP5qKey54mp2WzZNCu2jR2melZe+tWDyeEMOI9gybBqIy/rS8pQQVIP9ouN7VYjWM2SX
         kzcA==
X-Forwarded-Encrypted: i=1; AJvYcCW9YH++kKv6TnDhtq8GUOvu2WSmCYY8oxDNTnjNDENbfxxmKEaxVKCfKSQa4Y/fBqKL1eNRP3VjhWK5DgkdmY7AkhhdbMdB2eV78e7XYyVCICRHTsylxjDybCjR/wv72/2MgeoyDLVo/eEIoIALW6vw
X-Gm-Message-State: AOJu0YxESyqS9O/BQjSZLODbdT6CA6TdPVnKelcOI0pKD2WcBTLeWbay
	joZLdhjm08+n9+GsQmKInvv2Or4tMiAtuUonKh5ZVs2DR28QQQsP
X-Google-Smtp-Source: AGHT+IFRQC5Hl1XNJ8UHTusIXnKpuWVMqInH6NDdemHxy91rJUVQyZ1BvHxguN/C539fHznDlLcS0A==
X-Received: by 2002:a17:90a:e00f:b0:2a2:5876:5a74 with SMTP id u15-20020a17090ae00f00b002a258765a74mr666360pjy.25.1712303771654;
        Fri, 05 Apr 2024 00:56:11 -0700 (PDT)
Received: from hyeongtakPC.. ([147.46.174.104])
        by smtp.googlemail.com with ESMTPSA id ce17-20020a17090aff1100b002a2d4bf345bsm2539161pjb.55.2024.04.05.00.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:56:10 -0700 (PDT)
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Fri,  5 Apr 2024 16:55:57 +0900
Message-Id: <20240405075557.464190-1-hyeongtak.ji@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405060858.2818-6-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

..snip...

> +static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
> +					    enum migration_mode mm,
> +					    int target_nid)
> +{
> +	int nid;
> +	unsigned int nr_migrated = 0;
> +	LIST_HEAD(node_folio_list);
> +	unsigned int noreclaim_flag;
> +
> +	if (list_empty(folio_list))
> +		return nr_migrated;

How about checking if `target_nid` is `NUMA_NO_NODE` or not earlier,

> +
> +	noreclaim_flag = memalloc_noreclaim_save();
> +
> +	nid = folio_nid(lru_to_folio(folio_list));
> +	do {
> +		struct folio *folio = lru_to_folio(folio_list);
> +
> +		if (nid == folio_nid(folio)) {
> +			folio_clear_active(folio);
> +			list_move(&folio->lru, &node_folio_list);
> +			continue;
> +		}
> +
> +		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> +							   NODE_DATA(nid), mm,
> +							   target_nid);
> +		nid = folio_nid(lru_to_folio(folio_list));
> +	} while (!list_empty(folio_list));
> +
> +	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> +						   NODE_DATA(nid), mm,
> +						   target_nid);
> +
> +	memalloc_noreclaim_restore(noreclaim_flag);
> +
> +	return nr_migrated;
> +}
> +

..snip...

> +static unsigned int migrate_folio_list(struct list_head *migrate_folios,
> +				       struct pglist_data *pgdat,
> +				       int target_nid)
> +{
> +	unsigned int nr_succeeded;
> +	nodemask_t allowed_mask = NODE_MASK_NONE;
> +
> +	struct migration_target_control mtc = {
> +		/*
> +		 * Allocate from 'node', or fail quickly and quietly.
> +		 * When this happens, 'page' will likely just be discarded
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid = target_nid,
> +		.nmask = &allowed_mask
> +	};
> +
> +	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
> +		return 0;

instead of here.

> +
> +	if (list_empty(migrate_folios))
> +		return 0;
> +
> +	/* Migration ignores all cpuset and mempolicy settings */
> +	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
> +		      &nr_succeeded);
> +
> +	return nr_succeeded;
> +}
> +

..snip...

Kind regards,
Hyeongtak

