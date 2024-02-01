Return-Path: <linux-kernel+bounces-47723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FF8451CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EC728E4D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58791586E6;
	Thu,  1 Feb 2024 07:13:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3351157E94;
	Thu,  1 Feb 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771589; cv=none; b=FXFPJPfxkshmq2Rq3H+6lreKzw07qZwA4gWNTLjcWMQyXoNzZraXIcF2NyO0ckZn2IaLk03nfo3ENAirbDcqGkdwG6g5+YjV4/0QIUajXAzyY4xlkqxc3XB6SomVoiajvnW/+UyL1jVF/LocnpJ/kQWufiK0p5jthTnVHqaOxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771589; c=relaxed/simple;
	bh=huJMH0x/uqn1CsjcUxnVfiPIVCd0M2fQhOLMlIRHHMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MYwNwimYprF2q0T3nCuGFwwXiqVq0mKqu3wODJOFO/sw5/fhAjseaRmSNx+ftEjcJv/WwYZJk4/7qCy3+4/mgBzJRemOIHqPv1/tJ4CgTYnP8IUNayxYQmTIrwxWK9Yw+qQ3Z1OmKn9nycC9hO0YxNmcM5o/p7VdkNJeBhMS6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 791b174af724403da7687f9cd8aebb6e-20240201
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:e3ed52e8-b592-4d07-9f9e-0e04c6561891,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:e3ed52e8-b592-4d07-9f9e-0e04c6561891,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:de707f83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:2402011502192136VGHT,BulkQuantity:0,Recheck:0,SF:24|17|19|44|66|38|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 791b174af724403da7687f9cd8aebb6e-20240201
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 568714648; Thu, 01 Feb 2024 15:02:18 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>
Cc: Cong Liu <liucong2@kylinos.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev/core: Replace deprecated simple_strtol with kstrtol
Date: Thu,  1 Feb 2024 15:02:16 +0800
Message-Id: <20240201070216.3291999-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces the use of the deprecated simple_strtol [1] function
in the modedb.c file with the recommended kstrtol function. This change
improves error handling and boundary checks.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/video/fbdev/core/modedb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 7196b055f2bd..eebbbc7e2aa3 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -661,7 +661,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				namelen = i;
 				if (!refresh_specified && !bpp_specified &&
 				    !yres_specified) {
-					refresh = simple_strtol(&name[i+1], NULL,
+					refresh = kstrtol(&name[i+1], NULL,
 								10);
 					refresh_specified = 1;
 					if (cvt || rb)
@@ -672,7 +672,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			case '-':
 				namelen = i;
 				if (!bpp_specified && !yres_specified) {
-					bpp = simple_strtol(&name[i+1], NULL,
+					bpp = kstrtol(&name[i+1], NULL,
 							    10);
 					bpp_specified = 1;
 					if (cvt || rb)
@@ -682,7 +682,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 				break;
 			case 'x':
 				if (!yres_specified) {
-					yres = simple_strtol(&name[i+1], NULL,
+					yres = kstrtol(&name[i+1], NULL,
 							     10);
 					yres_specified = 1;
 				} else
@@ -719,7 +719,7 @@ int fb_find_mode(struct fb_var_screeninfo *var,
 			}
 		}
 		if (i < 0 && yres_specified) {
-			xres = simple_strtol(name, NULL, 10);
+			xres = kstrtol(name, NULL, 10);
 			res_specified = 1;
 		}
 done:
-- 
2.34.1


