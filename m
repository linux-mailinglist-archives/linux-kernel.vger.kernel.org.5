Return-Path: <linux-kernel+bounces-44504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD0E8422EB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C62B1F22FA7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8512C59B7C;
	Tue, 30 Jan 2024 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GyqDZ84M"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D1B66B5F;
	Tue, 30 Jan 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613872; cv=none; b=HOciMSD2Zmuz0hZ/CO1K0nM/ddUhYNyO9pFa4GaF49OeXaLTU6WVxgleWxE8E++JRI5b2FglT7XIreIPFwEX4WT5a+HWtEMKEvwDnCojmWwBB8Ouidvw5gkgdZRhloPNmzrnm3o+lK14iYSInWr8JLlGh0FjiMcy7C01Evf8se4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613872; c=relaxed/simple;
	bh=s9YWx0niqq/0hb6eo0iRhIrN+Gm4N4nnCpUXz+Ce8zM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5krBxMpEjO1uAfUWVqA9HEQtNmJvGRUj0qR3evRDAtHstLz/u5LYYugqH1ssB/Oax+4un26v/OD3huMoV+HmFSJCQGUvXHeVDYPWyTQLFAmkNS0K2dwqeSLzEHuK7KOsUtbcYNfuSVcCTqpR6mgjpPZjqZW+ttGVkQYjKuCD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GyqDZ84M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UATqTk004958;
	Tue, 30 Jan 2024 11:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=19/E3FYg6etQ1bcM7OtOpZ5QOGxHV/AWg0H8PpSM8FA=; b=Gy
	qDZ84MLyhSN1m/EYlxbWJM7b+0h+A+/gDkizI8xfzDdomosS3QIGiZ82Hj42SjSr
	km1y2Am4K6AktAwNeUJpjgrdPM+B1AX6DDGrDgc46Cy14NTkrEoJO2Hx9ZvcqsKK
	1JDCRSB853Tx5F1aHgFA3egnJ6HBLOW/ZIYkfLEUVXxqtYaG8Wuxk2Yd5R1CwAu3
	C9QLCp8/JhLIGRZ2B/QKH1oGdXr7o4SV0lJXVRn8M1ka5drX+PtBSZEFKVPX9RB4
	7jfPDUomJMLlRNGMPwYBgBwRpEXLjJA036hO2payrfqYiHgmBM/s3xKCXVtSoRV2
	j3EkjZ5zpyAo2hMpBQKg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxydh03fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UBOQsg020891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 11:24:26 GMT
Received: from hu-sachinku-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 03:24:22 -0800
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
Subject: [PATCH v2 1/2] media: v4l2-ctrls: add encoder maximum bitrate control
Date: Tue, 30 Jan 2024 16:53:59 +0530
Message-ID: <20240130112400.2636143-2-quic_sachinku@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
References: <20240130112400.2636143-1-quic_sachinku@quicinc.com>
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
X-Proofpoint-ORIG-GUID: EwQWnUDYolg4O80HRohGrAu06qJPOck8
X-Proofpoint-GUID: EwQWnUDYolg4O80HRohGrAu06qJPOck8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=771
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300083

Introduce V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control to
limit the frame level maximum bit rate.
Encoder will choose appropriate quantization parameter and
do the smart bit allocation to set the frame maximum bitrate
level as per the Bitrate value configured.

Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
 include/uapi/linux/v4l2-controls.h                        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 2a165ae063fb..05ef4a70e3f5 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -576,6 +576,8 @@ enum v4l2_mpeg_video_bitrate_mode -
       - Constant bitrate
     * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_CQ``
       - Constant quality
+    * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_MBR``
+      - Maximum bitrate
 
 
 
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 8696eb1cdd61..e0597b61ffb9 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -154,6 +154,7 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"Variable Bitrate",
 		"Constant Bitrate",
 		"Constant Quality",
+		"Maximum Bitrate",
 		NULL
 	};
 	static const char * const mpeg_stream_type[] = {
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 99c3f5e99da7..7c74d6c417d1 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -393,6 +393,7 @@ enum v4l2_mpeg_video_bitrate_mode {
 	V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = 0,
 	V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = 1,
 	V4L2_MPEG_VIDEO_BITRATE_MODE_CQ  = 2,
+	V4L2_MPEG_VIDEO_BITRATE_MODE_MBR = 3,
 };
 #define V4L2_CID_MPEG_VIDEO_BITRATE		(V4L2_CID_CODEC_BASE+207)
 #define V4L2_CID_MPEG_VIDEO_BITRATE_PEAK	(V4L2_CID_CODEC_BASE+208)
-- 
2.34.1


