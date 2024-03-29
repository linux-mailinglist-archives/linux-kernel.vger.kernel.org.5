Return-Path: <linux-kernel+bounces-126148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8387B8932D6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E7D1C21729
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC111487F1;
	Sun, 31 Mar 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FTERM9/V"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB471474D1;
	Sun, 31 Mar 2024 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902384; cv=fail; b=cL++eZa+O+BuEwhvjpJ8sS7a7Fo5oSbIOJXrG5JDFTlTTNXntP0Re/c0lcWUkX7A+znc3pd5NbopMWEO67GswopiUVrz/3+AKBLT6TTJpN+vsYPkYepwoa+3dHdhfp4xMycsn6GPG8pXpJKFc0wWCqPWMqkP4RLMJ9bifVLwDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902384; c=relaxed/simple;
	bh=pd/yQLgrf8goU0+fRJryUS/+vw2y5WKDeCF1TeAuKM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BBHRQ5llodz89uEdGy16Iu8WB92MEEZIhyRYc1p5ZQ3wIlWZJxmwOi6I7elWHIDbigHUls/w1hyvq1zqBnda0jnUXkQvpWirYq/nCatNpqxkQHwrQyBdi/6wSUjpTdFbAGKPJWBMUMSOoHc3GJyfiVUuCwysZNy6pUEMRQW/R8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FTERM9/V reason="signature verification failed"; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1E03720842;
	Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ063XuAar1k; Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C694F20847;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com C694F20847
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id BB0FA80004E;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:36 +0000
X-sender: <linux-wireless+bounces-5633-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB7AAAAjYoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13762
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5633-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com B2B79200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FTERM9/V"
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755060; cv=none; b=icRZ3GQZ4LH0m54ufTNTs9sYdI+VC4Tc9bjQiwntqOjeqcJZTWWPvGSMUBXHuvsyKAO6IJ0virN1V9EqoarLsh1zq457KppYfFe+aEYtPEW6HrbNqbm4SvfFCUAerpMZdlIOxqRCPxdi7CALATtLWnC8dDh1dAmBZGkFi2obJuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755060; c=relaxed/simple;
	bh=lBeSbpvKtu7CI6ssg8nuSsI5YVNDAdLUREbP4jjd/B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QkDEzo/zJIwRlN6thaQ0BMBD+m7kn9Wn4PHDgI7YsmA3iypvX3oEBe6BVIjyN53orikSVYv0NpiMVtN3WCShA0RnykAcJDcLBtPsHlQX0Ug3bjiHfFRxFGRBmD+6coPWmc+WhDKo3eXvF08hLSMjDWz1jog5mI4ig2dI1N3m7ms=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FTERM9/V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UdTjQRnbCW3xwMQWg7b868sxHGl70tF2hE40iTRHTRc
	=; b=FTERM9/Vf5bMSwtGcvW6UUUGdBBICbBDdpbt32nkhBCvk0NHBMzK0xADnKd
	wzpTlmO/OySYufrah2pc5Zb8GTWxC+it2QkU+xDaX8zEdW65V3T+FE3Gsmmd/Rcr
	0H+r9KHgcIMaqf+dDdvhCzI8o4oZd2Iw83t2tr4WcfC/BZ285DsTPNmCfL9vJVTb
	peLT3i4noaN15AFzRtCWVo58E4W3eFsjIvOcD/Z8Af4+Gd+3uNegNKli/tc1VrSS
	RGus5tHBKborFSUtSVE3Sl1ERvoYwttnBlpnRJvKe1unvYSXkyYnyQMhspObTUe8
	CBj2whTXUpODjePczhqvvoPsrog==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 16:30:50 -0700
Subject: [PATCH 1/2] wifi: ath11k: fix hal_rx_buf_return_buf_manager
 documentation
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-1-e62ec9dc2af9@quicinc.com>
References: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
In-Reply-To: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jmiGE6KP8kxGnutX1SJ7Y7nYSDbvY4wa
X-Proofpoint-ORIG-GUID: jmiGE6KP8kxGnutX1SJ7Y7nYSDbvY4wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=746 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290209
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

kernel-doc flagged the following issue, so fix it:

drivers/net/wireless/ath/ath11k/hal.h:668: warning: missing initial short d=
escription on line:
 * enum hal_rx_buf_return_buf_manager

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/a=
th/ath11k/hal.h
index 65e8f244ebb9..e453c137385e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -664,7 +664,7 @@ struct hal_srng_config {
 };
=20
 /**
- * enum hal_rx_buf_return_buf_manager
+ * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer l=
ist
  * @HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST: Descriptor returned to WBM idle

--=20
2.42.0


X-sender: <linux-kernel+bounces-125530-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAPDFCS25B=
AlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURh=
dGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQB=
HAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3=
VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4Y=
wUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5n=
ZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl=
2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ0=
49Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAH=
QAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5z=
cG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAw=
AAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbi=
xPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAo5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB+AAAAjYoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13174
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 00:31:46 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 00:31:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A241C208A6
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:31:46 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T4lsirLdQQoN for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 00:31:46 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125530-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 23DE720870
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 23DE720870
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9021F22701
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7C13F443;
	Fri, 29 Mar 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"FTERM9/V"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C8985644;
	Fri, 29 Mar 2024 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711755060; cv=3Dnone; b=3DicRZ3GQZ4LH0m54ufTNTs9sYdI+VC4Tc9bjQiwntqOj=
eqcJZTWWPvGSMUBXHuvsyKAO6IJ0virN1V9EqoarLsh1zq457KppYfFe+aEYtPEW6HrbNqbm4Sv=
fFCUAerpMZdlIOxqRCPxdi7CALATtLWnC8dDh1dAmBZGkFi2obJuM=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711755060; c=3Drelaxed/simple;
	bh=3DlBeSbpvKtu7CI6ssg8nuSsI5YVNDAdLUREbP4jjd/B4=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3DQkDEzo/zJIwRlN6thaQ0BMBD+m7kn9Wn4PHDgI7YsmA3iypvX3=
oEBe6BVIjyN53orikSVYv0NpiMVtN3WCShA0RnykAcJDcLBtPsHlQX0Ug3bjiHfFRxFGRBmD+6c=
oPWmc+WhDKo3eXvF08hLSMjDWz1jog5mI4ig2dI1N3m7ms=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DFTERM9/V; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TJFrmO=
013057;
	Fri, 29 Mar 2024 23:30:51 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3DUdTjQRnbCW3xwMQWg7b868sxHGl70tF2hE40iTRHTRc
	=3D; b=3DFTERM9/Vf5bMSwtGcvW6UUUGdBBICbBDdpbt32nkhBCvk0NHBMzK0xADnKd
	wzpTlmO/OySYufrah2pc5Zb8GTWxC+it2QkU+xDaX8zEdW65V3T+FE3Gsmmd/Rcr
	0H+r9KHgcIMaqf+dDdvhCzI8o4oZd2Iw83t2tr4WcfC/BZ285DsTPNmCfL9vJVTb
	peLT3i4noaN15AFzRtCWVo58E4W3eFsjIvOcD/Z8Af4+Gd+3uNegNKli/tc1VrSS
	RGus5tHBKborFSUtSVE3Sl1ERvoYwttnBlpnRJvKe1unvYSXkyYnyQMhspObTUe8
	CBj2whTXUpODjePczhqvvoPsrog=3D=3D
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89htf0-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 23:30:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TNUosE01=
0874
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 23:30:50 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 16:30:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 16:30:50 -0700
Subject: [PATCH 1/2] wifi: ath11k: fix hal_rx_buf_return_buf_manager
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-1-e62ec9dc2af9@quici=
nc.com>
References: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quici=
nc.com>
In-Reply-To: <20240329-hal_rx_buf_return_buf_manager-v1-0-e62ec9dc2af9@quic=
inc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: jmiGE6KP8kxGnutX1SJ7Y7nYSDbvY4wa
X-Proofpoint-ORIG-GUID: jmiGE6KP8kxGnutX1SJ7Y7nYSDbvY4wa
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 mlxscore=3D0
 mlxlogscore=3D746 bulkscore=3D0 malwarescore=3D0 priorityscore=3D1501
 lowpriorityscore=3D0 phishscore=3D0 adultscore=3D0 suspectscore=3D0
 impostorscore=3D0 spamscore=3D0 classifier=3Dspam adjust=3D0 reason=3Dmlx
 scancount=3D1 engine=3D8.19.0-2403210001 definitions=3Dmain-2403290209
Return-Path: linux-kernel+bounces-125530-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 23:31:46.6891
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 7c50e3d1-96e1-411e-1296-08dc=
5048667a
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.393|SMR=3D0.338(SMRDE=3D0.034|SMRC=3D0.30=
3(SMRCL=3D0.103|X-SMRCR=3D0.303))|CAT=3D0.054(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.021(CATRESLP2R=3D0.001)|CATORES=3D0.019
 (CATRS=3D0.019(CATRS-Index Routing Agent=3D0.018)));2024-03-29T23:31:47.09=
4Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9170
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.012|SMR=3D0.010(SMRPI=3D0.008(SMRPI-FrontendProxyAgent=3D0.008))=
|SMS=3D0.001
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAbACAAAPAAADH4sIAAAAAAAEAI1STW/T=
QBAdf8ROnLg9cE
 IIabjRpk6aNE1LQCiUFtGqXFoQ3CzHXjvbOmuwHRoE/BF+LbPrfhxI
 RKT17Mz4zZvZt/vHvma5YKkXZSHGaZAkLMJyyjDO0jS74SJBXhRzto
 NFhjFfIC9HruM6Uc6/s7zoClZ2b3jOUlYU3aCcyq/Xu+5Og7QzHQ2H
 hyO8CXJBPCOcEZMiFLzkQYrFNMtLjFgR5vxryTOBtFIuGHXAbWRiPk
 Pi8fOFP5nHfs7KeS6UOwtEkLBcDnLJE8EiL4tjb/JjhGcsjvEsm4qC
 uF59m/PQv7qqwrGMuAg7YTZ77Tqe51Gbtc6Bv7CPbQnvkQYpw3AaCB
 Jqh2IuCpbL4Z+3t2QcEYUKvS2lE6d5PC/hJQbd9ZpN1sO5DhcRW+Bw
 nx3G/cGATSYvOh022N8Le3sHe4f7DHu7u8PBQB113e6u02631x9hPE
 ZvOBzsHGC72ihRlPk8LNXNFblI/DATMU/wJ8n3+6XUBLvb2zTUmlfc
 XguHHt55cZZjBaCnnC+QUDEdhfritjI4fv/m3L/44h99eudfHH3wP9
 N3enx+ohLnp5cfR3ikih54ygwJhTyi268I6aUW5X/4jk8u394SHt8+
 82w5qdRFPsh+Z9Dv7MrIdQAsDRywDTBtqJNtgFMDWweDfB3sKlmHBl
 lLwTRNNwAMqNnQoL+0amA1oUUlJjgm1AwNnspa477EhiZ1cZWvg2mq
 WlODx1CrKxIDWssaEQQ0zZYWdFmlNSq/oW1UTh02zQoM+hIG0FfkDZ
 q5BRstzbVIAWitgNnL85plAm01NZ7+4ENNAjTYVGe04MkKNdwVeee+
 F+VteEQYvMNUSxZKa1FJBTNue9kmNAn/7B+8WpYDzQe81qom14EEMq
 T/FxUKlf6jBQAAAQr1ATw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rp
 bmc9InV0Zi0xNiI/Pg0KPEVtYWlsU2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPEVtYWlscz4NCiAgICA8RW1haWwg
 U3RhcnRJbmRleD0iMjIwIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCi
 AgICAgIDxFbWFpbFN0cmluZz5xdWljX2pqb2huc29uQHF1aWNpbmMu
 Y29tPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYWlsPg0KICA8L0VtYW
 lscz4NCjwvRW1haWxTZXQ+AQy6BDw/eG1sIHZlcnNpb249IjEuMCIg
 ZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRhY3RTZXQ+DQogIDxWZX
 JzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8Q29udGFjdHM+DQog
 ICAgPENvbnRhY3QgU3RhcnRJbmRleD0iMjA2IiBQb3NpdGlvbj0iU2
 lnbmF0dXJlIj4NCiAgICAgIDxQZXJzb24gU3RhcnRJbmRleD0iMjA2
 IiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgICAgPFBlcnNvbl
 N0cmluZz5KZWZmIEpvaG5zb248L1BlcnNvblN0cmluZz4NCiAgICAg
 IDwvUGVyc29uPg0KICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYW
 lsIFN0YXJ0SW5kZXg9IjIyMCIgUG9zaXRpb249IlNpZ25hdHVyZSI+
 DQogICAgICAgICAgPEVtYWlsU3RyaW5nPnF1aWNfampvaG5zb25AcX
 VpY2luYy5jb208L0VtYWlsU3RyaW5nPg0KICAgICAgICA8L0VtYWls
 Pg0KICAgICAgPC9FbWFpbHM+DQogICAgICA8Q29udGFjdFN0cmluZz
 5KZWZmIEpvaG5zb24gJmx0O3F1aWNfampvaG5zb25AcXVpY2luYy5j
 b208L0NvbnRhY3RTdHJpbmc+DQogICAgPC9Db250YWN0Pg0KICA8L0
 NvbnRhY3RzPg0KPC9Db250YWN0U2V0PgEOzwFSZXRyaWV2ZXJPcGVy
 YXRvciwxMCwwO1JldHJpZXZlck9wZXJhdG9yLDExLDA7UG9zdERvY1
 BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdERvY1BhcnNlck9wZXJhdG9y
 LDExLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLD
 EwLDA7UG9zdFdvcmRCcmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEx
 LDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVjZXIsMjAsMTA=3D
X-MS-Exchange-Forest-IndexAgent: 1 1733
X-MS-Exchange-Forest-EmailMessageHash: 25116FE1
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

kernel-doc flagged the following issue, so fix it:

drivers/net/wireless/ath/ath11k/hal.h:668: warning: missing initial short d=
escription on line:
 * enum hal_rx_buf_return_buf_manager

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/a=
th/ath11k/hal.h
index 65e8f244ebb9..e453c137385e 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -664,7 +664,7 @@ struct hal_srng_config {
 };
=20
 /**
- * enum hal_rx_buf_return_buf_manager
+ * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer l=
ist
  * @HAL_RX_BUF_RBM_WBM_IDLE_DESC_LIST: Descriptor returned to WBM idle

--=20
2.42.0



