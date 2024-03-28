Return-Path: <linux-kernel+bounces-123787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C50890DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8DED1F23FC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206753FBA1;
	Thu, 28 Mar 2024 22:48:01 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B61D68F;
	Thu, 28 Mar 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711666080; cv=none; b=AAizFBf8dgC8l5MarwZxu6EYdoz0QDs56addKZZry94yGHb/t3gh4SzIxy+nXUDdXxmchwut8iearyQeg0Ad4FVhNZl3syEIUtLticW/MEB2sidWV3Wx1yuGLf0Q5ZAykMTfUDk1V7hqc0oLL33RGe/braKQHgMo+mZ8+HWAQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711666080; c=relaxed/simple;
	bh=4ad7yQtm68+AT2mdcchsQ2drGN+aCD6c8DrgJXxKOTI=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=RRDG6CCJjjHw4bXTTGdHk+wZ/Ro75Zyo/90Tf2omi1DKa3S58HGHs8HOGFGU/GO6Q4gEa1l8phqYrw4yK9brvbtl4mqUovxmDHiUxNO+8C6FqvvknQOGmr5rH8VceCGUZvPcOMN5OqTgrmJDfXlOtmPRsQZlKBb6l5mQFmv4KHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b68717.dsl.pool.telekom.hu [::ffff:81.182.135.23])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000069CB0.000000006605F396.0024401B; Thu, 28 Mar 2024 23:47:50 +0100
From: Gergo Koteles <soyer@irl.hu>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
  Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>,
  kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: tas2781: mark dvc_tlv with __maybe_unused
Date: Thu, 28 Mar 2024 23:47:37 +0100
Message-ID: <0e461545a2a6e9b6152985143e50526322e5f76b.1711665731.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Since we put dvc_tlv static variable to a header file it's copied to
each module that includes the header. But not all of them are actually
used it.

Fix this W=1 build warning:

include/sound/tas2781-tlv.h:18:35: warning: 'dvc_tlv' defined but not
used [-Wunused-const-variable=]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403290354.v0StnRpc-lkp@intel.com/
Fixes: ae065d0ce9e3 ("ALSA: hda/tas2781: remove digital gain kcontrol")
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 include/sound/tas2781-tlv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sound/tas2781-tlv.h b/include/sound/tas2781-tlv.h
index 4038dd421150..1dc59005d241 100644
--- a/include/sound/tas2781-tlv.h
+++ b/include/sound/tas2781-tlv.h
@@ -15,7 +15,7 @@
 #ifndef __TAS2781_TLV_H__
 #define __TAS2781_TLV_H__
 
-static const DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
+static const __maybe_unused DECLARE_TLV_DB_SCALE(dvc_tlv, -10000, 100, 0);
 static const DECLARE_TLV_DB_SCALE(amp_vol_tlv, 1100, 50, 0);
 
 #endif

base-commit: 2d0401ee38d43ab0e4cdd02dfc9d402befb2b5c8
-- 
2.44.0


