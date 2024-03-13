Return-Path: <linux-kernel+bounces-101103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7536087A25E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAD428416C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34C1118A;
	Wed, 13 Mar 2024 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvkqlMeZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2443D2FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710304729; cv=none; b=INyA1eW2/5Vjls0LJgCXMPSzgegyeTg4qJDO90FKgVAvgUWYMEcgXr0jbBla1eTvZ1wK+B4cpcmaHFaFnSRWB/Rj9pXvEP/FqyYUee2TKWFlKXe7UNnWt539qdQ9Fr2Q0bNnr5jV3Vyb7EC1aFG8IHvsylRgAkH7vCrd0Ba3o+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710304729; c=relaxed/simple;
	bh=fdmiqzW6Blw1qeb4c/qtIgA+CgY3A+3/GMpfk5LDynw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UFwZycTsGEwDYkoBWFmNi6WQXvJeSLUZobMUh+MknLyB/GtYthc0P53BvRJh8raMiL37kfs+HZGRqIdDsimp1wfujaXirTQz7uvisgsQlUMWeE2tNC13QDSSDryLnd4y1TK0M1/UGIxyz7iSAVlh2O1b+CwsEj1bK9fuCQgSPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvkqlMeZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5686677bda1so897434a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710304726; x=1710909526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m41YgiFJI0DI0kZE4dckhHKpQxBXnR3ULsEvuFkvU74=;
        b=dvkqlMeZ54K2lcg3VWY12fuE4Tbifw09GUXE3C184ooJbCL+TCDYiT6PAlJE3UO6Aa
         OXCdEzMk8/IecP+vOc+OhE/0bp7S+Igq6WrXr/74c21XPSRZ5sYTESPr0DFB6ouVIJT5
         Kg3bLnZcDagQ7ouOj0JvVpspEGgD9Kai0lqGTVLRE5NM52ge7ou+t2mBMV+oY61ihYL3
         binhsFSVCi1EIIomXlGP95Yd1z+/Bnc1v+R+e5IbLswQnU3YUf+jZuK7n4leDR9pEEx2
         gzigLJvkTmBE85ij8pOo8X8kMQOxyKWSdYJ41cLDZwb4Abg3vrhqo19OkR+XSjh7UmHa
         2I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710304726; x=1710909526;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m41YgiFJI0DI0kZE4dckhHKpQxBXnR3ULsEvuFkvU74=;
        b=siXqdxmpGz3TkAgxv318c7GhL6SYnP4nVHsH2I1Zlt0WbfJQV4LVzI1ywCuatyM/Xo
         Fb68wINhOG/H71cz1MAOFiilKI9bSfChUPxyFp05S8ySNcbpll5nVgO3NyDHAjriI37c
         C3xwYmKQ4vH7Kt22KdCX5GmRDz96IQoSjsM5MpG8yqIOwlo4gOirgytTK45mR+Wo3/4V
         sKbYZPvqfCAm2Z9nUsxoneWfXKfEYTrOLzkzVEbKDIkOvt8qJHNvPIz+WKIDJS9pNebS
         Zf0YU9NwcSyfGsRb2Rjq56IlLDcXkwQ/nbDVt1kvycztpxHMfSMssQxsRZgIW3FFiDwA
         FvHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnMRr2BUqTtoJbMCqtBlGFOQfa7jUvE4PTgnqg+qrOU/T5hITYfWcdJKLaZCSVmud1v3UWd4qvZXxQ8UOHr08wsKed/FGxpCSwl8tJ
X-Gm-Message-State: AOJu0YzfDrn/EdqfRl38n76VkUdOawa7YuiRJw+vCdrhmCbnslAyfsas
	ZM4S36mG4oV6vu+cvEC599xVuKQeZvOgV5WAOl4fR1GM/BdLumkNSNwughBK2c4BxGGh1uuglGz
	iU0d+GjUGheRMgsE8WeCnSX2QU8g=
X-Google-Smtp-Source: AGHT+IHUS34YTGMkObn8k2mBK9rKROdA5jEv5l020MP2DAP7EhqYjSOt6+fflqfU5+lHFjXciBA2u8I3djBkZx4Xr/c=
X-Received: by 2002:a17:906:4c4c:b0:a45:af17:6e39 with SMTP id
 d12-20020a1709064c4c00b00a45af176e39mr1053331ejw.1.1710304725701; Tue, 12 Mar
 2024 21:38:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 13 Mar 2024 12:38:34 +0800
Message-ID: <CAKHoSAvonCz9q6+tbLu_zZ1_m6JA3Ab1-+NVchwUGn90yGy5MQ@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in swiotlb_bounce
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "cc: cc: H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello,



when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72  (tag: v6.8-rc7)

git tree: upstream

console output:
https://drive.google.com/file/d/1BQCubjzbGYPIVK4so6wEMwMfwp4bzcoW/view?usp=drive_link

kernel config: https://drive.google.com/file/d/19VXB1YKwoBFpzjqTmm02jVi4-N9tNIvm/view?usp=drive_link

C reproducer: https://drive.google.com/file/d/1CU_h8zSE9anV6gzteBK7_jbBMKKm_wBf/view?usp=drive_link

Syzlang reproducer:
https://drive.google.com/file/d/1J9VtUKKMwozBjqK2JgjMZ1b6H4lB9f22/view?usp=drive_link



If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------



BUG: unable to handle page fault for address: ffff888108a50000

#PF: supervisor read access in kernel mode

#PF: error_code(0x0000) - not-present page

PGD 61c01067 P4D 61c01067 PUD 1008ee063 PMD 108a51063 PTE 800ffffef75af060

Oops: 0000 [#1] PREEMPT SMP KASAN PTI

CPU: 0 PID: 9 Comm: kworker/0:0H Not tainted 6.8.0-rc7 #1

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014

Workqueue: kblockd blk_mq_run_work_fn

RIP: 0010:memcpy_orig+0x1e/0x140 arch/x86/lib/memcpy_64.S:65

Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 89 f8 48 83
fa 20 0f 82 86 00 00 00 40 38 fe 7c 35 48 83 ea 20 48 83 ea 20 <4c> 8b
06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 48 8d 76 20 4c 89 07

RSP: 0018:ffff888100307498 EFLAGS: 00010006

RAX: ffff8880bc51f000 RBX: ffff8880bbfdf000 RCX: ffffffffb98de085

RDX: 0000000000000fc0 RSI: ffff888108a50000 RDI: ffff8880bc51f000

RBP: ffff888100dfe0b8 R08: ffff8881c03ccc10 R09: fffffbfff7d61b01

R10: fffffbfff7d61b00 R11: ffffffffbeb0d807 R12: ffff888108a50000

R13: ffffffffbeb0d7a0 R14: ffff8880bc51f000 R15: ffff888108a50000

FS:  0000000000000000(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: ffff888108a50000 CR3: 0000000105330004 CR4: 0000000000770ef0

DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

PKRU: 55555554

Call Trace:

 <TASK>

 swiotlb_bounce+0x314/0x560 kernel/dma/swiotlb.c:899

 swiotlb_tbl_map_single+0xc67/0xfd0 kernel/dma/swiotlb.c:1343

 swiotlb_map+0x17a/0x700 kernel/dma/swiotlb.c:1480

 dma_direct_map_page kernel/dma/direct.h:95 [inline]

 dma_direct_map_sg+0x293/0x810 kernel/dma/direct.c:492

 __dma_map_sg_attrs+0xbb/0x1e0 kernel/dma/mapping.c:199

 dma_map_sg_attrs+0x34/0x50 kernel/dma/mapping.c:236

 ata_sg_setup drivers/ata/libata-core.c:4741 [inline]

 ata_qc_issue+0x5e9/0xb30 drivers/ata/libata-core.c:5043

 ata_scsi_translate drivers/ata/libata-scsi.c:1717 [inline]

 __ata_scsi_queuecmd+0x8de/0x11d0 drivers/ata/libata-scsi.c:4153

 ata_scsi_queuecmd+0xad/0x170 drivers/ata/libata-scsi.c:4198

 scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1518 [inline]

 scsi_queue_rq+0xc07/0x2ac0 drivers/scsi/scsi_lib.c:1760

 blk_mq_dispatch_rq_list+0x3b6/0x1bd0 block/blk-mq.c:2070

 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]

 blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]

 __blk_mq_sched_dispatch_requests+0xbd4/0x14b0 block/blk-mq-sched.c:309

 blk_mq_sched_dispatch_requests+0xb2/0x110 block/blk-mq-sched.c:331

 blk_mq_run_work_fn+0x131/0x190 block/blk-mq.c:2455

 process_one_work kernel/workqueue.c:2633 [inline]

 process_scheduled_works+0x252/0xe10 kernel/workqueue.c:2706

 worker_thread+0x56c/0xc10 kernel/workqueue.c:2787

 kthread+0x2c8/0x3c0 kernel/kthread.c:388

 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147

 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

 </TASK>

Modules linked in:

CR2: ffff888108a50000

---[ end trace 0000000000000000 ]---

RIP: 0010:memcpy_orig+0x1e/0x140 arch/x86/lib/memcpy_64.S:65

Code: 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 89 f8 48 83
fa 20 0f 82 86 00 00 00 40 38 fe 7c 35 48 83 ea 20 48 83 ea 20 <4c> 8b
06 4c 8b 4e 08 4c 8b 56 10 4c 8b 5e 18 48 8d 76 20 4c 89 07

RSP: 0018:ffff888100307498 EFLAGS: 00010006

RAX: ffff8880bc51f000 RBX: ffff8880bbfdf000 RCX: ffffffffb98de085

RDX: 0000000000000fc0 RSI: ffff888108a50000 RDI: ffff8880bc51f000

RBP: ffff888100dfe0b8 R08: ffff8881c03ccc10 R09: fffffbfff7d61b01

R10: fffffbfff7d61b00 R11: ffffffffbeb0d807 R12: ffff888108a50000

R13: ffffffffbeb0d7a0 R14: ffff8880bc51f000 R15: ffff888108a50000

FS:  0000000000000000(0000) GS:ffff8881c0000000(0000) knlGS:0000000000000000

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: ffff888108a50000 CR3: 0000000105330004 CR4: 0000000000770ef0

DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000

DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

PKRU: 55555554

note: kworker/0:0H[9] exited with irqs disabled

note: kworker/0:0H[9] exited with preempt_count 1

