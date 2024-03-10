Return-Path: <linux-kernel+bounces-98372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD51877939
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DD11F2197D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBA3C460;
	Sun, 10 Mar 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="iaTxUwe3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D743BB4D
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114959; cv=none; b=gJUg1TQfzHm6D1BUwy2YArYI6KAMbmemKd5JrQw2lSEEmqIE9QOHTW7e5uDN3eI9T6kKG5D5/9+E8jGEiEDlEL+gHQ1aWkA/K9RtmA7P/96/b5cpbTgWY5zslP2Gn2lr6MQNKyNNGdNoUlscZ6YQRIQDfMSH0JGDwh/qFhgkT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114959; c=relaxed/simple;
	bh=3K0sO1C4XLSXE8b13C4nNIhyadNMqY3iN3rrAQeDfb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRxd+jV/t8AfVsVhh/K7VZ6mrOGeQEjdXXLQmlP1tALLS23sdZ6em9KSs52fQ/MSJHwxSDcYXMAAGHkyNvN/rRmtb+3bkcPoKc6AZFo47UgizrfNyTJLZEhDAJ/1NYbxVKpSu2/hFEDpAphwpcd3l1nXCJ4UpQThNDTULc2kTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=iaTxUwe3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so2884081a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114957; x=1710719757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O21vPxTFfXzVjkRb4ZxaMigBSRssVgbLO2eIiMZRryw=;
        b=iaTxUwe3En8/a30sVete7js9o/bttAgN6tKuvTCeTFL2fv/c3/NV+FbcRUv0GO4X7D
         ACDxRScW05bK8y7V20aGrHR3FF1IW65OP6aHLA1DoOmWsJHwtnmenCbWgT9MMhdu1jyT
         DokMCGjxMQEKZDC4QEulBbCeFgmYNy9t27k1Bxx9wFTpeJsJsBSbGvZ5QGuC+A2xr7ky
         3q4Yotyp/7ljX3iY9Ngf/qZYJEOPM8f1SXtRKXXaBOEwrhVEgytyVEU+CN/T2fHHG4NM
         vTooH9QfiH4TlMSrdAb1OCvsqSCBfiMRSoP9CCI7qBlvvvdQBjLZhtrqnKiSH9YdKDXJ
         MCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114957; x=1710719757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O21vPxTFfXzVjkRb4ZxaMigBSRssVgbLO2eIiMZRryw=;
        b=P28kzbM/XA/2sON54B+lZUr29zoyXNMb9w81RNAkbJ2eS1j13OHdKBaEx0j5ChK7bI
         X5KjbmiuyJRIgj6r+YxJ+SVFeKvJOHEh4C8DIPB9VVlyGoNHBL+2HOwH+1hf6BZ8Nymt
         1Z9qPqTxtjrY3jqCbF9wdUMD+ffWBDIaXrnrnXK5DFfc2kW4tz3pDw0X3b1T3yUn7Nwk
         SaRqOOOauu/3yEi1dSPO22H1cYWRJm+Gut0ThCYtoHm6BZXkmxxkqGsdDEQoGsQELyLV
         MvD9r8TZ7xVbRLvr2U3kV/hy6nF51rJWnOyt4u8csZD/rSr+5eUe6taPJQecdljJp6yE
         kdmg==
X-Forwarded-Encrypted: i=1; AJvYcCUAPdl4jOMueYDh8GedwyFar2fQ3B0UPl0JMEmYgcFOizvMIoe10m+5MSKLd7pU71GCo3rBo3DDHl57qvZ4q1N9GLEtuSZvHbnI/ckR
X-Gm-Message-State: AOJu0YyFYoI4765OctbJHgjhn9quKsnCHSKdeLmpjisDkCzUZZR0ApFg
	5zATmvi1s+phbHfczIKa+Nen23TX9m2TArt/0QCCuC+uRYEOuJ971WEZ0uukCz6nOaXOIfJRFrQ
	o
X-Google-Smtp-Source: AGHT+IG80U2lYnIb95/FIBq/xcNYhI2Eh4gJda58mSg/SdUj+hFqN33boAFHMBHJuUtkuJQH53XUyQ==
X-Received: by 2002:a17:90b:3a81:b0:29b:efcb:7e7c with SMTP id om1-20020a17090b3a8100b0029befcb7e7cmr1007369pjb.24.1710114956974;
        Sun, 10 Mar 2024 16:55:56 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:55:56 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/11] Staging: rtl8192e: Rename variable ReturnPoint
Date: Sun, 10 Mar 2024 16:55:42 -0700
Message-Id: <20240310235552.4217-2-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240310235552.4217-1-tdavies@darkphysics.net>
References: <20240310235552.4217-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable ReturnPoint to return_point to fix
checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 649b529657ba..08d057ab8f74 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -964,7 +964,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
 		     MAC80211_NOLINK) &&
 		     (ieee->rf_power_state == rf_on) && !ieee->is_set_key &&
 		     (!ieee->proto_stoppping) && !ieee->wx_set_enc) {
-			if (ieee->pwr_save_ctrl.ReturnPoint == IPS_CALLBACK_NONE)
+			if (ieee->pwr_save_ctrl.return_point == IPS_CALLBACK_NONE)
 				rtl92e_ips_enter(dev);
 		}
 	}
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 6fbf11ac168f..b2b8947da89d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1051,7 +1051,7 @@ enum rt_rf_power_state {
 struct rt_pwr_save_ctrl {
 	bool				bSwRfProcessing;
 	enum rt_rf_power_state eInactivePowerState;
-	enum ips_callback_function ReturnPoint;
+	enum ips_callback_function return_point;
 
 	bool				bLeisurePs;
 	u8				lps_idle_count;
-- 
2.30.2


