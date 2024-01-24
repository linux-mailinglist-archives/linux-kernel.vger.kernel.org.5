Return-Path: <linux-kernel+bounces-37771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33E583B4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003AFB260AC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A4D13A242;
	Wed, 24 Jan 2024 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="lJL84VaC"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB1C13667A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136303; cv=none; b=CZAPUtjLeMDp0+hF66BMumefiRv6k6NQ95mK69wvQhqchXJa/vaVcHZLg7NPA46dYAMQMxXYO0SVIQiOk64vOusrwcfi3HuJMRP5Thb79JWvZbLCAVc3iVDH1hTieW7MbJqj6+R63Wfddp92ABklMDBr5GNDek1En36OvKqVKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136303; c=relaxed/simple;
	bh=MqGX90ifKvDAB4mcnexas5BdXpJwH6BIFxBoDJQyEo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S/J5RQX+5/W1wPN7q3LSRwnovSxp3XvW83M/rRFK0N2HLL2o+WLjZkpuM+YMYdql/iAiBXP0t5YlJW5jknS7Rjp6FWaPwZLPA/N25u98GILuyyZ0eVVKM+jNEOzlZjN+ejGtwd0i8epZlpgL19wgBGTyWCcOjGOV5GQ8BTO+4ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=lJL84VaC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d74678df08so24599075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706136300; x=1706741100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu8HUr+B6TPinTUaPQf0bFQfe6Q8eXlbxgT6SE9l4WM=;
        b=lJL84VaCPHRV/dzzm6oPuzLmX+ZLaeIeIjj/Jzx28n+zFeDIOtDIFW8fuhEofRneF3
         3cWI0Dyr+zdPzqZOPXyBlowiiIsyXPGWAa9LXgcVm3x7KS0FyUO4OQ8P7JOSGyVonLkD
         1Kmxxx+rpyce6kiKYoe70lTw8xs6o6pFyGmjsjOHQ30YPkgSXExTaSwGOIOu+o+KEDrW
         ElhfeM8jgI9QWTqGXai6LJIs4omnrmfL1Z+Em57qboTlbhGPJsW/chrmCA2GDVblXe/j
         icnCTC7E8TfbvhLwrJmIiYSOKwULfWpNuwnnNzIt/tNhhmKYfPXhzriiNxa0udd3BJaR
         utBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706136300; x=1706741100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu8HUr+B6TPinTUaPQf0bFQfe6Q8eXlbxgT6SE9l4WM=;
        b=EuuL97mgVn+AaNI2FdBbDAW2mQnOi0BHBotEj8NmygBRe2AvJCUgYP3Hyre25fboos
         meRPoY29XR841b6MQjjrdX7jdffZ3QXjVl03B3H7mXVis7zDuZXgIzVMbskdf0Ei4Ntr
         u6hEcnhj6c/HmND0icmNiBggi/dW3McF0zBnzu9xGp5vZQWxrpkXGoQ6QYul+maWFjgp
         H/VeCfNMeZdYWyaKB0hE1TMQcK+hYn8qTily+rVVC8mXF0+jgEueEOkYfFc3byXbw6zJ
         v/g83N4NNaMjV1JZ97xTAejsg+n26XlaIVngmuaIjzgCNlPgfAa33745unWRNfRRWQwO
         H99w==
X-Gm-Message-State: AOJu0YweZoGIEJI1e5p6FjsiFGmq7SEiXNnkUWrRBZzHLRApnkFiUuTF
	c3bAZ48F53xoW3Hxl6qnPZxOu2oBsgmBoGYr8CMk2s+LTJVBJ0zgcSRyCUEgejJC2mWaAKp1Y5l
	A
X-Google-Smtp-Source: AGHT+IF26Bc8sizywlTaTIeoI/iPF3Rp4xvRlzxMR6zS1SW856AIhx5UxfdW9z4BQ0qAm0d14is1ig==
X-Received: by 2002:a17:902:d4c1:b0:1d7:5d64:b2b8 with SMTP id o1-20020a170902d4c100b001d75d64b2b8mr114508plg.106.1706136300628;
        Wed, 24 Jan 2024 14:45:00 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id i5-20020a170902c28500b001d73a2acc0csm6743987pld.283.2024.01.24.14.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 14:44:59 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 05/18] Staging: rtl8192e: Rename function pointer SetHwRegHandler()
Date: Wed, 24 Jan 2024 14:44:39 -0800
Message-Id: <20240124224452.968724-6-tdavies@darkphysics.net>
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

Rename function pointer SetHwRegHandler to set_hw_reg_handler to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c |  4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 12 ++++++------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     |  6 +++---
 drivers/staging/rtl8192e/rtllib.h              |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c      |  6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 9b9d95ba06df..4cd3d7b7c31c 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -164,7 +164,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
 				    eACI);
 			break;
 		}
-		priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACM_CTRL,
+		priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACM_CTRL,
 					      &pAcParam);
 		break;
 	}
@@ -1698,7 +1698,7 @@ void rtl92e_stop_adapter(struct net_device *dev, bool reset)
 	u32	ulRegRead;
 
 	op_mode = RT_OP_MODE_NO_LINK;
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_MEDIA_STATUS, &op_mode);
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_MEDIA_STATUS, &op_mode);
 
 	if (!priv->rtllib->bSupportRemoteWakeUp) {
 		u1bTmp = 0x0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index f986dbb215e4..79e66b726b28 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -236,14 +236,14 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		if (priv->dot11_current_preamble_mode != PREAMBLE_SHORT) {
 			ShortPreamble = true;
 			priv->dot11_current_preamble_mode = PREAMBLE_SHORT;
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACK_PREAMBLE,
 					(unsigned char *)&ShortPreamble);
 		}
 	} else {
 		if (priv->dot11_current_preamble_mode != PREAMBLE_LONG) {
 			ShortPreamble = false;
 			priv->dot11_current_preamble_mode = PREAMBLE_LONG;
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_ACK_PREAMBLE,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_ACK_PREAMBLE,
 					      (unsigned char *)&ShortPreamble);
 		}
 	}
@@ -256,13 +256,13 @@ static void _rtl92e_update_cap(struct net_device *dev, u16 cap)
 		   (!priv->rtllib->ht_info->current_rt2rt_long_slot_time)) {
 			if (cur_slot_time != SHORT_SLOT_TIME) {
 				slot_time_val = SHORT_SLOT_TIME;
-				priv->rtllib->SetHwRegHandler(dev,
+				priv->rtllib->set_hw_reg_handler(dev,
 					 HW_VAR_SLOT_TIME, &slot_time_val);
 			}
 		} else {
 			if (cur_slot_time != NON_SHORT_SLOT_TIME) {
 				slot_time_val = NON_SHORT_SLOT_TIME;
-				priv->rtllib->SetHwRegHandler(dev,
+				priv->rtllib->set_hw_reg_handler(dev,
 					 HW_VAR_SLOT_TIME, &slot_time_val);
 			}
 		}
@@ -301,7 +301,7 @@ static void _rtl92e_qos_activate(void *data)
 		goto success;
 
 	for (i = 0; i <  QOS_QUEUE_NUM; i++)
-		priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
+		priv->rtllib->set_hw_reg_handler(dev, HW_VAR_AC_PARAM, (u8 *)(&i));
 
 success:
 	mutex_unlock(&priv->mutex);
@@ -660,7 +660,7 @@ static void _rtl92e_init_priv_handler(struct net_device *dev)
 	priv->rtllib->GetHalfNmodeSupportByAPsHandler =
 						rtl92e_is_halfn_supported_by_ap;
 
-	priv->rtllib->SetHwRegHandler = rtl92e_set_reg;
+	priv->rtllib->set_hw_reg_handler = rtl92e_set_reg;
 	priv->rtllib->AllowAllDestAddrHandler = rtl92e_set_monitor_mode;
 	priv->rtllib->init_gain_handler = rtl92e_init_gain;
 	priv->rtllib->rtllib_ips_leave_wq = rtl92e_rtllib_ips_leave_wq;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 92143c50c149..57e1a361a7c9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1185,7 +1185,7 @@ static void _rtl92e_dm_check_edca_turbo(struct net_device *dev)
 		if (priv->bcurrent_turbo_EDCA) {
 			u8 tmp = AC0_BE;
 
-			priv->rtllib->SetHwRegHandler(dev, HW_VAR_AC_PARAM,
+			priv->rtllib->set_hw_reg_handler(dev, HW_VAR_AC_PARAM,
 						      (u8 *)(&tmp));
 			priv->bcurrent_turbo_EDCA = false;
 		}
@@ -1636,7 +1636,7 @@ static void _rtl92e_dm_start_hw_fsync(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c12cf);
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING,
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_RF_TIMING,
 				      (u8 *)(&rf_timing));
 	rtl92e_writeb(dev, 0xc3b, 0x41);
 }
@@ -1647,7 +1647,7 @@ static void _rtl92e_dm_end_hw_fsync(struct net_device *dev)
 	struct r8192_priv *priv = rtllib_priv(dev);
 
 	rtl92e_writel(dev, rOFDM0_RxDetector2, 0x465c52cd);
-	priv->rtllib->SetHwRegHandler(dev, HW_VAR_RF_TIMING, (u8 *)
+	priv->rtllib->set_hw_reg_handler(dev, HW_VAR_RF_TIMING, (u8 *)
 				     (&rf_timing));
 	rtl92e_writeb(dev, 0xc3b, 0x49);
 }
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 0a366874a827..cd45a9c46a94 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1491,7 +1491,7 @@ struct rtllib_device {
 	void (*init_gain_handler)(struct net_device *dev, u8 Operation);
 	void (*ScanOperationBackupHandler)(struct net_device *dev,
 					   u8 Operation);
-	void (*SetHwRegHandler)(struct net_device *dev, u8 variable, u8 *val);
+	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
 	void (*AllowAllDestAddrHandler)(struct net_device *dev,
 					bool bAllowAllDA, bool WriteIntoReg);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index b5cd030f28c8..b5fe471f765b 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2256,11 +2256,11 @@ static void rtllib_mlme_disassociate_request(struct rtllib_device *rtllib,
 			rtllib->current_network.bssid[i] = 0x22;
 		op_mode = RT_OP_MODE_NO_LINK;
 		rtllib->op_mode = RT_OP_MODE_NO_LINK;
-		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_MEDIA_STATUS,
+		rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_MEDIA_STATUS,
 					(u8 *)(&op_mode));
 		rtllib_disassociate(rtllib);
 
-		rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_BSSID,
+		rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_BSSID,
 					rtllib->current_network.bssid);
 	}
 }
@@ -2270,7 +2270,7 @@ static void rtllib_mgnt_disconnect_ap(struct rtllib_device *rtllib, u8 asRsn)
 	bool filter_out_nonassociated_bssid = false;
 
 	filter_out_nonassociated_bssid = false;
-	rtllib->SetHwRegHandler(rtllib->dev, HW_VAR_CECHK_BSSID,
+	rtllib->set_hw_reg_handler(rtllib->dev, HW_VAR_CECHK_BSSID,
 				(u8 *)(&filter_out_nonassociated_bssid));
 	rtllib_mlme_disassociate_request(rtllib, rtllib->current_network.bssid,
 				       asRsn);
-- 
2.39.2


