Return-Path: <linux-kernel+bounces-44503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FDC8422E8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147FF1C235C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C142466B47;
	Tue, 30 Jan 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ht80Dq2P"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE959B7C;
	Tue, 30 Jan 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613870; cv=none; b=LDHDtvlkowByyIqJkvhOJ8diAvpEmJL0ruK/65JRujHUA4eKFw8Lpv55SQ+qcMEWBabd9HjcFrrk2EJUQPHqEQ1jumtyUjHK4jLzRYWn39Xzh9I/1jOXR57VLd6joDoTbZiyDpqQSauXOBAk+dSltuvPrzezJwgp8xjzoZbTl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613870; c=relaxed/simple;
	bh=55twkulurKEhU3/5jQyrocYphXr36C8mLB2dQCIalOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iL45w1r8kd49gmpEUK+Mipf/KKcQorkwpRqzHr882Eh2SG4oFciAhz522iJ73PYG5ks2Jtzhj1s5R0D0PXDw+ZBlOx8rgq0dhVwPWHil+7xncbjC6H9YK1cQ+6ffqfA/OmxkVizNGtF3WMvEr5gGeVaBShCCJ3YdelqPLBsTvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ht80Dq2P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U9Ruu7008388;
	Tue, 30 Jan 2024 11:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=zJmbk1V
	qksggc73frfFlV2kdKy6n+PP3JCr/btLA9JM=; b=ht80Dq2PHWzH6usw9uCqFfL
	oeyuGoWC5EA+sg9JaOCTJwrsXCdz2sXIUVXxt/CV0Kuu2odi9ROnqnL+J5PRWN89
	aAGo1VWchJrTCw7FKpz+homnggPwWPDK1v5GBjBCtpGsHOuM1dvww58vhk0TS/CK
	UmWn95E6xl5gxMZcOuTickhHEpRQu4/n2kytXx02m/i98oyF092R2OFCH9bi59sK
	v99/mxQGMsbGnQg4KkyagccLjPtk9wV8VeBYk3qMqgIwoAH8B8d9OTOKMj4MjqUd
	HQoebTC9a2xvRzYJPBHnfbBPi+5jw8lG/qrd5r7btXVvUIa8AKMnwFF2Sam0Bxg=
	=
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxsc20u54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UBOMcA020870
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:22 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 03:24:18 -0800
From: Sachin Kumar Garg <quic_sachinku@quicinc.com>
To: <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia
	<quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/2] add MBR type rate control for encoder
Date: Tue, 30 Jan 2024 16:53:58 +0530
Message-ID: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
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
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rYOHJIX_EUsV0uMZhC82x6jx-D5jJ2lk
X-Proofpoint-ORIG-GUID: rYOHJIX_EUsV0uMZhC82x6jx-D5jJ2lk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=408 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300083

This series adds the support for MBR rate control type in the
venus driver.
This rate control type will limit the frame level maximum bitrate as
per the target bitrate.
It will improve the video quality of low motion video at ultra low
bit-rates.

Sachin Kumar Garg (2):
  media: v4l2-ctrls: add encoder maximum bitrate control
  media: venus: add new rate control type MBR for encoder

 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 drivers/media/platform/qcom/venus/hfi_cmds.c              | 7 +++++++
 drivers/media/platform/qcom/venus/hfi_helper.h            | 1 +
 drivers/media/platform/qcom/venus/venc.c                  | 2 ++
 drivers/media/platform/qcom/venus/venc_ctrls.c            | 5 +++--
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
 include/uapi/linux/v4l2-controls.h                        | 1 +
 7 files changed, 17 insertions(+), 2 deletions(-)

-- 
2.34.1


