Return-Path: <linux-kernel+bounces-124116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CF289126E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE282B22452
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6138DED;
	Fri, 29 Mar 2024 04:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bYgNhOtt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF113182DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 04:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711687387; cv=none; b=Gs4Z7KK5v8DvUkSq0dTAIiyROfVFAIpPepAFJAKH+HBNho3B+0j77SYWSYX5ZOu8LKaI0a+0gcTLFwLgHpvAp64JAIvbyPwd7xch73Mq+53Zw/xTSfSCDVOrKYj4AMbRyFmPP2YR2dLoId13vJSbvjBsg7hVCqIJZcoXCf4U5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711687387; c=relaxed/simple;
	bh=My3f7M5mMYJXacZvdy1j2CVdTWB2Yzw0VQy6ISU7+O4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNDwhx7Z9QnXR5S0rwl72RFeKmuqvoQHIoyCnMgITJ75u11OswcNEPI4OxaJdWXDcSZnlqgFEM5bzwWv6dl8NYG2EvkJHn6bP/K5RKEKzEEJ8Mf2AZAwnfKY1EE361MhIXXaR9q/R4jx5e/6BZhblmzFr2aJ2nOOYjkGXWhzzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bYgNhOtt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e00d1e13acso11831175ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711687385; x=1712292185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+F3MEmVUPzwWL0/FLP/CCB6bmOFJ8TO+NbHdWfRAjA=;
        b=bYgNhOttv9vwUmTA/yUR6B8HTLEeBPJzqhsjY+SBmpi2nwqat6W1p2bsqaClBoD15k
         2cePg7qTpU4lgaFmh34MvZux+5AGmxNFFsPKKksSSi58Mn0ktOhIXhd7IhPUuW7r3a4d
         HC++QsAD88pW5gC2PC/zyWQ5Z1eytaHvmBF48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711687385; x=1712292185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+F3MEmVUPzwWL0/FLP/CCB6bmOFJ8TO+NbHdWfRAjA=;
        b=NCcf+t+bFR5J7ABeakgXRz5gcRskMfAczvY6iDTV5FdKxFY+p3CesToAkqdMEvSzOd
         ZWuiykiGEF7HBxhpitSaqDHbR3LHGsXzk0LCZj43wABTtoIAvnZhr3h+/UWOMLs97NHw
         FAGYtF9/7JIWD10p/uQMuqwh0vnooB6EGXo8nhff433vUv7ZgJ46Gjr5yEjLc0YrdIkk
         yx7VAYg5u157wtDKnuOqk2dTyyZMbgaTRU1AGT5QUjNFI6SOxoDvbXZTAdTu2tW+ftKh
         XtGVAoQzm6OUHVzIAQKPrOLzTRoP9dkr1xRVrhXN9XdikKd50ExMB3FHCuVZeEedcPKm
         gnqw==
X-Forwarded-Encrypted: i=1; AJvYcCU7u/NnM/Wh41uPUJkrXL5UTC0f7A7w2yimpHHMrMB+g6BShfzlefcxY1+5FOgLBiotb2NZ9dsLO7I7Y69y0RvET2gvCQKjlqa5ePhE
X-Gm-Message-State: AOJu0YyiWF6utFB8LZyiUu102uglBnuOCkO9C3ocKiSMVeXiJ8NWTfsV
	urN3KPAVba3t/4s/rf9kg2vmIHQstSBp5lmpw2TB6g4NCTPxHQnRyPk9pOep/Q==
X-Google-Smtp-Source: AGHT+IHCedueif2FtQVSxLOhPhqWgRritaTfZsBJlDn+eEkw34EDb+pABQ0tVdwsWrtdeb23F+EOuQ==
X-Received: by 2002:a17:903:2442:b0:1de:f18c:cdd with SMTP id l2-20020a170903244200b001def18c0cddmr1744816pls.3.1711687385018;
        Thu, 28 Mar 2024 21:43:05 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:89c9:dcae:ddce:1350])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001dd744f97d0sm2502345plh.273.2024.03.28.21.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 21:43:04 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johnson Wang <johnson.wang@mediatek.com>,
	Fei Shao <fshao@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2] pmdomain: mediatek: Add MT8188 buck isolation setting
Date: Fri, 29 Mar 2024 12:38:40 +0800
Message-ID: <20240329044142.3095193-1-fshao@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johnson Wang <johnson.wang@mediatek.com>

From: Johnson Wang <johnson.wang@mediatek.com>

Add buck isolation setting to ADSP_AO, CAM_VCORE and IMG_VCORE power
domains in MT8188 for proper buck isolation control in power domain
on/off.

Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Fei Shao <fshao@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

Changes in v2:
[1] was reviewed but didn't get accepted at the time.
This rebases [1] on next-20240327 with revised commit message.

[1]: https://lore.kernel.org/all/20230315114505.25144-1-johnson.wang@mediatek.com/

 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 06834ab6597c..007235be9efe 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -175,6 +175,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(10),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
@@ -187,7 +189,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
 		},
-		.caps = MTK_SCPD_ALWAYS_ON,
+		.caps = MTK_SCPD_ALWAYS_ON | MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_ADSP_INFRA] = {
 		.name = "adsp_infra",
@@ -524,6 +526,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(12),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
@@ -541,7 +545,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_IMG_MAIN] = {
 		.name = "img_main",
@@ -591,6 +596,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
+		.ext_buck_iso_offs = 0x3EC,
+		.ext_buck_iso_mask = BIT(11),
 		.bp_cfg = {
 			BUS_PROT_WR(INFRA,
 				    MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
@@ -618,7 +625,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY |
+			MTK_SCPD_EXT_BUCK_ISO,
 	},
 	[MT8188_POWER_DOMAIN_CAM_MAIN] = {
 		.name = "cam_main",
-- 
2.44.0.478.gd926399ef9-goog


