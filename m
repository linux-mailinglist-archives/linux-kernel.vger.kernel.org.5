Return-Path: <linux-kernel+bounces-98379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AD3877940
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D35FF1C20DFC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A95433B6;
	Sun, 10 Mar 2024 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="Fbt6awNK"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6E3F8C3
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710114964; cv=none; b=JFr/XJzKweFyGgGrtPg9cVjoJh9zBiTI/Wx42L1S8kZ7x1sY38VRSjZR8Apaf4QtH7gkxcNyYcALO/adcAWNoXQ3SO4ZohfxLKNNhHQAwxlyV+OA1gvpEROK1UJpkOXwnFxGjkT14FhEtqO1pnKx4PfxNeJhynQtdgEYC+c5CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710114964; c=relaxed/simple;
	bh=vt2AS0MY2T5K9VNmNLC6qpITMvYnpGjqYDDGu9p7wvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/kjKSLec0ohV4amyMktvGTElHTACBFbkk61Bx3bc9iLtbZOlVpKyNOQdorF/r9BCgz46mtGhtqjS8AXV/wqimunl2D+4U8yE8IrRkrM9wUJ+maKRxe4LPO4StvAkzRUtn564AbSkhzsaw1QadRYsYVnuqNdUcCFj+zVkDSkmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=Fbt6awNK; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29bad5f4ae8so1740369a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 16:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1710114962; x=1710719762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jkuqB7qYV1V/hZ7KuA1uZbe/cubaPjlVg/I55Vf+yE=;
        b=Fbt6awNKAkjCEzZqXy1JEmsMuNYlBV37/rjyR/gnsoqhVdjsHk9l1TgQ1zs+EISU+Z
         BX9fbyu+iS1dnG/5q2LUj1lIrBu9mim8q+NPef/tl5BEcRvIQrNBP9nR4XkRfa8vKuFJ
         GjdX8b4DztfXSvzBTSOfpcFKDMnLtHUqT8cnvFnw5u+VtUNwV7dxwa6+2rV9CWC8cM95
         BbA4gZFbl8KL2tQYjRWrtcoNW0Ocz8ZPEb5au6uxPf9csJvSJE1ivtUFp0kKlufVvAMg
         f/hFWSpZ0TiRTDE6PabpU8NrA3XdyCKjXcWHG4S3M3OEhqVWwUY6Sbn726aW9y/YTl42
         ObZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710114962; x=1710719762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jkuqB7qYV1V/hZ7KuA1uZbe/cubaPjlVg/I55Vf+yE=;
        b=MiZ0E4Bq2iJqzHUze+upWke5jYTz6/8EBU6MEGGffu/ZAGPJmTZFXFVAwtTNcbIzrp
         RRZb8hgDNdnXr7bipxTHihTADeIxS7vYhciVo7k9KFJbJicm/SjivJblrNu5btSu9YGw
         8GOhijxJ+7Scv+g+oWak6dzf24gOr5LENyJdXTXWvkcXNlqCnhjSYvl2xewR16YJzhW0
         iAI/9MnO0WnPlOk5kCAehbbEl9G5/nvQxRua+iNnRsrNjcUX72n+IFM9DGf5w9N8Kjal
         s5OzyD134FpuQLytOrtUY0RtLWtl8GJ09EUa4v2aimuGDzE5RDIT2ZDHg/C4rPkeH5xu
         4YaA==
X-Forwarded-Encrypted: i=1; AJvYcCVKiRK9l26qW2Aot074tbPDJYlNlX/g8FjW312VM4JNi8u6WSs12gUeWcwqAeqkcBDCFWNAQzO7DxLYWy3MF/FtvZK4ZmhPRZpc2tQj
X-Gm-Message-State: AOJu0YyqonofodaHgqrFraKsBierbAwyhBwXvmuQZhtTzLGii0A2S0dJ
	SDUUbf8oaRZ/PxI8C3ghIsQlbr7HsO+ICGcU1INTRT+BSc9tPSRuanuwEU4ha2Y=
X-Google-Smtp-Source: AGHT+IErnq8bbjzofXvfZsXHjRCyuNv83rcb1XF4zm4IiAjFp2CfdNYJUbASppyyMagZYgs85rgH1g==
X-Received: by 2002:a17:90b:a18:b0:29b:badf:cc1d with SMTP id gg24-20020a17090b0a1800b0029bbadfcc1dmr3893667pjb.29.1710114962133;
        Sun, 10 Mar 2024 16:56:02 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id o7-20020a17090ac08700b0029bb29ef41bsm2903439pjs.50.2024.03.10.16.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 16:56:01 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 08/11] Staging: rtl8192e: Rename variable pBssHT
Date: Sun, 10 Mar 2024 16:55:49 -0700
Message-Id: <20240310235552.4217-9-tdavies@darkphysics.net>
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

Rename variable pBssHT to bss_ht
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 20 ++++++++++----------
 drivers/staging/rtl8192e/rtllib.h         |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 1c3ef1b7ebd8..618523bacc8e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -543,19 +543,19 @@ void ht_initialize_ht_info(struct rtllib_device *ieee)
 	}
 }
 
-void ht_initialize_bss_desc(struct bss_ht *pBssHT)
+void ht_initialize_bss_desc(struct bss_ht *bss_ht)
 {
-	pBssHT->bd_support_ht = false;
-	memset(pBssHT->bd_ht_cap_buf, 0, sizeof(pBssHT->bd_ht_cap_buf));
-	pBssHT->bd_ht_cap_len = 0;
-	memset(pBssHT->bd_ht_info_buf, 0, sizeof(pBssHT->bd_ht_info_buf));
-	pBssHT->bd_ht_info_len = 0;
+	bss_ht->bd_support_ht = false;
+	memset(bss_ht->bd_ht_cap_buf, 0, sizeof(bss_ht->bd_ht_cap_buf));
+	bss_ht->bd_ht_cap_len = 0;
+	memset(bss_ht->bd_ht_info_buf, 0, sizeof(bss_ht->bd_ht_info_buf));
+	bss_ht->bd_ht_info_len = 0;
 
-	pBssHT->bd_ht_spec_ver = HT_SPEC_VER_IEEE;
+	bss_ht->bd_ht_spec_ver = HT_SPEC_VER_IEEE;
 
-	pBssHT->bd_rt2rt_aggregation = false;
-	pBssHT->bd_rt2rt_long_slot_time = false;
-	pBssHT->rt2rt_ht_mode = (enum rt_ht_capability)0;
+	bss_ht->bd_rt2rt_aggregation = false;
+	bss_ht->bd_rt2rt_long_slot_time = false;
+	bss_ht->rt2rt_ht_mode = (enum rt_ht_capability)0;
 }
 
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index cf75d1225501..3819a859710d 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1742,7 +1742,7 @@ void ht_construct_rt2rt_agg_element(struct rtllib_device *ieee,
 				u8 *posRT2RTAgg, u8 *len);
 void ht_on_assoc_rsp(struct rtllib_device *ieee);
 void ht_initialize_ht_info(struct rtllib_device *ieee);
-void ht_initialize_bss_desc(struct bss_ht *pBssHT);
+void ht_initialize_bss_desc(struct bss_ht *bss_ht);
 void ht_reset_self_and_save_peer_setting(struct rtllib_device *ieee,
 				   struct rtllib_network *pNetwork);
 void HT_update_self_and_peer_setting(struct rtllib_device *ieee,
-- 
2.30.2


