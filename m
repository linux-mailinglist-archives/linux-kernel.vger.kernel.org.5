Return-Path: <linux-kernel+bounces-11881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFC81ECDE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADD3B21816
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926153B9;
	Wed, 27 Dec 2023 07:18:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m12746.qiye.163.com (mail-m12746.qiye.163.com [115.236.127.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7823E5392;
	Wed, 27 Dec 2023 07:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id 01270DC0610;
	Wed, 27 Dec 2023 15:10:23 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH 3/3] Fix headset auto detect fail in cx8070 and SN6140
Date: Wed, 27 Dec 2023 15:10:08 +0800
Message-Id: <20231227071008.13665-3-bo.liu@senarytech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227071008.13665-1-bo.liu@senarytech.com>
References: <20231227071008.13665-1-bo.liu@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB1DVk1LHxlKGUMYGU9CTlUTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8caa1c33b6b223kuuu01270dc0610
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6Ayo*Njw5KwkIODoqHE4S
	EykKCwNVSlVKTEtITU1KS0lPQkxCVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBSUNOSTcG

CX8070 and SN6140 will get wrong headset type when use OMTP headset,
then the headset mic will not work.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 9ebc0709a202..86e7241b4961 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -184,7 +184,7 @@ static int cx_auto_init(struct hda_codec *codec)
 		snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
 		/* fix reboot headset recognize fail issue */
 		mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
-		if (mic_persent&0x80000000) 
+		if (mic_persent&0x80000000)
 			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
 		else
 			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
@@ -212,7 +212,7 @@ static void cx_auto_free(struct hda_codec *codec)
 static int headset_present_flag;
 static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	unsigned int val, phone_present, mic_persent,phone_tag, mic_tag;
+	unsigned int val, phone_present, mic_persent, phone_tag, mic_tag;
 	unsigned int count=0;
 
 	switch (codec->core.vendor_id) {
@@ -236,13 +236,11 @@ static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 				if ((phone_present&0x80000000) && (mic_persent&0x80000000)) {
 					/* wait headset detect done */
 					do {
+						msleep(20);
 						val = snd_hda_codec_read(codec, 0x1c,
 									0, 0xca0, 0x0);
-						if (val&0x080)
-							break;
-						msleep(20);
 						count += 1;
-					} while (count > 3);
+					} while ((count > 3) || (val&0x080));
 					val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
 					if (val&0x800) {
 						codec_dbg(codec, "headset plugin, type is CTIA\n");
-- 
2.34.1


