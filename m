Return-Path: <linux-kernel+bounces-96959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B08763AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106491F2183B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25225647C;
	Fri,  8 Mar 2024 11:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZ23HBGp"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10D56469
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898817; cv=none; b=WKbVnn5tzwyHgAAC2RssxKB7biLv430YGF2flvCyl1xljMILp5HOHvLbGeXoLvYArWjuqlEKMHf5uVJ/evKbKqtrOQYd8peidL+JxAncWNL4ESAbgKhmGFH5PB8/GEMt685vO80oovQqz8VgJFdCIdk5TSSPG9oiBSeOldK3mrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898817; c=relaxed/simple;
	bh=Dn8r9bW+FTM+5oRzkXYWhrom+kH8/qZ/PCHh7zzVWfk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h93p4Y99sELCQKj4UWaoMCFOrxMw1knd6RVkdhh8SHiSUpxlTELEZe4MpblL5RL8bnPSoh8FGggTU6+18l6/SFP8jJxncThOo5UIwAT+dlcbmevjE/broUkj6qhTVvIdgHS6ZiVJjSTBSLzOXkJLThY/NCrRTdVDDPsPdoAN3Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZ23HBGp; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4affeacaff9so315086e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709898814; x=1710503614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0v8zU7XN0c0ioL0E5zciB+cplp/WmstRvtEPlPhQSU=;
        b=uZ23HBGp59wrNKvIzCrd42fv3tvp28eoGXQFKBsXMbSCjdRTJUdRVj6ziz6uKEffvl
         TVymQl0WZSAJpKjwFgGOn49qGxtArsjA6LfSnLObo8fPMBvwCBl005Snh/zginiWmqJR
         +CqcP5WmNJyvrkIRlZsQEN4BIchgiWh38OJbtpfJlesHyQ4ZcGDj3kH7qYaPShT0+p7/
         GCiYz+Ay3Tfz5A3iE2J66J4pChKbIIpRciM29t3xp+F04UzwL2w02LdNRgFIlOO4pNAJ
         bSApaesTU+rbEPqI5Z/flwJ8+jxfi5P8AzgbLF5YwFQzqi3h5C9pIPa4CRQqPZum7ARk
         lVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709898814; x=1710503614;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0v8zU7XN0c0ioL0E5zciB+cplp/WmstRvtEPlPhQSU=;
        b=JwwA+k5MofjS/BgxbJGDuoLYVvDoawnrFWsGzbk7mIMwiRMBOLLwsX36nq6w29zrTz
         vXcSP8jjDJC95CQxz9TcwzpRxEpL4qUaX3n5B31xb37n+hxKPZ+CUPOneyG29rRl1jq7
         XWf1ujQQH4KTqeyWoQAHDPIwmfy1963sGrxkFNJi/C9CuULGs+oAbJ/2SlyqjQAFSliH
         74yDftWorSJLwsugvUA/3c4oNJyAY8u6j9CwvhAR7Xet8GcT3FlFtGqRAuz/5a9cKeL0
         k8Ygrrk6mn5rYGvMUj10EgqgcuKol+b00lxE9vOXjpEkaE6C7GifHv49A5jX/e2v56qb
         pQCg==
X-Forwarded-Encrypted: i=1; AJvYcCUMgRPw4x1TNvJ+SkhvZF+4TJATipxjuOHFBrjbod+Lftlfx2IwEVWmjo71TfKoe5jKQUsXEi94i2ifbsHuT5m39U9umM6KmSSIAGbt
X-Gm-Message-State: AOJu0YyIsTvZccFumU9ssINiSS84Qa4AqGHb8+5uCa9IhD51GJFltV+m
	3oMVi4AY3+/AtzbMjqmLNEPzG7X4O93gjaroH7PDVIzojmDc46viHnNV3vlWN+mLgDJP1yyvSI9
	szwsidnf9HYDtZ+Ui3JXwzehMjdqtpek9kSiDhw==
X-Google-Smtp-Source: AGHT+IH39dkyc8715GQhna4Yju4ZRTiBJH7LM4TZ7Lg+oJPgxWAYh7xjzu0J3gpUbackoMuEVVV6FNCW3UVSAzk7PHk=
X-Received: by 2002:a05:6122:1807:b0:4ce:7663:af1f with SMTP id
 ay7-20020a056122180700b004ce7663af1fmr11240830vkb.7.1709898814474; Fri, 08
 Mar 2024 03:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 8 Mar 2024 17:23:23 +0530
Message-ID: <CA+G9fYsVni7x6AuP97i10oxcusUrB4+m2wpM4Z3mTzWsnMz-Mg@mail.gmail.com>
Subject: arm64: WARNING: at mm/vmalloc.c:315 ioremap_page_range
To: linux-mm <linux-mm@kvack.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following warning was noticed while boot arm and arm64 devices.
The below log is extracted from arm64 ROCK Pi 4B while booting and
another issue is kernel oops noticed while testing selftests:  kvm:
memslot_perf_test.

1) WARNING: CPU: 1 PID: 201 at mm/vmalloc.c:315 ioremap_page_range
2)  Unable to handle kernel NULL pointer dereference at virtual address
  Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
  Kernel panic - not syncing: Oops: Fatal exception in interrupt

Please find steps to reproduce, logs and config file links below.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Warning log:
-----------
[   21.074045] ------------[ cut here ]------------
[   21.074468] vm_area at addr ffffffffc0800000 is not marked as VM_IOREMAP
[   21.075125] WARNING: CPU: 1 PID: 201 at mm/vmalloc.c:315
ioremap_page_range (vmalloc.c:?)
[   21.075854] Modules linked in: industrialio_triggered_buffer
pcie_rockchip_host(+) coresight kfifo_buf drm fuse backlight dm_mod
ip_tables x_tables
[   21.077047] CPU: 1 PID: 201 Comm: (udev-worker) Not tainted
6.8.0-rc7-next-20240307 #1
[   21.077749] Hardware name: Radxa ROCK Pi 4B (DT)
[   21.078163] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   21.078782] pc : ioremap_page_range (vmalloc.c:?)
[   21.079197] lr : ioremap_page_range (vmalloc.c:?)
<trim>
[   21.086242] Call trace:
[   21.086464] ioremap_page_range (vmalloc.c:?)
[   21.086839] pci_remap_iospace (??:?)
[   21.087192] devm_pci_remap_iospace (??:?)
[   21.087579] devm_of_pci_bridge_init (??:?)
[   21.087990] devm_pci_alloc_host_bridge (??:?)
[   21.088410] rockchip_pcie_probe+0x34/0x30c pcie_rockchip_host
[   21.088955] platform_probe (platform.c:?)
[   21.089288] really_probe (dd.c:?)
[   21.089617] __driver_probe_device (dd.c:?)
[   21.090009] driver_probe_device (dd.c:?)
[   21.090385] __driver_attach (dd.c:?)
[   21.090731] bus_for_each_dev (??:?)
[   21.091084] driver_attach (??:?)
[   21.091412] bus_add_driver (??:?)
[   21.091760] driver_register (??:?)
[   21.092105] __platform_driver_register (??:?)
[   21.092525] init_module+0x20/0xfe8 pcie_rockchip_host
[   21.093010] do_one_initcall (??:?)
[   21.093357] do_init_module (main.c:?)
[   21.093701] load_module (main.c:?)
[   21.094059] __arm64_sys_finit_module (??:?)
[   21.094486] invoke_syscall (syscall.c:?)
[   21.094829] el0_svc_common (syscall.c:?)
[   21.095163] do_el0_svc (??:?)
[   21.095462] el0_svc (entry-common.c:?)
[   21.095740] el0t_64_sync_handler (??:?)
[   21.096113] el0t_64_sync (debug-monitors.c:?)
[   21.096442] ---[ end trace 0000000000000000 ]---


<trim>

# selftests: kvm: memslot_perf_test
# Testing map performance with 1 runs, 5 seconds each
# Memslot count too high for this test, decrease the cap (max is 8209)
#
# Testing unmap performance with 1 runs, 5 seconds each
# Test took 5.097229878s for slot setup + 5.061973294s all iterations
# Done 68 iterations, avg 0.074440783s each
# Best runtime result was 0.074440783s per iteration (with 68 iterations)
#
# Testing unmap chunked performance with 1 runs, 5 seconds each
# Test took 5.037993336s for slot setup + 5.006405252s all iterations
# Done 71 iterations, avg 0.070512750s each
# Best runtime result was 0.070512750s per iteration (with 71 iterations)
#
# Testing move active area performance with 1 runs, 5 seconds each
[  353.142236] Unable to handle kernel NULL pointer dereference at
virtual address 000000000000000a
[  353.143045] Mem abort info:
[  353.143300]   ESR = 0x0000000096000006
[  353.143638]   EC = 0x25: DABT (current EL), IL = 32 bits
[  353.144115]   SET = 0, FnV = 0
[  353.144394]   EA = 0, S1PTW = 0
[  353.144680]   FSC = 0x06: level 2 translation fault
[  353.145124] Data abort info:
[  353.145724]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  353.146221]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  353.146675]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  353.147153] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000095d5000
[  353.147728] [000000000000000a] pgd=0800000009a7d003,
p4d=0800000009a7d003, pud=0800000006cd8003, pmd=0000000000000000
[  353.148692] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[  353.149253] Modules linked in: hantro_vpu snd_soc_hdmi_codec
brcmfmac dw_hdmi_i2s_audio dw_hdmi_cec v4l2_h264 v4l2_vp9 brcmutil
hci_uart v4l2_mem2mem btqca videobuf2_v4l2 btbcm rockchipdrm videodev
bluetooth dw_mipi_dsi panfrost snd_soc_audio_graph_card
snd_soc_simple_card analogix_dp videobuf2_dma_contig ecdh_generic
snd_soc_simple_card_utils dw_hdmi gpu_sched snd_soc_spdif_tx
crct10dif_ce videobuf2_memops cfg80211 videobuf2_common ecc
drm_shmem_helper cec phy_rockchip_pcie mc drm_display_helper rfkill
snd_soc_rockchip_i2s rtc_rk808 drm_dma_helper rockchip_saradc
snd_soc_es8316 drm_kms_helper rockchip_thermal coresight_cpu_debug
industrialio_triggered_buffer pcie_rockchip_host coresight kfifo_buf
drm fuse backlight dm_mod ip_tables x_tables
[  353.155470] CPU: 1 PID: 1146 Comm: memslot_perf_te Tainted: G
 W          6.8.0-rc7-next-20240307 #1
[  353.156328] Hardware name: Radxa ROCK Pi 4B (DT)
[  353.156743] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  353.157369] pc : unmap_region (mmap.c:?)
[  353.157744] lr : unmap_region (mmap.c:?)
<trim>

[  353.164918] Call trace:
[  353.165144] unmap_region (mmap.c:?)
[  353.165478] do_vmi_align_munmap (mmap.c:?)
[  353.165873] do_vmi_munmap (??:?)
[  353.166215] __arm64_sys_munmap (??:?)
[  353.166587] invoke_syscall (syscall.c:?)
[  353.166939] el0_svc_common (syscall.c:?)
[  353.167280] do_el0_svc (??:?)
[  353.167592] el0_svc (entry-common.c:?)
[  353.167881] el0t_64_sync_handler (??:?)
[  353.168265] el0t_64_sync (debug-monitors.c:?)
[ 353.168612] Code: b9003a88 b40000b6 f94006c3 b40000b5 (f94002a4)
All code
========
   0: b9003a88 str w8, [x20, #56]
   4: b40000b6 cbz x22, 0x18
   8: f94006c3 ldr x3, [x22, #8]
   c: b40000b5 cbz x21, 0x20
  10:* f94002a4 ldr x4, [x21] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f94002a4 ldr x4, [x21]
[  353.169156] ---[ end trace 0000000000000000 ]---
[  353.174026] Unable to handle kernel NULL pointer dereference at
virtual address 000000000000000a
[  353.174820] Mem abort info:
[  353.175068]   ESR = 0x0000000096000006
[  353.175400]   EC = 0x25: DABT (current EL), IL = 32 bits
[  353.175899]   SET = 0, FnV = 0
[  353.176171]   EA = 0, S1PTW = 0
[  353.176451]   FSC = 0x06: level 2 translation fault
[  353.176881] Data abort info:
[  353.177136]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  353.177694]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  353.178140]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  353.178608] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000095d5000
[  353.179174] [000000000000000a] pgd=0800000009a7d003,
p4d=0800000009a7d003, pud=0800000006cd8003, pmd=0000000000000000
[  353.180113] Internal error: Oops: 0000000096000006 [#2] PREEMPT SMP
[  353.180664] Modules linked in: hantro_vpu snd_soc_hdmi_codec
brcmfmac dw_hdmi_i2s_audio dw_hdmi_cec v4l2_h264 v4l2_vp9 brcmutil
hci_uart v4l2_mem2mem btqca videobuf2_v4l2 btbcm rockchipdrm videodev
bluetooth dw_mipi_dsi panfrost snd_soc_audio_graph_card
snd_soc_simple_card analogix_dp videobuf2_dma_contig ecdh_generic
snd_soc_simple_card_utils dw_hdmi gpu_sched snd_soc_spdif_tx
crct10dif_ce videobuf2_memops cfg80211 videobuf2_common ecc
drm_shmem_helper cec phy_rockchip_pcie mc drm_display_helper rfkill
snd_soc_rockchip_i2s rtc_rk808 drm_dma_helper rockchip_saradc
snd_soc_es8316 drm_kms_helper rockchip_thermal coresight_cpu_debug
industrialio_triggered_buffer pcie_rockchip_host coresight kfifo_buf
drm fuse backlight dm_mod ip_tables x_tables
[  353.186529] CPU: 1 PID: 1146 Comm: memslot_perf_te Tainted: G
D W          6.8.0-rc7-next-20240307 #1
[  353.187375] Hardware name: Radxa ROCK Pi 4B (DT)
[  353.187782] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  353.188394] pc : acct_collect (??:?)
[  353.188753] lr : acct_collect (??:?)
<trim>
[  353.195711] Call trace:
[  353.195929] acct_collect (??:?)
[  353.196250] do_exit (exit.c:?)
[  353.196543] make_task_dead (exit.c:?)
[  353.196878] die (??:?)
[  353.197138] __do_kernel_fault (fault.c:?)
[  353.197504] do_page_fault (fault.c:?)
[  353.197832] do_translation_fault (fault.c:?)
[  353.198204] do_mem_abort (??:?)
[  353.198516] el1_abort (entry-common.c:?)
[  353.198807] el1h_64_sync_handler (??:?)
[  353.199179] el1h_64_sync (debug-monitors.c:?)
[  353.199490] unmap_region (mmap.c:?)
[  353.199813] do_vmi_align_munmap (mmap.c:?)
[  353.200193] do_vmi_munmap (??:?)
[  353.200521] __arm64_sys_munmap (??:?)
[  353.200880] invoke_syscall (syscall.c:?)
[  353.201217] el0_svc_common (syscall.c:?)
[  353.201545] do_el0_svc (??:?)
[  353.201842] el0_svc (entry-common.c:?)
[  353.202117] el0t_64_sync_handler (??:?)
[  353.202488] el0t_64_sync (debug-monitors.c:?)
[ 353.202821] Code: 92800001 943f6bcb aa1f03f7 b4000100 (a9402009)
All code
========
   0: 92800001 mov x1, #0xffffffffffffffff    // #-1
   4: 943f6bcb bl 0xfdaf30
   8: aa1f03f7 mov x23, xzr
   c: b4000100 cbz x0, 0x2c
  10:* a9402009 ldp x9, x8, [x0] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: a9402009 ldp x9, x8, [x0]
[  353.203355] ---[ end trace 0000000000000000 ]---
[  353.204109] Fixing recursive fault but reboot is needed!
[  353.217290] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000038
[  353.218090] Mem abort info:
[  353.218340]   ESR = 0x0000000096000006
[  353.218675]   EC = 0x25: DABT (current EL), IL = 32 bits
[  353.219147]   SET = 0, FnV = 0
[  353.219422]   EA = 0, S1PTW = 0
[  353.219705]   FSC = 0x06: level 2 translation fault
[  353.220138] Data abort info:
[  353.220396]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[  353.220881]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[  353.221348]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  353.221821] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000095d5000
[  353.222393] [0000000000000038] pgd=0800000009a7d003,
p4d=0800000009a7d003, pud=0800000006cd8003, pmd=0000000000000000
[  353.223345] Internal error: Oops: 0000000096000006 [#3] PREEMPT SMP
[  353.223901] Modules linked in: hantro_vpu snd_soc_hdmi_codec
brcmfmac dw_hdmi_i2s_audio dw_hdmi_cec v4l2_h264 v4l2_vp9 brcmutil
hci_uart v4l2_mem2mem btqca videobuf2_v4l2 btbcm rockchipdrm videodev
bluetooth dw_mipi_dsi panfrost snd_soc_audio_graph_card
snd_soc_simple_card analogix_dp videobuf2_dma_contig ecdh_generic
snd_soc_simple_card_utils dw_hdmi gpu_sched snd_soc_spdif_tx
crct10dif_ce videobuf2_memops cfg80211 videobuf2_common ecc
drm_shmem_helper cec phy_rockchip_pcie mc drm_display_helper rfkill
snd_soc_rockchip_i2s rtc_rk808 drm_dma_helper rockchip_saradc
snd_soc_es8316 drm_kms_helper rockchip_thermal coresight_cpu_debug
industrialio_triggered_buffer pcie_rockchip_host coresight kfifo_buf
drm fuse backlight dm_mod ip_tables x_tables
[  353.229874] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D W
   6.8.0-rc7-next-20240307 #1
[  353.230659] Hardware name: Radxa ROCK Pi 4B (DT)
[  353.231070] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  353.231689] pc : kmem_cache_free (slub.c:?)
[  353.232079] lr : mt_free_walk (maple_tree.c:?)
<trim>
[  353.239161] Call trace:
[  353.239384] kmem_cache_free (slub.c:?)
[  353.239733] mt_free_walk (maple_tree.c:?)
[  353.240065] rcu_core (tree.c:?)
[  353.240374] rcu_core_si (tree.c:?)
[  353.240687] __do_softirq (??:?)
[  353.241013] ____do_softirq (irq.c:?)
[  353.241346] call_on_irq_stack (debug-monitors.c:?)
[  353.241703] do_softirq_own_stack (??:?)
[  353.242082] __irq_exit_rcu (softirq.c:?)
[  353.242419] irq_exit_rcu (??:?)
[  353.242741] el1_interrupt (entry-common.c:?)
[  353.243068] el1h_64_irq_handler (??:?)
[  353.243439] el1h_64_irq (debug-monitors.c:?)
[  353.243748] arch_local_irq_enable (build_policy.c:?)
[  353.244121] cpuidle_enter (??:?)
[  353.244446] do_idle (build_policy.c:?)
[  353.244743] cpu_startup_entry (??:?)
[  353.245099] secondary_start_kernel (smp.c:?)
[  353.245510] __secondary_switched (mte.c:?)
[ 353.245898] Code: f90003f3 d34c2d08 8a88fed6 d503201f (f9401ec8)
All code
========
   0: f90003f3 str x19, [sp]
   4: d34c2d08 lsl x8, x8, #52
   8: 8a88fed6 and x22, x22, x8, asr #63
   c: d503201f nop
  10:* f9401ec8 ldr x8, [x22, #56] <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0: f9401ec8 ldr x8, [x22, #56]
[  353.246438] ---[ end trace 0000000000000000 ]---
[  353.246850] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[  353.247456] SMP: stopping secondary CPUs
[  353.247938] Kernel Offset: disabled
[  353.248250] CPU features: 0x2,00000820,b0280000,2100421b
[  353.248722] Memory Limit: none
[  353.249007] ---[ end Kernel panic - not syncing: Oops: Fatal
exception in interrupt ]---


steps to reproduce:
--------

Boot warning on qemu-arm64:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2dLoS0ddamJtpsqNeVNZ6CKglNv/reproducer


Links:
  - https://lkft.validation.linaro.org/scheduler/job/7340334#L1014
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240307/testrun/22996522/suite/log-parser-test/test/check-kernel-oops-25b0708a1d4f25b5107a2f0a7d82f4edd2712d1b32a1c72988a53386013c1d6c/log
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240307/testrun/22996522/suite/log-parser-test/test/check-kernel-oops-25b0708a1d4f25b5107a2f0a7d82f4edd2712d1b32a1c72988a53386013c1d6c/details/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dLoQ0q6xeDevTFQGWYZqtTey7X/
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2dLoQ0q6xeDevTFQGWYZqtTey7X/config


--
Linaro LKFT
https://lkft.linaro.org

