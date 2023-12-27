Return-Path: <linux-kernel+bounces-12002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87581EEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB64E283937
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4156446CA;
	Wed, 27 Dec 2023 11:59:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA9F446B3;
	Wed, 27 Dec 2023 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=senarytech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=senarytech.com
Received: from book-ThinkStation-P328.. (unknown [61.183.143.78])
	by mail-m12756.qiye.163.com (Hmail) with ESMTPA id 459A0DC0636;
	Wed, 27 Dec 2023 15:10:20 +0800 (CST)
From: bo liu <bo.liu@senarytech.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bo liu <bo.liu@senarytech.com>
Subject: [PATCH 2/3] Fix headset auto detect fail in cx8070 and SN6140
Date: Wed, 27 Dec 2023 15:10:07 +0800
Message-Id: <20231227071008.13665-2-bo.liu@senarytech.com>
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
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQ0gdVkhMTBoaSUNJSE5MQ1UTARMWGhIXJBQOD1
	lXWRgSC1lBWU1KVUpDSFVKT0hVTENZV1kWGg8SFR0UWUFZT0tIVUpNT0lMTlVKS0tVSkJLS1kG
X-HM-Tid: 0a8caa1c2524b223kuuu459a0dc0636
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NTo6Dio5MDwrAQkJODg#HAxL
	IyJPFAlVSlVKTEtITU1KS0lKSU9JVTMWGhIXVRkUVRcSDjsIHhUaCQIPHhgTVRgUFkVZV1kSC1lB
	WU1KVUpDSFVKT0hVTENZV1kIAVlBT0lOSDcG

CX8070 and SN6140 will get wrong headset type when use OMTP headset,
then the headset mic will not work.

Signed-off-by: bo liu <bo.liu@senarytech.com>
---
 sound/pci/hda/patch_conexant.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 2d58595bfbdd..9ebc0709a202 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -184,11 +184,10 @@ static int cx_auto_init(struct hda_codec *codec)
 		snd_hda_codec_write(codec, 0x1c, 0, 0x4f0, 0x0eb);
 		/* fix reboot headset recognize fail issue */
 		mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
-		if (mic_persent&0x80000000) {
+		if (mic_persent&0x80000000) 
 			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
-		} else {
+		else
 			snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
-		}
 		break;
 	}
 
@@ -209,46 +208,46 @@ static void cx_auto_free(struct hda_codec *codec)
 	cx_auto_shutdown(codec);
 	snd_hda_gen_free(codec);
 }
- 
+
 static int headset_present_flag;
 static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	unsigned int val,phone_present,mic_persent,phone_tag,mic_tag;
+	unsigned int val, phone_present, mic_persent,phone_tag, mic_tag;
 	unsigned int count=0;
-	
+
 	switch (codec->core.vendor_id) {
 	case 0x14f11f86:
 	case 0x14f11f87:
 		/* check hp&mic tag to process headset pulgin&plugout */
 		phone_tag = snd_hda_codec_read(codec, 0x16, 0, 0xf08, 0x0);
 		mic_tag = snd_hda_codec_read(codec, 0x19, 0, 0xf08, 0x0);
-		if((phone_tag&(res>>26)) || (mic_tag&(res>>26))) {
-			//msleep(600);
+		if ((phone_tag&(res>>26)) || (mic_tag&(res>>26))) {
 			phone_present = snd_hda_codec_read(codec, 0x16, 0, 0xf09, 0x0);
-			if(!(phone_present&0x80000000)) {/* headphone plugout */
+			if (!(phone_present&0x80000000)) {/* headphone plugout */
 				headset_present_flag = 0;
 				snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x20);
 				break;
 			}
 			if (headset_present_flag == 0) {
 				headset_present_flag = 1;
-			} else if(headset_present_flag == 1) {
+			} else if (headset_present_flag == 1) {
 				mic_persent = snd_hda_codec_read(codec, 0x19, 0, 0xf09, 0x0);
-				if ((phone_present&0x80000000)&&(mic_persent&0x80000000)) {/* headset is present */
+				/* headset is present */
+				if ((phone_present&0x80000000) && (mic_persent&0x80000000)) {
 					/* wait headset detect done */
 					do {
-						val = snd_hda_codec_read(codec, 0x1c, 0, 0xca0, 0x0);
-						if(val&0x080) {
+						val = snd_hda_codec_read(codec, 0x1c,
+									0, 0xca0, 0x0);
+						if (val&0x080)
 							break;
-						}
-						msleep(10);
+						msleep(20);
 						count += 1;
-					} while(count > 5);
+					} while (count > 3);
 					val = snd_hda_codec_read(codec, 0x1c, 0, 0xcb0, 0x0);
-					if(val&0x800) {
+					if (val&0x800) {
 						codec_dbg(codec, "headset plugin, type is CTIA\n");
 						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
-					} else if(val&0x400) {
+					} else if (val&0x400) {
 						codec_dbg(codec, "headset plugin, type is OMTP\n");
 						snd_hda_codec_write(codec, 0x19, 0, 0x707, 0x24);
 					} else {
-- 
2.34.1


