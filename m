Return-Path: <linux-kernel+bounces-110574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 907098860CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0235B22339
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1113398E;
	Thu, 21 Mar 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="gJQM4XnZ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFA15CB5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047490; cv=none; b=TUnxOeX+4yX5ziwJps4DGdVSCWxnwcHMcjoXit+YRw46lUZUzCW/oEgX3Xg+v3UaWcX1+Qfu3CV5RLykd7tmSwjDOSv4Y2HO1qLfA8cWJ7wE2gg6v3iXWvDHp9qqJCV4Tx3SJyI3P0+sNM43Gh5i1c/4uqkgUGTSZkubMvtA/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047490; c=relaxed/simple;
	bh=wfl5BO/287jsyabQVYApJwdvqbKhOKhf+US7q+/8nks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byi/jlWDeTgebMDvACuDdg2rovK7ITeIYEqN5d5e0UBrluC+Xsc/T4lab+C214noNCd2jbMuBLFl6fykjIJDiXywMh2W9D682sgTtlUgER5mRnD2M+J3MUUDMWzD52dZraM+G6+Lcik+Tt6XBBaqcEvQNl3ygWasXBx5QsuV+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=gJQM4XnZ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-789f3bbe3d6so97318485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711047486; x=1711652286; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j1RSbdCHe2fKV0Yk4hs6rwghyLM721fWE3T8qG0MI14=;
        b=gJQM4XnZEwwfw+sQPQAjtEgJza4iGs9UnIrxjCDU59h0M3lpmUwdldRtZOkoFbDHEe
         8jtfEejrDyQeyZOivZA3GrpwQmrZNUuxk+zZzSHW1ujclCCuIznztpyNRU6hdexSbzHA
         qPHZ5i153Sg6sgW4ynwimfDELJDiW7qbHe2yiREiM4tCKb6tKY19X2+ZxGdHCoXVJRkW
         sQFOUgjras3c1rSk5oIXV7QJPO+GXxTsX+uEpdNXc5FpStZXmW2TXVCL2Ngor3kIfPil
         TJW7hs4+ik1z0lvRE9sHDzbLFZfZRSJxXuGycK3uzBflGEeK1VhgmpGCh7+npznmSVzD
         SWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711047486; x=1711652286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1RSbdCHe2fKV0Yk4hs6rwghyLM721fWE3T8qG0MI14=;
        b=Vk2KnpXs2dMSH7eukTpe9v+raOjXr2voftIbwhFxTmnkMlj26BwRulQG7iVFvF9AhE
         /CvjVFexW+9Tizv7H/AbcaglTD6LBVAu+rAftTwVXtJMjxK/wCzki/2CMCwPSNf/smz/
         72rsuU1rCbPppWlG6PpLlPYh532y1Yx/T6el17TodkUmd3YHEZFrlbYaaQ3wAp2HqRL6
         ZLRaVjAaKscXh1EO14le3c4VVZvmtSGJnGA2Z7f80uDvM/qM2EajLO17IneeCBVyBaKk
         1CQgeXuokBGzmuccw8wNRP08cudHhhxw4TRzdae+2L2sR6DTt8kt4x0bZjjzjwjWpvgu
         nURA==
X-Forwarded-Encrypted: i=1; AJvYcCXyKXhQRdgQFGMDi61rFzK15UZbESnrjBsDj+XPPctz9Kp43UXm4PwMclK/ep7lIStDUw5j/qwXHdr6Jx3k1EPudBoepWKSu87cUzcZ
X-Gm-Message-State: AOJu0Yyclv/GTOjRbxMxMhGjRBWEqkIE++fkZOiFERwdxROWhSVvNxVH
	ZfZq/53tZOL28mER36ZTZ1UXm8ge+RSGZotRIf/dvbBYyY2sel8KULEvZUX23tY=
X-Google-Smtp-Source: AGHT+IHaqKnPjbeF9DkE8OAIMrQn/yg3h/qvNhnVka/p03SEAhYE5s3kETq0WcRaXPXz6KfiExc3Vg==
X-Received: by 2002:a05:620a:990:b0:789:d140:5ab7 with SMTP id x16-20020a05620a099000b00789d1405ab7mr65798qkx.11.1711047485844;
        Thu, 21 Mar 2024 11:58:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:6036])
        by smtp.gmail.com with ESMTPSA id a6-20020a05620a102600b00789e2961225sm145765qkk.61.2024.03.21.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:58:05 -0700 (PDT)
Date: Thu, 21 Mar 2024 14:58:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?B?Suly9G1l?= Poulin <jeromepoulin@gmail.com>
Subject: Re: [PATCH] mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS
 recursion
Message-ID: <20240321185804.GA3154@cmpxchg.org>
References: <20240321182532.60000-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240321182532.60000-1-hannes@cmpxchg.org>

On Thu, Mar 21, 2024 at 02:25:32PM -0400, Johannes Weiner wrote:
> Kent forwards this bug report of zswap re-entering the block layer
> from an IO request allocation and locking up:
> 
> [10264.128242] sysrq: Show Blocked State
> [10264.128268] task:kworker/20:0H   state:D stack:0     pid:143   tgid:143   ppid:2      flags:0x00004000
> [10264.128271] Workqueue: bcachefs_io btree_write_submit [bcachefs]
> [10264.128295] Call Trace:
> [10264.128295]  <TASK>
> [10264.128297]  __schedule+0x3e6/0x1520
> [10264.128303]  schedule+0x32/0xd0
> [10264.128304]  schedule_timeout+0x98/0x160
> [10264.128308]  io_schedule_timeout+0x50/0x80
> [10264.128309]  wait_for_completion_io_timeout+0x7f/0x180
> [10264.128310]  submit_bio_wait+0x78/0xb0
> [10264.128313]  swap_writepage_bdev_sync+0xf6/0x150
> [10264.128317]  zswap_writeback_entry+0xf2/0x180
> [10264.128319]  shrink_memcg_cb+0xe7/0x2f0
> [10264.128322]  __list_lru_walk_one+0xb9/0x1d0
> [10264.128325]  list_lru_walk_one+0x5d/0x90
> [10264.128326]  zswap_shrinker_scan+0xc4/0x130
> [10264.128327]  do_shrink_slab+0x13f/0x360
> [10264.128328]  shrink_slab+0x28e/0x3c0
> [10264.128329]  shrink_one+0x123/0x1b0
> [10264.128331]  shrink_node+0x97e/0xbc0
> [10264.128332]  do_try_to_free_pages+0xe7/0x5b0
> [10264.128333]  try_to_free_pages+0xe1/0x200
> [10264.128334]  __alloc_pages_slowpath.constprop.0+0x343/0xde0
> [10264.128337]  __alloc_pages+0x32d/0x350
> [10264.128338]  allocate_slab+0x400/0x460
> [10264.128339]  ___slab_alloc+0x40d/0xa40
> [10264.128345]  kmem_cache_alloc+0x2e7/0x330
> [10264.128348]  mempool_alloc+0x86/0x1b0
> [10264.128349]  bio_alloc_bioset+0x200/0x4f0
> [10264.128352]  bio_alloc_clone+0x23/0x60
> [10264.128354]  alloc_io+0x26/0xf0 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128361]  dm_submit_bio+0xb8/0x580 [dm_mod 7e9e6b44df4927f93fb3e4b5c782767396f58382]
> [10264.128366]  __submit_bio+0xb0/0x170
> [10264.128367]  submit_bio_noacct_nocheck+0x159/0x370
> [10264.128368]  bch2_submit_wbio_replicas+0x21c/0x3a0 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128391]  btree_write_submit+0x1cf/0x220 [bcachefs 85f1b9a7a824f272eff794653a06dde1a94439f2]
> [10264.128406]  process_one_work+0x178/0x350
> [10264.128408]  worker_thread+0x30f/0x450
> [10264.128409]  kthread+0xe5/0x120
> 
> The zswap shrinker resumes the swap_writepage()s that were intercepted
> by the zswap store. This will enter the block layer, and may even
> enter the filesystem depending on the swap backing file.
> 
> Make it respect GFP_NOIO and GFP_NOFS.
> 
> Link: https://lore.kernel.org/linux-mm/rc4pk2r42oyvjo4dc62z6sovquyllq56i5cdgcaqbd7wy3hfzr@n4nbxido3fme/
> Reported-by: Kent Overstreet <kent.overstreet@linux.dev>

Andrew can you please also add:

Reported-by: Jérôme Poulin <jeromepoulin@gmail.com>

Thanks

