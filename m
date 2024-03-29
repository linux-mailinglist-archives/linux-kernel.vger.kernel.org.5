Return-Path: <linux-kernel+bounces-126216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DB18933D2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86441C224C5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579E15573F;
	Sun, 31 Mar 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt5XZQ8A"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5CB154422;
	Sun, 31 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903206; cv=fail; b=S7MqymfmvQGLPRNyVUFbk2jGUfzEXGCyi0mPSxcjqhPsluGx33GVz5LiX+8rDsFal09cn7NJ3RpkcjrSvn1TPeABcKvFWEFKwlqeNuloMxt7XAdb+tCkzI8xNruHggypaVu1JHILLrP6tqUTxeb3WMhqcNjz9c318EXwqBV7oec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903206; c=relaxed/simple;
	bh=8G+9T43jI3yvjQOfIREuD3iIzpxYF2FzcY1pUJg5BKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJagrkQJZepshpKemeoj6BqTa10KkQA0UDB8OQdktFjoNtUAAQzF0L9H/+eZs+WEDqsFqzoVImGbVWb0CcquUGW9P48wMPWy/rTSIO0tBTzEkm07Qc1wh8oiFpU/bLbt4lBL0arEc3bIHm5pH8mdWfJxlzRzgkZ7yKv1b7eROMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt5XZQ8A reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 879AC208B4;
	Sun, 31 Mar 2024 18:40:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hpjrUeRVGx0e; Sun, 31 Mar 2024 18:40:00 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D10F02087B;
	Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D10F02087B
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id C440480004A;
	Sun, 31 Mar 2024 18:39:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:39:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:16 +0000
X-sender: <netdev+bounces-83461-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAbUamlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgDKAAAAy4oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11175
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83461-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 58E0D20885
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711745626; cv=none; b=CVPCGk9LD0NbPjQV8T2NNphifh6hmBZaegACNK3HaX/lTWENaRN6Fdlf4knmT1jZjTtE/cxgVHj9nX5tC5bpS5XTf8CDbYoJ8g3k8LTz7UeL48U8g6RJk1nD/BJIk/d7y/S9r0GuQb3dVmwVSdggts92/Fgf7pXeAN/MxmrFpa4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711745626; c=relaxed/simple;
	bh=DPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/YgEleA7dhqMltk+cpaDAI5CB6Lxj8GtF3ftBqkh9p0yRW9z2he+RRe91fZHBJ+LqVhIsvHLMH0FT77gqRr4dYhRzsYZMFuBhQLc59ydGn2GoVeT3YNhGEpWwsNRFQlNo3N0K05H4mJRNmROttjq61J8Xwbz+5tyOFWqpx1HK4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt5XZQ8A; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711745625;
	bh=DPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nt5XZQ8AuFdzkpc2dRk4glfwOAVOcm1EdgvmJH132ePhRwjx5yZG7K5MDJf7XEaXf
	 DNUmTCxPOgEyg82a0x+w/HjPxm0ksMkeaCOMP/vZCOd9Xzx3wgYHLnO9JCshz15SQT
	 rMXaDnaBpPXSvZDu8fKKgkDjwpyBmbuvSAJQVLwDGgLMXs4WbAgKj4Swf1TEL7R6BY
	 7WPgwSohXsmR/Hlvjyyvl3pMa00trccpz/7FsrFsTzXSAyPZ+F+H/We6eRrIqvKQTE
	 Nt2XqeSYRkKbZraS9gxLxNtOsHaK4zygIPknpsWEa2Jr/9wVwM+l4r1fJB94AFXUB9
	 5iFtrKKt4p58Q==
Date: Fri, 29 Mar 2024 13:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329135344.1a310f31@kernel.org>
In-Reply-To: <20240329131857.730c6528@kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
	<20240329131857.730c6528@kernel.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
> > Sparse:
> >=20
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_=
res' shadows an earlier one
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declare=
d here =20
>=20
> I don't see these building with LLVM=3D1 W=3D12 C=3D1
> and I really don't like complicating the code because the compiler
> is stupid. Can't you solve this with some renames? Add another
> underscore or something?

I'm stupid I tried on the test branch which already had your fix..

This is enough:

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..2270fbb99cf7 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -89,7 +89,7 @@ struct netdev_stat_ops {
=20
 #define netif_txq_try_stop(txq, get_desc, start_thrs)			\
 	({								\
-		int _res;						\
+		int __res;						\
 									\
 		netif_tx_stop_queue(txq);				\
 		/* Producer index and stop bit must be visible		\
@@ -101,12 +101,12 @@ struct netdev_stat_ops {
 		/* We need to check again in a case another		\
 		 * CPU has just made room available.			\
 		 */							\
-		_res =3D 0;						\
+		__res =3D 0;						\
 		if (unlikely(get_desc >=3D start_thrs)) {			\
 			netif_tx_start_queue(txq);			\
-			_res =3D -1;					\
+			__res =3D -1;					\
 		}							\
-		_res;							\
+		__res;							\
 	})								\
=20
 /**

X-sender: <netdev+bounces-83461-steffen.klassert=3Dsecunet.com@vger.kernel.=
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
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAbUamlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAMsAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 11324
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:53:57 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:53:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id EF6BB2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:53:56 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=3D-5.399 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dham autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqhsOYZd3Ue1 for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:53:56 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83461-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 18C0E20270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"nt5XZQ8A"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 18C0E20270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF532847D8
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634AF86130;
	Fri, 29 Mar 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"nt5XZQ8A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB043FBB4;
	Fri, 29 Mar 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711745626; cv=3Dnone; b=3DCVPCGk9LD0NbPjQV8T2NNphifh6hmBZaegACNK3HaX/=
lTWENaRN6Fdlf4knmT1jZjTtE/cxgVHj9nX5tC5bpS5XTf8CDbYoJ8g3k8LTz7UeL48U8g6RJk1=
nD/BJIk/d7y/S9r0GuQb3dVmwVSdggts92/Fgf7pXeAN/MxmrFpa4=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711745626; c=3Drelaxed/simple;
	bh=3DDPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3Dp/YgEleA7dhqMltk+cpaDAI5CB6Lxj8GtF3ftBqkh9=
p0yRW9z2he+RRe91fZHBJ+LqVhIsvHLMH0FT77gqRr4dYhRzsYZMFuBhQLc59ydGn2GoVeT3YNh=
GEpWwsNRFQlNo3N0K05H4mJRNmROttjq61J8Xwbz+5tyOFWqpx1HK4=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3Dnt5XZQ=
8A; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A95C433C7;
	Fri, 29 Mar 2024 20:53:45 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711745625;
	bh=3DDPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3Dnt5XZQ8AuFdzkpc2dRk4glfwOAVOcm1EdgvmJH132ePhRwjx5yZG7K5MDJf7XEaXf
	 DNUmTCxPOgEyg82a0x+w/HjPxm0ksMkeaCOMP/vZCOd9Xzx3wgYHLnO9JCshz15SQT
	 rMXaDnaBpPXSvZDu8fKKgkDjwpyBmbuvSAJQVLwDGgLMXs4WbAgKj4Swf1TEL7R6BY
	 7WPgwSohXsmR/Hlvjyyvl3pMa00trccpz/7FsrFsTzXSAyPZ+F+H/We6eRrIqvKQTE
	 Nt2XqeSYRkKbZraS9gxLxNtOsHaK4zygIPknpsWEa2Jr/9wVwM+l4r1fJB94AFXUB9
	 5iFtrKKt4p58Q=3D=3D
Date: Fri, 29 Mar 2024 13:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329135344.1a310f31@kernel.org>
In-Reply-To: <20240329131857.730c6528@kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
	<20240329131857.730c6528@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: netdev+bounces-83461-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:53:57.0213
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: adfa49c9-4e8d-4796-70e9-08dc=
50325a1d
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.369|SMR=3D0.323(SMRDE=3D0.004|SMRC=3D0.318(=
SMRCL=3D0.104|X-SMRCR=3D0.317))|CAT=3D0.045(CATOS=3D0.001
 |CATRESL=3D0.010(CATRESLP2R=3D0.005)|CATORES=3D0.029(CATRS=3D0.029(CATRS-T=
ransport
 Rule Agent=3D0.001 |CATRS-Index Routing
 Agent=3D0.027))|CATORT=3D0.001(CATRT=3D0.001));2024-03-29T20:53:57.405Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7888
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.014|SMR=3D0.004(SMRPI=3D0.002(SMRPI-FrontendProxyAgent=3D0.002))=
|SMS=3D0.009
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXEEAAAPAAADH4sIAAAAAAAEAK1UW2/b=
NhSmLFm+xO6AtM
 CAPR1gD0ns+CLHqWMPSTsECNAtxQrs0pcCBi3RNhdZcknKjlHkea/7
 N/t7O6TsNF2E3DpClqnDc77zfYeH/Gf7lwjOBN+HTh/eUgGddqcL3s
 HAOxoc9qDR7rXb8BO9SEbwM/d5JC84LEWs2KBaPoET+HVOhVx/pJZA
 8AUTshUx1WJqyoSe8EixsMWD+di8hupSXDb9gdfvdwbeywEsqYh4NB
 mAXM1GcQg7Q8HkDsgpDeKlBBoBoyLkTEAcsa/IEws+4RENwxUEzA+p
 YAFgqIbUqG8giKMdBZIxQEjJYJTwMEBmsORqCufnf7w99uD9sdeB02
 NPh9AowDDBUkwTHfILBn48m4fcp0oHIxYaAoRjPk0kWxtmcx4yoVG4
 BKmSOQ+acEo1xipOQMbhQrviosku4xnDTBGdMfkKfgwCTB5r5RohiQ
 Kshh8LhiKNKwZGk1fVcrX8Zme2hkeqSnAUHUeGg2JSwUjQyJ/Ccsrx
 TUPUEqwAK69JCBjzy2ZTo/ymieDDojiZTAfaFPDxGBqNCVdAsfZ+mA
 TMbAj+ArYYfkxYwmRzCqO7VqtljuQvwWN+t310eHR40DtoNjudXns8
 GvX7/rgHXrv9stutlhuNxt2ZquV6vX5futevoXHU3+9B3bzxUyqR+A
 rWnlJRNYznEj5pkfB9wMY8YnqV65b6OFRihU7xfBc/9mHC1DBg0t9H
 GCrUUE2F3INb4wNCrcfup9vLjxkI1fiPCTsf9KH54fFQ9SyoJ2DdEP
 i1IwNqU31T+HQzdfn37iOZAdWqwTsRB4mP90naevoUa1wYYSvPEn0o
 GCy45KOQfQGlW8dre/t4AdTX/3e2T0bq97qT8AiqGPwp8y+ATiiPkA
 hQ8CleDutTfZ8KqMHpu9/xoEr4UzOeUbxgRBzPgC4oDylSbz6wIFBr
 3VPF7JHRh7pv4Bja/0MfDp+IlSGQj2E3ifTFHK52N+cVTo5vntg9uH
 0q72jpG/2oIe5tyIxabcZaZ8N7oNCMWl1DPRIrQ+DVw0hkQWU1w2Mb
 YQ2V2QxPwLoh8CrjUn4kFIK1ajX9T0iO2DbJ5yyyhY+eO46VLxJStE
 p5QvLExadIcF5xyXaBFNHBfLoOyTsWKeGb5C0r5xCCgTkN6BRIySUl
 hEV/xDdRpQfGlskW+jiaTg49MSQlYELyFiFoxxDjbOPEWPLohnaXFF
 LwCqlqIYaASVpBZ5cUrwEdk9o4IE8kvIV50adEnuEn4qTZc2lBSD5F
 TtEcnU7zMZhbDimk2dNV1yJVUkgRsow24lTIs4pVdQlxSSXLp5BhtJ
 A5Cna0Xiv3eW64ods3pGCIbWmqFtk2Sjds87ZFinru4lJZy0+0kZzZ
 2u1vXdfnRi16mxoN0n3axDup2oL17eetsuwb2+Z+SeK7FCpn1KZ1RE
 mm3LVrWulTIle25RolZ5vJac40yoZ0cUO6i5MXBi2FtUkPQwyBs83k
 L8sm5/a/2OuiUhEMAAABDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAsMT
 tSZXRyaWV2ZXJPcGVyYXRvciwxMSwxO1Bvc3REb2NQYXJzZXJPcGVy
 YXRvciwxMCwwO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bvc3
 RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwxO1Bvc3RX
 b3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5zcG
 9ydFdyaXRlclByb2R1Y2VyLDIwLDE2
X-MS-Exchange-Forest-IndexAgent: 1 1359
X-MS-Exchange-Forest-EmailMessageHash: 5D566706
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
> > Sparse:
> >=20
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_=
res' shadows an earlier one
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declare=
d here =20
>=20
> I don't see these building with LLVM=3D1 W=3D12 C=3D1
> and I really don't like complicating the code because the compiler
> is stupid. Can't you solve this with some renames? Add another
> underscore or something?

I'm stupid I tried on the test branch which already had your fix..

This is enough:

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..2270fbb99cf7 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -89,7 +89,7 @@ struct netdev_stat_ops {
=20
 #define netif_txq_try_stop(txq, get_desc, start_thrs)			\
 	({								\
-		int _res;						\
+		int __res;						\
 									\
 		netif_tx_stop_queue(txq);				\
 		/* Producer index and stop bit must be visible		\
@@ -101,12 +101,12 @@ struct netdev_stat_ops {
 		/* We need to check again in a case another		\
 		 * CPU has just made room available.			\
 		 */							\
-		_res =3D 0;						\
+		__res =3D 0;						\
 		if (unlikely(get_desc >=3D start_thrs)) {			\
 			netif_tx_start_queue(txq);			\
-			_res =3D -1;					\
+			__res =3D -1;					\
 		}							\
-		_res;							\
+		__res;							\
 	})								\
=20
 /**

X-sender: <linux-kernel+bounces-125414-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAbUamlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAM0AAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 11325
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 21:54:14 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 21:54:14 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 5E26F2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:54:14 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -3.099
X-Spam-Level:
X-Spam-Status: No, score=3D-3.099 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_NONE=3D-0.0001, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mtnP-P3F68RA for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 21:54:09 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.48.161; helo=3Dsy.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125414-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 49DBA20270
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"nt5XZQ8A"
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 49DBA20270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C98B21EC3
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910013B59A;
	Fri, 29 Mar 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"nt5XZQ8A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB043FBB4;
	Fri, 29 Mar 2024 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711745626; cv=3Dnone; b=3DCVPCGk9LD0NbPjQV8T2NNphifh6hmBZaegACNK3HaX/=
lTWENaRN6Fdlf4knmT1jZjTtE/cxgVHj9nX5tC5bpS5XTf8CDbYoJ8g3k8LTz7UeL48U8g6RJk1=
nD/BJIk/d7y/S9r0GuQb3dVmwVSdggts92/Fgf7pXeAN/MxmrFpa4=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711745626; c=3Drelaxed/simple;
	bh=3DDPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3Dp/YgEleA7dhqMltk+cpaDAI5CB6Lxj8GtF3ftBqkh9=
p0yRW9z2he+RRe91fZHBJ+LqVhIsvHLMH0FT77gqRr4dYhRzsYZMFuBhQLc59ydGn2GoVeT3YNh=
GEpWwsNRFQlNo3N0K05H4mJRNmROttjq61J8Xwbz+5tyOFWqpx1HK4=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3Dnt5XZQ=
8A; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A95C433C7;
	Fri, 29 Mar 2024 20:53:45 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711745625;
	bh=3DDPU/cpMX8JgPzOh54Wy5Z1joAaXrPLw4+pp0/2XrYwo=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3Dnt5XZQ8AuFdzkpc2dRk4glfwOAVOcm1EdgvmJH132ePhRwjx5yZG7K5MDJf7XEaXf
	 DNUmTCxPOgEyg82a0x+w/HjPxm0ksMkeaCOMP/vZCOd9Xzx3wgYHLnO9JCshz15SQT
	 rMXaDnaBpPXSvZDu8fKKgkDjwpyBmbuvSAJQVLwDGgLMXs4WbAgKj4Swf1TEL7R6BY
	 7WPgwSohXsmR/Hlvjyyvl3pMa00trccpz/7FsrFsTzXSAyPZ+F+H/We6eRrIqvKQTE
	 Nt2XqeSYRkKbZraS9gxLxNtOsHaK4zygIPknpsWEa2Jr/9wVwM+l4r1fJB94AFXUB9
	 5iFtrKKt4p58Q=3D=3D
Date: Fri, 29 Mar 2024 13:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dmitry Safonov
 <0x7f454c46@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdev_queues: fix -Wshadow / Sparse
 shadow warnings throughout the file
Message-ID: <20240329135344.1a310f31@kernel.org>
In-Reply-To: <20240329131857.730c6528@kernel.org>
References: <20240329170000.3241460-1-aleksander.lobakin@intel.com>
	<20240329170000.3241460-3-aleksander.lobakin@intel.com>
	<20240329131857.730c6528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125414-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 20:54:14.4167
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 7b3221dc-8701-4ced-c3c0-08dc=
5032647b
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.374|SMR=3D0.322(SMRDE=3D0.004|SMRC=3D0.317(=
SMRCL=3D0.102|X-SMRCR=3D0.316))|CAT=3D0.050(CATOS=3D0.001
 |CATRESL=3D0.008(CATRESLP2R=3D0.003)|CATORES=3D0.037(CATRS=3D0.037(CATRS-T=
ransport
 Rule Agent=3D0.002 (X-ETREX=3D0.001)|CATRS-Index Routing
 Agent=3D0.033)));2024-03-29T20:54:14.813Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7902
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.023|SMR=3D0.012(SMRPI=3D0.009(SMRPI-FrontendProxyAgent=3D0.009))=
|SMS=3D0.011
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAXEEAAAPAAADH4sIAAAAAAAEAK1UW2/b=
NhSmLFm+xO6AtM
 CAPR1gD0ns+CLHqWMPSTsECNAtxQrs0pcCBi3RNhdZcknKjlHkea/7
 N/t7O6TsNF2E3DpClqnDc77zfYeH/Gf7lwjOBN+HTh/eUgGddqcL3s
 HAOxoc9qDR7rXb8BO9SEbwM/d5JC84LEWs2KBaPoET+HVOhVx/pJZA
 8AUTshUx1WJqyoSe8EixsMWD+di8hupSXDb9gdfvdwbeywEsqYh4NB
 mAXM1GcQg7Q8HkDsgpDeKlBBoBoyLkTEAcsa/IEws+4RENwxUEzA+p
 YAFgqIbUqG8giKMdBZIxQEjJYJTwMEBmsORqCufnf7w99uD9sdeB02
 NPh9AowDDBUkwTHfILBn48m4fcp0oHIxYaAoRjPk0kWxtmcx4yoVG4
 BKmSOQ+acEo1xipOQMbhQrviosku4xnDTBGdMfkKfgwCTB5r5RohiQ
 Kshh8LhiKNKwZGk1fVcrX8Zme2hkeqSnAUHUeGg2JSwUjQyJ/Ccsrx
 TUPUEqwAK69JCBjzy2ZTo/ymieDDojiZTAfaFPDxGBqNCVdAsfZ+mA
 TMbAj+ArYYfkxYwmRzCqO7VqtljuQvwWN+t310eHR40DtoNjudXns8
 GvX7/rgHXrv9stutlhuNxt2ZquV6vX5futevoXHU3+9B3bzxUyqR+A
 rWnlJRNYznEj5pkfB9wMY8YnqV65b6OFRihU7xfBc/9mHC1DBg0t9H
 GCrUUE2F3INb4wNCrcfup9vLjxkI1fiPCTsf9KH54fFQ9SyoJ2DdEP
 i1IwNqU31T+HQzdfn37iOZAdWqwTsRB4mP90naevoUa1wYYSvPEn0o
 GCy45KOQfQGlW8dre/t4AdTX/3e2T0bq97qT8AiqGPwp8y+ATiiPkA
 hQ8CleDutTfZ8KqMHpu9/xoEr4UzOeUbxgRBzPgC4oDylSbz6wIFBr
 3VPF7JHRh7pv4Bja/0MfDp+IlSGQj2E3ifTFHK52N+cVTo5vntg9uH
 0q72jpG/2oIe5tyIxabcZaZ8N7oNCMWl1DPRIrQ+DVw0hkQWU1w2Mb
 YQ2V2QxPwLoh8CrjUn4kFIK1ajX9T0iO2DbJ5yyyhY+eO46VLxJStE
 p5QvLExadIcF5xyXaBFNHBfLoOyTsWKeGb5C0r5xCCgTkN6BRIySUl
 hEV/xDdRpQfGlskW+jiaTg49MSQlYELyFiFoxxDjbOPEWPLohnaXFF
 LwCqlqIYaASVpBZ5cUrwEdk9o4IE8kvIV50adEnuEn4qTZc2lBSD5F
 TtEcnU7zMZhbDimk2dNV1yJVUkgRsow24lTIs4pVdQlxSSXLp5BhtJ
 A5Cna0Xiv3eW64ods3pGCIbWmqFtk2Sjds87ZFinru4lJZy0+0kZzZ
 2u1vXdfnRi16mxoN0n3axDup2oL17eetsuwb2+Z+SeK7FCpn1KZ1RE
 mm3LVrWulTIle25RolZ5vJac40yoZ0cUO6i5MXBi2FtUkPQwyBs83k
 L8sm5/a/2OuiUhEMAAABDs8BUmV0cmlldmVyT3BlcmF0b3IsMTAsMT
 tSZXRyaWV2ZXJPcGVyYXRvciwxMSwzO1Bvc3REb2NQYXJzZXJPcGVy
 YXRvciwxMCwxO1Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMSwwO1Bvc3
 RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMCwxO1Bvc3RX
 b3JkQnJlYWtlckRpYWdub3N0aWNPcGVyYXRvciwxMSwwO1RyYW5zcG
 9ydFdyaXRlclByb2R1Y2VyLDIwLDE4
X-MS-Exchange-Forest-IndexAgent: 1 1359
X-MS-Exchange-Forest-EmailMessageHash: 5D566706
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, 29 Mar 2024 13:18:57 -0700 Jakub Kicinski wrote:
> > Sparse:
> >=20
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: warning: symbol '_=
res' shadows an earlier one
> > drivers/net/ethernet/intel/idpf/idpf_txrx.c:1992:16: originally declare=
d here =20
>=20
> I don't see these building with LLVM=3D1 W=3D12 C=3D1
> and I really don't like complicating the code because the compiler
> is stupid. Can't you solve this with some renames? Add another
> underscore or something?

I'm stupid I tried on the test branch which already had your fix..

This is enough:

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 1ec408585373..2270fbb99cf7 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -89,7 +89,7 @@ struct netdev_stat_ops {
=20
 #define netif_txq_try_stop(txq, get_desc, start_thrs)			\
 	({								\
-		int _res;						\
+		int __res;						\
 									\
 		netif_tx_stop_queue(txq);				\
 		/* Producer index and stop bit must be visible		\
@@ -101,12 +101,12 @@ struct netdev_stat_ops {
 		/* We need to check again in a case another		\
 		 * CPU has just made room available.			\
 		 */							\
-		_res =3D 0;						\
+		__res =3D 0;						\
 		if (unlikely(get_desc >=3D start_thrs)) {			\
 			netif_tx_start_queue(txq);			\
-			_res =3D -1;					\
+			__res =3D -1;					\
 		}							\
-		_res;							\
+		__res;							\
 	})								\
=20
 /**


