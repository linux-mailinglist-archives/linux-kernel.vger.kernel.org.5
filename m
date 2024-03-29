Return-Path: <linux-kernel+bounces-126217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038878933D9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2372C1C2231C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D216156228;
	Sun, 31 Mar 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8gRcOX1"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB715382B;
	Sun, 31 Mar 2024 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903208; cv=fail; b=FQwSDqLWOiIA39vEngOeOHfb5eY6bqO6J4nQdj4CcSixCM7meRLvkggd2GuGWs9G2ogmDGgARXPKLQLjTLhKDrVoYkRUj+jqErtD6IE0Ce8b1BuhYEpaEyb7lWNnV7MQ4Yd/5uXdqDLRoinraHs20PglWKA1obX/qPhccXPSF1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903208; c=relaxed/simple;
	bh=LZzuJLqoDL8Mv8zLa8jDfWRqme6SNJVYC9sSWCkpiDo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=A6EP1skO79XJNLGr8KAsfIlF/Ru+fTsIJKEHk0gE1aUCSlXLXV3tdnVekwe6RznJIdROeOiA1kKpWRtD54xGuj2xNQSAOQ4JtNC/pm7fYXMxNvQpSL7g7bz3bgNOQ0AbusSSCVCTuatkI9GgrcGBQit718gaSDlFTdlTd+ef/4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com; spf=fail smtp.mailfrom=quicinc.com; dkim=fail (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8gRcOX1 reason="signature verification failed"; arc=none smtp.client-ip=205.220.180.131; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quicinc.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4D75D2087D;
	Sun, 31 Mar 2024 18:40:03 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSaBSq68zuQC; Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 76774207D1;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 76774207D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 395EA80004A;
	Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:15 +0000
X-sender: <netdev+bounces-83459-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw0WmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAGYAAADLigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12150
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83459-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com BE2B120270
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8gRcOX1"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744056; cv=none; b=OPBSKjFrF2w/aKYgriC1IBh2znuljYTNiT01Z6mT0viLFA0xBB0ZYLJKG0/Ja3AuvXXN3wyyLOWWizWI/LJB4m56eONH9Fs28ZZNQefAgtAR63FeTt2IwSXkMwnxCu7rdDXMaGwIjmA9yGcoljmpDmd4NMz0hf0UBlOke9h/Y3s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744056; c=relaxed/simple;
	bh=DmN7SbvHc83v86CT34JrU35maYPW9TcbhqkpKuMp20Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=H/bY0uIMvO9080riphCTnhAJyyCLI/j/xGw61vVnuhIf7UMYCAOMxUcSIrHrvlWPiv59BL8WxrWA+6dtvpp45DjpWY7lhZGjRcLAOYIhydsxyb6gcgixbZN+lKkPbHC6Bno7TVZ3mSTh8PNNJ1quw8AW/mJ6yUBnWhvyBiZFqkY=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8gRcOX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=FA9/ZSidqDsn9N
	VYFrPdU6Qa0ODwOHndzWtzGX+s/uM=; b=L8gRcOX1nJQyvvw8Is1dU9SwHRjpR0
	rSAud7fuaXBCp2r/JHEPiVUfVmakPG2ntQupOiXnKxe8UVQSCcTKIhwuF6+6W4D1
	Sj9oMXYgCSxQs5AhJTUBFMKU/zXNdecykatd68XTV40/GOyC602wi6KWaFMFMbC+
	6LJ/91HDbxvcwffFVI+IsgByH2lkll+uAPVJOfFFLhq3/DPLI4IPZK2KJ0G1W7Ve
	pkTtSorFBxyknvra0hSbVx/pbszz69FMudR+QoaTZq2LBMlQb67T9BS77JFq42FX
	ZR7Hr1kyoAiegRhT9wfWOd5v6GqLqrEmEafEkKU4NMOvyfoq1fEBkiIw==
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: Fix mac80211.h kernel-doc issues
Date: Fri, 29 Mar 2024 13:27:16 -0700
Message-ID: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-B4-Tracking: v=1; b=H4sIACQkB2YC/x3MTQrCQAxA4auUrA3MjEKnXkVczE+0wTqVpFSh9
 O5Gl9/ivQ2UhEnh3G0gtLLy3Az+0EEZU7sTcjVDcOHkjmHAZyrRBe/xUeeCQsuaJqzkY46ur30
 ewNKX0I0//+3las5JCbOkVsbf7M1CE6najBvs+xeSJLS4hgAAAA==
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
X-Proofpoint-ORIG-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=367 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290183
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Once again my process to validate a Qualcomm Innovation Center patch
has exposed pre-existing kernel-doc issues in mac80211.h. I think I
had previously fixed all of the issues here, but that was before Randy
made me aware that I was missing some warnings which I'm now seeing
using -Wall.

One of the issues was for a function which has a prototype but which
doesn't have an implementation, so just delete that one.

---
Jeff Johnson (2):
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation

 include/net/mac80211.h | 50 ++++++++++++++++++++++++++++++----------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)
---
base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
change-id: 20240329-mac80211-kdoc-retval-de18b807d7b9


X-sender: <linux-wireless+bounces-5624-peter.schumann=3Dsecunet.com@vger.ke=
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
X-ExtendedProps: BQBjAAoAw0WmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3Vu=
ZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAA=
AAAUABQACAAEFAGIACgBnAAAAy4oAAAUAZAAPAAMAAABIdWI=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 12036
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:20 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4DF972087C
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:28:20 +0100 (CET)
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
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VgejM7I3KT5B for <peter.schumann@secunet.com>;
	Fri, 29 Mar 2024 21:28:17 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-wirel=
ess+bounces-5624-peter.schumann=3Dsecunet.com@vger.kernel.org; receiver=3Dp=
eter.schumann@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com A21642087B
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id A21642087B
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 21:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12681285D7D
	for <peter.schumann@secunet.com>; Fri, 29 Mar 2024 20:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3573C13D257;
	Fri, 29 Mar 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"L8gRcOX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.=
220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B013BC2E;
	Fri, 29 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.180.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744056; cv=3Dnone; b=3DOPBSKjFrF2w/aKYgriC1IBh2znuljYTNiT01Z6mT0vi=
LFA0xBB0ZYLJKG0/Ja3AuvXXN3wyyLOWWizWI/LJB4m56eONH9Fs28ZZNQefAgtAR63FeTt2IwS=
XkMwnxCu7rdDXMaGwIjmA9yGcoljmpDmd4NMz0hf0UBlOke9h/Y3s=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744056; c=3Drelaxed/simple;
	bh=3DDmN7SbvHc83v86CT34JrU35maYPW9TcbhqkpKuMp20Y=3D;
	h=3DFrom:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=3DH/bY=
0uIMvO9080riphCTnhAJyyCLI/j/xGw61vVnuhIf7UMYCAOMxUcSIrHrvlWPiv59BL8WxrWA+6d=
tvpp45DjpWY7lhZGjRcLAOYIhydsxyb6gcgixbZN+lKkPbHC6Bno7TVZ3mSTh8PNNJ1quw8AW/m=
J6yUBnWhvyBiZFqkY=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DL8gRcOX1; arc=3Dnone smtp.client-ip=3D205.220.180.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TKODvm=
021226;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=3Dqcppdkim1; bh=3DFA9/ZSidqDsn9N
	VYFrPdU6Qa0ODwOHndzWtzGX+s/uM=3D; b=3DL8gRcOX1nJQyvvw8Is1dU9SwHRjpR0
	rSAud7fuaXBCp2r/JHEPiVUfVmakPG2ntQupOiXnKxe8UVQSCcTKIhwuF6+6W4D1
	Sj9oMXYgCSxQs5AhJTUBFMKU/zXNdecykatd68XTV40/GOyC602wi6KWaFMFMbC+
	6LJ/91HDbxvcwffFVI+IsgByH2lkll+uAPVJOfFFLhq3/DPLI4IPZK2KJ0G1W7Ve
	pkTtSorFBxyknvra0hSbVx/pbszz69FMudR+QoaTZq2LBMlQb67T9BS77JFq42FX
	ZR7Hr1kyoAiegRhT9wfWOd5v6GqLqrEmEafEkKU4NMOvyfoq1fEBkiIw=3D=3D
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkykc05-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRIYp01=
8570
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: Fix mac80211.h kernel-doc issues
Date: Fri, 29 Mar 2024 13:27:16 -0700
Message-ID: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=3D1; b=3DH4sIACQkB2YC/x3MTQrCQAxA4auUrA3MjEKnXkVczE+0wTqVp=
FSh9
 O5Gl9/ivQ2UhEnh3G0gtLLy3Az+0EEZU7sTcjVDcOHkjmHAZyrRBe/xUeeCQsuaJqzkY46ur30
 ewNKX0I0//+3las5JCbOkVsbf7M1CE6najBvs+xeSJLS4hgAAAA=3D=3D
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
X-Proofpoint-ORIG-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 mlxlogscore=3D367 mlxscore=3D0
 phishscore=3D0 lowpriorityscore=3D0 suspectscore=3D0 spamscore=3D0 imposto=
rscore=3D0
 priorityscore=3D1501 bulkscore=3D0 clxscore=3D1011 malwarescore=3D0 adults=
core=3D0
 classifier=3Dspam adjust=3D0 reason=3Dmlx scancount=3D1 engine=3D8.19.0-24=
03210001
 definitions=3Dmain-2403290183
Return-Path: linux-wireless+bounces-5624-peter.schumann=3Dsecunet.com@vger.=
kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:20.3319
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 7aeda0bf-bd8a-47e0-177e-08dc=
502ec62d
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.185|SMR=3D0.142(SMRDE=3D0.003|SMRC=3D0.139(=
SMRCL=3D0.103|X-SMRCR=3D0.138))|CAT=3D0.041(CATRESL=3D0.022
 (CATRESLP2R=3D0.002)|CATORES=3D0.016(CATRS=3D0.016(CATRS-Index Routing
 Agent=3D0.015)));2024-03-29T20:28:20.531Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9265
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.014|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.005
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAc8CAAAPAAADH4sIAAAAAAAEAH1STU/b=
QBRcB/JlcKnaaw
 /vBoEY4hBIyK3qKVxQe+kRbexn7GLvRt41Aan/rH+u4zXQqmrrw+p9
 zszO+kfvRsVM8k7mison2lQ6ZmPIanqQRZ5IiyZ9rmUR67KklVL6Qd
 pcK/rEynJFG2njLPAzaYgfN9pwAgwO+TE3Nld3dM+V4iJMdEy5MTUb
 aohkvJhMo+g0O6UV2SxX97RqQNzyQ65rUzxRmj8CTRYF6RRD/AKQcc
 VjWtcWRWlpC+o1p7pi+iJV8hT4pUyYSgjfShTd0MqNlUBoRBmNLpoK
 iaFtlscZrQ5LUnpLhhnVwK/dZPgV/KeBH/g3iv/Q0SCCFv6ktYqdKS
 1UY4ZsrLTaPm3YSXWdwE80G3VoMfIAfYryclNwCSudqWMoo2+1sZRw
 wfZZu1bsFIRhGPjXnKZ0rTNlQHc0HS0Dn9y3zdN8+erskiouNThyZn
 aVW8P2NtvetgmrWG6ORv9a/pgkr2ZVbOtKNb9DzYR3rF/lNqLwnHFR
 J3ym2J79elf6ThcTOvnvF/7lA2CEhy+Y4kyqO07GdD4Bh+GqYTRHJ6
 MxTSetP64Qjp6dWUvDYfOX5nZJC5bn6SyNZLSeTWfT5CKNp3NUIinn
 8eIyvVzPJtF8EQd+yxPmyRK409nkfHoVvtwjvMd9QxiAy4cJR4v1Yj
 JP5uur5uaBL8Su6HZFryN2+mKAcyCGnujg9MVeT/S7or8jdtHa8cS+
 2EW95wnfFdF9mUezAxAEqGMRMYKOSzG261IQtWm3qXTRxRgC7LYUiI
 HW7rrJgZsc/g7VtlqF7STiofARYLgFwfAb8RYnYscO3gBn34NU4Yk9
 6BkIHy3kH9xux4MYAcCuOGi7rSSntheId40D7vqeBzGi4y0cVKeFbS
 pix/cO2mAo3kPWXsM+OBLH8GUIrzysi4EnjsUQOK22/Z/UPO85vQQA
 AAEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldHJpZXZlck9wZX
 JhdG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9z
 dERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRG
 lhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZH VjZXIsMjAsNw=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 940
X-MS-Exchange-Forest-EmailMessageHash: 0EED6740
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Once again my process to validate a Qualcomm Innovation Center patch
has exposed pre-existing kernel-doc issues in mac80211.h. I think I
had previously fixed all of the issues here, but that was before Randy
made me aware that I was missing some warnings which I'm now seeing
using -Wall.

One of the issues was for a function which has a prototype but which
doesn't have an implementation, so just delete that one.

---
Jeff Johnson (2):
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation

 include/net/mac80211.h | 50 ++++++++++++++++++++++++++++++----------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)
---
base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
change-id: 20240329-mac80211-kdoc-retval-de18b807d7b9


X-sender: <linux-kernel+bounces-125390-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAw0WmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGsAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12218
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:28:40 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:28:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 467CD2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:40 +0100 (CET)
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
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Flb3RkhXB_Tm for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:28:39 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125390-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 469F120270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"L8gRcOX1"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 469F120270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBEEB23B0F
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE6E13DDCB;
	Fri, 29 Mar 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@quicinc.com =
header.b=3D"L8gRcOX1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.=
220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B013BC2E;
	Fri, 29 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D205.220.180.131
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711744056; cv=3Dnone; b=3DOPBSKjFrF2w/aKYgriC1IBh2znuljYTNiT01Z6mT0vi=
LFA0xBB0ZYLJKG0/Ja3AuvXXN3wyyLOWWizWI/LJB4m56eONH9Fs28ZZNQefAgtAR63FeTt2IwS=
XkMwnxCu7rdDXMaGwIjmA9yGcoljmpDmd4NMz0hf0UBlOke9h/Y3s=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711744056; c=3Drelaxed/simple;
	bh=3DDmN7SbvHc83v86CT34JrU35maYPW9TcbhqkpKuMp20Y=3D;
	h=3DFrom:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=3DH/bY=
0uIMvO9080riphCTnhAJyyCLI/j/xGw61vVnuhIf7UMYCAOMxUcSIrHrvlWPiv59BL8WxrWA+6d=
tvpp45DjpWY7lhZGjRcLAOYIhydsxyb6gcgixbZN+lKkPbHC6Bno7TVZ3mSTh8PNNJ1quw8AW/m=
J6yUBnWhvyBiZFqkY=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dquicinc.com; spf=3Dpass smtp.mailfrom=3D=
quicinc.com; dkim=3Dpass (2048-bit key) header.d=3Dquicinc.com header.i=3D@=
quicinc.com header.b=3DL8gRcOX1; arc=3Dnone smtp.client-ip=3D205.220.180.13=
1
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dquicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dquicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TKODvm=
021226;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dquicinc.com=
; h=3D
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=3Dqcppdkim1; bh=3DFA9/ZSidqDsn9N
	VYFrPdU6Qa0ODwOHndzWtzGX+s/uM=3D; b=3DL8gRcOX1nJQyvvw8Is1dU9SwHRjpR0
	rSAud7fuaXBCp2r/JHEPiVUfVmakPG2ntQupOiXnKxe8UVQSCcTKIhwuF6+6W4D1
	Sj9oMXYgCSxQs5AhJTUBFMKU/zXNdecykatd68XTV40/GOyC602wi6KWaFMFMbC+
	6LJ/91HDbxvcwffFVI+IsgByH2lkll+uAPVJOfFFLhq3/DPLI4IPZK2KJ0G1W7Ve
	pkTtSorFBxyknvra0hSbVx/pbszz69FMudR+QoaTZq2LBMlQb67T9BS77JFq42FX
	ZR7Hr1kyoAiegRhT9wfWOd5v6GqLqrEmEafEkKU4NMOvyfoq1fEBkiIw=3D=3D
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.=
96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkykc05-1
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.4=
7.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRIYp01=
8570
	(version=3DTLSv1.2 cipher=3DECDHE-RSA-AES256-GCM-SHA384 bits=3D256 verify=
=3DNOT);
	Fri, 29 Mar 2024 20:27:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 M=
ar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: Fix mac80211.h kernel-doc issues
Date: Fri, 29 Mar 2024 13:27:16 -0700
Message-ID: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=3D1; b=3DH4sIACQkB2YC/x3MTQrCQAxA4auUrA3MjEKnXkVczE+0wTqVp=
FSh9
 O5Gl9/ivQ2UhEnh3G0gtLLy3Az+0EEZU7sTcjVDcOHkjmHAZyrRBe/xUeeCQsuaJqzkY46ur30
 ewNKX0I0//+3las5JCbOkVsbf7M1CE6najBvs+xeSJLS4hgAAAA=3D=3D
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
X-Proofpoint-ORIG-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-Virus-Version: vendor=3Dbaseguard
 engine=3DICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=3D2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=3Doutbound_notspam policy=3Doutbound score=
=3D0 mlxlogscore=3D367 mlxscore=3D0
 phishscore=3D0 lowpriorityscore=3D0 suspectscore=3D0 spamscore=3D0 imposto=
rscore=3D0
 priorityscore=3D1501 bulkscore=3D0 clxscore=3D1011 malwarescore=3D0 adults=
core=3D0
 classifier=3Dspam adjust=3D0 reason=3Dmlx scancount=3D1 engine=3D8.19.0-24=
03210001
 definitions=3Dmain-2403290183
Return-Path: linux-kernel+bounces-125390-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:28:40.3174
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 8503ecc5-4503-48b6-ca2f-08dc=
502ed216
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.196|SMR=3D0.139(SMRDE=3D0.003|SMRC=3D0.135(=
SMRCL=3D0.102|X-SMRCR=3D0.134))|CAT=3D0.056(CATOS=3D0.001
 |CATRESL=3D0.029(CATRESLP2R=3D0.004)|CATORES=3D0.022(CATRS=3D0.022(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.018))|CATORT=3D0.001);2024-03-29T20:28:40.529Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 9371
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.015|SMR=3D0.008(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.007
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAc8CAAAPAAADH4sIAAAAAAAEAH1STU/b=
QBRcB/JlcKnaaw
 /vBoEY4hBIyK3qKVxQe+kRbexn7GLvRt41Aan/rH+u4zXQqmrrw+p9
 zszO+kfvRsVM8k7mison2lQ6ZmPIanqQRZ5IiyZ9rmUR67KklVL6Qd
 pcK/rEynJFG2njLPAzaYgfN9pwAgwO+TE3Nld3dM+V4iJMdEy5MTUb
 aohkvJhMo+g0O6UV2SxX97RqQNzyQ65rUzxRmj8CTRYF6RRD/AKQcc
 VjWtcWRWlpC+o1p7pi+iJV8hT4pUyYSgjfShTd0MqNlUBoRBmNLpoK
 iaFtlscZrQ5LUnpLhhnVwK/dZPgV/KeBH/g3iv/Q0SCCFv6ktYqdKS
 1UY4ZsrLTaPm3YSXWdwE80G3VoMfIAfYryclNwCSudqWMoo2+1sZRw
 wfZZu1bsFIRhGPjXnKZ0rTNlQHc0HS0Dn9y3zdN8+erskiouNThyZn
 aVW8P2NtvetgmrWG6ORv9a/pgkr2ZVbOtKNb9DzYR3rF/lNqLwnHFR
 J3ym2J79elf6ThcTOvnvF/7lA2CEhy+Y4kyqO07GdD4Bh+GqYTRHJ6
 MxTSetP64Qjp6dWUvDYfOX5nZJC5bn6SyNZLSeTWfT5CKNp3NUIinn
 8eIyvVzPJtF8EQd+yxPmyRK409nkfHoVvtwjvMd9QxiAy4cJR4v1Yj
 JP5uur5uaBL8Su6HZFryN2+mKAcyCGnujg9MVeT/S7or8jdtHa8cS+
 2EW95wnfFdF9mUezAxAEqGMRMYKOSzG261IQtWm3qXTRxRgC7LYUiI
 HW7rrJgZsc/g7VtlqF7STiofARYLgFwfAb8RYnYscO3gBn34NU4Yk9
 6BkIHy3kH9xux4MYAcCuOGi7rSSntheId40D7vqeBzGi4y0cVKeFbS
 pix/cO2mAo3kPWXsM+OBLH8GUIrzysi4EnjsUQOK22/Z/UPO85vQQA
 AAEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwyO1JldHJpZXZlck9wZX
 JhdG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9z
 dERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRG
 lhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZH VjZXIsMjAsOA=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 940
X-MS-Exchange-Forest-EmailMessageHash: 0EED6740
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Once again my process to validate a Qualcomm Innovation Center patch
has exposed pre-existing kernel-doc issues in mac80211.h. I think I
had previously fixed all of the issues here, but that was before Randy
made me aware that I was missing some warnings which I'm now seeing
using -Wall.

One of the issues was for a function which has a prototype but which
doesn't have an implementation, so just delete that one.

---
Jeff Johnson (2):
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation

 include/net/mac80211.h | 50 ++++++++++++++++++++++++++++++----------------=
----
 1 file changed, 30 insertions(+), 20 deletions(-)
---
base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
change-id: 20240329-mac80211-kdoc-retval-de18b807d7b9



