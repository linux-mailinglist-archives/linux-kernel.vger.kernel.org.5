Return-Path: <linux-kernel+bounces-37775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7B983B4EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69AC2847DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498B13AA4A;
	Wed, 24 Jan 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="hT7HK7xX"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6812813A253
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136307; cv=none; b=CdhtLbq6+rwwF3tc26ASvq6gefDirumL4d10knM2l+bfMXgZ1l70lVHS4+mcYqG27vuSrYUfJIuUSXxvfnvb1S8rNdUQCXhUlY/svyOGJ0rrh92ls05LTxcaEDsqVGYz10u09OZINMwArcwT3mzgxT/uqL5Dm5oekaIjXjuaYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136307; c=relaxed/simple;
	bh=T8lAXHhEHXiLGL3ETUNkKXFoMHqYxZITdgqKthPPRAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pH0iUoomQtpegIMW1IpTMUIWJtmnOgN+IG3taYm6ZHjI3hcUhuuX2NTNxofceLCehmrBgFGAAnfSNQBKMuCgxpfV0DKnD0HqDR8fHaLoKHP1wF4IgCrAbgFmVbgtsPFuathMk3pI5rLA0jmCm1DOR34598Wr3EzsXypFCLypYCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=hT7HK7xX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d70a98c189so37730305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136305; x=1706741105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkLFSrZwI1mLWOk8tlT9qQKCr92CB+cIr/Ab2HCh9y4=;
        b=hT7HK7xXF93/OeRVTYZD2pxEplHzTACGWY8d0Xfuadp8QPhPUPPsXtA+oBaXZxlETl
         gRS5/i4on+FoM5XM8EZtCAejDpS/PfL0YceFv3CH47LiHbWGYmssYeNjkTGLOrnOFE3q
         uywqO8b6f47IzQDw/HlGBObVnWpJ3lPLSc/nJo9Gvo5eOZbAOTvhqK52rqERNDbdx3/i
         gvCcboUgfqlnQ7dO6HOtoj7q88j2X0bWXqLXHAs+K9E1oA8KFLvcxogqnMbD/rcTJPqQ
         PJvko1nNSD9MZYPyn4zrGaInq/CFa7zSg8cQqZR8OxJ2DLIfIZimQTQlDbGTqtQnloCH
         5G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136305; x=1706741105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkLFSrZwI1mLWOk8tlT9qQKCr92CB+cIr/Ab2HCh9y4=;
        b=DvKaxJ08rF5B2nn5H/NNxbM0BTQCZB9laHvadCA1BX2aKNaNv13JRcGWrEaiKIMK4m
         +Fx6sadqraU8Qtu7UG3R5IujUKzazxnpI/uwajb9Wdgv6GSAmWKOej1e6ZOU6rwQIdyA
         l5Deo6znJJz7m57ZUX2007zmK3jI3/yGR6X/AqMA8/1ROwFhy3Xu7anUheda3dXcHdQz
         fVuef6ia4BU9+47uGR/rOEr2s55XIKNUltUQtOX5eddolHNisdi4h0pAEFP/PuN8CWfS
         QmVIVn+D/UTRUitlslWFg5CcbGrATMDNc0F3LRzGhmKC3H/YXgSNcsV1U5mD9MsGuXAH
         UXTg==
X-Gm-Message-State: AOJu0YzTp070VyQr77wiUzfv0x/GZwutxSpWS28IoFVdwCJbY10DM3Qu
	IunP1x9Qkq9piVgEMF/6BbSGfwI/n63JlmKmzc8jKk3J43OftC36gaJnx8mehwY=
X-Google-Smtp-Source: AGHT+IGARAk/mAfacGPn7QsTncZe4CTVXvHB9y9nqos69NaacsWX/HzgYBBS4ug7vrtqPs1/d3i/xQ==
X-Received: by 2002:a17:903:24d:b0:1d5:b948:36a5 with SMTP id j13-20020a170903024d00b001d5b94836a5mr82360plh.95.1706136304829;
        Wed, 24 Jan 2024 14:45:04 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:04 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/18] Staging: rtl8192e: Rename variable SelfHTCap
Date: Wed, 24 Jan 2024 14:44:44 -0800
Message-Id: <20240124224452.968724-11-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124224452.968724-1-tdavies@darkphysics.net>
References: <20240124224452.968724-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable SelfHTCap to self_ht_cap to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index 18dab893270f..a4580445305d 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -98,7 +98,7 @@ struct rt_hi_throughput {
 	u8 cur_short_gi_40mhz;
 	u8 cur_short_gi_20mhz;
 	enum ht_spec_ver peer_ht_spec_ver;
-	struct ht_capab_ele SelfHTCap;
+	struct ht_capab_ele self_ht_cap;
 	u8 peer_ht_cap_buf[32];
 	u8 peer_ht_info_buf[32];
 	u8 ampdu_enable;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 98f0ac80f1fd..76f115f56680 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -516,8 +516,8 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	ht_info->current_mpdu_density = 0;
 	ht_info->CurrentAMPDUFactor = ht_info->ampdu_factor;
 
-	memset((void *)(&ht_info->SelfHTCap), 0,
-	       sizeof(ht_info->SelfHTCap));
+	memset((void *)(&ht_info->self_ht_cap), 0,
+	       sizeof(ht_info->self_ht_cap));
 	memset((void *)(&ht_info->peer_ht_cap_buf), 0,
 	       sizeof(ht_info->peer_ht_cap_buf));
 	memset((void *)(&ht_info->peer_ht_info_buf), 0,
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 545f79387991..60598b41fb9f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -728,8 +728,8 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (ieee->ht_info->current_ht_support && ieee->ht_info->enable_ht) {
-		ht_cap_buf = (u8 *)&ieee->ht_info->SelfHTCap;
-		ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
+		ht_cap_buf = (u8 *)&ieee->ht_info->self_ht_cap;
+		ht_cap_len = sizeof(ieee->ht_info->self_ht_cap);
 		ht_construct_capability_element(ieee, ht_cap_buf, &ht_cap_len,
 					     encrypt, true);
 		if (ieee->ht_info->current_rt2rt_aggregation) {
-- 
2.39.2


