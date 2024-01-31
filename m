Return-Path: <linux-kernel+bounces-46680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F54844294
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0033294E38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A486C12837F;
	Wed, 31 Jan 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CZBXejZh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F284A25;
	Wed, 31 Jan 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713443; cv=none; b=n26tEciDBtBzukBmDT+fbrLNIaAfaSR/pvPJONDoIml2mbVWFEIDwQF3Jr1kDAO2pUuur8Z6l0De0pcd5ZK++R9mgBXQEqag7aTy/lb3xxJUnZhVSKLfmvCGgdnpn89FoWigWqdHLQ6AGExsOmTFp/awpO+Wde9+o4fdQSLGiMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713443; c=relaxed/simple;
	bh=HJdmb7h0QaZGP66qIXldp2YTcyPoeipLgIu7f7lQLcU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBuwrAl6UTQKawDiEUd+tXJfUnCr4twEr26zBIZIwb9PozzK4mBqA0lspTLAfsOfLB5/So09Kj+9MnFh944cYWFlHutyGMiG2wd6CmmtmqY28Ht+hlx/VZmnd1FA+JYRYpvzsRpv2kroO5PK/qyFa5OMeTN0/kNxZpFzyJi1zK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CZBXejZh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V8GcpL030372;
	Wed, 31 Jan 2024 15:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=YtxZvW3
	hnfdJmx6lb0KykRZsA1aJx+W6kbJi++0M8JM=; b=CZBXejZhAuugqSVSipwawdf
	UFp9GPbC849P/dOytU2wbEIAkmebaYWjKJwwBorp5nXTbmqrkcvp4/fJPx/KDuo5
	dAtWBFCAgOyLtCJ7+L286WMD15mg0mkvb4ZfYaxP6U+bRuyejpgVPU4xcSTOlV5w
	P7vG3/S/wL9dB7GmL2LPX3UD3f8MMauDPhJkRbXWuq0AumW1d3NqLJz/NzYhQnku
	uFrTI3jRDHJDpjT+mbovHWrYeJfp0dU2ClCfPmYTR/PesIGbsnbcvei56E4pfmfv
	QE6JlEKRd1fdEMH+Aec041XI7f5q8UFoAwcpIAbp39VuGibX/HdKT9srnR4ZQ8w=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vygp7h9bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 15:03:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VF3ptV008739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 15:03:51 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 07:03:48 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs
Date: Wed, 31 Jan 2024 20:33:32 +0530
Message-ID: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
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
X-Proofpoint-ORIG-GUID: dMXBnbG4Yd2ijiJbA1SRxDJyYJ9Icngh
X-Proofpoint-GUID: dMXBnbG4Yd2ijiJbA1SRxDJyYJ9Icngh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=590 lowpriorityscore=0 clxscore=1011 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401310116

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

According to Windows driver, no ZLP is needed if wBlockLength is non-zero,
because the non-zero wBlockLength has already told the function side the
size of transfer to be expected. However, there are in-market NCM devices
that rely on ZLP as long as the wBlockLength is multiple of wMaxPacketSize.
To deal with such devices, it pads an extra 0 at end so the transfer is no
longer multiple of wMaxPacketSize.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/gadget/function/f_ncm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index ca5d5f564998..8c314dc98952 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1338,11 +1338,17 @@ static int ncm_unwrap_ntb(struct gether *port,
 	     "Parsed NTB with %d frames\n", dgram_counter);
 
 	to_process -= block_len;
-	if (to_process != 0) {
+
+	if (to_process == 1 &&
+	    (block_len % 512 == 0) &&
+	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
+		goto done;
+	} else if (to_process > 0) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
 
+done:
 	dev_consume_skb_any(skb);
 
 	return 0;
-- 
2.34.1


