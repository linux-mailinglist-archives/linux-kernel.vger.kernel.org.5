Return-Path: <linux-kernel+bounces-13294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB7382031E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE6928388C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96790A5B;
	Sat, 30 Dec 2023 00:10:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8447F;
	Sat, 30 Dec 2023 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b6838a.dsl.pool.telekom.hu [::ffff:81.182.131.138])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000071EB8.00000000658F5FCE.0014D494; Sat, 30 Dec 2023 01:09:50 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
  Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v2 0/4] ALSA: hda/tas2781: Add tas2563 support
Date: Sat, 30 Dec 2023 01:09:41 +0100
Message-ID: <cover.1703891777.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701906455.git.soyer@irl.hu>
References: <cover.1701906455.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The tas2781-hda driver can be modified to support tas2563 as well.
Before knowing this information, I created another series for a
new driver.
Link: https://lore.kernel.org/lkml/cover.1701733441.git.soyer@irl.hu/

This series now extends tas2781-hda.

The tas2563 is a smart amplifier. Similar to tas2562 but with DSP. Some
Lenovo laptops have it to drive the bass speakers. By default, it is in
software shutdown state.

To make the DSP work it needs a firmware and some calibration data.
The latter can be read from the EFI in Lenovo laptops.

For the correct configuration it needs additional register data.
It captured after running the Windows driver.

The firmware can be extracted as TAS2563Firmware.bin from the Windows
driver with innoextract.
https://download.lenovo.com/consumer/mobiles/h5yd037fbfyy7kd0.exe

The driver will search for it as TAS2XXX3870.bin with the Lenovo Yoga 7 
14ARB7.

The captured registers extracted with TI's regtool: 
https://github.com/soyersoyer/tas2563rca/raw/main/INT8866RCA2.bin

Changes since v1:
- fixes were sent as individual patches
- rebased onto for-next
- adding the missed fixup

Gergo Koteles (4):
  ALSA: hda/tas2781: add ptrs to calibration functions
  ALSA: hda/tas2781: add configurable global i2c address
  ALSA: hda/tas2781: add TAS2563 support for 14ARB7
  ALSA: hda/tas2781: add fixup for Lenovo 14ARB7

 include/sound/tas2781.h           |   8 +++
 sound/pci/hda/patch_realtek.c     |  14 ++++
 sound/pci/hda/tas2781_hda_i2c.c   | 115 ++++++++++++++++++++++++++----
 sound/soc/codecs/tas2781-comlib.c |  15 ++++
 4 files changed, 137 insertions(+), 15 deletions(-)


base-commit: 64bf8dec54cfe57f416884a6b3d54c7f4259e93f
-- 
2.43.0


