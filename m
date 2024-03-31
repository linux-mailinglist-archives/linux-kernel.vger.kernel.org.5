Return-Path: <linux-kernel+bounces-126246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51022893435
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD861B24A97
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8051315A4B7;
	Sun, 31 Mar 2024 16:41:32 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A4915990E;
	Sun, 31 Mar 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903290; cv=fail; b=gq1ARRlbQX8U/GU4MMEUSM9fPBdjqEb5A7N08b2lkyYCmGodye4SlzSnbF4AhjwcgKaAc2QMC/M2PVJ46KjY2B90i6o05dvBMt2TGpr/ru4yYImYX0pnTHxzdB81F9d/F+QWzczDKSiXan5YW6RFjft/Y25FymBraye2X6zje6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903290; c=relaxed/simple;
	bh=Ky4jZuk5f4/BIwdR/a/TIpHLP2mgDdaaWJJiXNR/f2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGYKrbY9wYpDTjFLzCVPasSnXva886YxvgLYhLm4iLswxMY/DLDlF169FZ4i84Q+4MdBh3vskokoF0+tTdCqf4JcOFWSqqGYc6VnA4VPx6GJnIo0zJatbnHjVmXsSxCUJkYIMokIn3xMjtpDc1kjAd6YV98GVu445bL3GZYqsLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn; spf=fail smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=shingroup.cn
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F0FDA201E5;
	Sun, 31 Mar 2024 18:41:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xfdcvyxRIhsu; Sun, 31 Mar 2024 18:41:20 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CE6A3208A2;
	Sun, 31 Mar 2024 18:41:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CE6A3208A2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id C20E780005E;
	Sun, 31 Mar 2024 18:41:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:28 +0000
X-sender: <netdev+bounces-83538-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBiAAAA7IoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12960
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83538-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 7E34320199
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711863413; cv=none; b=RpVDbX2JD0/RlW8D3gN7OWsadmc/olonOAvagvgCKlgPh8iwqleFOAs1g1tsHRmtm5UUYluM5mA1wYn26M5NeINJKyIg90zg4vqzAdudbbmXgcs05AQmoZX3s7pqWOyEbC4QtOoms2WPtUhwcYKE/2gGCjzh8Ce4wGf3gL3KJI8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711863413; c=relaxed/simple;
	bh=cRT3X+uLWIo/WDT/dysE7g0AVNehkJ5rdYqVsI+vjX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJGQalf5ygsLz6W7crwPcqJPg9D2iGQDLglH0ceLy/J91sAwjpOeLVrpyKsKv+GF3c/o5LJ9MTIYYGxWiDZdwZrtpK4DnTjYj/bwd04ljxHUXXks+AJ62V2K+q6ynlRDjwUtctZuSI/7xszZJI9mjsIOksy7n6En4OXN4lYeN9g=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp87t1711863353tvqruomb
X-QQ-Originating-IP: dHu89vOsfyXlaQKZF86cBB1XYRxM3aKc0t7f88USl8g=
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: rZJGTgY0+YOuhoc1+jgTQzFXybo6WpkwHmAznXexq7mNnvmJOrZ22rJCyRlxA
	yv+DUYrg83tauZiFD4e5OeolzNLxCkYZAI3ridWwMnx2JQecfKQBp6G915QB7WwOeONSCAQ
	yiiu0Z+ri/Nw7546cTU5FunYzRvLQVeaNQXN84uh1FHxLo6fpmfcrxm7/+sMZdYHa3cAaRl
	lTYuZWrjb5rQtysFSnufhD17smjbr9Zod6O8MaB8Un+YnXkUvQCTJjP7wxCo8r0n+rP7Omt
	ETATyyanGMCSnkBeXJDPkdGNQF1RQgjq6q60WhxSBKe90UnQzoh9rQ6lzMDcGqqJm5fJaTq
	T82qGnoMMUZejzj1HUiSxMd5lxp71G2bssZRY5kxGdGRmMmri9sTkshPuxG6SH3lpBNpj3e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4506703939604469898
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 1/2] net/iucv: Avoid explicit cpumask var allocation on stack
Date: Sun, 31 Mar 2024 13:34:40 +0800
Message-ID: <20240331053441.1276826-2-dawei.li@shingroup.cn>
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
 net/iucv/iucv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a4ab615ca3e3..5e37a8ceebcb 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -520,7 +520,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
=20
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -628,23 +628,33 @@ static int iucv_cpu_online(unsigned int cpu)
=20
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret =3D 0;
=20
 	if (!iucv_path_table)
 		return 0;
=20
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto __free_cpumask;
+	}
=20
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
=20
 /**
--=20
2.27.0


X-sender: <netdev+bounces-83538-steffen.klassert=3Dsecunet.com@vger.kernel.=
org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=3Drfc822;steffen.klassert@=
secunet.com NOTIFY=3DNEVER; X-ExtendedProps=3DBQBYABcASgAAAPDFCS25BAlDktII2=
g02frhDTj1LbGFzc2VydCBTdGVmZmVuLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0=
LERDPWRlBQBsAAIAAAUADAACAAAPADYAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0Lk1=
haWxSZWNpcGllbnQuRGlzcGxheU5hbWUPABEAAABLbGFzc2VydCwgU3RlZmZlbgUAPAACAAAFAB=
0ADwAMAAAAbWJ4LWVzc2VuLTAyBQAOABEABiAS9uuMOkqzwmEZDvWNNQUACwAXAL4AAACheZxkH=
SGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2=
ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2V=
jdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbi=
xEQz1zZWN1bmV0LERDPWRlBQASAA8AYgAAAC9vPXNlY3VuZXQvb3U9RXhjaGFuZ2UgQWRtaW5pc=
3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCkvY249UmVjaXBpZW50cy9jbj1TdGVmZmVu=
IEtsYXNzZXJ0NjhjBQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAA=
ABQAUABEA8MUJLbkECUOS0gjaDTZ+uAUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2=
UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQ=
XV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8ALwAAAE1p=
Y3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmV=
yc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ=3D=3D
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAm3AFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1=
pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAg=
ABBQBiAAoAYwAAAOyKAAAFAGQADwADAAAASHViBQApAAIAAQ=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13156
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:07 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:07 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id B85AA20199
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:07 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -4.951
X-Spam-Level:
X-Spam-Status: No, score=3D-4.951 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001,
	SPF_PASS=3D-0.001] autolearn=3Dunavailable autolearn_force=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W5t16-SzPzNP for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:04 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83538-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C26CF20310
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id C26CF20310
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA95282445
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EEF6FB2;
	Sun, 31 Mar 2024 05:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D6FA7;
	Sun, 31 Mar 2024 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D54.207.22.56
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863413; cv=3Dnone; b=3DRpVDbX2JD0/RlW8D3gN7OWsadmc/olonOAvagvgCKlg=
Ph8iwqleFOAs1g1tsHRmtm5UUYluM5mA1wYn26M5NeINJKyIg90zg4vqzAdudbbmXgcs05AQmoZ=
X3s7pqWOyEbC4QtOoms2WPtUhwcYKE/2gGCjzh8Ce4wGf3gL3KJI8=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863413; c=3Drelaxed/simple;
	bh=3DcRT3X+uLWIo/WDT/dysE7g0AVNehkJ5rdYqVsI+vjX4=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DsJGQalf5ygsLz6W7crwPcqJPg9D2iGQDLglH0ceLy/J91sAwjpOeLVr=
pyKsKv+GF3c/o5LJ9MTIYYGxWiDZdwZrtpK4DnTjYj/bwd04ljxHUXXks+AJ62V2K+q6ynlRDjw=
UtctZuSI/7xszZJI9mjsIOksy7n6En4OXN4lYeN9g=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp87t1711863353tvqruomb
X-QQ-Originating-IP: dHu89vOsfyXlaQKZF86cBB1XYRxM3aKc0t7f88USl8g=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:35:52 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: rZJGTgY0+YOuhoc1+jgTQzFXybo6WpkwHmAznXexq7mNnvmJOrZ22rJCyRlxA
	yv+DUYrg83tauZiFD4e5OeolzNLxCkYZAI3ridWwMnx2JQecfKQBp6G915QB7WwOeONSCAQ
	yiiu0Z+ri/Nw7546cTU5FunYzRvLQVeaNQXN84uh1FHxLo6fpmfcrxm7/+sMZdYHa3cAaRl
	lTYuZWrjb5rQtysFSnufhD17smjbr9Zod6O8MaB8Un+YnXkUvQCTJjP7wxCo8r0n+rP7Omt
	ETATyyanGMCSnkBeXJDPkdGNQF1RQgjq6q60WhxSBKe90UnQzoh9rQ6lzMDcGqqJm5fJaTq
	T82qGnoMMUZejzj1HUiSxMd5lxp71G2bssZRY5kxGdGRmMmri9sTkshPuxG6SH3lpBNpj3e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4506703939604469898
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 1/2] net/iucv: Avoid explicit cpumask var alloc=
ation on stack
Date: Sun, 31 Mar 2024 13:34:40 +0800
Message-ID: <20240331053441.1276826-2-dawei.li@shingroup.cn>
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
Return-Path: netdev+bounces-83538-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:07.8102
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 7ef23b67-34b2-4e2d-6d56-08dc=
51449ae5
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D17530.414|SMR=3D0.140(SMRDE=3D0.005|SMRC=3D0.=
135(SMRCL=3D0.101|X-SMRCR=3D0.135))|CAT=3D0.081(CATOS=3D0.001
 |CATRESL=3D0.030(CATRESLP2R=3D0.018)|CATORES=3D0.044(CATRS=3D0.044(CATRS-T=
ransport
 Rule Agent=3D0.001 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.041))|CATORT=3D0.003(CATRT=3D0.003(CATRT-Journal Agent=3D0.002
 )))|QDM=3D6662.984|SMSC=3D0.180(X-SMSDR=3D0.011)|SMS=3D1.932(SMSMBXD-INC=
=3D1.860)|QDM=3D10865.222
 |UNK=3D0.001|CAT=3D0.012(CATRESL=3D0.009(CATRESLP2R=3D0.001)|CATORES=3D0.0=
01(CATRS=3D0.001));2024-03-31T10:29:18.270Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8067
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.045|SMR=3D0.011(SMRPI=3D0.008(SMRPI-FrontendProxyAgent=3D0.008))=
|SMS=3D0.035
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AATQFAAAPAAADH4sIAAAAAAAEAI1VW3Ob=
VhA+SAgQNo5rJ2
 3SPnT7kki2kG+J44mbTjyOnfH4kkxT55VBcJCZYFC5yPG0/Xv9Xd09
 gIUknIZBcDi7++337S7o3+XjKIbD9xfHJ++sww+X5wcfT633x8cf/z
 g4PH19C595HPKgB/zLKPAdPwU7CCLHTv0ohMgDZ5Rd28lnQx/bsW8P
 Ag64n6S28xn8BMIohZg70fU1D13uQuKHDgcEcewQf1nCYRSlPEx9O8
 ijDD0a89gLopu+oRv6SZik3HZ7BQ1wIpdDchVlgYtEbuzbBAhkraBh
 IQs4+HDSSbqQRiVVbuiFHcjuY+oo9PyhGfIsjTEz4vQg4PbYD4dVfQ
 laUz68RSxDv6dEgublVzi4bsyTBEULz4/+MOSuGXmeObh9BW/tG+7D
 mQ+/urTqB/6b5ApZxFE26jvhb4ZumqahQ8jTDT9zxuLSd+Bv2N6F9b
 nDLA6M2ALPx244V3Y45FjArT0UnvCYhCWd9W4P9sDlAc+fzS6Rc33P
 A9McUpc3ZlMOZncM3cemfgH7uT3Y3Xrh2Dt8p99/wXde2nsO5wNnAF
 ubm7vPnwsR84iGjozrYN+8AfPF9mbvJaznN9zA4Uh9B8aR7wL5WQlP
 RbWvRx3aRP4Aaxt4vdczm3j+hZQgP8qupeVqH3kVtgKqzqXwwJqK3X
 0qX7m3sQZv/US8DDhMZIZBlkJ6xbEncZKKCRxllh//aRWIfcGdhO9u
 7/W2d2Cd7js7FemUSeih0CgM/JB3sjAR81TSEF2sDXCjm9AaxXxUF/
 Ot9ahMeK2dEGOewmvYnCqI70HnF0FlZKdXVkql6U7M5YGhWRwWsbN8
 nGh023laPPXgqYAbZJ7H47KI3f2aMHythUMHfxhW40rsSnd+PUonab
 rdijbSIL4NVqUMFUbvjj9Yp0e/XxydVcNmtJlHF+/Pj86pZvNlFRL/
 V+Fc1LTCGs95gXf6qPOzbcDxPbTDZyl+3j2aMghsnNmTy8NPwENqnU
 tJ8ok1Z2LvZJ5cfDo426+tA47H/fZhhN9My/Jizq35AftnaqqoPogX
 +3wsnDsXl2dn3f2ZuZtprYiqvHnUrHtUbH47v0nO5HpkOTgnlpeFDn
 1cLfzTGwb8rgPiE9Cp7W5vvhlzh4ijObyxRL9JM37dqwNdpY/nNNtX
 E03VbTHMNbNTYOGN6prXf2NtjT7phr7d337Z36Q9Q2esyWRFYj8wVW
 WaxtoSayhiobOFBmuqrI1rXLSYgld0XmCLd2tctJneYqrGDPRUmCqz
 Fl7xbLKWKrEFpqEbnhJrYojGdFXs4BqTLomk5Mk0TCcSVckYtSBoam
 AKiRmUBaFkwUduSeyRIIaUGmwBTUgGT0lCH9aQQGIM1cmE2aYd1tSl
 B/lmmy3LAg3Xk0AMmnqkIiyypUXJUBhT2OK0VZ16lBSZIVyL8KXGZC
 3qQz4SeyCEIw2ZLdVtriJim2kIq7IVdKg+ioKsqmVl8rPoC4HQoyot
 53mF/OZkzRTRIDlPRwNAHWwLkPadaUWYcjmldaXKQaUWaHnRCkqSIj
 QuNUotGNtijxVJzffxtsg0mSkq09FhVVRDFUq/YxryF1nQutog/oTf
 Eg4I2CIfpRyYNsrUifmPOK4Ke1git76K3JpGRjQQVy2XKcCfCMAnTR
 rjJ1ixpXxm2M8yQRWlkNlyQwxnzhBNy6JcKvupFPuwEvsI2T4WxdRE
 hauBJdWeTG9ES1DF6uWVNAo0SSuhVvJceetRDvVL+j4fs7zRtP4PHj
 FOqCAMAAABCvEBPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0i
 dXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC
 4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFy
 dEluZGV4PSIzOTAiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgIC
 AgPEVtYWlsU3RyaW5nPmRhd2VpLmxpQHNoaW5ncm91cC5jbjwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0
 VtYWlsU2V0PgEMqgQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5n
 PSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250
 YWN0IFN0YXJ0SW5kZXg9IjM4MCIgUG9zaXRpb249IlNpZ25hdHVyZS
 I+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjM4MCIgUG9zaXRp
 b249IlNpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+RG
 F3ZWkgTGk8L1BlcnNvblN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0K
 ICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZX
 g9IjM5MCIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICAgICAg
 PEVtYWlsU3RyaW5nPmRhd2VpLmxpQHNoaW5ncm91cC5jbjwvRW1haW
 xTdHJpbmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWls
 cz4NCiAgICAgIDxDb250YWN0U3RyaW5nPkRhd2VpIExpICZsdDtkYX
 dlaS5saUBzaGluZ3JvdXAuY248L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0Pg
 EOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwyO1JldHJpZXZlck9wZXJh
 dG9yLDExLDI7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDE7UG9zdE
 RvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDEwLDI7UG9zdFdvcmRCcmVha2VyRGlhZ2
 5vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVj ZXIsMjAsMjI=3D
X-MS-Exchange-Forest-IndexAgent: 1 2357
X-MS-Exchange-Forest-EmailMessageHash: 31D07584
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
 net/iucv/iucv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a4ab615ca3e3..5e37a8ceebcb 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -520,7 +520,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
=20
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -628,23 +628,33 @@ static int iucv_cpu_online(unsigned int cpu)
=20
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret =3D 0;
=20
 	if (!iucv_path_table)
 		return 0;
=20
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto __free_cpumask;
+	}
=20
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
=20
 /**
--=20
2.27.0


X-sender: <linux-kernel+bounces-125959-steffen.klassert=3Dsecunet.com@vger.=
kernel.org>
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
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAknAFfe5Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1=
pdENvdW50BwACAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAg=
ABBQBiAAoAZAAAAOyKAAAFAGQADwADAAAASHViBQApAAIAAQ8APwAAAE1pY3Jvc29mdC5FeGNoY=
W5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5NYWlsRGVsaXZlcnlQcmlvcml0eQ8AAwAAAExv=
dw=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13384
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sun, 31 Mar 2024 07:37:14 +0200
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37 via Fronte=
nd
 Transport; Sun, 31 Mar 2024 07:37:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id AA1D120310
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:14 +0200 (CEST)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -2.651
X-Spam-Level:
X-Spam-Status: No, score=3D-2.651 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, HEADER_FROM_DIFFERENT_DOMAINS=3D0.249,
	MAILING_LIST_MULTI=3D-1, RCVD_IN_DNSWL_NONE=3D-0.0001,
	SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7Tz73JS66gbv for <steffen.klassert@secunet.com>;
	Sun, 31 Mar 2024 07:37:13 +0200 (CEST)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125959-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 7034320199
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 7034320199
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 07:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A3E1F212E2
	for <steffen.klassert@secunet.com>; Sun, 31 Mar 2024 05:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6C88BE2;
	Sun, 31 Mar 2024 05:36:54 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9D6FA7;
	Sun, 31 Mar 2024 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D54.207.22.56
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711863413; cv=3Dnone; b=3DRpVDbX2JD0/RlW8D3gN7OWsadmc/olonOAvagvgCKlg=
Ph8iwqleFOAs1g1tsHRmtm5UUYluM5mA1wYn26M5NeINJKyIg90zg4vqzAdudbbmXgcs05AQmoZ=
X3s7pqWOyEbC4QtOoms2WPtUhwcYKE/2gGCjzh8Ce4wGf3gL3KJI8=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711863413; c=3Drelaxed/simple;
	bh=3DcRT3X+uLWIo/WDT/dysE7g0AVNehkJ5rdYqVsI+vjX4=3D;
	h=3DFrom:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=3DsJGQalf5ygsLz6W7crwPcqJPg9D2iGQDLglH0ceLy/J91sAwjpOeLVr=
pyKsKv+GF3c/o5LJ9MTIYYGxWiDZdwZrtpK4DnTjYj/bwd04ljxHUXXks+AJ62V2K+q6ynlRDjw=
UtctZuSI/7xszZJI9mjsIOksy7n6En4OXN4lYeN9g=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dshingroup.cn; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn; arc=3Dnone smtp.client-ip=3D54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dshingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dshingroup.cn
X-QQ-mid: bizesmtp87t1711863353tvqruomb
X-QQ-Originating-IP: dHu89vOsfyXlaQKZF86cBB1XYRxM3aKc0t7f88USl8g=3D
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with=20
	id ; Sun, 31 Mar 2024 13:35:52 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: rZJGTgY0+YOuhoc1+jgTQzFXybo6WpkwHmAznXexq7mNnvmJOrZ22rJCyRlxA
	yv+DUYrg83tauZiFD4e5OeolzNLxCkYZAI3ridWwMnx2JQecfKQBp6G915QB7WwOeONSCAQ
	yiiu0Z+ri/Nw7546cTU5FunYzRvLQVeaNQXN84uh1FHxLo6fpmfcrxm7/+sMZdYHa3cAaRl
	lTYuZWrjb5rQtysFSnufhD17smjbr9Zod6O8MaB8Un+YnXkUvQCTJjP7wxCo8r0n+rP7Omt
	ETATyyanGMCSnkBeXJDPkdGNQF1RQgjq6q60WhxSBKe90UnQzoh9rQ6lzMDcGqqJm5fJaTq
	T82qGnoMMUZejzj1HUiSxMd5lxp71G2bssZRY5kxGdGRmMmri9sTkshPuxG6SH3lpBNpj3e
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4506703939604469898
From: Dawei Li <dawei.li@shingroup.cn>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ioana.ciornei@nxp.com>, <wintera@linux.ibm.com>,
	<twinkler@linux.ibm.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH net-next v2 1/2] net/iucv: Avoid explicit cpumask var alloc=
ation on stack
Date: Sun, 31 Mar 2024 13:34:40 +0800
Message-ID: <20240331053441.1276826-2-dawei.li@shingroup.cn>
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
Return-Path: linux-kernel+bounces-125959-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 31 Mar 2024 05:37:14.7545
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 19b28e6c-dddc-4bb1-ec3c-08dc=
51449f08
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D17528.705|SMR=3D0.326(SMRDE=3D0.005|SMRC=3D0.=
320(SMRCL=3D0.103|X-SMRCR=3D0.319))|CAT=3D0.054(CATOS=3D0.001
 (CATSM=3D0.001)|CATRESL=3D0.013(CATRESLP2R=3D0.005)|CATORES=3D0.036(CATRS=
=3D0.036(CATRS-Transport
 Rule Agent=3D0.001 |CATRS-Index Routing
 Agent=3D0.034))|CATORT=3D0.001)|UNK=3D0.001|QDM=3D6656.202|SMSC=3D0.018
 |SMS=3D1.820(SMSMBXD-INC=3D1.814)|QDM=3D10865.222|CAT=3D0.023(CATRESL=3D0.=
021(CATRESLP2R=3D0.001
 ))|QDM=3D5.124|CAT=3D0.052(CATRESL=3D0.050(CATRESLP2R=3D0.031));2024-03-31=
T10:29:23.461Z
Content-Type: text/plain
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 8075
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
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AATQFAAAPAAADH4sIAAAAAAAEAI1VW3Ob=
VhA+SAgQNo5rJ2
 3SPnT7kki2kG+J44mbTjyOnfH4kkxT55VBcJCZYFC5yPG0/Xv9Xd09
 gIUknIZBcDi7++337S7o3+XjKIbD9xfHJ++sww+X5wcfT633x8cf/z
 g4PH19C595HPKgB/zLKPAdPwU7CCLHTv0ohMgDZ5Rd28lnQx/bsW8P
 Ag64n6S28xn8BMIohZg70fU1D13uQuKHDgcEcewQf1nCYRSlPEx9O8
 ijDD0a89gLopu+oRv6SZik3HZ7BQ1wIpdDchVlgYtEbuzbBAhkraBh
 IQs4+HDSSbqQRiVVbuiFHcjuY+oo9PyhGfIsjTEz4vQg4PbYD4dVfQ
 laUz68RSxDv6dEgublVzi4bsyTBEULz4/+MOSuGXmeObh9BW/tG+7D
 mQ+/urTqB/6b5ApZxFE26jvhb4ZumqahQ8jTDT9zxuLSd+Bv2N6F9b
 nDLA6M2ALPx244V3Y45FjArT0UnvCYhCWd9W4P9sDlAc+fzS6Rc33P
 A9McUpc3ZlMOZncM3cemfgH7uT3Y3Xrh2Dt8p99/wXde2nsO5wNnAF
 ubm7vPnwsR84iGjozrYN+8AfPF9mbvJaznN9zA4Uh9B8aR7wL5WQlP
 RbWvRx3aRP4Aaxt4vdczm3j+hZQgP8qupeVqH3kVtgKqzqXwwJqK3X
 0qX7m3sQZv/US8DDhMZIZBlkJ6xbEncZKKCRxllh//aRWIfcGdhO9u
 7/W2d2Cd7js7FemUSeih0CgM/JB3sjAR81TSEF2sDXCjm9AaxXxUF/
 Ot9ahMeK2dEGOewmvYnCqI70HnF0FlZKdXVkql6U7M5YGhWRwWsbN8
 nGh023laPPXgqYAbZJ7H47KI3f2aMHythUMHfxhW40rsSnd+PUonab
 rdijbSIL4NVqUMFUbvjj9Yp0e/XxydVcNmtJlHF+/Pj86pZvNlFRL/
 V+Fc1LTCGs95gXf6qPOzbcDxPbTDZyl+3j2aMghsnNmTy8NPwENqnU
 tJ8ok1Z2LvZJ5cfDo426+tA47H/fZhhN9My/Jizq35AftnaqqoPogX
 +3wsnDsXl2dn3f2ZuZtprYiqvHnUrHtUbH47v0nO5HpkOTgnlpeFDn
 1cLfzTGwb8rgPiE9Cp7W5vvhlzh4ijObyxRL9JM37dqwNdpY/nNNtX
 E03VbTHMNbNTYOGN6prXf2NtjT7phr7d337Z36Q9Q2esyWRFYj8wVW
 WaxtoSayhiobOFBmuqrI1rXLSYgld0XmCLd2tctJneYqrGDPRUmCqz
 Fl7xbLKWKrEFpqEbnhJrYojGdFXs4BqTLomk5Mk0TCcSVckYtSBoam
 AKiRmUBaFkwUduSeyRIIaUGmwBTUgGT0lCH9aQQGIM1cmE2aYd1tSl
 B/lmmy3LAg3Xk0AMmnqkIiyypUXJUBhT2OK0VZ16lBSZIVyL8KXGZC
 3qQz4SeyCEIw2ZLdVtriJim2kIq7IVdKg+ioKsqmVl8rPoC4HQoyot
 53mF/OZkzRTRIDlPRwNAHWwLkPadaUWYcjmldaXKQaUWaHnRCkqSIj
 QuNUotGNtijxVJzffxtsg0mSkq09FhVVRDFUq/YxryF1nQutog/oTf
 Eg4I2CIfpRyYNsrUifmPOK4Ke1git76K3JpGRjQQVy2XKcCfCMAnTR
 rjJ1ixpXxm2M8yQRWlkNlyQwxnzhBNy6JcKvupFPuwEvsI2T4WxdRE
 hauBJdWeTG9ES1DF6uWVNAo0SSuhVvJceetRDvVL+j4fs7zRtP4PHj
 FOqCAMAAABCvEBPD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0i
 dXRmLTE2Ij8+DQo8RW1haWxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC
 4wPC9WZXJzaW9uPg0KICA8RW1haWxzPg0KICAgIDxFbWFpbCBTdGFy
 dEluZGV4PSIzOTAiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgIC
 AgPEVtYWlsU3RyaW5nPmRhd2VpLmxpQHNoaW5ncm91cC5jbjwvRW1h
 aWxTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0
 VtYWlsU2V0PgEMqgQ8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5n
 PSJ1dGYtMTYiPz4NCjxDb250YWN0U2V0Pg0KICA8VmVyc2lvbj4xNS
 4wLjAuMDwvVmVyc2lvbj4NCiAgPENvbnRhY3RzPg0KICAgIDxDb250
 YWN0IFN0YXJ0SW5kZXg9IjM4MCIgUG9zaXRpb249IlNpZ25hdHVyZS
 I+DQogICAgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjM4MCIgUG9zaXRp
 b249IlNpZ25hdHVyZSI+DQogICAgICAgIDxQZXJzb25TdHJpbmc+RG
 F3ZWkgTGk8L1BlcnNvblN0cmluZz4NCiAgICAgIDwvUGVyc29uPg0K
 ICAgICAgPEVtYWlscz4NCiAgICAgICAgPEVtYWlsIFN0YXJ0SW5kZX
 g9IjM5MCIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICAgICAg
 PEVtYWlsU3RyaW5nPmRhd2VpLmxpQHNoaW5ncm91cC5jbjwvRW1haW
 xTdHJpbmc+DQogICAgICAgIDwvRW1haWw+DQogICAgICA8L0VtYWls
 cz4NCiAgICAgIDxDb250YWN0U3RyaW5nPkRhd2VpIExpICZsdDtkYX
 dlaS5saUBzaGluZ3JvdXAuY248L0NvbnRhY3RTdHJpbmc+DQogICAg
 PC9Db250YWN0Pg0KICA8L0NvbnRhY3RzPg0KPC9Db250YWN0U2V0Pg
 EOzwFSZXRyaWV2ZXJPcGVyYXRvciwxMCwyO1JldHJpZXZlck9wZXJh
 dG9yLDExLDE7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG9zdE
 RvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2VyRGlh
 Z25vc3RpY09wZXJhdG9yLDEwLDE7UG9zdFdvcmRCcmVha2VyRGlhZ2
 5vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJvZHVj ZXIsMjAsMTc=3D
X-MS-Exchange-Forest-IndexAgent: 1 2357
X-MS-Exchange-Forest-EmailMessageHash: 31D07584
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent
X-MS-Exchange-Organization-Transport-Properties: DeliveryPriority=3DLow
X-MS-Exchange-Organization-Prioritization: 2:RC:REDACTED-af51df60fd698f80b0=
64826f9ee192ca@secunet.com:42/10|SR
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
 net/iucv/iucv.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index a4ab615ca3e3..5e37a8ceebcb 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -520,7 +520,7 @@ static void iucv_setmask_mp(void)
  */
 static void iucv_setmask_up(void)
 {
-	cpumask_t cpumask;
+	static cpumask_t cpumask;
 	int cpu;
=20
 	/* Disable all cpu but the first in cpu_irq_cpumask. */
@@ -628,23 +628,33 @@ static int iucv_cpu_online(unsigned int cpu)
=20
 static int iucv_cpu_down_prep(unsigned int cpu)
 {
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
+	int ret =3D 0;
=20
 	if (!iucv_path_table)
 		return 0;
=20
-	cpumask_copy(&cpumask, &iucv_buffer_cpumask);
-	cpumask_clear_cpu(cpu, &cpumask);
-	if (cpumask_empty(&cpumask))
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_copy(cpumask, &iucv_buffer_cpumask);
+	cpumask_clear_cpu(cpu, cpumask);
+	if (cpumask_empty(cpumask)) {
 		/* Can't offline last IUCV enabled cpu. */
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto __free_cpumask;
+	}
=20
 	iucv_retrieve_cpu(NULL);
 	if (!cpumask_empty(&iucv_irq_cpumask))
-		return 0;
+		goto __free_cpumask;
+
 	smp_call_function_single(cpumask_first(&iucv_buffer_cpumask),
 				 iucv_allow_cpu, NULL, 1);
-	return 0;
+
+__free_cpumask:
+	free_cpumask_var(cpumask);
+	return ret;
 }
=20
 /**
--=20
2.27.0



