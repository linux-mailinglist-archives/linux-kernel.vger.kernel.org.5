Return-Path: <linux-kernel+bounces-14065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DB3821783
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E991C2131B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934B15CA;
	Tue,  2 Jan 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="euwHxWwO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7643223AD;
	Tue,  2 Jan 2024 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4023vt8N032529;
	Tue, 2 Jan 2024 05:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=nqkpKW1
	BO7eF60KkQnC7BBZxA2RoHV62l7mseP9CNgk=; b=euwHxWwOcAJmzQADEiGOxWd
	k3MOUNdXO4FUwj5AR2LO3zY70MkxcY/5/NMo8Rer2yS2gN2VVmpkGqM6KqJew2Fw
	G6RO1fdWUygKknEafYHRNWV+nvC4r9EWEPBP4iqKiNPZ1CWoEW087PIyxFh9iZrk
	tuYYUE1pJ6JH1eQbL1UEloRKWW2bcKoUDUbJItMOaMMwJP0bzxo/oDEMcSH/NGwi
	CzusVH5l7dxu/aF6twDfwU1fmdvUPGcnpschdvKo4iEIS4P8jwzi0aTECmTzFH0A
	jlidI6gX3y0K3o1ox1FSuN4BacrsMpjy5KgpMFcX8DDuNfDAkiBW0vwPDju+I2g=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vabe7c5ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 05:52:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4025pvNd004884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 05:51:57 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jan 2024 21:51:54 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH] usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
Date: Tue, 2 Jan 2024 11:21:43 +0530
Message-ID: <20240102055143.3889-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: njA0TAA-TpOdBu5vcoKT5MADoqv0CTc4
X-Proofpoint-ORIG-GUID: njA0TAA-TpOdBu5vcoKT5MADoqv0CTc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=638
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401020043

It is observed sometimes when tethering is used over NCM with Windows 11
as host, at some instances, the gadget_giveback has one byte appended at
the end of a proper NTB. When the NTB is parsed, unwrap call looks for
any leftover bytes in SKB provided by u_ether and if there are any pending
bytes, it treats them as a separate NTB and parses it. But in case the
second NTB (as per unwrap call) is faulty/corrupt, all the datagrams that
were parsed properly in the first NTB and saved in rx_list are dropped.

Adding a few custom traces showed the following:

[002] d..1  7828.532866: dwc3_gadget_giveback: ep1out:
req 000000003868811a length 1025/16384 zsI ==> 0
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb toprocess: 1025
[002] d..1  7828.532867: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb seq: 0xce67
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x400
[002] d..1  7828.532868: ncm_unwrap_ntb: K: ncm_unwrap_ntb ndp_len: 0x10
[002] d..1  7828.532869: ncm_unwrap_ntb: K: Parsed NTB with 1 frames

In this case, the giveback is of 1025 bytes and block length is 1024.
The rest 1 byte (which is 0x00) won't be parsed resulting in drop of
all datagrams in rx_list.

Same is case with packets of size 2048:
[002] d..1  7828.557948: dwc3_gadget_giveback: ep1out:
req 0000000011dfd96e length 2049/16384 zsI ==> 0
[002] d..1  7828.557949: ncm_unwrap_ntb: K: ncm_unwrap_ntb nth: 1751999342
[002] d..1  7828.557950: ncm_unwrap_ntb: K: ncm_unwrap_ntb blk_len: 0x800

Lecroy shows one byte coming in extra confirming that the byte is coming
in from PC:

Transfer 2959 - Bytes Transferred(1025)  Timestamp((18.524 843 590)
- Transaction 8391 - Data(1025 bytes) Timestamp(18.524 843 590)
--- Packet 4063861
      Data(1024 bytes)
      Duration(2.117us) Idle(14.700ns) Timestamp(18.524 843 590)
--- Packet 4063863
      Data(1 byte)
      Duration(66.160ns) Time(282.000ns) Timestamp(18.524 845 722)

Fix this by checking if the leftover bytes before parsing next NTB is of
size more than the expected header.

Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
There could probably be cases where the first NTB is proper and the second
NTB's header is proper but the NDP is corrupt, and in those cases too, all
the datagrams are dropped. But I haven't seen such case practically.

 drivers/usb/gadget/function/f_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index cc0ed29a4adc..a75b6dc8b0cb 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1325,7 +1325,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+	if (to_process > opts->nth_size) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
-- 
2.42.0


