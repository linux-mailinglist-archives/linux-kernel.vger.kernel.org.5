Return-Path: <linux-kernel+bounces-111933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9A8872F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B618282D13
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B888A64CC6;
	Fri, 22 Mar 2024 18:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNGQO5q3"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115BC63CB4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131667; cv=none; b=F2AhX0XNON0V2uVhOKnu3bQp0pIkNeaa9snPOdks39Bgn9bFbQ5jESh0ZNvgIm/wScedf/2VAXyyqu1xkonJE4Ah3LnH/+MgRfVDy+PyiA8PUGk/ktm8IIWeaXCQMa6P5sfV0Wh4HAdgJe8VzIIx+kODQZg5fVjt8jDhTZFD6hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131667; c=relaxed/simple;
	bh=jzS7HefDnXxvgYgPkneY73Mxg7R/H5XGX9WlR9BpZb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQCLCaN4kd8zFLYPPR/0Z0c67FS+jp+DeSli+qfWqH1N5ZJlh/VVKzLnA98Nrd7x5QATaVV+X4C/keXTbNm3KDnUNlSN9nSNXaK/4FBq4oZrcACuHI4rUO6xyZWAgmd1QFyTLn1If9x+ZX3LlyQZQ/fFJLDNl3yGYewlzI3EJEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNGQO5q3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e8f51d0bf0so1909776b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711131665; x=1711736465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZCsdPU8TvLgwvx27n1JjkkvlHepysidwj+yYBUyfFvU=;
        b=FNGQO5q3ONhTXUHI/JtLKMvdUaNAeGoNFu4AiRwEDZZqvI2USnwn2W8LyimtuUPLGn
         c2LEq2iKW1Y/jeXyyd9EUEG7zEYnd+EewBq1U+zfGaIrUAZVO01mE04xZCqM2jix1nUS
         BDE9mNYE/KwuumEqzkKdx8U7xMd9tAPvXuKHsIdS4Ktd64UEaFZEUPOeeRa2hDluChO4
         sJV0ZC5xZpGBy/OPNO8qZY6U3PeSaJQ+YzJZKUttdaxE4/pFEPSAALw3EqkUDrppYD93
         r2UunQSiYFXSZ9d3SRcV3fKIB2O0q7PmmkbKp/PKCw4nYwhnbdfGbj9NoeLeA1/WSlh/
         QMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711131665; x=1711736465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCsdPU8TvLgwvx27n1JjkkvlHepysidwj+yYBUyfFvU=;
        b=KPgrRRQN8V5krm0y1nb9GjbTmaXGdjO6FP11wT3ZpER1iIatmgbfsjKZYOpoSkB3bH
         2X5dmQ7Z0uoJNtsuQ34MrlnLR8mF7ngGkxwEwfbNZm7f5wlFO53Rs1zlDvfKPpXbLTgU
         WwlGinpY75ckVM76u292o6YkS8Jfoh6zVFjJwDsDLp8uOdNiCLTwmgGezFvAyW5dJhwi
         AVtUusb1cLE7vt+t5QVmiDUTw5N0kNenazDppEZc+REl7RwmBiRVZKT1Sc2tU0FZL1Pb
         BjjaI/aYzbP0rvLdttAOVxTx81nlg53BpV8c5nHp8/nPUXZIrTDdsjeI3X3CrhSi4Wts
         XN2A==
X-Forwarded-Encrypted: i=1; AJvYcCWrf85QZiDYTv5Om2ViEMpZ9H2B4c9mmMrHLfREfAWLM4W4sZ43b6Cpg3svnnHqrAVK6DHXMEWJy2aIN/kUcdp2E2KiAvZVmM4LBMFL
X-Gm-Message-State: AOJu0Yywuks0o8Wp6ZoA8JV+euYjIkljs9BGFG6RrWaEZpIqYulNrF8G
	h4/u1zzYF6fqKxxYtACkax2fBk82ZgVZagAt0KhQIHD680/N8c+2
X-Google-Smtp-Source: AGHT+IEnHjkLgCac/gX146QfYoCPdmnpDjB2s9pbwb4Nk3vBwjQqkx4dPHNdIUUDr79X6ksMtkucbw==
X-Received: by 2002:a05:6a00:22cc:b0:6ea:79a5:3fc with SMTP id f12-20020a056a0022cc00b006ea79a503fcmr734525pfj.5.1711131665096;
        Fri, 22 Mar 2024 11:21:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j36-20020a63fc24000000b005dc5289c4edsm1880971pgi.64.2024.03.22.11.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:21:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Mar 2024 11:21:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Dave Chinner <david@fromorbit.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <bbc242d5-3ab0-410f-a3b1-54a68e3e375f@roeck-us.net>
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

Hi,

On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> Concurrent access to a global vmap space is a bottle-neck.
> We can simulate a high contention by running a vmalloc test
> suite.
> 
> To address it, introduce an effective vmap node logic. Each
> node behaves as independent entity. When a node is accessed
> it serves a request directly(if possible) from its pool.
> 
> This model has a size based pool for requests, i.e. pools are
> serialized and populated based on object size and real demand.
> A maximum object size that pool can handle is set to 256 pages.
> 
> This technique reduces a pressure on the global vmap lock.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

This patch results in a persistent "spinlock bad magic" message
when booting s390 images with spinlock debugging enabled.

[    0.465445] BUG: spinlock bad magic on CPU#0, swapper/0
[    0.465490]  lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
[    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    0.466270] Call Trace:
[    0.466470]  [<00000000011f26c8>] dump_stack_lvl+0x98/0xd8
[    0.466516]  [<00000000001dcc6a>] do_raw_spin_lock+0x8a/0x108
[    0.466545]  [<000000000042146c>] find_vmap_area+0x6c/0x108
[    0.466572]  [<000000000042175a>] find_vm_area+0x22/0x40
[    0.466597]  [<000000000012f152>] __set_memory+0x132/0x150
[    0.466624]  [<0000000001cc0398>] vmem_map_init+0x40/0x118
[    0.466651]  [<0000000001cc0092>] paging_init+0x22/0x68
[    0.466677]  [<0000000001cbbed2>] setup_arch+0x52a/0x708
[    0.466702]  [<0000000001cb6140>] start_kernel+0x80/0x5c8
[    0.466727]  [<0000000000100036>] startup_continue+0x36/0x40

Bisect results and decoded stacktrace below.

The uninitialized spinlock is &vn->busy.lock.
Debugging shows that this lock is actually never initialized.

[    0.464684] ####### locking 0000000002280fb8
[    0.464862] BUG: spinlock bad magic on CPU#0, swapper/0
..
[    0.464684] ####### locking 0000000002280fb8
[    0.477479] ####### locking 0000000002280fb8
[    0.478166] ####### locking 0000000002280fb8
[    0.478218] ####### locking 0000000002280fb8
..
[    0.718250] #### busy lock init 0000000002871860
[    0.718328] #### busy lock init 00000000028731b8

Only the initialized locks are used after the call to vmap_init_nodes().

Guenter

---
# bad: [8e938e39866920ddc266898e6ae1fffc5c8f51aa] Merge tag '6.9-rc-smb3-client-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6
# good: [e8f897f4afef0031fe618a8e94127a0934896aba] Linux 6.8
git bisect start 'HEAD' 'v6.8'
# good: [e56bc745fa1de77abc2ad8debc4b1b83e0426c49] smb311: additional compression flag defined in updated protocol spec
git bisect good e56bc745fa1de77abc2ad8debc4b1b83e0426c49
# bad: [902861e34c401696ed9ad17a54c8790e7e8e3069] Merge tag 'mm-stable-2024-03-13-20-04' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 902861e34c401696ed9ad17a54c8790e7e8e3069
# good: [480e035fc4c714fb5536e64ab9db04fedc89e910] Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 480e035fc4c714fb5536e64ab9db04fedc89e910
# good: [fe46a7dd189e25604716c03576d05ac8a5209743] Merge tag 'sound-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
git bisect good fe46a7dd189e25604716c03576d05ac8a5209743
# bad: [435a75548109f19e5b5b14ae35b9acb063c084e9] mm: use folio more widely in __split_huge_page
git bisect bad 435a75548109f19e5b5b14ae35b9acb063c084e9
# good: [4d5bf0b6183f79ea361dd506365d2a471270735c] mm/mmu_gather: add tlb_remove_tlb_entries()
git bisect good 4d5bf0b6183f79ea361dd506365d2a471270735c
# bad: [4daacfe8f99f4b4cef562649d56c48642981f46e] mm/damon/sysfs-schemes: support PSI-based quota auto-tune
git bisect bad 4daacfe8f99f4b4cef562649d56c48642981f46e
# good: [217b2119b9e260609958db413876f211038f00ee] mm,page_owner: implement the tracking of the stacks count
git bisect good 217b2119b9e260609958db413876f211038f00ee
# bad: [40254101d87870b2e5ac3ddc28af40aa04c48486] arm64, crash: wrap crash dumping code into crash related ifdefs
git bisect bad 40254101d87870b2e5ac3ddc28af40aa04c48486
# bad: [53becf32aec1c8049b854f0c31a11df5ed75df6f] mm: vmalloc: support multiple nodes in vread_iter
git bisect bad 53becf32aec1c8049b854f0c31a11df5ed75df6f
# good: [7fa8cee003166ef6db0bba70d610dbf173543811] mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
git bisect good 7fa8cee003166ef6db0bba70d610dbf173543811
# good: [282631cb2447318e2a55b41a665dbe8571c46d70] mm: vmalloc: remove global purge_vmap_area_root rb-tree
git bisect good 282631cb2447318e2a55b41a665dbe8571c46d70
# bad: [96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e] mm: vmalloc: add a scan area of VA only once
git bisect bad 96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e
# bad: [72210662c5a2b6005f6daea7fe293a0dc573e1a5] mm: vmalloc: offload free_vmap_area_lock lock
git bisect bad 72210662c5a2b6005f6daea7fe293a0dc573e1a5
# first bad commit: [72210662c5a2b6005f6daea7fe293a0dc573e1a5] mm: vmalloc: offload free_vmap_area_lock lock

---
[    0.465490] lock: single+0x1860/0x1958, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    0.466067] CPU: 0 PID: 0 Comm: swapper Not tainted 6.8.0-12955-g8e938e398669 #1
[    0.466188] Hardware name: QEMU 8561 QEMU (KVM/Linux)
[    0.466270] Call Trace:
[    0.466470] dump_stack_lvl (lib/dump_stack.c:117)
[    0.466516] do_raw_spin_lock (kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
[    0.466545] find_vmap_area (mm/vmalloc.c:1059 mm/vmalloc.c:2364)
[    0.466572] find_vm_area (mm/vmalloc.c:3150)
[    0.466597] __set_memory (arch/s390/mm/pageattr.c:360 arch/s390/mm/pageattr.c:393)
[    0.466624] vmem_map_init (./arch/s390/include/asm/set_memory.h:55 arch/s390/mm/vmem.c:660)
[    0.466651] paging_init (arch/s390/mm/init.c:97)
[    0.466677] setup_arch (arch/s390/kernel/setup.c:972)
[    0.466702] start_kernel (init/main.c:899)
[    0.466727] startup_continue (arch/s390/kernel/head64.S:35)
[    0.466811] INFO: lockdep is turned off.


