Return-Path: <linux-kernel+bounces-126247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8B389343A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B321F23D30
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59115AD80;
	Sun, 31 Mar 2024 16:41:35 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B0715A48D;
	Sun, 31 Mar 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903292; cv=fail; b=hi8kyAw+WRg/FoTdP/+WFlmd/U02vA/VNIklj6BMisBYv2dR6yytm0MAct8u12/MWutvn4ozBiUofZsjMoPEhVmU6v7izjEDMMOOQsR9Iv3jCSkUQy46AE62+xc00W1chnfpHlzF7O4dTaAU0snldvW4TRiM2oRLnPJ80w3LLaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903292; c=relaxed/simple;
	bh=9w0O1z6FUxoK9VC1GZASFkZub1vkSkorKeuHCgtNLxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3coX4pQ9thb4dhXL6akmqc098NrLXmn4/iW97BXbkxgV2E4DVNxyOmbFiGnhZar+Kg0F7QTpLMcDReejFJtcS7jyMK412gtuZvQ7ZnMBuyhFzuZB6a2+KVb1aeKqmWGzH2E/Cfy5Ws9QirlxxHD58/qLn1iuYY+mVW391+t6Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn; spf=fail smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shingroup.cn
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9EADA208B5;
	Sun, 31 Mar 2024 18:41:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gEdFZqMAudcH; Sun, 31 Mar 2024 18:41:24 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 41E50207D1;
	Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 41E50207D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 3246980005E;
	Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:20 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:28 +0000
X-sender: <netdev+bounces-83540-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBoAAAA7IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13072
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83540-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 7701620199
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863444; cv=none; b=Dlu1TmEw7MS4RDkvkBakHqa39dMnDH6OfEjY3vaS0C11tlYX5NsJQ4wSReiOUk+CH3B/qKshuWtWcYRrn7MYtYvr2ylYL7UbxFcm/Hb7M++625PyNnDiEQeApsSXTpibI6B9ZWt4wiwJWEP+/lQzvXiAKPwnA4naQ8p14Nl78zQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863444; c=relaxed/simple;
	bh=nxx+6xNwnVOmWpIQMEjVW/rRZuWaUlN8c6YVrXlsBh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpMP9f9Z3rsFywTSaApOr1Flcq6aAevdG27Ak/yXjXx01cXvhi1OBwPwA096rdqKKp6/HB2SuFNGSQ1iPW0diO7rNZb5Y3r7MtXYLOrImSlrCPXnURips5is7H4yqvXXgOLWE22ORGkeTKqZrA6LeJJF723McJ1SLfyDmuq4R6Q=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1711863362tp4jo7vv
X-QQ-Originating-IP: 1n8l4ALh9WiJP6dd4Vqjjg2n3vV6oK56OsALArkr0dA=
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3hJk2d/iE1l8M7/xX9AiPOvpZgXK4zA8yArofRwWfr63wL+fu12a
	kkxymzrJlfg8UhRnrd7HjT/aqE+NFAdWiu2IJnOjhT4iePMDukh+e6VxPFUPNt50TQOoRI6
	F69k3j/xMD7wn3BI6rejwFuTbfM7SEbgo5C408pa7je2hQTakW3frIH1RwMQYfaMa1jNpp4
	hDIykph0ygNn2KwTHbTBExTuLaYnDAICkXMU+S6vk478oqWqxnmAhpiobE6+Y02/KKP01dk
	EEc23nBmmqHpNQX1P2BvH16FmD4x/yg6aTlkrS4s6yNwXDJojARS9eEbfV8esu+W/KmU6Zi
	6yOKikBXQ8gIE1ZW85c8SK9lZ2fh6cmXUbAEws85gxFuevlxQCTE1ECh//5QdJpGEILYwKC
	y5stMRazGpc=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3312073214826077322
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 2/2] net/dpaa2: Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:41 +0800
Message-ID: <20240331053441.1276826-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-eth.c
index 888509cf1f21..40e881829595 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2896,11 +2896,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *ne=
t_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev =3D priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err =3D 0;
=20
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues =3D dpaa2_eth_queue_count(priv);
 	netdev_queues =3D (net_dev->num_tc ? : 1) * num_queues;
=20
@@ -2910,16 +2913,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i =3D 0; i < netdev_queues; i++) {
 		fq =3D &priv->fq[i % num_queues];
=20
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
=20
-		err =3D netif_set_xps_queue(net_dev, &xps_mask, i);
+		err =3D netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
=20
+	free_cpumask_var(xps_mask);
 	return err;
 }
=20
--=20
2.27.0


X-sender: <linux-kernel+bounces-125961-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGoAAADsigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13049
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:52 +0200
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 9EF252087C
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:52 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -4.951
X-Spam-Level:
X-Spam-Status: No, score=3D-4.951 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XU5B4TiqmHGx for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:50 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125961-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 114E82083E
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 114E82083E
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D9028246A
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB598F45;
	Sun, 31 Mar 2024 05:37:26 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD6FB2;
	Sun, 31 Mar 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.62.65
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863444; cv=3Dnone; b=3DDlu1TmEw7MS4RDkvkBakHqa39dMnDH6OfEjY3vaS0C1=
1tlYX5NsJQ4wSReiOUk+CH3B/qKshuWtWcYRrn7MYtYvr2ylYL7UbxFcm/Hb7M++625PyNnDiEQ=
eApsSXTpibI6B9ZWt4wiwJWEP+/lQzvXiAKPwnA4naQ8p14Nl78zQ=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863444; c=3Drelaxed/simple;
	bh=3Dnxx+6xNwnVOmWpIQMEjVW/rRZuWaUlN8c6YVrXlsBh0=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DWpMP9f9Z3rsFywTSaApOr1Flcq6aAevdG27Ak/yXjXx01cXvhi1OBwP=
wA096rdqKKp6/HB2SuFNGSQ1iPW0diO7rNZb5Y3r7MtXYLOrImSlrCPXnURips5is7H4yqvXXgO=
LWE22ORGkeTKqZrA6LeJJF723McJ1SLfyDmuq4R6Q=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp87t1711863362tp4jo7vv
X-QQ-Originating-IP: 1n8l4ALh9WiJP6dd4Vqjjg2n3vV6oK56OsALArkr0dA=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:36:01 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3hJk2d/iE1l8M7/xX9AiPOvpZgXK4zA8yArofRwWfr63wL+fu12a
	kkxymzrJlfg8UhRnrd7HjT/aqE+NFAdWiu2IJnOjhT4iePMDukh+e6VxPFUPNt50TQOoRI6
	F69k3j/xMD7wn3BI6rejwFuTbfM7SEbgo5C408pa7je2hQTakW3frIH1RwMQYfaMa1jNpp4
	hDIykph0ygNn2KwTHbTBExTuLaYnDAICkXMU+S6vk478oqWqxnmAhpiobE6+Y02/KKP01dk
	EEc23nBmmqHpNQX1P2BvH16FmD4x/yg6aTlkrS4s6yNwXDJojARS9eEbfV8esu+W/KmU6Zi
	6yOKikBXQ8gIE1ZW85c8SK9lZ2fh6cmXUbAEws85gxFuevlxQCTE1ECh//5QdJpGEILYwKC
	y5stMRazGpc=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3312073214826077322
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 2/2] net/dpaa2: Avoid explicit cpumask var allo=
cation on stack
Date: Sun, 31 Mar 2024 13:34:41 +0800
Message-ID: <20240331053441.1276826-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: linux-kernel+bounces-125961-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:52.6959
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 431ca728-9f98-41df-7672-08dc=
5144b5a6
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.385|SMR=3D0.327(SMRDE=3D0.005|SMRC=3D0.321(=
SMRCL=3D0.103|X-SMRCR=3D0.320))|CAT=3D0.057(CATOS=3D0.001
 |CATRESL=3D0.009(CATRESLP2R=3D0.003)|CATORES=3D0.045(CATRS=3D0.045(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.042)));2024-03-31T05:37:53.080Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8167
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.006|SMR=3D0.006(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.004))
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAUgFAAAPAAADH4sIAAAAAAAEAJ1VjU/b=
RhQ/O7GTGEzp2m
 pVNU1vlVYlYIeYQZuUlVF1UKF+obFKk7bJMvY5nAh2sB0+tPUv2D+9
 d3d2bCihH5ZjPd+993u/93vvnP9u78QJvHj3dmf3pfti7/2b5/uv3H
 c7O/u/P3/x6tkFHNEkoiML6Pl4xHyWgTcaxb6XsTiCOAR/PDn20iPT
 OPUS5h2MKOB6mnn+EbAUojiDhPrx8TGNAhpAyiKfAoL4XoS/SUphHG
 c0ypg3klGmEZ/SJBzFZ13TMI3dKM2oF1g5DfDjgEJ6GE9GARI58y5S
 4CBLOQ0XWcDzvd122oEsLqhS08j3ge8zTB1HIRvaEZ1kCWZGHAtG1D
 tl0bBaX4q7GR1eIJZpzJBI0Hx/A4cgSGiaYtHCc58NIxrYcRjaBxdP
 4VfvjDJ4zeDngFvdEdtKD5FFEk/GXT/aNA3btk0DgoShLOlKRLMVmh
 1yMbKVMKE09b0RXQnGnrcqnzZud334F5w1WC4u25YwDoQMW+QfetGQ
 oqoDFCOlCS82bS93LFiHgI6ofLc7nHDAwhBse8g7v/LFNA6+OMQ0GI
 7KOfT7/fXewA+dcNXpdtd6tN93+quD9cE6OL3e47U1Ic1XcDINFOSr
 iG1tgb3aHzy2HAeWpbEGuIiDmzEfpcxA+Lvo754HY/f8mGVtHKKJnw
 GiuwE9ZTj/S7ltiZDIwsZUICbjAIfOPR+nRWgJOkbOsMSf2Bv4B3/5
 NTsJPAPub2/m7xuo2+Wg4mxgRpcbH3uUBMITWApPNsrEnDGzIJocuy
 cTOqGpxUlgnvwVXZc/CVZ4VE6Qm1X5VLPRJMGaeht8OItAFkL7B3Fw
 3QpG+1EBYcHLnT331fZvb7dfdzplXHElNJskEdjbb9+92X7DGZU5y9
 IwbUleLLl+PImytmhIheYlBTCqnWuPTUCwzIdf4Ck4HViqgIt6xIQN
 nJ7lPMYJGzg/Wc6TKxP2+eORXyF+3ttMSAb4nbnSHmDLy53qJE3DTj
 DkkRyd8ORPBj9WyP4t2NpXQgrpffyUVsTvbMx2TVEYtNvhib2ZeclQ
 vlpwKfhqty7n+RzPWWmqsR+TlJOGerFQIHBvUX97eoArE8auI/AZEF
 cQrvaBjzaiXNuj4spbeuYlkRvjP2wJ/nA7SbD/mDrj/21/7O2DSP9X
 9PC6ZMV1kFDv6Jr9D+XSh+r545/NSyevKmwRkR8yLIYvinj+p7TaXX
 3S7fE30yCkRuq6Qr4ljQZpNklLIaouDIPMqaTWIC200dCIjk90niPz
 UxuNFjE00mgSEz110qgTDZ9414jWUMgcaaIb3gqpYUiTGA2xgjYmXR
 BJuSdpYjqRqErGvBYEt1RMoRCTZ0GouuBT1xRyTxBDSiqZk4kQUzDU
 cbdFdA6iYAhRlbsKIVhsnadoSdtQbkmjRRbrAhztmTiIcdMuV2yeLM
 wrpk6ITuZvdG7ctKvoGiGaogvatdImutCZF/6N8MRb6l9TiIFKIiBC
 83VNZNGkv853hUEaGu+CLgL1OrlzXSyu64W9oMuWKaTJQ25JhHmBoP
 LblLVPQWSbdHL7Y88G32pKJaeAvApFF11YUImGIbeJLoek8NEL8Acc
 n9wtXltyAORYapz2YpHdKHVQsBd1VWmIFFoeqyzcrPBsxZCwhhMl0B
 CsXmRsKuS+KqRTxXpB8jtZtSZ0FuXcx5VbxYSrZS696iBC9E+FTCV6
 UBPzc6eYCq3s4BQEg+7NdtOqbipfAbQWxQGvi12JpuXd4bEK+V4jvT
 p30+RiAbIo5mqRq6SoUmRu/w9rgi99Cg0AAAEK8QE8P3htbCB2ZXJz
 aW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD
 4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxFbWFp
 bHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjM5MCIgUG9zaXRpb2
 49IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxTdHJpbmc+ZGF3ZWku
 bGlAc2hpbmdyb3VwLmNuPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYW
 lsPg0KICA8L0VtYWlscz4NCjwvRW1haWxTZXQ+AQyqBDw/eG1sIHZl
 cnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRhY3
 RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8
 Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD0iMzgwIi
 BQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJzb24gU3Rh
 cnRJbmRleD0iMzgwIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgIC
 AgICAgPFBlcnNvblN0cmluZz5EYXdlaSBMaTwvUGVyc29uU3RyaW5n
 Pg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW1haWxzPg0KICAgIC
 AgICA8RW1haWwgU3RhcnRJbmRleD0iMzkwIiBQb3NpdGlvbj0iU2ln
 bmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+ZGF3ZWkubG
 lAc2hpbmdyb3VwLmNuPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9F
 bWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdH
 Jpbmc+RGF3ZWkgTGkgJmx0O2Rhd2VpLmxpQHNoaW5ncm91cC5jbjwv
 Q29udGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udG
 FjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJpZXZlck9wZXJhdG9y
 LDEwLDA7UmV0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0RG9jUGFyc2
 VyT3BlcmF0b3IsMTAsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEs
 MDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMz
 tQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtU
 cmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwyMQ=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 2377
X-MS-Exchange-Forest-EmailMessageHash: 7A646CF9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-eth.c
index 888509cf1f21..40e881829595 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2896,11 +2896,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *ne=
t_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev =3D priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err =3D 0;
=20
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues =3D dpaa2_eth_queue_count(priv);
 	netdev_queues =3D (net_dev->num_tc ? : 1) * num_queues;
=20
@@ -2910,16 +2913,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i =3D 0; i < netdev_queues; i++) {
 		fq =3D &priv->fq[i % num_queues];
=20
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
=20
-		err =3D netif_set_xps_queue(net_dev, &xps_mask, i);
+		err =3D netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
=20
+	free_cpumask_var(xps_mask);
 	return err;
 }
=20
--=20
2.27.0


X-sender: <netdev+bounces-83540-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com; X-ExtendedProps=3DDwA1AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9y=
dC5EaXJlY3RvcnlEYXRhLklzUmVzb3VyY2UCAAAFABUAFgACAAAABQAUABEA8MUJLbkECUOS0gj=
aDTZ+uAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAG=
IAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IR=
jIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACh=
eZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJ=
hdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ0=
49c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhd=
GlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngt=
ZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmV=
jaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAGwAAgAABQBYABcASg=
AAAPDFCS25BAlDktII2g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3Jhd=
GlvbixEQz1zZWN1bmV0LERDPWRlBQAMAAIAAAUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNl=
U3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGN=
oYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW=
5zaW9uBQAjAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1=
pdENvdW50BwACAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAg=
ABBQBiAAoAaQAAAOyKAAAFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoY=
W5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExv=
dw=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 13480
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:41 +0200
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:41 +0200
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 337A92087C
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:41 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001] autolearn=3Dham autolearn_force=
=3Dno
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gF101sjQceD for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:39 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83540-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com DE8FC2083E
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id DE8FC2083E
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0AC1F21609
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115516FCB;
	Sun, 31 Mar 2024 05:37:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAD6FB2;
	Sun, 31 Mar 2024 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D114.132.62.65
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863444; cv=3Dnone; b=3DDlu1TmEw7MS4RDkvkBakHqa39dMnDH6OfEjY3vaS0C1=
1tlYX5NsJQ4wSReiOUk+CH3B/qKshuWtWcYRrn7MYtYvr2ylYL7UbxFcm/Hb7M++625PyNnDiEQ=
eApsSXTpibI6B9ZWt4wiwJWEP+/lQzvXiAKPwnA4naQ8p14Nl78zQ=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863444; c=3Drelaxed/simple;
	bh=3Dnxx+6xNwnVOmWpIQMEjVW/rRZuWaUlN8c6YVrXlsBh0=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DWpMP9f9Z3rsFywTSaApOr1Flcq6aAevdG27Ak/yXjXx01cXvhi1OBwP=
wA096rdqKKp6/HB2SuFNGSQ1iPW0diO7rNZb5Y3r7MtXYLOrImSlrCPXnURips5is7H4yqvXXgO=
LWE22ORGkeTKqZrA6LeJJF723McJ1SLfyDmuq4R6Q=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp87t1711863362tp4jo7vv
X-QQ-Originating-IP: 1n8l4ALh9WiJP6dd4Vqjjg2n3vV6oK56OsALArkr0dA=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:36:01 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3hJk2d/iE1l8M7/xX9AiPOvpZgXK4zA8yArofRwWfr63wL+fu12a
	kkxymzrJlfg8UhRnrd7HjT/aqE+NFAdWiu2IJnOjhT4iePMDukh+e6VxPFUPNt50TQOoRI6
	F69k3j/xMD7wn3BI6rejwFuTbfM7SEbgo5C408pa7je2hQTakW3frIH1RwMQYfaMa1jNpp4
	hDIykph0ygNn2KwTHbTBExTuLaYnDAICkXMU+S6vk478oqWqxnmAhpiobE6+Y02/KKP01dk
	EEc23nBmmqHpNQX1P2BvH16FmD4x/yg6aTlkrS4s6yNwXDJojARS9eEbfV8esu+W/KmU6Zi
	6yOKikBXQ8gIE1ZW85c8SK9lZ2fh6cmXUbAEws85gxFuevlxQCTE1ECh//5QdJpGEILYwKC
	y5stMRazGpc=3D
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 3312073214826077322
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 2/2] net/dpaa2: Avoid explicit cpumask var allo=
cation on stack
Date: Sun, 31 Mar 2024 13:34:41 +0800
Message-ID: <20240331053441.1276826-3-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240331053441.1276826-1-dawei.li@shingroup.cn>
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
Return-Path: netdev+bounces-83540-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:41.2594
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: b6498806-01fb-404c-64d7-08dc=
5144aed5
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D17502.188|SMR=3D0.141(SMRDE=3D0.005|SMRC=3D0.=
135(SMRCL=3D0.103|X-SMRCR=3D0.134))|CAT=3D0.074(CATRESL=3D0.024
 (CATRESLP2R=3D0.018)|CATORES=3D0.047(CATRS=3D0.047(CATRS-Transport Rule
 Agent=3D0.001(X-ETREX=3D0.001 )|CATRS-Index Routing
 Agent=3D0.044)))|QDM=3D8140.787|SMSC=3D0.009|SMS=3D1.518(SMSMBXD-INC=3D1.5=
13
 )|UNK=3D0.001|QDM=3D9354.611|CAT=3D0.025(CATRESL=3D0.023(CATRESLP2R=3D0.00=
3))|QDM=3D5.150|CAT=3D0.007
 (CATRESL=3D0.006(CATRESLP2R=3D0.002));2024-03-31T10:29:23.449Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8163
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.008|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAUgFAAAPAAADH4sIAAAAAAAEAJ1VjU/b=
RhQ/O7GTGEzp2m
 pVNU1vlVYlYIeYQZuUlVF1UKF+obFKk7bJMvY5nAh2sB0+tPUv2D+9
 d3d2bCihH5ZjPd+993u/93vvnP9u78QJvHj3dmf3pfti7/2b5/uv3H
 c7O/u/P3/x6tkFHNEkoiML6Pl4xHyWgTcaxb6XsTiCOAR/PDn20iPT
 OPUS5h2MKOB6mnn+EbAUojiDhPrx8TGNAhpAyiKfAoL4XoS/SUphHG
 c0ypg3klGmEZ/SJBzFZ13TMI3dKM2oF1g5DfDjgEJ6GE9GARI58y5S
 4CBLOQ0XWcDzvd122oEsLqhS08j3ge8zTB1HIRvaEZ1kCWZGHAtG1D
 tl0bBaX4q7GR1eIJZpzJBI0Hx/A4cgSGiaYtHCc58NIxrYcRjaBxdP
 4VfvjDJ4zeDngFvdEdtKD5FFEk/GXT/aNA3btk0DgoShLOlKRLMVmh
 1yMbKVMKE09b0RXQnGnrcqnzZud334F5w1WC4u25YwDoQMW+QfetGQ
 oqoDFCOlCS82bS93LFiHgI6ofLc7nHDAwhBse8g7v/LFNA6+OMQ0GI
 7KOfT7/fXewA+dcNXpdtd6tN93+quD9cE6OL3e47U1Ic1XcDINFOSr
 iG1tgb3aHzy2HAeWpbEGuIiDmzEfpcxA+Lvo754HY/f8mGVtHKKJnw
 GiuwE9ZTj/S7ltiZDIwsZUICbjAIfOPR+nRWgJOkbOsMSf2Bv4B3/5
 NTsJPAPub2/m7xuo2+Wg4mxgRpcbH3uUBMITWApPNsrEnDGzIJocuy
 cTOqGpxUlgnvwVXZc/CVZ4VE6Qm1X5VLPRJMGaeht8OItAFkL7B3Fw
 3QpG+1EBYcHLnT331fZvb7dfdzplXHElNJskEdjbb9+92X7DGZU5y9
 IwbUleLLl+PImytmhIheYlBTCqnWuPTUCwzIdf4Ck4HViqgIt6xIQN
 nJ7lPMYJGzg/Wc6TKxP2+eORXyF+3ttMSAb4nbnSHmDLy53qJE3DTj
 DkkRyd8ORPBj9WyP4t2NpXQgrpffyUVsTvbMx2TVEYtNvhib2ZeclQ
 vlpwKfhqty7n+RzPWWmqsR+TlJOGerFQIHBvUX97eoArE8auI/AZEF
 cQrvaBjzaiXNuj4spbeuYlkRvjP2wJ/nA7SbD/mDrj/21/7O2DSP9X
 9PC6ZMV1kFDv6Jr9D+XSh+r545/NSyevKmwRkR8yLIYvinj+p7TaXX
 3S7fE30yCkRuq6Qr4ljQZpNklLIaouDIPMqaTWIC200dCIjk90niPz
 UxuNFjE00mgSEz110qgTDZ9414jWUMgcaaIb3gqpYUiTGA2xgjYmXR
 BJuSdpYjqRqErGvBYEt1RMoRCTZ0GouuBT1xRyTxBDSiqZk4kQUzDU
 cbdFdA6iYAhRlbsKIVhsnadoSdtQbkmjRRbrAhztmTiIcdMuV2yeLM
 wrpk6ITuZvdG7ctKvoGiGaogvatdImutCZF/6N8MRb6l9TiIFKIiBC
 83VNZNGkv853hUEaGu+CLgL1OrlzXSyu64W9oMuWKaTJQ25JhHmBoP
 LblLVPQWSbdHL7Y88G32pKJaeAvApFF11YUImGIbeJLoek8NEL8Acc
 n9wtXltyAORYapz2YpHdKHVQsBd1VWmIFFoeqyzcrPBsxZCwhhMl0B
 CsXmRsKuS+KqRTxXpB8jtZtSZ0FuXcx5VbxYSrZS696iBC9E+FTCV6
 UBPzc6eYCq3s4BQEg+7NdtOqbipfAbQWxQGvi12JpuXd4bEK+V4jvT
 p30+RiAbIo5mqRq6SoUmRu/w9rgi99Cg0AAAEK8QE8P3htbCB2ZXJz
 aW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz4NCjxFbWFpbFNldD
 4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxFbWFp
 bHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9IjM5MCIgUG9zaXRpb2
 49IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxTdHJpbmc+ZGF3ZWku
 bGlAc2hpbmdyb3VwLmNuPC9FbWFpbFN0cmluZz4NCiAgICA8L0VtYW
 lsPg0KICA8L0VtYWlscz4NCjwvRW1haWxTZXQ+AQyqBDw/eG1sIHZl
 cnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPENvbnRhY3
 RTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJzaW9uPg0KICA8
 Q29udGFjdHM+DQogICAgPENvbnRhY3QgU3RhcnRJbmRleD0iMzgwIi
 BQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgICAgIDxQZXJzb24gU3Rh
 cnRJbmRleD0iMzgwIiBQb3NpdGlvbj0iU2lnbmF0dXJlIj4NCiAgIC
 AgICAgPFBlcnNvblN0cmluZz5EYXdlaSBMaTwvUGVyc29uU3RyaW5n
 Pg0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW1haWxzPg0KICAgIC
 AgICA8RW1haWwgU3RhcnRJbmRleD0iMzkwIiBQb3NpdGlvbj0iU2ln
 bmF0dXJlIj4NCiAgICAgICAgICA8RW1haWxTdHJpbmc+ZGF3ZWkubG
 lAc2hpbmdyb3VwLmNuPC9FbWFpbFN0cmluZz4NCiAgICAgICAgPC9F
 bWFpbD4NCiAgICAgIDwvRW1haWxzPg0KICAgICAgPENvbnRhY3RTdH
 Jpbmc+RGF3ZWkgTGkgJmx0O2Rhd2VpLmxpQHNoaW5ncm91cC5jbjwv
 Q29udGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udG
 FjdHM+DQo8L0NvbnRhY3RTZXQ+AQ7PAVJldHJpZXZlck9wZXJhdG9y
 LDEwLDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMjtQb3N0RG9jUGFyc2
 VyT3BlcmF0b3IsMTAsMTtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEs
 MDtQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMj
 tQb3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtU
 cmFuc3BvcnRXcml0ZXJQcm9kdWNlciwyMCwyNA=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 2377
X-MS-Exchange-Forest-EmailMessageHash: 7A646CF9
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:RC:REDACTED-af51df60fd698f80b0=
64826f9ee192ca@secunet.com:15/10|SR
X-MS-Exchange-Organization-IncludeInSla: False:RecipientCountThresholdExcee=
ded

For CONFIG_CPUMASK_OFFSTACK=3Dy kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config-neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net=
/ethernet/freescale/dpaa2/dpaa2-eth.c
index 888509cf1f21..40e881829595 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2896,11 +2896,14 @@ static int dpaa2_eth_xdp_xmit(struct net_device *ne=
t_dev, int n,
 static int update_xps(struct dpaa2_eth_priv *priv)
 {
 	struct net_device *net_dev =3D priv->net_dev;
-	struct cpumask xps_mask;
-	struct dpaa2_eth_fq *fq;
 	int i, num_queues, netdev_queues;
+	struct dpaa2_eth_fq *fq;
+	cpumask_var_t xps_mask;
 	int err =3D 0;
=20
+	if (!alloc_cpumask_var(&xps_mask, GFP_KERNEL))
+		return -ENOMEM;
+
 	num_queues =3D dpaa2_eth_queue_count(priv);
 	netdev_queues =3D (net_dev->num_tc ? : 1) * num_queues;
=20
@@ -2910,16 +2913,17 @@ static int update_xps(struct dpaa2_eth_priv *priv)
 	for (i =3D 0; i < netdev_queues; i++) {
 		fq =3D &priv->fq[i % num_queues];
=20
-		cpumask_clear(&xps_mask);
-		cpumask_set_cpu(fq->target_cpu, &xps_mask);
+		cpumask_clear(xps_mask);
+		cpumask_set_cpu(fq->target_cpu, xps_mask);
=20
-		err =3D netif_set_xps_queue(net_dev, &xps_mask, i);
+		err =3D netif_set_xps_queue(net_dev, xps_mask, i);
 		if (err) {
 			netdev_warn_once(net_dev, "Error setting XPS queue\n");
 			break;
 		}
 	}
=20
+	free_cpumask_var(xps_mask);
 	return err;
 }
=20
--=20
2.27.0



