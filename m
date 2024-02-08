Return-Path: <linux-kernel+bounces-57892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5184DEB4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA531C22075
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A778A6E2B3;
	Thu,  8 Feb 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnZep+P1"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4571B33
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389473; cv=none; b=oby6ybdsC2WXwQESWxZWKTVHwSqfgYTSkuBegNmdYJjrw6Ev1ZCC34dcqDayfjHgqRUHVE87+fV5nXZxNDOzHnUOZpSNJa0e4rSaZhF00CTbAWfqYiqCiAXL3avLecMIo9E3BiKxJW4/9xmBAM98zC00FZUFD8BVnIFsDQX7o7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389473; c=relaxed/simple;
	bh=xJfnEJ+zVsCbj3Czpg60LPhMDPo5+HXP6lXubKlhf+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtV0OfFgVBDDad1ppVXuxJL00VvZBnoJZTZgJwHLYFWD8ovGwkGnamvzrvVCqU9Qcup6UhSWvgwx5FoL53BRgCunPdQBK36dqQHzVO2ytKdGIdtzEsc39YLMx22Csl2y1n1sZhOaDa7jMXUvD/sOnkfjIMkQLdLeGS46vme/gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnZep+P1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4102eae7e6aso6602775e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389469; x=1707994269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkWzwIjo/uZaIYjgKgDNcnhcc1cwlKLdvZXvoZJLBm8=;
        b=WnZep+P1F4+Nsn24SCC7jw8PnKUaajsse5HmxzZGZUM6Ye058QFnSXydVHVWcUkFax
         oZhe5S/sPfWSN6QKYmUtDnBQIZJnEs4Z4f5kWGxSWSYvyfFyqCx/sF6w4NL4AsObpgJ+
         wMvRChH86mLXAsEQkayxx8GYVc7DXOiad3/aDRH06NA/S6BAB7GIdCv2ZF6046n+d2CP
         XeGzLpH434DX3b6Gq6/NnY38f69jBjBCsL9ndwZUhPlYZNaTOTtwdpE5S1GORK1BgHZr
         eQwT3O9zc9xG4FncJbSRIn3D/UiEGo0zwPq/pqN+sFd3L1a0VnS0dXHbmEs4oZxwfQgn
         l79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389469; x=1707994269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkWzwIjo/uZaIYjgKgDNcnhcc1cwlKLdvZXvoZJLBm8=;
        b=FJUW+INcSNJCkTBOJr7YMs7UXHvk514VIvm4H/ouurmogz6k+QXYLW5oKCAA7cgEL8
         tkYCIjEOTuSQjp8oP/7oHhaH4OTMlSY3E1Pm88WG3BkHB0nPcO2b75ugErGfDdmJIEcH
         O0jUfDBV7MFMX/yOGDCVD3wOXtiTFKtzIBHTMu/pHFT+zreI+cJ5/6XNGK1zn4Xw0YvS
         PEMUEiNCcRH/QtRg0DcVLTwTN7fCEkbYjYxPABvFK06sIU9gMyyaHhMxavKGHzQVZUMo
         H1WKGjDrMAIho4kxZ+ph2oT334jD+14Lm1DCA10x3Wm9gRW21Rz/6x+ow+PjZ1E/Z75V
         FJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXUx2LqRA2ZqFmr0rCao7mZkB7+aUrBgrBcKJpWY7laqS3VFIrnh/fWQvDbjCxdqVe7sbivjJF3n0xEMEpmR4VtoL4Jj14UPIU/PEFG
X-Gm-Message-State: AOJu0Yy/t2irCxzY6V49NgBtZKywKzSVTerF49ZJSpvcIzW0Sl7qIKB/
	PI72f/0kAx0SME6hwdxf3qY4KDLISVtSerTT0dcSWRQh2uidbzWfS+vQb6fhfIQ=
X-Google-Smtp-Source: AGHT+IEDQm5VMj88QgMa7T2443WaR0z1L0cupYZAj6nJd5Y/yuIH6Y5K3aV/K/rbrptqrKJPbyMfpw==
X-Received: by 2002:adf:a3d0:0:b0:33b:2100:3a44 with SMTP id m16-20020adfa3d0000000b0033b21003a44mr5785649wrb.39.1707389469321;
        Thu, 08 Feb 2024 02:51:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXdJz84ovdU6pVqpNw60wd7HVwL15lYcM+n6oKgtk++P2/cWs0wiEm4kCDeoSC295ABHv6ze6F0PqI/Vog2Kl9f5nws8pWwqCTIDOdU3oqLsabsMlEJt3WF7y93IGweLBiR6AAK3/44S/b9d9jJwhVUl0Gwp1olFjo978YBfnrMyvovgy4r9By/4HqInf/JKChViz9WnRTL4m5SbOAmlSP1O+CicgzP78T8B9TiCk/JRJ8
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d69c1000000b0033b4719eb6esm3308283wrw.27.2024.02.08.02.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:51:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] interconnect: qcom: x1e80100: constify pointer to qcom_icc_bcm
Date: Thu,  8 Feb 2024 11:50:56 +0100
Message-Id: <20240208105056.128448-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointers to struct qcom_icc_bcm are const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/interconnect/qcom/x1e80100.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
index 281295a9a077..99824675ee3f 100644
--- a/drivers/interconnect/qcom/x1e80100.c
+++ b/drivers/interconnect/qcom/x1e80100.c
@@ -1542,7 +1542,7 @@ static struct qcom_icc_bcm bcm_sn4 = {
 	.nodes = { &qnm_usb_anoc },
 };
 
-static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
+static struct qcom_icc_bcm * const aggre1_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const aggre1_noc_nodes[] = {
@@ -1730,7 +1730,7 @@ static const struct qcom_icc_desc x1e80100_gem_noc = {
 	.num_bcms = ARRAY_SIZE(gem_noc_bcms),
 };
 
-static struct qcom_icc_bcm *lpass_ag_noc_bcms[] = {
+static struct qcom_icc_bcm * const lpass_ag_noc_bcms[] = {
 };
 
 static struct qcom_icc_node * const lpass_ag_noc_nodes[] = {
@@ -1871,7 +1871,7 @@ static const struct qcom_icc_desc x1e80100_pcie_north_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_north_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *pcie_south_anoc_bcms[] = {
+static struct qcom_icc_bcm * const pcie_south_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const pcie_south_anoc_nodes[] = {
@@ -1890,7 +1890,7 @@ static const struct qcom_icc_desc x1e80100_pcie_south_anoc = {
 	.num_bcms = ARRAY_SIZE(pcie_south_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *system_noc_bcms[] = {
+static struct qcom_icc_bcm * const system_noc_bcms[] = {
 	&bcm_sn0,
 	&bcm_sn2,
 	&bcm_sn3,
@@ -1928,7 +1928,7 @@ static const struct qcom_icc_desc x1e80100_usb_center_anoc = {
 	.num_bcms = ARRAY_SIZE(usb_center_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *usb_north_anoc_bcms[] = {
+static struct qcom_icc_bcm * const usb_north_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const usb_north_anoc_nodes[] = {
@@ -1944,7 +1944,7 @@ static const struct qcom_icc_desc x1e80100_usb_north_anoc = {
 	.num_bcms = ARRAY_SIZE(usb_north_anoc_bcms),
 };
 
-static struct qcom_icc_bcm *usb_south_anoc_bcms[] = {
+static struct qcom_icc_bcm * const usb_south_anoc_bcms[] = {
 };
 
 static struct qcom_icc_node * const usb_south_anoc_nodes[] = {
-- 
2.34.1


