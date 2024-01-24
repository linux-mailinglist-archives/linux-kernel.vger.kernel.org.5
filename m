Return-Path: <linux-kernel+bounces-37767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE083B4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473EB286599
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B240136671;
	Wed, 24 Jan 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R9U18aa5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51E135407
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136300; cv=none; b=O8Ts1D2hOmGFZm08tsH+G36K2FnMIMwMNIEhM2A7JKtbu1ib99Avl9jcMR5x6M1gVcbQaoAAhRNBnpJ65fcxRjio34YXNq5eE6CkWsYvs1vpz9ChFaiTjlykw86fCMoYQaclnX/QFVOGXa/4OSeTCZCL4NzPqbqdLfxSZDNqthk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136300; c=relaxed/simple;
	bh=mDWkLRaeD7jE4mY2ogV/dDnV0AcV9C9S5DYirGLToaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WqGrzFUGrBpQTVotqAvgs3gyPD3Bnll7unKDf7nxhWMOQaJtGWk15r96LluEqQQqFWWLoXzLtES49TnuxnzNUsdypVEdaBgoHWnjAjDmc9K2UfCiIFTOW60LXj5YFxv5nYjSRuo2Kwqdac+qcdPfEtRAONehsrcTDCZ5n4m8ocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=R9U18aa5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d746856d85so24088075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136297; x=1706741097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzYk9eLH9WOTdFVZV/EkZvm0zsnXu4X7XxZS+490jJA=;
        b=R9U18aa5gV3e4McwCVeSdoPEh+fRRDDcU6pPcbYwvYXQ1wUBQ/VEjI8JCYR0k6HxZV
         FDKCy/t6z0cQDKzf0hMetYyB8tq20/2fHL7STETd+P1MwZIfaFdEU/E3uc/sKhyFiEpS
         e+FwwsQ1Ef4lUY+DvNGLfOsqFl4t7NF3juQkFe6koczOrGk3zEue4nrLUfYXFcvuZsEh
         avsk2V6gEsNf/z4N3xJ/m65/gATC2/wzYQOtMt+PGvjvU6BXb/DMrb14zcefHGbTeLke
         /TmvqvoBxIVgYAiIIt4JFjpwuAyOmQBH3RrC3zkeN5JXWkL68u8QUS/7+hl1nW4D6cNQ
         aGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136297; x=1706741097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzYk9eLH9WOTdFVZV/EkZvm0zsnXu4X7XxZS+490jJA=;
        b=W0zRxlyV+jOFLCjJaY22203ufiJHxCak5wKnl0OpGur8jIstpWjrWdPXp0/hPxxZV3
         dv98JPEli73HWYgQ//J91T4lijwJElk0sItgTs7JdN/CyJEjIJnt/alFCQngAX7n0QAR
         qGmOEccqrOTokkO9pSEyMnc2bOIU08p7SmAuR2lcl86LQcxvBE4liSJWL3pGaWSLS0MF
         JV2EX4QeqWZYuaFA9iy3+R5DSfiBQlZap9C9XisPYdmpVMoT0u3ODusu4scA3TYNsuzO
         Dhu9zcgeD9znEdBnJ17xqN0FzCaplRJCl/zXI7PoC2M2CRuxk60fm/mfN64CwNlVRiBK
         fRWQ==
X-Gm-Message-State: AOJu0Yy5NFX75CXhm6rA9OnD17JxGirC97qJM+SLt7ZknU72IuPiTvCM
	y5EvKNwsc1AGV7MR26OoiCZ//7a1YnKkHL+S5Q7krdM3GtnYncc08nRy2dzIUTI=
X-Google-Smtp-Source: AGHT+IF3fpKD8YiFHq/Vvj6F6RVfXoBS6HD8e9raHdWjggIBZtMS/6hivzeQzVsvGiuBFxOiEmoJIw==
X-Received: by 2002:a17:902:6b8b:b0:1d7:60fc:99f0 with SMTP id p11-20020a1709026b8b00b001d760fc99f0mr87764plk.10.1706136297166;
        Wed, 24 Jan 2024 14:44:57 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:56 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 01/18] Staging: rtl8192e: Rename variable FirstIe_InScan
Date: Wed, 24 Jan 2024 14:44:35 -0800
Message-Id: <20240124224452.968724-2-tdavies@darkphysics.net>
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

Rename variable FirstIe_InScan to first_ie_in_scan to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h          | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
index 5fd44d0c4b1d..d131ef525f46 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
@@ -269,7 +269,7 @@ static int _rtl92e_wx_set_scan(struct net_device *dev,
 
 	mutex_lock(&priv->wx_mutex);
 
-	priv->rtllib->FirstIe_InScan = true;
+	priv->rtllib->first_ie_in_scan = true;
 
 	if (priv->rtllib->link_state != MAC80211_LINKED) {
 		if (rt_state == rf_off) {
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0fdc767d43e0..13a901c0db1d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1201,7 +1201,7 @@ struct rtllib_device {
 	bool cannot_notify;
 	bool bSupportRemoteWakeUp;
 	bool actscanning;
-	bool FirstIe_InScan;
+	bool first_ie_in_scan;
 	bool be_scan_inprogress;
 	bool beinretry;
 	enum rt_rf_power_state rf_power_state;
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 9d1e9b780bc7..44b36cc867d9 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2101,7 +2101,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	ieee->reg_dot11tx_ht_oper_rate_set[1] = 0xff;
 	ieee->reg_dot11tx_ht_oper_rate_set[4] = 0x01;
 
-	ieee->FirstIe_InScan = false;
+	ieee->first_ie_in_scan = false;
 	ieee->actscanning = false;
 	ieee->beinretry = false;
 	ieee->is_set_key = false;
-- 
2.39.2


