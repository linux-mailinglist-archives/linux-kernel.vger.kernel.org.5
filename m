Return-Path: <linux-kernel+bounces-83551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4A869B48
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6950D1C23758
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BB5149E14;
	Tue, 27 Feb 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NAUqpgdK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17B1487E2;
	Tue, 27 Feb 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049229; cv=none; b=FLi3yWXYWvQFk7+7wIK7wVhivCji/llgtgOyLERd7iNysBdaMC+gcvRYASHKk095nhW6Bs21qQEn/0ai+iTQRjuTStCtcmIc1BEAwhT8i1H8F8j5GgJ8cjxMWJ8K8FPXpB1Iog96wiTpJLZCrByIrLMWfqjMZZhBsje4766YLhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049229; c=relaxed/simple;
	bh=cMCWwOFDDzkP/opZ4OZblcKhabLUYOPklY3q66jnb6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gj6dLA5Vyd8/CzybLOxqJXCmlWmzNODV7Rwrl9VKBJ6VfdhIW7mIDSDJBhgJJjABTpldghaT7cp8X37dc09tJoVS3vPQV6fbd1fxESNwB7ClMx3izsYKpQfSOwRvEU58DX05rVeFBKfuQOuvu8rTzBgjEbISQH8Oj5WXf7L1LVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NAUqpgdK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41REac2u021570;
	Tue, 27 Feb 2024 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iK+5IGZCTHYf95YGpbHUD4YjDMRJdiTM0LY+A4KnU0Q=; b=NA
	UqpgdKbzq7NOxihfjQK3XdK5fREzSOpfiWt/WcZc1JM56r2xktAIV8CQRDM9tLWo
	KKHwhtb8RSaT63nht4Yt4Q7+JYfhRUh1kyfXGG7RgzAmdxHnu4X9CSagV8X7UK3M
	5IqR6FfekDy5evAsquS4+Aa1fkKS4JbQJl7yX5XboioQVeqg6eIx3KiDEABjSFUO
	WWvleFW/CwthFpRtPlpuO9TVrFJ0UogxKIXNvsPLl92fuy88KfepL3EMyU2BJn1O
	K0OaOaeJdblMWPNjjZNF7x416sRWvZcyd3VZ0BdsYpbfiYSCV/dr7GJtcpcfSH3b
	N4Wz/6gGeeqipP2lE/OA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wha079bjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:44 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RFrhjS028712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 15:53:43 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 07:53:41 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v12 5/9] pinctrl: qcom: Use qcom_scm_io_rmw() function
Date: Tue, 27 Feb 2024 21:23:04 +0530
Message-ID: <20240227155308.18395-6-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240227155308.18395-1-quic_mojha@quicinc.com>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kBVG0DAQQiBnusn7Yhm6ROiLjrCfJjI4
X-Proofpoint-GUID: kBVG0DAQQiBnusn7Yhm6ROiLjrCfJjI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_01,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=719 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402270123

Use qcom_scm_io_rmw() exported function in pinctrl-msm
driver.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
@Linus.Walleij,

I have removed your Ack on this patch after your comment
on https://lore.kernel.org/lkml/CACRpkdbnj3W3k=snTx3iadHWU+RNv9GY4B3O4K0hu8TY+DrK=Q@mail.gmail.com/

If you agree on the current solution, please ack this again.

 drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index aeaf0d1958f5..1bd5c8c43fcd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1082,22 +1082,20 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 	if (g->intr_target_width)
 		intr_target_mask = GENMASK(g->intr_target_width - 1, 0);
 
+	intr_target_mask <<= g->intr_target_bit;
 	if (pctrl->intr_target_use_scm) {
 		u32 addr = pctrl->phys_base[0] + g->intr_target_reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
-		val &= ~(intr_target_mask << g->intr_target_bit);
-		val |= g->intr_target_kpss_val << g->intr_target_bit;
-
-		ret = qcom_scm_io_writel(addr, val);
+		val = g->intr_target_kpss_val << g->intr_target_bit;
+		ret = qcom_scm_io_rmw(addr, intr_target_mask, val);
 		if (ret)
 			dev_err(pctrl->dev,
 				"Failed routing %lu interrupt to Apps proc",
 				d->hwirq);
 	} else {
 		val = msm_readl_intr_target(pctrl, g);
-		val &= ~(intr_target_mask << g->intr_target_bit);
+		val &= ~intr_target_mask;
 		val |= g->intr_target_kpss_val << g->intr_target_bit;
 		msm_writel_intr_target(val, pctrl, g);
 	}
-- 
2.43.0.254.ga26002b62827


