Return-Path: <linux-kernel+bounces-101062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1D87A1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 03:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C41F235F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE57D51A;
	Wed, 13 Mar 2024 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgwOfK9Q"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2D6C13D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710298551; cv=none; b=tMqA5+WPPphD2w7FTV2mGY7m/ZnYOE9zkobfXNUjdB5+Ry6wG1vUfSCwCW/X+V0JFijGGycFHrEUUE4s82nME5ozVBzRTn8SN3JBMorP1zG83IHkxlHF2bVkxgVmlY3PLrFG10Zvlq/FJsThpF4Hww2NyRVboYz2FPspc9fwiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710298551; c=relaxed/simple;
	bh=Nx47pDObyrbzralqgVl6NOBCia50rcQJh7y3UjKsxNM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=G+RAbDGOL7CkIhRYCxFCpAkg31Xc/FuigIU/nSlpJWJcncuW9I4R/ksl+/Gs6wR/HZLmBa/s5e+M0rYHFPPA5PkZvSDAl5Xd18kwWIVLmr4chxnV0fcjLn4r9VuHFxjXQTU6lq833/oJqx0tLUyx3xnw/VKs+rznLltuxuX2oHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgwOfK9Q; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45cdb790dfso638822966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710298548; x=1710903348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/3rWfBimKSgUzcFH3WhJRAOHMjF83kSLXcwvLRNPla4=;
        b=WgwOfK9QITcuwCramORez4MCo/6EKeaQdWKQoePQhYkxHqSEUxQtrFpwM85p9rCPdO
         Qehrrm5TldFxQnGUBREl04k6PHD+c1uBpPD5OutDwyPFR0g6aWFO/q7wvfsihokDLtiZ
         WL5xldt6KFzFtEbDAYB99K9gkoRZ3Ip5AWmk3QMnHOPOzZB/pF23EXYfPBgN9U33f6ci
         +qCILB4p/YGF5pbv0Cje1qKb9b9UjsmwbF+PRkDocYqDD4gerg1I33nLYJt2yhXbsrKN
         kMDJ/gzZ3Err/jJtD+o+sdrmihZXVoOcCtjjsIpk4wSgBmJGcSKufwYlvSp/MowcuiRB
         dfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710298548; x=1710903348;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3rWfBimKSgUzcFH3WhJRAOHMjF83kSLXcwvLRNPla4=;
        b=hD7+n4hZVAasmmZ9VXo37wPzeQwxpMnotl5ZMvu4Ux2mWqtoKiDHrKV6bTrGtckmmu
         YCT7hpMrtIg/8hgZheUsh5t6RtODPn3wEqRN/RT8ZS1eAsdN9BA7Di3/xyu1U9TAP/b8
         ZYb3jU0fcMEP54Ej7nfSgDlfCvOe1F65h1q2rRPZqTFRnrofl/ScDiuPAKQuh0JWykLO
         z1tedabZ+4+zFVRjYwb++zFa7J/lTQ/Vf/X8uojfT0xNDna3NcGw93zCkLFbKd9xk4Pr
         nfS+o+33k0MdpNx682kHssjcrfowFDFW5rORirNYRE3pbmcUk2uDd6ztQZuksStVvp5A
         cqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2NasOJcx8ROfDmujpIpYC/3jes835uiogeEkMTCV2Q0eWXRmnGErzVK8qS4R1wyMn66BjeKlAyxM7aiBgQr5eO0u2dF/vJJxu41Zi
X-Gm-Message-State: AOJu0YydrL/F3Dv4e9MPFO+LPrKcj5PJzdWSPfHGemn1+lglO9jHPBYj
	2bVjqQIQEDn4h7AE9uVZWeebg510u7MiObQ2Vyl/DftX36Ro3UgiyRnTXN8ItuhjPMbQP4ZBONE
	08IW3TW8tUfonTfX2yTckW0wnomg=
X-Google-Smtp-Source: AGHT+IECuae9s6cEk6CTEheftzCfvAeBxpjTfNIo7CrwvIQD1RjoOmtoPAVW8n61EGoBNWhg/H3baP0f1bZeiHKnWdk=
X-Received: by 2002:a17:906:fb81:b0:a43:29e1:6db8 with SMTP id
 lr1-20020a170906fb8100b00a4329e16db8mr7132722ejb.9.1710298548016; Tue, 12 Mar
 2024 19:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Wed, 13 Mar 2024 10:55:36 +0800
Message-ID: <CAKHoSAtQxd8dcuZcFrYH550An2Zr9bjChCRirYNQgXRk57N8NA@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in swiotlb_bounce
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: "cc: H. Peter Anvin" <hpa@zytor.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>
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

