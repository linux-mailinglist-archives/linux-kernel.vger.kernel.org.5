Return-Path: <linux-kernel+bounces-131948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D265898DCF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C9981F224BC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE80130E4B;
	Thu,  4 Apr 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8LHNcae"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44031304A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254517; cv=none; b=aaEE29412E5JkGwGTScEzOw4iiC2YZ611VHxDnh9uq3aGNUM7ZKf0CvFF4fEfBz9OOaGsDRjATR8BR5naBzKLHdHx8pgXCKXsc7jKcMWhj1AaqoTPjSRm4q0GkHmpKFnvUrS4EAdOPwDu+Tpau1XGFxybKdoLVP2KHM4Vy25720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254517; c=relaxed/simple;
	bh=miDfFkGahfW575cQTnt9NydHrEj1kiKT1K1yasM4uoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxOvyE5UrPIdfP4bbPN/vFXOB6GC5rYVYZ/bS5yUB5Ut4jzkVBW0Lel8gjVACTfHK1TCN6kCTrdZBCagOGGVBKzRZQLCyQamHhNfS5B2kDqvYBpf1MqKznihEudHTAydM3gsergZM15Kw+uj8fuHmNPMGtnHZQD/OzTWXZzY7sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8LHNcae; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41629b9b85eso8365235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712254512; x=1712859312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhXKmsel/QjiG85obJSCvyvZXMQ/jaHgW8CbmNJE+gg=;
        b=K8LHNcae/h+sY7aRWotVFJXxhDUYXcrBsHTpxyc/Ws21EeJNQyHsYP+xb3WnjC+jzP
         xe6YG+dvgJC3kq21mOSROg9KeB0C7aadbZ3iQ3zMbzfzw8UfEx8gjcl//3qz3cq+D5lh
         Saxiy1LwNBumJPdQOgn38FsY0Bnw1/NlRsZZHGh20WuOm1TDwM+7+0Z8LAk5mKmlKwud
         RIcID8XY2Z6PqIMIqt9mw65c8UAD/7Ya2JxG9yx0BU5aTxr3eDwCff9Lg6YteRfr7E48
         DoAlScgWA9AQSZQJYm3NOorSP8f/PNcTA7bfPBMuM8Mfp2M+KZQMUq07A24W422jzFHT
         kHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254512; x=1712859312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhXKmsel/QjiG85obJSCvyvZXMQ/jaHgW8CbmNJE+gg=;
        b=nMzpwYZjjDENcqVVVFrKnvSzVh98OLQcoLSmABE5QH4Ebq6EfN3Scmx/FG8bmw6qtF
         6h1eZ3ML3T51SpB2tVoo1OYjkU2PjWTxjUYK+LQS/WOMeQ0/XhiGLHpjsFBxqsq1T/2T
         bt1kjqmcENRdb7yD6iaJOfLEj9gmOQLmRqVpfEuioX1A46UhsTjutWYdZxZ2G7Fm2Xwk
         tP7/XQxHsrskDWue6NqwYzZTKCZ4iLeJ/LcWRoYgw2eobpFrikrfTOIJTbDiXixjuhdq
         RfAfy7As/JzXlP6vtoOZEz3MjDicdMWk65EDLAXRyL8mkqoxlFV4P6WlAMMAvVrCrWkU
         tigQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk1Sk/ey0nyciznrNVXfrK7yis37FT3McEX0egKTjTtiTcfot/30TT3f6S9zqtdspBvNoBJej9fdraHBJocUXiW7c2X7CbqgdVl5gS
X-Gm-Message-State: AOJu0YyBNG9IltY2lxDUykbTDvppCrMK+6CjiV/FlVvovoCUOJRWrY3Q
	uphG8x7qPxK7i1kigK6Fp3ukgNAb+EbAyYh2w0Dsw/QhsNJxliYH
X-Google-Smtp-Source: AGHT+IHdLs3ogk4vydRBQzViBMBQahD8AqpOqJH1vPjKCORYoRd8taYneJRLjybMgXyBK6dUiasMlg==
X-Received: by 2002:a7b:c34a:0:b0:415:6d1d:6048 with SMTP id l10-20020a7bc34a000000b004156d1d6048mr2407485wmj.14.1712254512072;
        Thu, 04 Apr 2024 11:15:12 -0700 (PDT)
Received: from localhost (ec2-18-175-17-34.eu-west-2.compute.amazonaws.com. [18.175.17.34])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b004162d62397dsm272146wmq.9.2024.04.04.11.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 11:15:11 -0700 (PDT)
From: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
To: mripard@kernel.org
Cc: 1054514@bugs.debian.org,
	airlied@redhat.com,
	carnil@debian.org,
	daniel@ffwll.ch,
	dreaming.about.electric.sheep@gmail.com,
	dri-devel@lists.freedesktop.org,
	kraxel@redhat.com,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	regressions@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	timo.lindfors@iki.fi,
	tzimmermann@suse.de,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/1] Revert "drm/qxl: simplify qxl_fence_wait"
Date: Thu,  4 Apr 2024 19:14:47 +0100
Message-Id: <20240404181448.1643-1-dreaming.about.electric.sheep@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327-cuddly-smooth-trogon-59c02d@houat>
References: <20240327-cuddly-smooth-trogon-59c02d@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1:
- replace new code logic in v1 with past code version by reverting
  commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
- add missing code dependency from
  commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2")

---

Hi,

To clarify, the reason for my original patch, as explained in more detail
in my previous email, was that it fixed the issue while keeping the code
simpler (which was the original reason for the commit being reverted here).
But I perfectly understand opting for previously battle tested code. Makes
sense.

As requested I've reverted commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
and then executed both Timo's and my test cases, and 1h video playback.
I was unable to reproduce the bug with any of those cases. So the revert
seems to fix the bug.
Please note, and as stated in the commit message, due to a dependency to
DMA_FENCE_WARN this patch also restores the relevant code deleted
by commit d72277b6c37d ("dma-buf: nuke DMA_FENCE_TRACE macros v2").

A couple of things I've observed from dmesg:
- (1) it always triggers a single warning at boot, this is issued by
  `WARN_ON(list_empty(&release->bos));` @ qxl_release_free @ qxl_release.c
  Maybe better for this to be addressed separately from this patch?
- (2) there are quite a few `failed to wait on release xx after spincount
  301` messages as printed by the patch v2 code when the test case shell
  scripts are being executed.
- (3) there can be a single error message `[drm:qxl_release_from_id_locked
  [qxl]] *ERROR* failed to find id in release_idr`
- (4) occasional error messages about `[drm:drm_atomic_helper_commit_planes
  [drm_kms_helper]] *ERROR* head 9 wrong:`.

Issue (1) relates to this patch v2 and also happened with kernel from
base-commit 1870cdc0e8de (March 1st).
Issue (2) also relates to this patch v2 but only happens with kernel from
base-commit a6bd6c933339 (March 30th).
Both (3) and (4) are unrelated to this patch as they can occur
independently of it and I'm guessing these may be related to the recent
changes discussed in
https://lore.kernel.org/dri-devel/38d38331-3848-4995-b78e-a87ecae722d5@linux.intel.com/T/#u


For reference here is the output of (1):
```
[   20.779514] ------------[ cut here ]------------
[   20.779525] workqueue: WQ_MEM_RECLAIM ttm:ttm_bo_delayed_delete [ttm] is flushing !WQ_MEM_RECLAIM events:qxl_gc_work [qxl]
[   20.779666] WARNING: CPU: 1 PID: 601 at kernel/workqueue.c:3692 check_flush_dependency+0xfa/0x110
[   20.779683] Modules linked in: nfsv3 nfs_acl nfs lockd grace intel_rapl_msr intel_rapl_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvm_intel rfkill kvm snd_hda_codec_generic crct10dif_pclmul crct10dif_common crc32_pclmul ghash_clmulni_intel snd_hda_intel snd_intel_dspcfg sha512_ssse3 sha512_generic snd_hda_codec sha256_ssse3 snd_hwdep sha1_ssse3 snd_hda_core sunrpc binfmt_misc snd_pcm aesni_intel qxl drm_ttm_helper ttm crypto_simd snd_timer cryptd rapl snd virtio_balloon virtio_console drm_kms_helper pcspkr soundcore button evdev joydev serio_raw drm loop fuse efi_pstore dm_mod configfs qemu_fw_cfg virtio_rng autofs4 ext4 crc32c_generic crc16 mbcache jbd2 virtio_net ata_generic net_failover virtio_blk failover uhci_hcd ata_piix ehci_hcd libata scsi_mod usbcore crc32c_intel i2c_piix4 virtio_pci virtio psmouse virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring floppy scsi_common usb_common
[   20.779825] CPU: 1 PID: 601 Comm: kworker/u13:1 Not tainted 6.9.0-rc1-next-20240328-amd64-00001-g756220c4615c #81
[   20.779833] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
[   20.779837] Workqueue: ttm ttm_bo_delayed_delete [ttm]
[   20.779862] RIP: 0010:check_flush_dependency+0xfa/0x110
[   20.779869] Code: ff ff 49 8b 55 18 48 8d 8b c0 00 00 00 49 89 e8 48 81 c6 c0 00 00 00 48 c7 c7 c0 16 44 8d c6 05 e7 75 b3 01 01 e8 86 97 fd ff <0f> 0b e9 21 ff ff ff 80 3d d5 75 b3 01 00 75 96 e9 4d ff ff ff 90
[   20.779875] RSP: 0000:ffffb59600dd7cc8 EFLAGS: 00010082
[   20.779880] RAX: 0000000000000000 RBX: ffff9af88104ee00 RCX: 0000000000000027
[   20.779902] RDX: ffff9af8fdd21708 RSI: 0000000000000001 RDI: ffff9af8fdd21700
[   20.779906] RBP: ffffffffc0882570 R08: 0000000000000000 R09: 0000000000000003
[   20.779910] R10: ffffb59600dd7b58 R11: ffffffff8dcc83e8 R12: ffff9af894498000
[   20.779914] R13: ffff9af89558d780 R14: ffffb59600dd7cf8 R15: 0000000000000001
[   20.779918] FS:  0000000000000000(0000) GS:ffff9af8fdd00000(0000) knlGS:0000000000000000
[   20.779924] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.779928] CR2: 00005574b0bd4148 CR3: 000000001fb40002 CR4: 0000000000370ef0
[   20.779994] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   20.779999] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   20.780003] Call Trace:
[   20.780135]  <TASK>
[   20.780144]  ? __warn+0x7c/0x120
[   20.780153]  ? check_flush_dependency+0xfa/0x110
[   20.780161]  ? report_bug+0x160/0x190
[   20.780169]  ? prb_read_valid+0x17/0x20
[   20.780179]  ? handle_bug+0x41/0x70
[   20.780186]  ? exc_invalid_op+0x13/0x60
[   20.780193]  ? asm_exc_invalid_op+0x16/0x20
[   20.780201]  ? __pfx_qxl_gc_work+0x10/0x10 [qxl]
[   20.780221]  ? check_flush_dependency+0xfa/0x110
[   20.780228]  ? check_flush_dependency+0xfa/0x110
[   20.780234]  __flush_work+0xce/0x2c0
[   20.780244]  qxl_queue_garbage_collect+0x7f/0x90 [qxl]
[   20.780268]  qxl_fence_wait+0xa0/0x190 [qxl]
[   20.780287]  dma_fence_wait_timeout+0x5e/0x130
[   20.780313]  dma_resv_wait_timeout+0x7b/0xe0
[   20.780327]  ttm_bo_delayed_delete+0x26/0x80 [ttm]
[   20.780359]  process_one_work+0x184/0x3a0
[   20.780370]  worker_thread+0x273/0x390
[   20.780379]  ? __pfx_worker_thread+0x10/0x10
[   20.780388]  kthread+0xcb/0x100
[   20.780396]  ? __pfx_kthread+0x10/0x10
[   20.780404]  ret_from_fork+0x2d/0x50
[   20.780416]  ? __pfx_kthread+0x10/0x10
[   20.780421]  ret_from_fork_asm+0x1a/0x30
[   20.780435]  </TASK>
[   20.780437] ---[ end trace 0000000000000000 ]---
```


TLDR: this patch fixes the instability issues. But there may be warnings
in dmesg. Errors in dmesg were observed too but they are unrelated to this
patch.


Thank you for your time.

---

Alex Constantino (1):
  Revert "drm/qxl: simplify qxl_fence_wait"

 drivers/gpu/drm/qxl/qxl_release.c | 50 +++++++++++++++++++++++++++----
 include/linux/dma-fence.h         |  7 +++++
 2 files changed, 52 insertions(+), 5 deletions(-)


base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
-- 
2.39.2


