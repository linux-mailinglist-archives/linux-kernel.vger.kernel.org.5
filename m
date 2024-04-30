Return-Path: <linux-kernel+bounces-163422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5848B6AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C3283459
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9013FE51;
	Tue, 30 Apr 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MCpp3aWW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60CE3FB87;
	Tue, 30 Apr 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714459375; cv=none; b=uNhIw92SITMYfQlUtQVatYjCH8A7qCwgwKK4RgKxvvgVf6k3gA4XbLeUSBM2mZvhc0J6bgnQp0cKXJ2y/xBPknssyPozb49XM88wYXyXLY9UTQw5LxUyVH2n8mJgHUGonxXsAce216DXLnQRPehRcn5xBndc8SJlg0kLEWntlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714459375; c=relaxed/simple;
	bh=zFm9Qv8kKPGatVb+jfAM3WkrDvto1OvHqRWpk6u6GEo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIURWi6fkNFphRS+NsJs6/1ttCOthz1ywldcdU0JwM1aBx0BTxv1wI3AbLMfcUsJdOxAn2KZZjGO4VFQy21Yb51FZPcVEDiUu3aSiQzeudmcHO2iBOztUlRLT/4YiSZgmzyDjb9vKvAYMxt/xwjoth3/p/qul4bB1ucL5TR/RU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MCpp3aWW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U50tgf021481;
	Tue, 30 Apr 2024 06:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=UnzGxxe38yDW6xu1Ra68WWgSMNebSA6aPlwPDiinqH4=; b=MC
	pp3aWW8diUqaePkI+3gM2in7vYDDXDnQVSWjVKYiBP5daPVWHcWkephfgk2HmDQp
	92J+774bzL9OkSC2O3Irg/XvojRfQRwN/FdURxaOJLsEkscFEi3q5AYxBPMO/DUv
	ROxukuHzZNdlErQ/0JXJhDZP5V9xnTv7H+z0vk7YDR7L1qTwSS0txqHVzLRzP9AP
	jYQaobsBrsq4Y/wC0O6Xz91OV1LUOSEFW69UvtAbVK4phatTVWlfF8++DCiIUxya
	zeBcEh8vjGp5PI8XIKuXZ3Lxs7KSiAtaVfXHOekEqbjCh54UUpQcTJVIfjSzHsUk
	WQH9IYNy3QLuyk3CelZQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtbv8c81v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43U6gnJE018919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 06:42:49 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 23:42:44 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_varada@quicinc.com>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <bryan.odonoghue@linaro.org>
Subject: [PATCH v11 3/6] interconnect: icc-clk: Add devm_icc_clk_register
Date: Tue, 30 Apr 2024 12:12:11 +0530
Message-ID: <20240430064214.2030013-4-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430064214.2030013-1-quic_varada@quicinc.com>
References: <20240430064214.2030013-1-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EPVIFOUz2zncG24BF-8eDKkd4TU2LXs8
X-Proofpoint-GUID: EPVIFOUz2zncG24BF-8eDKkd4TU2LXs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_03,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300047

Wrap icc_clk_register to create devm_icc_clk_register to be
able to release the resources properly.

Acked-by: Georgi Djakov <djakov@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v8: Added Reviewed-by: Dmitry Baryshkov
v7: Simplify devm_icc_clk_register implementation as suggested in review
v5: Introduced devm_icc_clk_register
---
 drivers/interconnect/icc-clk.c   | 18 ++++++++++++++++++
 include/linux/interconnect-clk.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 2be193fd7d8f..f788db15cd76 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -148,6 +148,24 @@ struct icc_provider *icc_clk_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(icc_clk_register);
 
+static void devm_icc_release(void *res)
+{
+	icc_clk_unregister(res);
+}
+
+int devm_icc_clk_register(struct device *dev, unsigned int first_id,
+			  unsigned int num_clocks, const struct icc_clk_data *data)
+{
+	struct icc_provider *prov;
+
+	prov = icc_clk_register(dev, first_id, num_clocks, data);
+	if (IS_ERR(prov))
+		return PTR_ERR(prov);
+
+	return devm_add_action_or_reset(dev, devm_icc_release, prov);
+}
+EXPORT_SYMBOL_GPL(devm_icc_clk_register);
+
 /**
  * icc_clk_unregister() - unregister a previously registered clk interconnect provider
  * @provider: provider returned by icc_clk_register()
diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
index 170898faaacb..9bcee3e9c56c 100644
--- a/include/linux/interconnect-clk.h
+++ b/include/linux/interconnect-clk.h
@@ -19,6 +19,8 @@ struct icc_provider *icc_clk_register(struct device *dev,
 				      unsigned int first_id,
 				      unsigned int num_clocks,
 				      const struct icc_clk_data *data);
+int devm_icc_clk_register(struct device *dev, unsigned int first_id,
+			  unsigned int num_clocks, const struct icc_clk_data *data);
 void icc_clk_unregister(struct icc_provider *provider);
 
 #endif
-- 
2.34.1


