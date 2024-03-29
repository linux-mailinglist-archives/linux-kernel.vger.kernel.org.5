Return-Path: <linux-kernel+bounces-126149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9708932D7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804CC283751
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C931487F9;
	Sun, 31 Mar 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j+mW4tSn"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1D9146004;
	Sun, 31 Mar 2024 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902385; cv=fail; b=Umh74UVbbMvLBc0ONUMDFKm84NMwK0Y1/Tgvr0iaSNCbDZNmgBEfgqUnruvgg8+dHhxVjkCyUGaKn3uS0A49unMKWzVlSCKrAd531N6ObEMzZAA5aEW5PbdrzVvZVYoZDx0SpeM492AEpgIWWpTD6HwWDzu/Bev1TaeKh/DzqU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902385; c=relaxed/simple;
	bh=KTXE+hxvRcGvx2T7TIi2o0oFUorzYjPoFu/No8hkrfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DzmnZPGrEatW3pIQi+jDqeYPJgbHhoBu3YVUuvkSRDf90BYgeqxCGlzpFn6QmAFbJtLAqxWhn3p10SFwCWI8ve+so/Frj/WisJgfMZ2HwqDBJNrJ60eIPncHZcAjL7VyPLZQkYZ+6sJS5gITNlco7nLkQIp2+xT4CI5u89msvS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+mW4tSn reason="signature verification failed"; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F3CA820847;
	Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljOQUmaCANTk; Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id F401A20851;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com F401A20851
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id E7F9780004A;
	Sun, 31 Mar 2024 18:26:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:36 +0000
X-sender: <linux-wireless+bounces-5631-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB5AAAAjYoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13233
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5631-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BAB3C208A6
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711755058; cv=none; b=pxoK3GCHRJFFbaOzOV9fp85bZfH+gNqrlWhQILJTAKUocFhT5FOf5fABGA1IgvUKWeHBH41NjuthFJRb1zDR0RfXwm67VfSw9MKO130RfwBsgUJpz+2MNNNqUNmkR2sA8KSBMbDlrGdiI0a8l8Qfp/453StBeNwigUTy38rj76g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711755058; c=relaxed/simple;
	bh=wNEr96hbZAhFfCued7lRV8Yr//BFDNMs0NMQUkiAb9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a569xJwHjGjwUOUGNe0rKikWvSjQHL9uVMbljY/4aDxxq7OsOKjuD66fkyUvM/b52ce6W2+SU6rwuOrxrC9bLPP0d1jGFqeUxJfm+vCWMzHM7OcSuZ0civNgs6LTw8AZrr/CaTClIaiDvQfPcQgW6NpsxqoyHemMyTQJZINNNRg=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+mW4tSn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=btMEj1aDrdTcd3Zv9FcYOvSp4BckjwM0F4bigfeZiFI
	=; b=j+mW4tSnzVHkAi1Uz4sNohN0wtKGNQ4a5xKduE11uw5rcseapnVrts4bi7K
	F9xZOjPr8+dioSOT8uV3I7ZefkuHwT2hWQKvYWVUDYMmAL+IIxTThaN9MgoYc9JT
	HrA3zaQ+a/rOEi+3o1rUlH2LQiAYv9xg0d8uGeYEWd3q75HfeSedVTL6nRkQGorj
	6Cy9eoMFD5sFV5gdIaSGKe6t0qr9s/viTqdY2OV7450e6tuKQyDB4MtHWcLYlu3I
	vGqMjXdYvX7cg3qpShxYLOhUq7ie18Bb1zSa5cxHfHn/PePPv99DmYl7lgYtSiF8
	3ttnUndd050GYqh1FmmXMMhlr+Q==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 16:30:51 -0700
Subject: [PATCH 2/2] wifi: ath12k: fix hal_rx_buf_return_buf_manager
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
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-2-e62ec9dc2af9@quicinc.com>
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
X-Proofpoint-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-ORIG-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=681 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290209
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

kernel-doc flagged the following issue, so fix it:

drivers/net/wireless/ath/ath12k/hal.h:771: warning: missing initial short d=
escription on line:
 * enum hal_rx_buf_return_buf_manager

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/a=
th/ath12k/hal.h
index 107927d64bbb..dbb9205bfa10 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -767,7 +767,7 @@ struct hal_srng_config {
 };
=20
 /**
- * enum hal_rx_buf_return_buf_manager
+ * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer l=
ist
  * @HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST: Descriptor returned to WBM id=
le

--=20
2.42.0


X-sender: <linux-kernel+bounces-125528-steffen.klassert=3Dsecunet.com@vger.=
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
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Tp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgB8AAAAjYoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13324
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 00:31:33 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 00:31:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id CEA562032C
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:31:33 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8-h2vhykujDj for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 00:31:33 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dlinux-kern=
el+bounces-125528-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 274FD200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"j+mW4tSn"
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 274FD200BB
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 00:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E328E1C21261
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421513EFF6;
	Fri, 29 Mar 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"j+mW4tSn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA74241E7;
	Fri, 29 Mar 2024 23:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711755058; cv=3Dnone; b=3DpxoK3GCHRJFFbaOzOV9fp85bZfH+gNqrlWhQILJTAKU=
ocFhT5FOf5fABGA1IgvUKWeHBH41NjuthFJRb1zDR0RfXwm67VfSw9MKO130RfwBsgUJpz+2MNN=
NqUNmkR2sA8KSBMbDlrGdiI0a8l8Qfp/453StBeNwigUTy38rj76g=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711755058; c=3Drelaxed/simple;
	bh=3DwNEr96hbZAhFfCued7lRV8Yr//BFDNMs0NMQUkiAb9E=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3Da569xJwHjGjwUOUGNe0rKikWvSjQHL9uVMbljY/4aDxxq7OsOK=
juD66fkyUvM/b52ce6W2+SU6rwuOrxrC9bLPP0d1jGFqeUxJfm+vCWMzHM7OcSuZ0civNgs6LTw=
8AZrr/CaTClIaiDvQfPcQgW6NpsxqoyHemMyTQJZINNNRg=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3Dj+mW4tSn; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TLxODS=
019270;
	Fri, 29 Mar 2024 23:30:52 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3DbtMEj1aDrdTcd3Zv9FcYOvSp4BckjwM0F4bigfeZiFI
	=3D; b=3Dj+mW4tSnzVHkAi1Uz4sNohN0wtKGNQ4a5xKduE11uw5rcseapnVrts4bi7K
	F9xZOjPr8+dioSOT8uV3I7ZefkuHwT2hWQKvYWVUDYMmAL+IIxTThaN9MgoYc9JT
	HrA3zaQ+a/rOEi+3o1rUlH2LQiAYv9xg0d8uGeYEWd3q75HfeSedVTL6nRkQGorj
	6Cy9eoMFD5sFV5gdIaSGKe6t0qr9s/viTqdY2OV7450e6tuKQyDB4MtHWcLYlu3I
	vGqMjXdYvX7cg3qpShxYLOhUq7ie18Bb1zSa5cxHfHn/PePPv99DmYl7lgYtSiF8
	3ttnUndd050GYqh1FmmXMMhlr+Q=3D=3D
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5uccstm3-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 23:30:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TNUpNQ01=
0878
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 23:30:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 16:30:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 16:30:51 -0700
Subject: [PATCH 2/2] wifi: ath12k: fix hal_rx_buf_return_buf_manager
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-hal_rx_buf_return_buf_manager-v1-2-e62ec9dc2af9@quici=
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
X-Proofpoint-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-ORIG-GUID: 1TRfxswzYYGmIIvFz4OQbnVPNd35DZRQ
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 malwarescore=3D0
 mlxlogscore=3D681 impostorscore=3D0 spamscore=3D0 priorityscore=3D1501
 lowpriorityscore=3D0 phishscore=3D0 adultscore=3D0 mlxscore=3D0 bulkscore=
=3D0
 suspectscore=3D0 clxscore=3D1015 classifier=3Dspam adjust=3D0 reason=3Dmlx
 scancount=3D1 engine=3D8.19.0-2403210001 definitions=3Dmain-2403290209
Return-Path: linux-kernel+bounces-125528-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 23:31:33.8748
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: ee1bd3b9-e40d-43f5-9e0b-08dc=
50485ed6
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.406|SMR=3D0.335(SMRDE=3D0.034|SMRC=3D0.30=
0(SMRCL=3D0.103|X-SMRCR=3D0.300))|CAT=3D0.069(CATOS=3D0.011
 (CATSM=3D0.010(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.038(CATRESLP2R=3D0.017)|CATORES=3D0.019
 (CATRS=3D0.019(CATRS-Index Routing Agent=3D0.018)));2024-03-29T23:31:34.29=
1Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9307
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.011|SMR=3D0.005(SMRPI=3D0.002(SMRPI-FrontendProxyAgent=3D0.002))=
|SMS=3D0.006
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAbgCAAAPAAADH4sIAAAAAAAEAI1SWW/T=
QBAeH4kTJ24feE
 IIad6gTZ1LoVEDQqEHaqsioRYEb5aPtbOts4a1Q4OA/8JPZdbuIaRE
 irQ7OzP7zTfH7l/rhknBUjfKQoxTP0lYhMWMYZylaXbLRYI8zxdsD/
 MMY75EXkwc27EjyX8wmfcEK3q3XLKU5XnPL2ZqD4Y3vZmfdmeT8Xgw
 wVtfCuKZ4JyYSkLBC+6nmM8yWWDE8lDybwXPBNJKuWCUAXeRicUcic
 eTSy9YxJ5kxUKKUp37wk+YVIVc8USwyM3i2A1+TvCcxTGeZzORE9eb
 7wseetfXlTlVFhdhN8zmbx3bdV1Ks1Ef+BuH2FHwAc0gZRjOfEGD2i
 Obi5xJVfzLzo6yI6IoTXennBOnelw34QX6vc2SBZvhHJuLiC1x0B8f
 DMfR/igIgm43CoKDYf9VEPuDPl3190ejstVNszt2p9PZvITpFN3x/n
 hvjJ3qIEdeyEVYlC+XS5F4YSZinuAvGt+f12om2NvdpaI2fOLORjh0
 8V6LM4kVgL6yXCKhYmqF8uJuKXB6+u7Cu/zqHX5+710efvC+0D47vj
 gpHRdnV58meFgGPfIUGRIKeUSvXxHST82L9XxHp2cf+xXr8cnV0R3t
 8d1nz1ZTq+mobznsjobdvrIcG6CugQ2WAaYFDZJNsGtg6WCQroNVOR
 vQJFkvYZqmGwAG1Cxo0i2tGtRb0KYQE2wTaoYGz1Ws8RBiQYuyOKWu
 g2mWsaYGT6HWKEkMaK9KRBDQNEtJ0FWU1qz0prZVKQ3YNisw6CsYQF
 /jN6jmNmy1NadOE4D2Gpi12q/VTaCjVpanP+pQUwANtsse6/BszTSc
 NX77IRf5LXhCGLzHVEsFKlmnkApm3OWyTGgR/sX/eGqTbstVt6H1GK
 K1q+J1oBkZSv8Hk2zayqwFAAABCvUBPD94bWwgdmVyc2lvbj0iMS4w
 IiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZX
 JzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAg
 IDxFbWFpbCBTdGFydEluZGV4PSIyMjAiIFBvc2l0aW9uPSJTaWduYX
 R1cmUiPg0KICAgICAgPEVtYWlsU3RyaW5nPnF1aWNfampvaG5zb25A
 cXVpY2luYy5jb208L0VtYWlsU3RyaW5nPg0KICAgIDwvRW1haWw+DQ
 ogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BDLoEPD94bWwgdmVyc2lv
 bj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD
 4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250
 YWN0cz4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSIyMDYiIFBvc2
 l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgPFBlcnNvbiBTdGFydElu
 ZGV4PSIyMDYiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgIC
 A8UGVyc29uU3RyaW5nPkplZmYgSm9obnNvbjwvUGVyc29uU3RyaW5n
 Pg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW1haWxzPg0KICAgIC
 AgICA8RW1haWwgU3RhcnRJbmRleD0iMjIwIiBQb3NpdGlvbj0iU2ln
 bmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+cXVpY19qam
 9obnNvbkBxdWljaW5jLmNvbTwvRW1haWxTdHJpbmc+DQogICAgICAg
 IDwvRW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YW
 N0U3RyaW5nPkplZmYgSm9obnNvbiAmbHQ7cXVpY19qam9obnNvbkBx
 dWljaW5jLmNvbTwvQ29udGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3
 Q+DQogIDwvQ29udGFjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJp
 ZXZlck9wZXJhdG9yLDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMD
 tQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2Vy
 T3BlcmF0b3IsMTEsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3
 BlcmF0b3IsMTAsMDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3Bl
 cmF0b3IsMTEsMDtUcmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwxMQ =3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1741
X-MS-Exchange-Forest-EmailMessageHash: AD780892
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

kernel-doc flagged the following issue, so fix it:

drivers/net/wireless/ath/ath12k/hal.h:771: warning: missing initial short d=
escription on line:
 * enum hal_rx_buf_return_buf_manager

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/a=
th/ath12k/hal.h
index 107927d64bbb..dbb9205bfa10 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -767,7 +767,7 @@ struct hal_srng_config {
 };
=20
 /**
- * enum hal_rx_buf_return_buf_manager
+ * enum hal_rx_buf_return_buf_manager - manager for returned rx buffers
  *
  * @HAL_RX_BUF_RBM_WBM_IDLE_BUF_LIST: Buffer returned to WBM idle buffer l=
ist
  * @HAL_RX_BUF_RBM_WBM_CHIP0_IDLE_DESC_LIST: Descriptor returned to WBM id=
le

--=20
2.42.0



