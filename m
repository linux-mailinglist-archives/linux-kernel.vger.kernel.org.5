Return-Path: <linux-kernel+bounces-11891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8287F81ED04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8137BB2228B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73766569F;
	Wed, 27 Dec 2023 07:44:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904525666;
	Wed, 27 Dec 2023 07:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id E61892001FD;
	Wed, 27 Dec 2023 07:37:19 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 4ABEDA0083; Wed, 27 Dec 2023 08:37:07 +0100 (CET)
Date: Wed, 27 Dec 2023 08:37:07 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Oops in hdac_hda_dev_probe (6.7-rc7)
Message-ID: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

unfortunately, the latest 6.7.0-rc7 and the two previous rc kernels cause an
oops in hdac_hda_dev_probe(); sound and resume-from-suspend subsequently do
not work:


BUG: kernel NULL pointer dereference, address: 0000000000000078
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0
P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
Workqueue: events sof_probe_work

RIP: 0010:hdac_hda_dev_probe+0x42/0xf0
Code: 48 8b 37 48 8b bb c8 04 00 00 e8 09 9b 0a 00 48 85 c0 48 89 c5 0f 84 a6 00 00 00 48 8b bb c8 04 00 00 48 89 c6 e8 1e 9a 0a 00 <41> 80 7c 24 78 00 75 46 b9 03 00 00 00 48 c7 c2 c0 b2 a1 ac 48 c7
RSP: 0000:ffffc90000207b50 EFLAGS: 00010246

RAX: 0000000000000000 RBX: ffff88811495d000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888108691600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88811400b028
FS:  0000000000000000(0000) GS:ffff88886f500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000078 CR3: 00000002b7a5a000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die+0x1e/0x70
 ? page_fault_oops+0x17c/0x4b0
 ? snd_hdac_ext_bus_link_get+0x24/0xc0
 ? exc_page_fault+0x462/0x8e0
 ? asm_exc_page_fault+0x26/0x30
 ? hdac_hda_dev_probe+0x42/0xf0
 really_probe+0x166/0x300
 ? __pfx___device_attach_driver+0x10/0x10
 __driver_probe_device+0x6e/0x120
 driver_probe_device+0x1a/0x90
 __device_attach_driver+0x8e/0xd0
 bus_for_each_drv+0x90/0xf0
 __device_attach+0xac/0x1a0
 bus_probe_device+0x93/0xb0
 device_add+0x669/0x860
 snd_hdac_device_register+0x10/0x60
 hda_codec_probe_bus+0x189/0x290
 hda_dsp_probe+0x211/0x550
 sof_probe_work+0x2c/0x430
 ? process_one_work+0x19c/0x500
 process_one_work+0x205/0x500
 worker_thread+0x1dc/0x3e0

 ? __pfx_worker_thread+0x10/0x10
 kthread+0xea/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
Modules linked in:
CR2: 0000000000000078
---[ end trace 0000000000000000 ]---
RIP: 0010:hdac_hda_dev_probe+0x42/0xf0
Code: 48 8b 37 48 8b bb c8 04 00 00 e8 09 9b 0a 00 48 85 c0 48 89 c5 0f 84 a6 00 00 00 48 8b bb c8 04 00 00 48 89 c6 e8 1e 9a 0a 00 <41> 80 7c 24 78 00 75 46 b9 03 00 00 00 48 c7 c2 c0 b2 a1 ac 48 c7
RSP: 0000:ffffc90000207b50 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811495d000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888108691600 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88811400b028
FS:  0000000000000000(0000) GS:ffff88886f500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000078 CR3: 00000002b7a5a000 CR4: 0000000000f50ef0
PKRU: 55555554
note: kworker/2:0[24] exited with irqs disabled


I was able to bisect the issue to commit a0575b4add21 ("ASoC: hdac_hda:
Conditionally register dais for HDMI and Analog"). Reverting that patch on
top of mainline fixes it.

Best,
	Dominik

