Return-Path: <linux-kernel+bounces-126219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC008933E3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F361F257E5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC10156968;
	Sun, 31 Mar 2024 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SQcC6e1U"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648E154C08;
	Sun, 31 Mar 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903210; cv=fail; b=Axt8s4f7nxuC73NVDZGGfYQi/wjRrgvmpstrG1yVEhQ0o0DyxtsuVSUYFQ7Ym9ZJijgUHtgT+RsotodQUsLgedxFoM5GaynC83OKTQhSxXPqi8k78cEZDIIB+t7YRuMwoo66jesxIlghktsxqxFkJhteka48gtZrrfAWg5H2T7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903210; c=relaxed/simple;
	bh=e/D929xDxbG1rSjCAzKBqFSR/M5/P8r1wbxsbWjnGOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tkkgKPWr6lyTLw56zHbxi/iwFUHy3EqoRKOG7hEA8H4pzmZNz+1mGSyDjxxM2ENR7FRXOaKEhKaBkQ/7QQ6DuRQ/eUdadeUDY6fHrtkYCPCUZkRcJhobXEpOgyMnXOScKiGWRe48hSvNE6vEeI5uJGQ7FJfvJd1lxMaJhqFMc1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SQcC6e1U reason="signature verification failed"; arc=none smtp.client-ip=205.220.168.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 257B7207C6;
	Sun, 31 Mar 2024 18:40:04 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bimDyib83o3; Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AB50820896;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com AB50820896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5F437800050;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:00 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:15 +0000
X-sender: <netdev+bounces-83457-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBdAAAAy4oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14339
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83457-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 153592087B
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744054; cv=none; b=qpWUhTghtpxAkXbbsMYRpxBq/yFfZys+67c8HI2Hb7K9VWCuTtnEA5gsW+TP2qycXEPW42vwi3Q22OQlgnWt8tI2bxdhT1zcVFCurtZoQo1Dekfz+m2NlpP67Onkr2Y6HdgpQKjI18wD9nNkImPTZw02wUq34lmAxbb9/At2bME=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744054; c=relaxed/simple;
	bh=gbGnL0gewmXLZlGj5Y4rOs83fi3Ir5o3AQbVnBS4Upo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pr1PZydC+d9O8PbnD2rgRIeG6nAuZFpfnzbuu+BS+g8Znu+fC+phB6s0omClBmL3ixUlrqkZLLVx0HqIlITXP9PivKtsHf6VJk0VWyG37pCickh0OBDFW7z3AbNSt+Znp+ggr0yr9OGHNmtNH5ub8yiy0OnZyMwZN/DFdSNXWOQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SQcC6e1U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=c1TSAXudN1gCLr4FCS1phZaaFIRMRxVAsvGPnn14IrA
	=; b=SQcC6e1UAWC7yj89VEyEUiVcKXt6/dbMvyFDW9q8hN7lEJtLhpnMI8xpbBM
	LFRSW364+bvcuWU0ee+RPA9rZQM3yMQfvzeN1CNnrmL5rb2UtMPcmaF6YDFhN5nD
	zJaTn4guqrGAXqwAFitMKWzF2SlX/BJMzC2eD8nJKeoaACAjm2a/ovy90NQsm/JM
	b9eYAt4HId7meSF4eguzzB0BinIaaFR4rvkD9xppyaNNyQ/lJ2SsONj7dngep8pY
	PkTyMBKVJ7hawJuXMzQ/DY5c9E+C/OKWlSbJyLx5EA43UEm1JemxQtXxEeBMvXoW
	N70Pka2klGMVEem4I+uRm+gqV0w==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:17 -0700
Subject: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-ID: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-ORIG-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=653 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290183
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

While fixing kernel-doc issues it was discovered that the
ieee80211_set_hw_80211_encap() prototype doesn't actually have an
implementation, so remove it.

Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
rework tx encapsulation offload API").

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..e6a11a982ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *h=
w,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
-/**
- * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading=
.
- *
- * This function is used to notify mac80211 that a vif can be passed raw 8=
02.3
- * frames. The driver needs to then handle the 802.11 encapsulation inside=
 the
- * hardware or firmware.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @enable: indicate if the feature should be turned on or off
- */
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
-
 /**
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().

--=20
2.42.0


X-sender: <linux-wireless+bounces-5622-peter.schumann=3Dsecunet.com@vger.ke=
rnel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=3Drfc822;peter.schumann@secu=
net.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQAVABYAAgAAAAUAFAARAJ05ab4WgQhHs=
qdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEu=
SXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAI=
AAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIC=
hGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAF=
wC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRt=
aW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3J=
vdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbm=
ZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMA=
AAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQu=
TWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGw=
AAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2Vycy=
xPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3Bvb=
nNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5F=
eGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXh=
wYW5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAdEWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3Vu=
ZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAA=
AAAUABQACAAEFAGIACgBeAAAAy4oAAAUAZAAPAAMAAABIdWI=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14418
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:27:45 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:27:45 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DBF1020883
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:27:45 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZmzWrxnDFL2x for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 21:27:43 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-wirel=
ess+bounces-5622-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dp=
eter.schumann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5FC282087C
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 5FC282087C
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA0F1F231FA
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E0113BC1A;
	Fri, 29 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"SQcC6e1U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212C1DFD1;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744054; cv=3Dnone; b=3DqpWUhTghtpxAkXbbsMYRpxBq/yFfZys+67c8HI2Hb7K=
9VWCuTtnEA5gsW+TP2qycXEPW42vwi3Q22OQlgnWt8tI2bxdhT1zcVFCurtZoQo1Dekfz+m2Nlp=
P67Onkr2Y6HdgpQKjI18wD9nNkImPTZw02wUq34lmAxbb9/At2bME=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744054; c=3Drelaxed/simple;
	bh=3DgbGnL0gewmXLZlGj5Y4rOs83fi3Ir5o3AQbVnBS4Upo=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3Dpr1PZydC+d9O8PbnD2rgRIeG6nAuZFpfnzbuu+BS+g8Znu+fC+=
phB6s0omClBmL3ixUlrqkZLLVx0HqIlITXP9PivKtsHf6VJk0VWyG37pCickh0OBDFW7z3AbNSt=
+Znp+ggr0yr9OGHNmtNH5ub8yiy0OnZyMwZN/DFdSNXWOQ=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DSQcC6e1U; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THerM2=
001554;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3Dc1TSAXudN1gCLr4FCS1phZaaFIRMRxVAsvGPnn14IrA
	=3D; b=3DSQcC6e1UAWC7yj89VEyEUiVcKXt6/dbMvyFDW9q8hN7lEJtLhpnMI8xpbBM
	LFRSW364+bvcuWU0ee+RPA9rZQM3yMQfvzeN1CNnrmL5rb2UtMPcmaF6YDFhN5nD
	zJaTn4guqrGAXqwAFitMKWzF2SlX/BJMzC2eD8nJKeoaACAjm2a/ovy90NQsm/JM
	b9eYAt4HId7meSF4eguzzB0BinIaaFR4rvkD9xppyaNNyQ/lJ2SsONj7dngep8pY
	PkTyMBKVJ7hawJuXMzQ/DY5c9E+C/OKWlSbJyLx5EA43UEm1JemxQtXxEeBMvXoW
	N70Pka2klGMVEem4I+uRm+gqV0w=3D=3D
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89heht-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJpW02=
7230
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:17 -0700
Subject: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-ORIG-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 mlxscore=3D0
 mlxlogscore=3D653 bulkscore=3D0 malwarescore=3D0 priorityscore=3D1501
 lowpriorityscore=3D0 phishscore=3D0 adultscore=3D0 suspectscore=3D0
 impostorscore=3D0 spamscore=3D0 classifier=3Dspam adjust=3D0 reason=3Dmlx
 scancount=3D1 engine=3D8.19.0-2403210001 definitions=3Dmain-2403290183
Return-Path: linux-wireless+bounces-5622-peter.schumann=3Dsecunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:27:45.9206
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 80b2ea33-6d77-46f6-8111-08dc=
502eb1aa
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.198|SMR=3D0.138(SMRDE=3D0.005|SMRC=3D0.132(=
SMRCL=3D0.102|X-SMRCR=3D0.132))|CAT=3D0.059(CATOS=3D0.001
 |CATRESL=3D0.011(CATRESLP2R=3D0.002)|CATORES=3D0.043(CATRS=3D0.042(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.040))|CATORT=3D0.001(CATRT=3D0.001));2024-03-29T20:27:46.136Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9884
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.017|SMR=3D0.010(SMRPI=3D0.007(SMRPI-FrontendProxyAgent=3D0.007))=
|SMS=3D0.007
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAT0EAAAPAAADH4sIAAAAAAAEAI1UbW/b=
NhCmLPlNsdK0wD
 YM2Idbh22JEymx47quNwzelw0thmFAC+yjQVNUxEYmPYmKY2A/bj9t
 R3JxYuSl0weCd7p77rk3/rP3Zy4KDpm4FvICLnkpeRGnioGoqppXID
 SsaQWpqJi64iVPQedU48GjUHDOJ2fDwWBecT3P13MncMno6vAIVqXS
 Sm9WHFLFK/m9Bsp0TYtiAzm94kAlQixXBV9yqakWSp5ApaDkS4yEgZ
 MojMLfleYmGuxaWlLlkqNlCkLCimqWw5hyOhwz/oqOGBy+XFJmGU2j
 sORrVV6CvgbLrqoLB6OyrFA0hZ//ePvyyAZ8Ly4kT2P8ES82U3jHsw
 zeqVxWaP3jX7Vg848fnTgzkpAsYWr5UxTGcRyFyIUVdcpPJdenN/GT
 HP6GwRDiOx+aDrDqWHqWU3nB0xNjkfKCG17VYXxkyKQCo8fxBXaBnj
 4CvXjkBxZXpvwazl+djyYTungzosMk4WM6GNA3kyGjExicnY1HI0v9
 UfwoPD4+fiLIbAbx69HryclgAsf2MgbU1edDuJ0PRgs2L6/nVJRaLP
 lhpcua6TsG+Rr6+foEq/KAo/5fjk9+9/wQU8hMQd+cn3QXUkPB5dEP
 WKvTfh9P6MNT4w8xDhpdYHtzWqZrWvKHBw+XLrFoDvJDLirIasmsDd
 7rymycAqm0yDZwU3i3hBSuRAaMSlhw3IDK2JZ0DWiSnDvArKRLXiUI
 jFtYCtxgkJynlcHErZJIT6aF2zDjhtC7PIWsRMrdvhvAbTqqxPEtl+
 Z+N4MZUprCd/fqbZiuFNYRGWSlWtqINE3nVpVRhouAT8OCssvkPyRX
 wClSSAWj+AwghPHKONU1MqhyVRepyR1F3FkwZS1NZS3AKZ4LpYon+3
 R/oAzRPh4nYJ0dCdt4HBLbe9jp/QVi4h5X85sncjPX+FThAPzKNfzy
 9rf328dzA5rjL0wlcSizfD3dVkUtNBUmDVue2wBYFcWQ9qF7n8zTMU
 xGw+TMSFFISJO0WqTd8khI2j4J8N4gPl5CsheQpk+aXY98RULUNDy/
 ae2bpNMlYZt0OqSLNg0S7JMD9LK+beuFmmd4og3q0aVHnnXIngOPyD
 7qfRJi0MgGRQT0aiOaR74kTYS1Bj17Bih6HtqQhvfCI8QjDWPsdY2G
 +F1yEFgQ1N/ao+2O6Djs97yoRUiL9Hb/tndEr2XS9Fo2ou/uNq7Jq2
 sYhjZrH10wI9T0SNgwWbQ+ZfCNE58b0Q9IKyDfootPnj9YZDRGPliu
 kHwe2LJYr6YrtSs+MrcIgVP6XmDdsdQd102Ecl7ur02/jZhGJF2H2S
 Gf+XYMuqYjoWuc66NvNAG2u0MOWrbjbjxcajdN962yFzw8LXeRzURZ
 Ml+g5mtrabxMxdrbe8eMU7AdMLR8QUKTiBeZRngN1xpz/xdywcUCgw
 gAAAEK9QE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYt
 MTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1
 ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5k
 ZXg9IjMwMSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW
 1haWxTdHJpbmc+cXVpY19qam9obnNvbkBxdWljaW5jLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0
 VtYWlsU2V0PgEMugQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5n
 PSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250
 YWN0IFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRpb249IlNpZ25hdHVyZS
 I+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRp
 b249IlNpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+Sm
 VmZiBKb2huc29uPC9QZXJzb25TdHJpbmc+DQogICAgICA8L1BlcnNv
 bj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFpbCBTdGFydE
 luZGV4PSIzMDEiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAg
 ICAgIDxFbWFpbFN0cmluZz5xdWljX2pqb2huc29uQHF1aWNpbmMuY2
 9tPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAg
 IDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+SmVmZiBKb2
 huc29uICZsdDtxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPC9Db250
 YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCiAgPC9Db250YWN0cz
 4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAs
 MTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwyO1Bvc3REb2NQYXJzZXJPcG
 VyYXRvciwxMCwyO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bv
 c3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwzO1Bvc3
 RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5z
 cG9ydFdyaXRlclByb2R1Y2VyLDIwLDE4
X-MS-Exchange-Forest-IndexAgent: 1 2130
X-MS-Exchange-Forest-EmailMessageHash: 1C129DF9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

While fixing kernel-doc issues it was discovered that the
ieee80211_set_hw_80211_encap() prototype doesn't actually have an
implementation, so remove it.

Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
rework tx encapsulation offload API").

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..e6a11a982ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *h=
w,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
-/**
- * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading=
.
- *
- * This function is used to notify mac80211 that a vif can be passed raw 8=
02.3
- * frames. The driver needs to then handle the 802.11 encapsulation inside=
 the
- * hardware or firmware.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @enable: indicate if the feature should be turned on or off
- */
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
-
 /**
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().

--=20
2.42.0


X-sender: <netdev+bounces-83457-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
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
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGAAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14309
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:27:49 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:27:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 895AB208B4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:27:49 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.051
X-Spam-Level:
X-Spam-Status: No, score=3D-5.051 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cL_bk7ZS7AuS for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:27:46 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83457-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BC44A2087B
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BC44A2087B
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E7A285D8B
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003213BC2C;
	Fri, 29 Mar 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"SQcC6e1U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212C1DFD1;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744054; cv=3Dnone; b=3DqpWUhTghtpxAkXbbsMYRpxBq/yFfZys+67c8HI2Hb7K=
9VWCuTtnEA5gsW+TP2qycXEPW42vwi3Q22OQlgnWt8tI2bxdhT1zcVFCurtZoQo1Dekfz+m2Nlp=
P67Onkr2Y6HdgpQKjI18wD9nNkImPTZw02wUq34lmAxbb9/At2bME=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744054; c=3Drelaxed/simple;
	bh=3DgbGnL0gewmXLZlGj5Y4rOs83fi3Ir5o3AQbVnBS4Upo=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3Dpr1PZydC+d9O8PbnD2rgRIeG6nAuZFpfnzbuu+BS+g8Znu+fC+=
phB6s0omClBmL3ixUlrqkZLLVx0HqIlITXP9PivKtsHf6VJk0VWyG37pCickh0OBDFW7z3AbNSt=
+Znp+ggr0yr9OGHNmtNH5ub8yiy0OnZyMwZN/DFdSNXWOQ=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DSQcC6e1U; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THerM2=
001554;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3Dc1TSAXudN1gCLr4FCS1phZaaFIRMRxVAsvGPnn14IrA
	=3D; b=3DSQcC6e1UAWC7yj89VEyEUiVcKXt6/dbMvyFDW9q8hN7lEJtLhpnMI8xpbBM
	LFRSW364+bvcuWU0ee+RPA9rZQM3yMQfvzeN1CNnrmL5rb2UtMPcmaF6YDFhN5nD
	zJaTn4guqrGAXqwAFitMKWzF2SlX/BJMzC2eD8nJKeoaACAjm2a/ovy90NQsm/JM
	b9eYAt4HId7meSF4eguzzB0BinIaaFR4rvkD9xppyaNNyQ/lJ2SsONj7dngep8pY
	PkTyMBKVJ7hawJuXMzQ/DY5c9E+C/OKWlSbJyLx5EA43UEm1JemxQtXxEeBMvXoW
	N70Pka2klGMVEem4I+uRm+gqV0w=3D=3D
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89heht-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJpW02=
7230
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:17 -0700
Subject: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-ORIG-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 mlxscore=3D0
 mlxlogscore=3D653 bulkscore=3D0 malwarescore=3D0 priorityscore=3D1501
 lowpriorityscore=3D0 phishscore=3D0 adultscore=3D0 suspectscore=3D0
 impostorscore=3D0 spamscore=3D0 classifier=3Dspam adjust=3D0 reason=3Dmlx
 scancount=3D1 engine=3D8.19.0-2403210001 definitions=3Dmain-2403290183
Return-Path: netdev+bounces-83457-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:27:49.5783
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: ca703e3d-97e1-472b-a023-08dc=
502eb3d8
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.205|SMR=3D0.141(SMRDE=3D0.005|SMRC=3D0.135(=
SMRCL=3D0.103|X-SMRCR=3D0.134))|CAT=3D0.063(CATRESL=3D0.021
 (CATRESLP2R=3D0.017)|CATORES=3D0.037(CATRS=3D0.037(CATRS-Index Routing
 Agent=3D0.035))|CATORT=3D0.001 (CATRT=3D0.001));2024-03-29T20:27:49.796Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9835
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.012|SMR=3D0.007(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.004
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAT0EAAAPAAADH4sIAAAAAAAEAI1UbW/b=
NhCmLPlNsdK0wD
 YM2Idbh22JEymx47quNwzelw0thmFAC+yjQVNUxEYmPYmKY2A/bj9t
 R3JxYuSl0weCd7p77rk3/rP3Zy4KDpm4FvICLnkpeRGnioGoqppXID
 SsaQWpqJi64iVPQedU48GjUHDOJ2fDwWBecT3P13MncMno6vAIVqXS
 Sm9WHFLFK/m9Bsp0TYtiAzm94kAlQixXBV9yqakWSp5ApaDkS4yEgZ
 MojMLfleYmGuxaWlLlkqNlCkLCimqWw5hyOhwz/oqOGBy+XFJmGU2j
 sORrVV6CvgbLrqoLB6OyrFA0hZ//ePvyyAZ8Ly4kT2P8ES82U3jHsw
 zeqVxWaP3jX7Vg848fnTgzkpAsYWr5UxTGcRyFyIUVdcpPJdenN/GT
 HP6GwRDiOx+aDrDqWHqWU3nB0xNjkfKCG17VYXxkyKQCo8fxBXaBnj
 4CvXjkBxZXpvwazl+djyYTungzosMk4WM6GNA3kyGjExicnY1HI0v9
 UfwoPD4+fiLIbAbx69HryclgAsf2MgbU1edDuJ0PRgs2L6/nVJRaLP
 lhpcua6TsG+Rr6+foEq/KAo/5fjk9+9/wQU8hMQd+cn3QXUkPB5dEP
 WKvTfh9P6MNT4w8xDhpdYHtzWqZrWvKHBw+XLrFoDvJDLirIasmsDd
 7rymycAqm0yDZwU3i3hBSuRAaMSlhw3IDK2JZ0DWiSnDvArKRLXiUI
 jFtYCtxgkJynlcHErZJIT6aF2zDjhtC7PIWsRMrdvhvAbTqqxPEtl+
 Z+N4MZUprCd/fqbZiuFNYRGWSlWtqINE3nVpVRhouAT8OCssvkPyRX
 wClSSAWj+AwghPHKONU1MqhyVRepyR1F3FkwZS1NZS3AKZ4LpYon+3
 R/oAzRPh4nYJ0dCdt4HBLbe9jp/QVi4h5X85sncjPX+FThAPzKNfzy
 9rf328dzA5rjL0wlcSizfD3dVkUtNBUmDVue2wBYFcWQ9qF7n8zTMU
 xGw+TMSFFISJO0WqTd8khI2j4J8N4gPl5CsheQpk+aXY98RULUNDy/
 ae2bpNMlYZt0OqSLNg0S7JMD9LK+beuFmmd4og3q0aVHnnXIngOPyD
 7qfRJi0MgGRQT0aiOaR74kTYS1Bj17Bih6HtqQhvfCI8QjDWPsdY2G
 +F1yEFgQ1N/ao+2O6Djs97yoRUiL9Hb/tndEr2XS9Fo2ou/uNq7Jq2
 sYhjZrH10wI9T0SNgwWbQ+ZfCNE58b0Q9IKyDfootPnj9YZDRGPliu
 kHwe2LJYr6YrtSs+MrcIgVP6XmDdsdQd102Ecl7ur02/jZhGJF2H2S
 Gf+XYMuqYjoWuc66NvNAG2u0MOWrbjbjxcajdN962yFzw8LXeRzURZ
 Ml+g5mtrabxMxdrbe8eMU7AdMLR8QUKTiBeZRngN1xpz/xdywcUCgw
 gAAAEK9QE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYt
 MTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1
 ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5k
 ZXg9IjMwMSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW
 1haWxTdHJpbmc+cXVpY19qam9obnNvbkBxdWljaW5jLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0
 VtYWlsU2V0PgEMugQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5n
 PSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250
 YWN0IFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRpb249IlNpZ25hdHVyZS
 I+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRp
 b249IlNpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+Sm
 VmZiBKb2huc29uPC9QZXJzb25TdHJpbmc+DQogICAgICA8L1BlcnNv
 bj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFpbCBTdGFydE
 luZGV4PSIzMDEiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAg
 ICAgIDxFbWFpbFN0cmluZz5xdWljX2pqb2huc29uQHF1aWNpbmMuY2
 9tPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAg
 IDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+SmVmZiBKb2
 huc29uICZsdDtxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPC9Db250
 YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCiAgPC9Db250YWN0cz
 4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAs
 MTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwyO1Bvc3REb2NQYXJzZXJPcG
 VyYXRvciwxMCwxO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bv
 c3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwxO1Bvc3
 RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5z
 cG9ydFdyaXRlclByb2R1Y2VyLDIwLDE4
X-MS-Exchange-Forest-IndexAgent: 1 2130
X-MS-Exchange-Forest-EmailMessageHash: 1C129DF9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

While fixing kernel-doc issues it was discovered that the
ieee80211_set_hw_80211_encap() prototype doesn't actually have an
implementation, so remove it.

Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
rework tx encapsulation offload API").

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..e6a11a982ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *h=
w,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
-/**
- * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading=
.
- *
- * This function is used to notify mac80211 that a vif can be passed raw 8=
02.3
- * frames. The driver needs to then handle the 802.11 encapsulation inside=
 the
- * hardware or firmware.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @enable: indicate if the feature should be turned on or off
- */
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
-
 /**
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().

--=20
2.42.0


X-sender: <linux-kernel+bounces-125388-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAfUWmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGQAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 14341
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:11 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:11 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 92BF32087C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:11 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.751
X-Spam-Level:
X-Spam-Status: No, score=3D-2.751 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIM_SIGNED=3D0.1, DKIM_VALID=3D-0.1,
	DKIM_VALID_AU=3D-0.1, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mT4pj3LWQDgt for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:28:11 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dlinux-kern=
el+bounces-125388-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E46452087B
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E46452087B
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3EC1C214E9
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F0E13CFAE;
	Fri, 29 Mar 2024 20:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"SQcC6e1U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.=
220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1212C1DFD1;
	Fri, 29 Mar 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.168.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744054; cv=3Dnone; b=3DqpWUhTghtpxAkXbbsMYRpxBq/yFfZys+67c8HI2Hb7K=
9VWCuTtnEA5gsW+TP2qycXEPW42vwi3Q22OQlgnWt8tI2bxdhT1zcVFCurtZoQo1Dekfz+m2Nlp=
P67Onkr2Y6HdgpQKjI18wD9nNkImPTZw02wUq34lmAxbb9/At2bME=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744054; c=3Drelaxed/simple;
	bh=3DgbGnL0gewmXLZlGj5Y4rOs83fi3Ir5o3AQbVnBS4Upo=3D;
	h=3DFrom:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=3Dpr1PZydC+d9O8PbnD2rgRIeG6nAuZFpfnzbuu+BS+g8Znu+fC+=
phB6s0omClBmL3ixUlrqkZLLVx0HqIlITXP9PivKtsHf6VJk0VWyG37pCickh0OBDFW7z3AbNSt=
+Znp+ggr0yr9OGHNmtNH5ub8yiy0OnZyMwZN/DFdSNXWOQ=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DSQcC6e1U; arc=3Dnone smtp.client-ip=3D205.220.168.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42THerM2=
001554;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=3Dqcppdkim1; bh=3Dc1TSAXudN1gCLr4FCS1phZaaFIRMRxVAsvGPnn14IrA
	=3D; b=3DSQcC6e1UAWC7yj89VEyEUiVcKXt6/dbMvyFDW9q8hN7lEJtLhpnMI8xpbBM
	LFRSW364+bvcuWU0ee+RPA9rZQM3yMQfvzeN1CNnrmL5rb2UtMPcmaF6YDFhN5nD
	zJaTn4guqrGAXqwAFitMKWzF2SlX/BJMzC2eD8nJKeoaACAjm2a/ovy90NQsm/JM
	b9eYAt4HId7meSF4eguzzB0BinIaaFR4rvkD9xppyaNNyQ/lJ2SsONj7dngep8pY
	PkTyMBKVJ7hawJuXMzQ/DY5c9E+C/OKWlSbJyLx5EA43UEm1JemxQtXxEeBMvXoW
	N70Pka2klGMVEem4I+uRm+gqV0w=3D=3D
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89heht-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRJpW02=
7230
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Fri, 29 Mar 2024 13:27:17 -0700
Subject: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=3Dnai engine=3D6200 definitions=3D5800 s=
ignatures=3D585085
X-Proofpoint-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-ORIG-GUID: eC6dER2XUg40RjrSEUxFhyIgOuY9FXDX
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 clxscore=3D1015 mlxscore=3D0
 mlxlogscore=3D653 bulkscore=3D0 malwarescore=3D0 priorityscore=3D1501
 lowpriorityscore=3D0 phishscore=3D0 adultscore=3D0 suspectscore=3D0
 impostorscore=3D0 spamscore=3D0 classifier=3Dspam adjust=3D0 reason=3Dmlx
 scancount=3D1 engine=3D8.19.0-2403210001 definitions=3Dmain-2403290183
Return-Path: linux-kernel+bounces-125388-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:11.6178
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 0474a4ba-87e0-4c2c-9326-08dc=
502ec0fb
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.386|SMR=3D0.338(SMRDE=3D0.003|SMRC=3D0.335(=
SMRCL=3D0.102|X-SMRCR=3D0.334))|CAT=3D0.047(CATRESL=3D0.011
 (CATRESLP2R=3D0.002)|CATORES=3D0.033(CATRS=3D0.032(CATRS-Transport Rule
 Agent=3D0.001(X-ETREX=3D0.001 )|CATRS-Index Routing
 Agent=3D0.030)));2024-03-29T20:28:12.013Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9845
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.008|SMR=3D0.004(SMRPI=3D0.003(SMRPI-FrontendProxyAgent=3D0.003))=
|SMS=3D0.004
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAT0EAAAPAAADH4sIAAAAAAAEAI1UbW/b=
NhCmLPlNsdK0wD
 YM2Idbh22JEymx47quNwzelw0thmFAC+yjQVNUxEYmPYmKY2A/bj9t
 R3JxYuSl0weCd7p77rk3/rP3Zy4KDpm4FvICLnkpeRGnioGoqppXID
 SsaQWpqJi64iVPQedU48GjUHDOJ2fDwWBecT3P13MncMno6vAIVqXS
 Sm9WHFLFK/m9Bsp0TYtiAzm94kAlQixXBV9yqakWSp5ApaDkS4yEgZ
 MojMLfleYmGuxaWlLlkqNlCkLCimqWw5hyOhwz/oqOGBy+XFJmGU2j
 sORrVV6CvgbLrqoLB6OyrFA0hZ//ePvyyAZ8Ly4kT2P8ES82U3jHsw
 zeqVxWaP3jX7Vg848fnTgzkpAsYWr5UxTGcRyFyIUVdcpPJdenN/GT
 HP6GwRDiOx+aDrDqWHqWU3nB0xNjkfKCG17VYXxkyKQCo8fxBXaBnj
 4CvXjkBxZXpvwazl+djyYTungzosMk4WM6GNA3kyGjExicnY1HI0v9
 UfwoPD4+fiLIbAbx69HryclgAsf2MgbU1edDuJ0PRgs2L6/nVJRaLP
 lhpcua6TsG+Rr6+foEq/KAo/5fjk9+9/wQU8hMQd+cn3QXUkPB5dEP
 WKvTfh9P6MNT4w8xDhpdYHtzWqZrWvKHBw+XLrFoDvJDLirIasmsDd
 7rymycAqm0yDZwU3i3hBSuRAaMSlhw3IDK2JZ0DWiSnDvArKRLXiUI
 jFtYCtxgkJynlcHErZJIT6aF2zDjhtC7PIWsRMrdvhvAbTqqxPEtl+
 Z+N4MZUprCd/fqbZiuFNYRGWSlWtqINE3nVpVRhouAT8OCssvkPyRX
 wClSSAWj+AwghPHKONU1MqhyVRepyR1F3FkwZS1NZS3AKZ4LpYon+3
 R/oAzRPh4nYJ0dCdt4HBLbe9jp/QVi4h5X85sncjPX+FThAPzKNfzy
 9rf328dzA5rjL0wlcSizfD3dVkUtNBUmDVue2wBYFcWQ9qF7n8zTMU
 xGw+TMSFFISJO0WqTd8khI2j4J8N4gPl5CsheQpk+aXY98RULUNDy/
 ae2bpNMlYZt0OqSLNg0S7JMD9LK+beuFmmd4og3q0aVHnnXIngOPyD
 7qfRJi0MgGRQT0aiOaR74kTYS1Bj17Bih6HtqQhvfCI8QjDWPsdY2G
 +F1yEFgQ1N/ao+2O6Djs97yoRUiL9Hb/tndEr2XS9Fo2ou/uNq7Jq2
 sYhjZrH10wI9T0SNgwWbQ+ZfCNE58b0Q9IKyDfootPnj9YZDRGPliu
 kHwe2LJYr6YrtSs+MrcIgVP6XmDdsdQd102Ecl7ur02/jZhGJF2H2S
 Gf+XYMuqYjoWuc66NvNAG2u0MOWrbjbjxcajdN962yFzw8LXeRzURZ
 Ml+g5mtrabxMxdrbe8eMU7AdMLR8QUKTiBeZRngN1xpz/xdywcUCgw
 gAAAEK9QE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYt
 MTYiPz4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1
 ZlcnNpb24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5k
 ZXg9IjMwMSIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW
 1haWxTdHJpbmc+cXVpY19qam9obnNvbkBxdWljaW5jLmNvbTwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0
 VtYWlsU2V0PgEMugQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5n
 PSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250
 YWN0IFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRpb249IlNpZ25hdHVyZS
 I+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjI4NyIgUG9zaXRp
 b249IlNpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+Sm
 VmZiBKb2huc29uPC9QZXJzb25TdHJpbmc+DQogICAgICA8L1BlcnNv
 bj4NCiAgICAgIDxFbWFpbHM+DQogICAgICAgIDxFbWFpbCBTdGFydE
 luZGV4PSIzMDEiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAg
 ICAgIDxFbWFpbFN0cmluZz5xdWljX2pqb2huc29uQHF1aWNpbmMuY2
 9tPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9FbWFpbD4NCiAgICAg
 IDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdHJpbmc+SmVmZiBKb2
 huc29uICZsdDtxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPC9Db250
 YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD4NCiAgPC9Db250YWN0cz
 4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAs
 MTtSZXRyaWV2ZXJPcGVyYXRvciwxMSwyO1Bvc3REb2NQYXJzZXJPcG
 VyYXRvciwxMCwxO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bv
 c3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwxO1Bvc3
 RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5z
 cG9ydFdyaXRlclByb2R1Y2VyLDIwLDE1
X-MS-Exchange-Forest-IndexAgent: 1 2130
X-MS-Exchange-Forest-EmailMessageHash: 1C129DF9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

While fixing kernel-doc issues it was discovered that the
ieee80211_set_hw_80211_encap() prototype doesn't actually have an
implementation, so remove it.

Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
rework tx encapsulation offload API").

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/net/mac80211.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 353488ab94a2..e6a11a982ca8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *h=
w,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
-/**
- * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading=
.
- *
- * This function is used to notify mac80211 that a vif can be passed raw 8=
02.3
- * frames. The driver needs to then handle the 802.11 encapsulation inside=
 the
- * hardware or firmware.
- *
- * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @enable: indicate if the feature should be turned on or off
- */
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
-
 /**
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().

--=20
2.42.0



