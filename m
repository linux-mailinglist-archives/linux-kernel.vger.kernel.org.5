Return-Path: <linux-kernel+bounces-116400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B4889FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4BB2ACD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525801428FD;
	Mon, 25 Mar 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLbbd5Fr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FD14290E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332686; cv=none; b=BRL+aYrHUuJWXnf51Wokj6S8DoVrk40NcHx5NgQL9QB5Em7zLFjXl1pv8IgOUKuwxzsF+qxfAD4eyqmyq5eIxOJpDm6WLcL9tjz8x5wDCah0YAgU2XZ8CIi0x/Ll9JCGga2YxE9GVUmxUf6v/KWdGwaFwZVfDE5MnomAHZv1NEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332686; c=relaxed/simple;
	bh=6Upk9HpVnvdqSXAN+homYdfR9eVLX8GVlmX2hGmxejw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R5hB2unwSV9U5Q13We1Mbdk+wjEloJ9lPcC5j2OsKqz/NVI11KtVFNY+nLzDu6tdCLB0QmiP9nccSp/X5Rj7+QZaeiuPXV9IdHMKvzaRWDo97R1QTx788qZk6L9kWGuqGsKnJU1UAX0iGkPU+JFX9JYIiYtTFv03R5iek0Es56A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLbbd5Fr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711332682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
	b=NLbbd5FrvOPznQyNwXaw5IPqfgacnFhjyTDjjCd9420PiMJPUG9sdgvpp8UlwAIdhcC8Lx
	sComoC0QzohV3I7XuwnrC1swvr5WIFRGExj6cWzgO9l1mbf4jktTddeUCmbj+1CIMd77v8
	GnZBQb96M3qg2Gdrn0TTE1KA6g5aOYo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-QBbyyBI1Oty4evhMbEGAvA-1; Sun, 24 Mar 2024 22:11:21 -0400
X-MC-Unique: QBbyyBI1Oty4evhMbEGAvA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a46bae02169so453435666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 19:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711332680; x=1711937480;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZLO/mIIstkgFP8Jy9i1sdTVDL/fM4acrw4PX4Ic7og=;
        b=ZG+wJyvq8w95rFkXWjCIXFZwT92+aS7QS1u2e8CGH8tyldNDGhzcL8LEASVFMBbAp5
         vdje3QfN9WzER9xsNfRP8/ei1zMzJKm3O37B/po5prfQ5uyQEGIO+S6DEk+khdPstEnI
         5JpIbVPLcxAfWPNSY5dq9X6sMXXLUj6LlU8TGjNFJ7YoY+ff3VCQGmcb07o9yytqe/pO
         5dnGrl7FCPDQwPa+DgmFYQ7YbCouLJrJKibFHBX9HoFxAD8v6VMDoIWmw/JBL14H7pVf
         ym2YsE+N+qoxDHb0nO3hDmdkYigJmVVnXR/zsdlq5lwdTgZp+xdOtWMjwg+ckO6IT0+n
         XZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUgojPiaCikJr6EfVonc106ARdYWKdIkDCxPsCaf3LI2V0WawGBf8kBHVlVlnA0shbYLLixmvldQKUnpQtHTmND6FDLshJVxadQeOnL
X-Gm-Message-State: AOJu0YymVftzKn0hcJfROQt6S78U9Ydtrq2EFG0jinzNxMohkklHgvf1
	LFyx1D7aq1OqEbam6TIYFfoeKcindYsOSO/CIPinhBmKqABUEbF0qBCc6lMcf3mNJNvELsUt14K
	XdO0SFby5REFE8FVL3YV3SlOW/t2cA8A6lggwq5Osda1eTQTAvb53gniL4gyiD/FYN2l7+KbENX
	QrxLxd6xkybXitoNtIekcAvkEVfbAsw/ELTM7K
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id wk11-20020a170907054b00b00a46e9f92208mr4432405ejb.3.1711332679839;
        Sun, 24 Mar 2024 19:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlvHyzb1y00a0FYKpm52OZFuMgSrNhoJRiBdIzTv8yYTOECUxWIn1dwVBxksvbNzrSvulGNb9Lk/iWgFtvNWU=
X-Received: by 2002:a17:907:54b:b0:a46:e9f9:2208 with SMTP id
 wk11-20020a170907054b00b00a46e9f92208mr4432394ejb.3.1711332679543; Sun, 24
 Mar 2024 19:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tao Liu <ltao@redhat.com>
Date: Mon, 25 Mar 2024 10:10:43 +0800
Message-ID: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
Subject: Implementing .shutdown method for efa module
To: mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	jgg@ziepe.ca, leon@kernel.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Recently I experienced a kernel panic which is related to efa module
when testing kexec -l && kexec -e to switch to a new kernel on AWS
i4g.16xlarge instance.

Here is the dmesg log:

[    6.379918] systemd[1]: Mounting FUSE Control File System...
[    6.381984] systemd[1]: Mounting Kernel Configuration File System...
[    6.383918] systemd[1]: Starting Apply Kernel Variables...
[    6.385430] systemd[1]: Started Journal Service.
[    6.394221] ACPI: bus type drm_connector registered
[    6.421408] systemd-journald[1263]: Received client request to
flush runtime journal.
[    7.262543] efa 0000:00:1b.0: enabling device (0010 -> 0012)
[    7.432420] efa 0000:00:1b.0: Setup irq:191 name:efa-mgmnt@pci:0000:00:1b.0
[    7.435581] efa 0000:00:1b.0 efa_0: IB device registered
[    7.885564] random: crng init done
[    8.139857] XFS (nvme0n1p2): Mounting V5 Filesystem
d7003ecc-db6f-4bfb-bf92-60376b6a6563
[    8.265233] XFS (nvme0n1p2): Ending clean mount
[   10.555612] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

Red Hat Enterprise Linux 9.4 Beta (Plow)
Kernel 5.14.0-425.el9.aarch64 on an aarch64

ip-10-0-27-226 login: [   29.940381] kexec_core: Starting new kernel
[   30.079279] psci: CPU1 killed (polled 0 ms)
[   30.119222] psci: CPU2 killed (polled 0 ms)
[   30.199293] psci: CPU3 killed (polled 0 ms)
[   30.309214] psci: CPU4 killed (polled 0 ms)
[   30.379221] psci: CPU5 killed (polled 0 ms)
[   30.419210] psci: CPU6 killed (polled 0 ms)
[   30.489207] IRQ 191: no longer affine to CPU7
[   30.489667] psci: CPU7 killed (polled 0 ms)
.snip...
[   33.849123] psci: CPU63 killed (polled 0 ms)
[   33.849943] Bye!
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x413fd0c1]
[    0.000000] Linux version 5.14.0-417.el9.aarch64
(mockbuild@arm64-025.build.eng.bos.redhat.com) (gcc (GCC) 11.4.1
20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-42.el9) #1 SMP
PREEMPT_DYNAMIC Thu Feb 1 21:23:03 EST 2024
..snip...
[    1.012692] Freeing unused kernel memory: 6016K
[    2.370947] Checked W+X mappings: passed, no W+X pages found
[    2.370980] Run /init as init process
[    2.370982]   with arguments:
[    2.370983]     /init
[    2.370984]   with environment:
[    2.370984]     HOME=/
[    2.370985]     TERM=linux
[    2.373257] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    2.373259] CPU: 1 PID: 1 Comm: init Not tainted 5.14.0-417.el9.aarch64 #1
[    2.382240] Hardware name: Amazon EC2 i4g.16xlarge/, BIOS 1.0 11/1/2018
[    2.383814] Call trace:
[    2.384410]  dump_backtrace+0xa8/0x120
[    2.385318]  show_stack+0x1c/0x30
[    2.386124]  dump_stack_lvl+0x74/0x8c
[    2.387011]  dump_stack+0x14/0x24
[    2.387810]  panic+0x158/0x368
[    2.388553]  do_exit+0x3a8/0x3b0
[    2.389333]  do_group_exit+0x38/0xa4
[    2.390195]  get_signal+0x7a4/0x810
[    2.391044]  do_signal+0x1bc/0x260
[    2.391870]  do_notify_resume+0x108/0x210
[    2.392839]  el0_da+0x154/0x160
[    2.393603]  el0t_64_sync_handler+0xdc/0x150
[    2.394628]  el0t_64_sync+0x17c/0x180
[    2.395513] SMP: stopping secondary CPUs
[    2.396483] Kernel Offset: 0x586f04e00000 from 0xffff800008000000
[    2.397934] PHYS_OFFSET: 0x40000000
[    2.398774] CPU features: 0x0,00000101,70020143,10417a0b
[    2.400042] Memory Limit: none
[    2.400783] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

In the dmesg log, I found "[   30.489207] IRQ 191: no longer affine to
CPU7" is suspicious, which is related to efa module. After blacklist
efa module from automatic loading when bootup, the kernel panic issue
doesn't appear again.

It looks to me it is due to the efa being not properly shutdown during
kexec, so the ongoing DMA/interrupts etc overwrite the memory range.

Though the issue is reproduced on rhel's kernel, the upstream kernel
[1] doesn't have the .shutdown method implemented either. Since I'm
not very familiar with the efa driver, could you please implement the
shutdown method in drivers/infiniband/hw/efa/efa_main.c? Thanks in
advance!

[1]: https://github.com/torvalds/linux/blob/master/drivers/infiniband/hw/efa/efa_main.c#L674

Thanks,
Tao Liu


