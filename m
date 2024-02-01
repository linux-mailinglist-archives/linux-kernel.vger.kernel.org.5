Return-Path: <linux-kernel+bounces-47724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C490F8451CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EAEB264A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB7157E90;
	Thu,  1 Feb 2024 07:13:09 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DB3157E9E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706771589; cv=none; b=MPD7DNpyqmb1vT5rWD9k4iAXI0R/qzfpFHZoogIfkeJDHlkrbHMY49gQwjbl9GFuc1Q7z02pnovd5ACakftafr/EibwT5u1CQaXUoDr3EdB3nCVh9PQj035i7O6c61y5deVvoSzcwE3IsVBrb9Lw/81CDVvhoOdBRwpzm5LFxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706771589; c=relaxed/simple;
	bh=RpMnmw/an2pFxmoLlqNIiJawqVl2hGBpf8rsHawUFx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTbVGY6DSpiyVHB+rEcErg3wipFknyC543w8hfIyW4ZwWaCsEKC1AlD+eizTPJiG+n++pOunqiFlFZjd8YDXMEWH4TnGm1PKeuHSw9ewhRZgBkNtnoC55T+q0LuGh7yi1r8Jk5PQ4EKhMbaX3L9R5PVmxZpefzJkAPWgygd17Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 764c45ccbd574fcc909a3d5b5243e43a-20240201
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:91f91266-b94d-412b-b9d1-95986282e5bc,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.35,REQID:91f91266-b94d-412b-b9d1-95986282e5bc,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:43717f83-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:240201150228KA92BHID,BulkQuantity:0,Recheck:0,SF:19|44|66|38|24|17|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULS
X-UUID: 764c45ccbd574fcc909a3d5b5243e43a-20240201
X-User: liucong2@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1569227187; Thu, 01 Feb 2024 15:02:27 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Cong Liu <liucong2@kylinos.cn>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/modes: Replace deprecated simple_strtol with kstrtol
Date: Thu,  1 Feb 2024 15:02:25 +0800
Message-Id: <20240201070226.3292315-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces the use of the deprecated simple_strtol [1] function
in the drm_modes.c file with the recommended kstrtol function. This change
improves error handling and boundary checks.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 drivers/gpu/drm/drm_modes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 893f52ee4926..fce0fb1df9b2 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1942,7 +1942,7 @@ static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
 		return -EINVAL;
 
 	str++;
-	bpp = simple_strtol(str, end_ptr, 10);
+	bpp = kstrtol(str, end_ptr, 10);
 	if (*end_ptr == str)
 		return -EINVAL;
 
@@ -1961,7 +1961,7 @@ static int drm_mode_parse_cmdline_refresh(const char *str, char **end_ptr,
 		return -EINVAL;
 
 	str++;
-	refresh = simple_strtol(str, end_ptr, 10);
+	refresh = kstrtol(str, end_ptr, 10);
 	if (*end_ptr == str)
 		return -EINVAL;
 
@@ -2033,7 +2033,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	int remaining, i;
 	char *end_ptr;
 
-	xres = simple_strtol(str, &end_ptr, 10);
+	xres = kstrtol(str, &end_ptr, 10);
 	if (end_ptr == str)
 		return -EINVAL;
 
@@ -2042,7 +2042,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	end_ptr++;
 
 	str = end_ptr;
-	yres = simple_strtol(str, &end_ptr, 10);
+	yres = kstrtol(str, &end_ptr, 10);
 	if (end_ptr == str)
 		return -EINVAL;
 
@@ -2100,7 +2100,7 @@ static int drm_mode_parse_cmdline_int(const char *delim, unsigned int *int_ret)
 		return -EINVAL;
 
 	value = delim + 1;
-	*int_ret = simple_strtol(value, &endp, 10);
+	*int_ret = kstrtol(value, &endp, 10);
 
 	/* Make sure we have parsed something */
 	if (endp == value)
-- 
2.34.1


