Return-Path: <linux-kernel+bounces-153726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC828AD260
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE701C21228
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3BF154438;
	Mon, 22 Apr 2024 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S84wX8FJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3B6A039;
	Mon, 22 Apr 2024 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804068; cv=none; b=VbZm8s2qiKi3Fj9rCnN/JHNQYxKewdPjUulfFl3qCng5Njy7lZotekaGfJbFkQnxP4I1emNZ2+jXWicyuoEJUZb7OCnYWiZCg51d31MH1nDBKmiM4m1S3EekGlociO99C6DJIy0hWirSeU4PW+pbUFKKUGWzq/ITuiu4aBmjoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804068; c=relaxed/simple;
	bh=GRJhH4yFri7nEDKCf75SdVhX/QLfLKQemLE+tUiqSrY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f5VKx6PrwSWzfmgRH0gbtSRi0fzK8Mv3GG9Z7feoa7mpBVXMQz//D0KbFkrTxWlzMlu0il+6QYTsYMiKoOTcwsBanzat98AvaYc9XkEyAn6uzpmYeszDtTDAaHYqWHz+NtfWl3AM0WKRINfXIyX8hq3djwlZzPmpqaan+uuMTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S84wX8FJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9vSNd006264;
	Mon, 22 Apr 2024 16:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=sTWR3Nk
	9D0p72sg0Ndf28rPM6luo5VBfzjM7fZfXFl4=; b=S84wX8FJ2Hy05HVkyNRDIOj
	wUAbHR8UbFWpUV5NTLLpPp82Lw50cNiUijqRkXAOtp8LnDFAyW2SVVya1wNPGBM1
	yQEeQ4CvIND8mXZs77LQNl15eHkPwgvl1+q1Km3wxsbn6pwOBPoxdaj/UshJzDiw
	gxyVADSitBljY/hVRT+bQK3UU2XbxgBNZxS3NJf2zOyjc37OQt0mh8T2MI/GOdAt
	4J3oVcU9VQPacK4Q9VG4sxokTRBet/i8SQEykDC2GQBIgwo6wqT3LHmVfjhlMDaz
	ofp5ru3MWJ6/LM138dD0aa2iK0klsFgW6I7cKnXhfq0Pyx8mb64EbVfrUTlA+Ig=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnet79v98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:40:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MGetYv025858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 16:40:55 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 09:40:49 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_gkohli@quicinc.com>,
        <quic_nkela@quicinc.com>, <quic_psodagud@quicinc.com>,
        <abel.vesa@linaro.org>
Subject: [PATCH V4 0/5] qcom: x1e80100: Enable CPUFreq
Date: Mon, 22 Apr 2024 22:10:30 +0530
Message-ID: <20240422164035.1045501-1-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: it1jMnWhTDP92oXwP3i50BmS5WUq7bzY
X-Proofpoint-ORIG-GUID: it1jMnWhTDP92oXwP3i50BmS5WUq7bzY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220070

This series enables CPUFreq support on the X1E SoC using the SCMI perf
protocol. This was originally part of the RFC: firmware: arm_scmi:
Qualcomm Vendor Protocol [1]. I've split it up so that this part can
land earlier.

V3:
* Fix Maintainer info in cpucp mbox bindings. [Bjorn]
* Fix copyright info in cpucp driver. [Bjorn]
* Drop unused APSS_CPUCP_TX_MBOX_IDR, value init and drv_data. [Bjorn/Dmitry]
* Convert to lower case hex. [Bjorn]
* Convert irq and dev to local variables. [Bjorn]
* Replace for and if with for_each_set_bit. [Bjorn]
* Document the need for spinlock. [Bjorn]
* Add space after " for aesthetics. [Bjorn]
* Fix err in calc and add fixes tag. [Bjorn]
* Include io.h and re-order platform_device.h
* Use GENMASK_ULL to generate APSS_CPUCP_RX_MBOX_CMD_MASK.

V2:
* Fix series version number [Rob]
* Pickup Rbs from Dimitry and Rob.
* Use power-domain instead of clocks. [Sudeep/Ulf]
* Rename sram sub-nodes according to schema. [Dmitry]
* Use BIT() instead of manual shift. [Dmitry]
* Define RX_MBOX_CMD to account for chan calculation. [Dmitry]
* Clear the bit instead of the entire status within the spinlock. [Dmitry]
* Use dev_err_probe instead. [Dmitry]
* Drop superfluous error message while handling errors from get_irq. [Dmitry]
* Use devm_mbox_controller_register and drop remove path. [Dmitry]
* Define TX_MBOX_CMD to account for chan calculation.
* Use cpucp->dev in probe path for conformity.

RFC V1:
* Use x1e80100 as the fallback for future SoCs using the cpucp-mbox
  controller. [Krzysztoff/Konrad/Rob]
* Use chan->lock and chan->cl to detect if the channel is no longer
  Available. [Dmitry]
* Use BIT() instead of using manual shifts. [Dmitry]
* Don't use integer as a pointer value. [Dmitry]
* Allow it to default to of_mbox_index_xlate. [Dmitry]
* Use devm_of_iomap. [Dmitry]
* Use module_platform_driver instead of module init/exit. [Dmitry]
* Get channel number using mailbox core (like other drivers) and
  further simplify the driver by dropping setup_mbox func.

[1]: https://lore.kernel.org/lkml/20240117173458.2312669-1-quic_sibis@quicinc.com/#r

Other relevant Links:
https://lore.kernel.org/lkml/be2e475a-349f-4e98-b238-262dd7117a4e@linaro.org/

Sibi Sankar (5):
  dt-bindings: mailbox: qcom: Add CPUCP mailbox controller bindings
  mailbox: Add support for QTI CPUCP mailbox controller
  arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
  arm64: dts: qcom: x1e80100: Add cpucp mailbox and sram nodes
  arm64: dts: qcom: x1e80100: Enable cpufreq

 .../bindings/mailbox/qcom,cpucp-mbox.yaml     |  49 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi        |  91 ++++++---
 drivers/mailbox/Kconfig                       |   8 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/qcom-cpucp-mbox.c             | 179 ++++++++++++++++++
 5 files changed, 304 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
 create mode 100644 drivers/mailbox/qcom-cpucp-mbox.c

-- 
2.34.1


