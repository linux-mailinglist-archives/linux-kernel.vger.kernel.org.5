Return-Path: <linux-kernel+bounces-37781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0883B4F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D299F28252B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB82136657;
	Wed, 24 Jan 2024 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="WJFS7xNw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DAD13BEAD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136312; cv=none; b=L99op+x4xW+fOKxdLb+BexpkTQqPDYiTogamyOACPXrOfhvMbNRVbKPRL8lLJOutI/OvsnESJTCIth1r3q8Htlpbj5JLOzajNvcP2HzcXU1qbmxgOVpNsClwYE9Pob/MifV11EeXZQABzrXg0+OdyqqlMjzxjsSKy0GivyEYRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136312; c=relaxed/simple;
	bh=zNTGg9O1uHTrMo5a7o/kgsOPTdOlZEvPH/Xn6YUvYH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jk5zfOxUsdcgIyORX8YiFgI9j3L4aNJtyCGCGIVPBbx2cK427yI8URcPvvgA/+doKQGx/cHh++SxRGmROZ7RWEoLv2y4sWwTxj1bLctd+7UXWP8SBWnRz9kZPWZ9XRTO4PBQsDRW5SlCnohusN77ILa4nJIDBRtowJW05on3sCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=WJFS7xNw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d750660a0aso20918575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136311; x=1706741111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gIkGh+5ZA5vLoI2IrUm8KS6UN+4kyipoUtsV0cpcNc=;
        b=WJFS7xNwmT+gIUl8u29UaK4lxySrnqxgDYGndqZryyaMAb8Jbz9BizViM5zq29fAzB
         7XbaUy+lOFmuBbpnT5dsYRiuE7ffzH1TIGa0m8RO5PjfLkXy29q3Oebw1uVrGFoi5pbT
         xVnxKM6tWmKBBnQvMJCo3ykOZ/naHSCxHH15AGlSwRs0oCWPa3ArjcWRWzN7842/JCRx
         C9/ocZWOMf/FuYLkSOfFn/Ne636+EDhJOrnjcbzbLffxoHRyTBD5988Gj8/aZgxLdbPw
         rKm2kkcMtPygU1CVdaOX8BDsImTOGZZWIDLovh4I7DCFWvu2iDu8gGLlu0++GmvefUGu
         Hqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136311; x=1706741111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gIkGh+5ZA5vLoI2IrUm8KS6UN+4kyipoUtsV0cpcNc=;
        b=K7rp5CsqrlLkv8vvkJSDGlCpx6THh2aXLTRkGi7+4YzZzUVQggv7JB6Rxx1VNBweRy
         4VF3ZJWSr+EVOmwv/AOFr3S6QXStz5AadhzgSy4mxzLPp87oQPRaOLY0viya6Cawgfqh
         n9zo/edvlBkJSSqTa3U6zhhn0QzoGCb4gxLAERjvxs1fA3h3+ZooAhXtXuo+BUrMpEjo
         PjkLu2A3tPdZSjqNaNIMWtyhRJGjXCdBLJZl9wM7YFgX3/hjkMrLkFcq3Z5dKgGd7aAp
         6Cm8fCyee+5JbpIODDCV6Ucp1NRUTjIpRCSC5FgLJNKenOKXIB5tVWAt3aFNiGvp0/lb
         Hahg==
X-Gm-Message-State: AOJu0YzFPnbBEyWCDkV49QlEcS4ipH1PRw7STgOIQijV21AumOubkaz/
	cAQ1FPwSs6HiyM1f9NMNJV08KGNEvWXHaXu1Ec8gLGkF5KGKAcn4Hr09MdcfsQtZcGGjY6m6cKj
	r
X-Google-Smtp-Source: AGHT+IE+DlB1U3o9qKXsnNs+kyZuaFEl0+8kZISKy7YLvlJupgUy72qwTWRQ14oAMijqbYNelUl1+w==
X-Received: by 2002:a17:903:2498:b0:1d5:30fd:26b6 with SMTP id p24-20020a170903249800b001d530fd26b6mr98904plw.66.1706136310765;
        Wed, 24 Jan 2024 14:45:10 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:45:10 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 16/18] Staging: rtl8192e: Rename variable LpsIdleCount
Date: Wed, 24 Jan 2024 14:44:50 -0800
Message-Id: <20240124224452.968724-17-tdavies@darkphysics.net>
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

Rename variable LpsIdleCount to lps_idle_count to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 4 ++--
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 44a9fe831849..5aac9110bff6 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -208,12 +208,12 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 		return;
 
 	if (psc->bLeisurePs) {
-		if (psc->LpsIdleCount >= RT_CHECK_FOR_HANG_PERIOD) {
+		if (psc->lps_idle_count >= RT_CHECK_FOR_HANG_PERIOD) {
 
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED)
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST | RTLLIB_PS_UNICAST);
 		} else {
-			psc->LpsIdleCount++;
+			psc->lps_idle_count++;
 		}
 	}
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 8de46b61416b..0ca38ca4d3af 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1071,7 +1071,7 @@ struct rt_pwr_save_ctrl {
 	enum ips_callback_function ReturnPoint;
 
 	bool				bLeisurePs;
-	u8				LpsIdleCount;
+	u8				lps_idle_count;
 	u8				lps_awake_intvl;
 
 	u32				CurPsLevel;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index e47292455585..a7e7a0b0214f 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1079,7 +1079,7 @@ static void rtllib_associate_complete_wq(void *data)
 		ieee->link_detect_info.NumRecvBcnInPeriod = 1;
 		ieee->link_detect_info.NumRecvDataInPeriod = 1;
 	}
-	psc->LpsIdleCount = 0;
+	psc->lps_idle_count = 0;
 	ieee->link_change(ieee->dev);
 }
 
-- 
2.39.2


