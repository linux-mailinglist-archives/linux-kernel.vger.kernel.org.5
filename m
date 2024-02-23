Return-Path: <linux-kernel+bounces-78226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C14861079
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4451C234B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C07179DB5;
	Fri, 23 Feb 2024 11:34:57 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA001758D;
	Fri, 23 Feb 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688096; cv=none; b=pFvCA1mpO+p0/XVpOSkg9c7MYekXBH+Fp5I/LAB41THDDa9avQOxVSEeRwjwwLmFnbaDk/ZpzQkfKbnwF2vfULzRMIwWcDPu7SkTBUU4nQHrrZYPhd0t5i2YLRAZym1hl17gxOXXNeicO4YJOWDF73T+F+heRJpnCjvPilVbkXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688096; c=relaxed/simple;
	bh=IYOdq5sD1YmRKu7QJkXS/lwxV/Q8L01LSzl/baU/5A8=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=nYzM8qnibq8E72mu3p04DnDS/8oFUXtC5hc557WteLwQEzJhoS+ppHmZn2E0GvcMFb0bZ4xvgiSbYo5cYiOvF/OttG5xiQPGIGSyqeJsUmYHGbwq8Cy6hyQamkQW1ogHBX32FqHPc3TEsOmyQ+64E03TgKMtyTIUYje+9dFRQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68dc5.dsl.pool.telekom.hu [::ffff:81.182.141.197])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000075253.0000000065D882DC.001DC1EC; Fri, 23 Feb 2024 12:34:52 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Shenghao Ding <shenghao-ding@ti.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
  alsa-devel@alsa-project.org, Gergo Koteles <soyer@irl.hu>,
  stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: tas2781: enable subwoofer volume control
Date: Fri, 23 Feb 2024 12:34:30 +0100
Message-ID: <7ffae10ebba58601d25fe2ff8381a6ae3a926e62.1708687813.git.soyer@irl.hu>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

The volume of subwoofer channels is always at maximum with the
ALC269_FIXUP_THINKPAD_ACPI chain.

Use ALC285_FIXUP_THINKPAD_HEADSET_JACK to align it to the master volume.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=208555#c827

Fixes: 3babae915f4c ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ec1312bffd5..24a26959070f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9585,7 +9585,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = tas2781_fixup_i2c,
 		.chained = true,
-		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
+		.chain_id = ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	},
 	[ALC287_FIXUP_YOGA7_14ARB7_I2C] = {
 		.type = HDA_FIXUP_FUNC,

base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
-- 
2.43.2


