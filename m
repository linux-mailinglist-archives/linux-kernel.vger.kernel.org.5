Return-Path: <linux-kernel+bounces-98381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7483D877942
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAB71F207C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C044C68;
	Sun, 10 Mar 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="f5GQfz4M"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E447405DB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114965; cv=none; b=cpfZBLOJrLCKWvSE0dNzNuBJebSIJIlXaw7LEg3JI0t6bUcye3Wp/ymD5NVs7SwjIbmUfncLpzttBhyqvHegjpIsRwlur0BvwtKO88iID9VgrYFJUv/UTcRsnw8tEv5AVtTbMDStGDa1dP2dtW4VkfZXMMqgpbq+D8esoC/Zn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114965; c=relaxed/simple;
	bh=aaynatjePreX+ZKYWdldnU245uJ/F0v5BQjpQnzULeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SW9Ybl4794RifCxgHv7e7gRBgdodvzMWYJqVHST42TJ+OaHN5Rf5Pe4ENxRyUoy43im2Pm1x2LM4Tsi0krCHHIDY8J+xY+4EHEMeGX2TvG+QX4HdEWqk6T2E6Fed+oiTx0knKzmjEWj3r3jOKu1nAsKWWwKI7vXlEY9RjjFJ20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=f5GQfz4M; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29c0b648713so152774a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114963; x=1710719763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln106wSAsJuT/MNbqsLOu6Yq7Zx1wW1j4VdR3CdkZKI=;
        b=f5GQfz4M2jqx/Ncb1OFlcJxOhfWNh+UBTfPTQIdizcniYvYbfG6wXO/SOhCPoYEMM4
         MC2Xn3IW2I9KAjxqh5WpfU3gGPzpA83LUmJnMAPSBzKSzyFuzIIJb4lDSHTA+wPjh/nv
         J7rZTDftXu8vYcPQPdo62wtcMW6T09V4MSkb5IhbFG3Oc4moUksb4gCecBGITLqVywWz
         J5iOQLJLwWmeYO1N5DLmUr2swzCYShP5LBzJUvKQ4PMbzs+eO4YWEpafSyNXFWDPumH9
         XDQiA6j83DowD8bOPf6NLdYG7bILQWM/pKyNvntSF7MeOyF6Zld3dXlgHz21+G1eMWcJ
         iZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114963; x=1710719763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln106wSAsJuT/MNbqsLOu6Yq7Zx1wW1j4VdR3CdkZKI=;
        b=td8nvs7APAwJn89MXcHsleZnGlXR0uWsvO5FU5sBPUkaU+fvnh61kiLfO2XBiy/RRq
         w2kiKuXHQNLGWbaCCy3Z+A5twq2xxRPigLG8XeT1lg2noIHHPhDrVQX4ZS9m2O+QsP9y
         59739E4KITUZ1jQEZwy9SSjq/UfFVN0m8pl1sgub0KdeLaO9xfpthANttvBJLd5DnjvF
         TE9V/MTfYFQCKqAhe1NHuZ0iKcA4OnKQMxERTRb4NPNeegDXE+ya8Zj9gvyTzK+4Yo7V
         9cYeyLq59//f/OVYoKVEsGgHBQGO2E/Wu5Nm5POu0PPgbhh8kOaTq31UUMhCAIbEzaiA
         gVnw==
X-Forwarded-Encrypted: i=1; AJvYcCWKvEFwxsyFWuR3n2ILgFYl3XUPKI8qIr1/tvuWDccg3JKVTar71NQnp9yWVKjc66/KPCRJmioD8vG36e6/H9FeWM3F420n0lpXCxkf
X-Gm-Message-State: AOJu0YxLvD1yFcHEVMBVp62Fckr5fMYHCmUqZXn7XB5XNS3A7rh2vkWW
	k28LTLp5CtNGyXPrh4efVtdw7e1mkf7FAhF4A5K9ULkAb4Pv+aYux44Aade6y+g=
X-Google-Smtp-Source: AGHT+IEIAbOVNnGKx6wzOoW8hNNjB2NnNHkQsiZkONPnLfuHT6c9vJuyffUCYHWNfE+Y4POPboHX3g==
X-Received: by 2002:a17:90b:33d1:b0:29b:38c0:b933 with SMTP id lk17-20020a17090b33d100b0029b38c0b933mr3947602pjb.8.1710114963563;
        Sun, 10 Mar 2024 16:56:03 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:56:03 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 10/11] Staging: rtl8192e: Rename variable WriteIntoReg
Date: Sun, 10 Mar 2024 16:55:51 -0700
Message-Id: <20240310235552.4217-11-tdavies@darkphysics.net>
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

Rename variable WriteIntoReg to write_into_reg
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h | 2 +-
 drivers/staging/rtl8192e/rtllib.h              | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e3276d2c3616..fdf8fc66939d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -703,7 +703,7 @@ void rtl92e_link_change(struct net_device *dev)
 }
 
 void rtl92e_set_monitor_mode(struct net_device *dev, bool allow_all_da,
-			     bool WriteIntoReg)
+			     bool write_into_reg)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
@@ -712,7 +712,7 @@ void rtl92e_set_monitor_mode(struct net_device *dev, bool allow_all_da,
 	else
 		priv->receive_config &= ~RCR_AAP;
 
-	if (WriteIntoReg)
+	if (write_into_reg)
 		rtl92e_writel(dev, RCR, priv->receive_config);
 }
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
index 1224f190937e..9d9c5051c7fe 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
@@ -22,7 +22,7 @@ void rtl92e_get_eeprom_size(struct net_device *dev);
 bool rtl92e_start_adapter(struct net_device *dev);
 void rtl92e_link_change(struct net_device *dev);
 void rtl92e_set_monitor_mode(struct net_device *dev, bool allow_all_da,
-			     bool WriteIntoReg);
+			     bool write_into_reg);
 void  rtl92e_fill_tx_desc(struct net_device *dev, struct tx_desc *pdesc,
 			  struct cb_desc *cb_desc, struct sk_buff *skb);
 void  rtl92e_fill_tx_cmd_desc(struct net_device *dev, struct tx_desc_cmd *entry,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 393fff7e6a8d..0809af3fd041 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1478,7 +1478,7 @@ struct rtllib_device {
 
 	void (*allow_all_dest_addr_handler)(struct net_device *dev,
 					    bool allow_all_da,
-					    bool WriteIntoReg);
+					    bool write_into_reg);
 
 	void (*rtllib_ips_leave_wq)(struct net_device *dev);
 	void (*rtllib_ips_leave)(struct net_device *dev);
-- 
2.30.2


