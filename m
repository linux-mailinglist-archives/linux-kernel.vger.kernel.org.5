Return-Path: <linux-kernel+bounces-37768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8049183B4E8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB961C20C09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E80137C22;
	Wed, 24 Jan 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="YeImZ4xP"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F98135A7F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136300; cv=none; b=Tgx+zvON4sQBIfVtIxOtEJiKYbllma9Vnbt5brsYKFSsDP3YYp8Q/uylwT7XkTqbPybMdy6nFcIgZp7v472MI4P/2np7qjR294SNeHgVORR6njfS4CbSCG9GQ8fPxtLFQHuVRVwl6ZDklauPB9nKjAWY1dFI7JlOPxE/7g9uFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136300; c=relaxed/simple;
	bh=yjaeTV0WtXXorMCtYS00rvQnBP5KP664fSy4NR08CsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J81zFkr3W6QhuPJsk7237hYlUDWC3GsoEv1Ao6p+B5VQ/gkMR0NfokZjtH3hcu7h8IX/s5mKGwQ28/I3J7ISUve+0XFvC//6tfS6uaup7MbfjnRW7O6ujjkLJ8uyc5eisB5tnskxlmUjx1n2ri8LDPOVEtudBKCQBKs2sZP/Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=YeImZ4xP; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d751bc0c15so35019255ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136299; x=1706741099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqmpICGnSbhZYBTw1NATugWFKeRYRTOpi7VeoU0Msb4=;
        b=YeImZ4xPdwX+2dc5nyZPJjHx+IL4K5LW8r1QfEyrzAHppqkhYs3d9VtQ2fEpo3QiZk
         P5pl6xA8Lqwz4+eoN3v3Aa5I73lWCV4MKaT3x+iLFCfmbZ1a35dqZijQ6LcJ3a7fNGB+
         9nCOXOA+f004ztoZXSb5/q44QFwyUGZGEptMTu6NHawzAOZciOxY6b8CxG/z2fSpWoJD
         +SA4G6u7UbRsltFpIM9Nmcd2dQgOSo61VRpwuMrJ8bz0i6KYglpNLam3qYKyPtbvNA+R
         wgDDY0nOEKHRnFgmPSH16GjYKImt8XwSoGpGJ0dzjAAyEC5CB3Vj/OraJV+s24virf7V
         r2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136299; x=1706741099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqmpICGnSbhZYBTw1NATugWFKeRYRTOpi7VeoU0Msb4=;
        b=dys5KlT0GkXUud9CzeBBdgOWEooyEymBdiee0a38ICz2IMvFey4F4McmeIBsXtrBD5
         Cps2uATKqgiwHiqCrKk+V5Yazw46zfkxrLvI+DVW1W59edhnP9fFa4dksVoSkDBGLY7y
         JgNbREi0QKbQNF+ZUEHGtwbOCFeSDRgDLAg6Iw/rtSdYK/M+KF6mRHlrXkDI7C3aglfh
         ksJ9YeUUKqM1oR8VdxSNjMvmabJinn9l97OgoWI8VAJP4zhb56aowa/MYQGkFGZdrBuR
         ZKfRiut8E4j1Pf/juQkvD42EYFX18HasNrcyklM8smG+F48se55Teco//5D2Q2tnr7Gb
         TmSg==
X-Gm-Message-State: AOJu0YwS0JQsyhChPgC6TzkN4REKCBqk4gwyAuKiJx91PGnuuRM6rMKW
	ugXTW0C3G5/5nu8cCBLm6tUBtaDj0lPVPogKYPRIOTl/VM0hgmrsuWj1ZEoRwvQ=
X-Google-Smtp-Source: AGHT+IE3fWRM/KGM1SfiKW4qgAG8rBmrk4GOXaAk4Ta1UovW6uz+vNGqJ9A9Au3Im49rulGW462V6g==
X-Received: by 2002:a17:902:e5c3:b0:1d6:f240:87df with SMTP id u3-20020a170902e5c300b001d6f24087dfmr114928plf.4.1706136298789;
        Wed, 24 Jan 2024 14:44:58 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:58 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 03/18] Staging: rtl8192e: Rename variable LPSAwakeIntvl_tmp
Date: Wed, 24 Jan 2024 14:44:37 -0800
Message-Id: <20240124224452.968724-4-tdavies@darkphysics.net>
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

Rename variable LPSAwakeIntvl_tmp to lps_awake_intvl_tmp to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index cf855ba39c10..8a60bf3b7079 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1390,33 +1390,33 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 					       (psc->LPSAwakeIntvl + 1);
 		}
 		{
-			u8 LPSAwakeIntvl_tmp = 0;
+			u8 lps_awake_intvl_tmp = 0;
 			u8 period = ieee->current_network.dtim_period;
 			u8 count = ieee->current_network.tim.tim_count;
 
 			if (count == 0) {
 				if (psc->LPSAwakeIntvl > period)
-					LPSAwakeIntvl_tmp = period +
+					lps_awake_intvl_tmp = period +
 						 (psc->LPSAwakeIntvl -
 						 period) -
 						 ((psc->LPSAwakeIntvl - period) %
 						 period);
 				else
-					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
 
 			} else {
 				if (psc->LPSAwakeIntvl >
 				    ieee->current_network.tim.tim_count)
-					LPSAwakeIntvl_tmp = count +
+					lps_awake_intvl_tmp = count +
 					(psc->LPSAwakeIntvl - count) -
 					((psc->LPSAwakeIntvl - count) % period);
 				else
-					LPSAwakeIntvl_tmp = psc->LPSAwakeIntvl;
+					lps_awake_intvl_tmp = psc->LPSAwakeIntvl;
 			}
 
 		*time = ieee->current_network.last_dtim_sta_time
 			+ msecs_to_jiffies(ieee->current_network.beacon_interval *
-			LPSAwakeIntvl_tmp);
+			lps_awake_intvl_tmp);
 	}
 	}
 
-- 
2.39.2


