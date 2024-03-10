Return-Path: <linux-kernel+bounces-98380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBAE877941
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2F7281734
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0CB44384;
	Sun, 10 Mar 2024 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="PNecXnWe"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5761A3FB8E
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114964; cv=none; b=tUPO338FszT640HG+pmtFJlujGxMryLNvsHd92m2XtDsBnuEhDosAoHW9ytbQKu/qgcvjwbZAB9fPWPPou4taCHYSTVMURw+i36DV4rqRlDmNTKhF40c2uuUUWbqwk9r0F7x3dOTITT2KP0/c9btjtdwwrmqWezVms+eg95xUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114964; c=relaxed/simple;
	bh=0rM740sBdk8huHY4NhOTOHcOY/GxVUJCFjfyR5Pl/4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CjDY7iodSQrdW5xQmvCznZKr1YFGVWMbWfIGILwK2WSSxiUAQvbOwRxpHUeTsknNV2xO/giprs1ZjPSjt4VNPpk+zD3AQjttdURvEbCPai98Hz6w2TdqnHyQ9euM1NkEX57Db5MMt3j8IvXrTOnPVQZpPqg/KpI0xgppYTBoIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=PNecXnWe; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso1953952a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114962; x=1710719762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7EKp2vsKNvqYuCUlnv6xBioKoVPQsG67LiV/PqaQG8=;
        b=PNecXnWeF/EGHNEztZMnXzk216d5b7YDmKAtqYOZ3LVaDDVsmb/nQSwA/CBeg2iFuo
         2VKLByyJi/XscA0JW6KL4jl01gPNWUip6Op741iKHTaoHQsGmULYQ9WmB/qFs1ZI6ON+
         JPU45IBrNeOO/JDPwgaPGj03jmTv/2C1AE+ccV9JfchUdyYspdv2uXr/7SGUWAn1EUMH
         dv+ow/7XlMEijQeT0KF0vTHBqCi3zwPYuX26Kmvyl94fSNtqN1zzu3osVvpLQiq9p9F2
         Vr7jVuQ17czFw3BepFunpg5YGPg/Ph1en97tQSFF9rsyYI5DkrA2n1x7A6HtsISOo563
         FReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114962; x=1710719762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7EKp2vsKNvqYuCUlnv6xBioKoVPQsG67LiV/PqaQG8=;
        b=GfFypx6giPHOZI4oM7iovT6nRyndYNZvWSZXSI1bSG+kD7WfOX0IH0OQ+uz0NYkPtx
         72fh0oWdTdMpETXY6d5SaxB7x1Z6WHKccgOup0HXTA2wzV9mU4SLIuRVBhIfHehf9ENu
         R8HHDqSOt4zA7YUndTrjHj7koZaaHNxmhQGNV2C7Vv6LW6CpNMw19r5Ns4XNan6AtyIw
         8Zef4VfFJ+hJ0TBVG4xjSk7eAya/qxQGPKA3Rk4T1MLUb1FE4KPiGpYvsyAD2mVaaH65
         u5xighcwohhdEuj0iPDxOYnPuch1KIe6qHBu8EyNhjsJ3utsGg2NiQxZHl2gkfewnheb
         du7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtNIlZRCYxXujAUuEO3h3Clv1mCAHYg56odW0mCb35I04X1TU1BT2Ch2ZU+vTvF2RuS4AcZdQEMAO3QJZJAVZA4QzTH6R/gFUj97V+
X-Gm-Message-State: AOJu0Yy7zLXvozpaSpZ6drQtUK80lV/GJRlqBcJF5YNPTYnKtbxhYhxo
	e/JBaisha6K08aPl6DZW+d+R6NEThPKfRE2zLuS3ezCVsw3G8c+2IC/CbtXbD6w=
X-Google-Smtp-Source: AGHT+IEyS1YeZzKbvQgPctRBcV6Cg1k8qI2HQXgKh+rzOM36uKfAjbZhzNULukcyyLJwJ52A5lvn5A==
X-Received: by 2002:a17:90a:df96:b0:29b:aae6:49da with SMTP id p22-20020a17090adf9600b0029baae649damr2396493pjv.47.1710114962764;
        Sun, 10 Mar 2024 16:56:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:56:02 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/11] Staging: rtl8192e: Rename variable bAllowAllDA
Date: Sun, 10 Mar 2024 16:55:50 -0700
Message-Id: <20240310235552.4217-10-tdavies@darkphysics.net>
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

Rename variable bAllowAllDA to allow_all_da
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 41373c013299..e3276d2c3616 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -702,12 +702,12 @@ void rtl92e_link_change(struct net_device *dev)
 	}
 }
 
-void rtl92e_set_monitor_mode(struct net_device *dev, bool bAllowAllDA,
+void rtl92e_set_monitor_mode(struct net_device *dev, bool allow_all_da,
 			     bool WriteIntoReg)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (bAllowAllDA)
+	if (allow_all_da)
 		priv->receive_config |= RCR_AAP;
 	else
 		priv->receive_config &= ~RCR_AAP;
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 878c96236824..1224f190937e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -21,7 +21,7 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val);
 void rtl92e_get_eeprom_size(struct net_device *dev);
 bool rtl92e_start_adapter(struct net_device *dev);
 void rtl92e_link_change(struct net_device *dev);
-void rtl92e_set_monitor_mode(struct net_device *dev, bool bAllowAllDA,
+void rtl92e_set_monitor_mode(struct net_device *dev, bool allow_all_da,
 			     bool WriteIntoReg);
 void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 			  struct cb_desc *cb_desc, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 3819a859710d..393fff7e6a8d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1477,7 +1477,7 @@ struct rtllib_device {
 	void (*set_hw_reg_handler)(struct net_device *dev, u8 variable, u8 *val);
 
 	void (*allow_all_dest_addr_handler)(struct net_device *dev,
-					    bool bAllowAllDA,
+					    bool allow_all_da,
 					    bool WriteIntoReg);
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
-- 
2.30.2


