Return-Path: <linux-kernel+bounces-126102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAEE893232
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A51282811
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67983145B3B;
	Sun, 31 Mar 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8dykE3"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9150145B09;
	Sun, 31 Mar 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900923; cv=fail; b=DcN/mb9Iveqjz8J4uaWYiywTf05UFpnSluEDyCWeOdZVUQYLkGo+rqgYUES9yqX5alc8doxdniGSjvoRQgd0j1Ncu+YfPoCnqBEei3KbFhbT8EPpbCl9HwnDS/tk4E7yrcTjo4+LkPSlhNegIV7qkcKhl2DeePjj/bkpwwwh1a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900923; c=relaxed/simple;
	bh=FsoBp1MCh5EYkQo9TQVIgBH7tRFAGLmidfsHYr5sz+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwJDLqvxQj+qk4b9JC9F8EBbNx5SZVP+A9XxFoJH296qL8JD6k3Q5fKw63xf3WRnMfjGu+yoYprQbbmPV1/xUInYev00fHxAj69H0dvkdj+j9C4FYRWzfU14oiefzakpD66kOj3rCdGfrqpPu/rDpHRBkkmaOJ2lAfXVwHdC0X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3 reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 00E342067F;
	Sun, 31 Mar 2024 18:01:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGRPaYipPao9; Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B75E220612;
	Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B75E220612
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id A9E6280004A;
	Sun, 31 Mar 2024 18:01:57 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:01:57 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:41 +0000
X-sender: <netdev+bounces-83469-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAvgxrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgCxAAAAy4oAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 8873
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83469-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com ED91620883
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749319; cv=none; b=XVQFfHeE9c0xnyYx07Syowd5TeLXf3pto5rmG1SsHR7H+7AOzfy4pspo9LNKbgLlZFu9KQybTmplG3h69Cegz7JISgOhrER2TsLV7W3vzMOiXj2onDyVxSLJsB/Qki+wTDKdSxSYjsLsMCEiRZOGxrKZplOoqofXF/YJUuJMwiY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749319; c=relaxed/simple;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIQ99dvb6UMV/aWTov9pUyTkMiTogmsGmcvwczu67NkrjPWL8dg5sp9t1PCUVSj5xTeqZ7n4cIap9pbON1zNasJv3lQ0K72dJFPSLEOA5XhVLMjRS30kIGcFqD5niDdQ4EzDBrWDioiwpKdq1Sr9iUGnZUWvslbiA8ACObaUw1Y=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749319;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+8dykE3YQdY+53+8POC4U17NyrlajsaBHru/9ULCn8ZmHHgjv6YhubjUAVssnGn7
	 9gdfmdlrdeqSQsdEs+TqJXpADkQZZWLiOO7dIaOZAI7dbu8yKWvYHv6WrRT6ZFQrHx
	 D/I4ma82Tn/VN/p7+hO9u5INnF4+b8tIolpHEl+k6HT9IOMlPWENg0c8cYK4L74bN1
	 22isDn6kmwlgOHnzWF08arFawoiHlUdA+oSLOonYtrVg5dFp6q4KgleAb+oSYoBcyL
	 DbMiAYDpwjVwkCZeC4eL0eUpVpoM7rVsfxekupwlZuXqR+EUguXEzifK4bFgeg2yRW
	 Scvby6W1H5WyA==
Date: Fri, 29 Mar 2024 14:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
Message-ID: <20240329145517.7b46a15a@kernel.org>
In-Reply-To: <20240327054234.1906957-3-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-3-c-vankar@ti.com>
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

On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.

Is there a reason this is not part of the previous patch?

X-sender: <linux-kernel+bounces-125463-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAvgxrGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKALMAAADLigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 8966
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-01.secunet.de (10.53.40.197) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 22:56:35 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 22:56:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 22BFC2032C
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:56:35 +0100 (CET)
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
	with ESMTP id 4CSTfgpjVr81 for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 22:56:34 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125463-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 53C7A200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"i+8dykE3"
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 53C7A200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8DE283430
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA6513E3E6;
	Fri, 29 Mar 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"i+8dykE3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AC28DCA;
	Fri, 29 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711749319; cv=3Dnone; b=3DXVQFfHeE9c0xnyYx07Syowd5TeLXf3pto5rmG1SsHR7=
H+7AOzfy4pspo9LNKbgLlZFu9KQybTmplG3h69Cegz7JISgOhrER2TsLV7W3vzMOiXj2onDyVxS=
LJsB/Qki+wTDKdSxSYjsLsMCEiRZOGxrKZplOoqofXF/YJUuJMwiY=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711749319; c=3Drelaxed/simple;
	bh=3D+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3DOIQ99dvb6UMV/aWTov9pUyTkMiTogmsGmcvwczu67N=
krjPWL8dg5sp9t1PCUVSj5xTeqZ7n4cIap9pbON1zNasJv3lQ0K72dJFPSLEOA5XhVLMjRS30kI=
GcFqD5niDdQ4EzDBrWDioiwpKdq1Sr9iUGnZUWvslbiA8ACObaUw1Y=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3Di+8dyk=
E3; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F4C433C7;
	Fri, 29 Mar 2024 21:55:18 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711749319;
	bh=3D+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3Di+8dykE3YQdY+53+8POC4U17NyrlajsaBHru/9ULCn8ZmHHgjv6YhubjUAVssnGn7
	 9gdfmdlrdeqSQsdEs+TqJXpADkQZZWLiOO7dIaOZAI7dbu8yKWvYHv6WrRT6ZFQrHx
	 D/I4ma82Tn/VN/p7+hO9u5INnF4+b8tIolpHEl+k6HT9IOMlPWENg0c8cYK4L74bN1
	 22isDn6kmwlgOHnzWF08arFawoiHlUdA+oSLOonYtrVg5dFp6q4KgleAb+oSYoBcyL
	 DbMiAYDpwjVwkCZeC4eL0eUpVpoM7rVsfxekupwlZuXqR+EUguXEzifK4bFgeg2yRW
	 Scvby6W1H5WyA=3D=3D
Date: Fri, 29 Mar 2024 14:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heine=
r
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
Message-ID: <20240329145517.7b46a15a@kernel.org>
In-Reply-To: <20240327054234.1906957-3-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-3-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125463-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 21:56:35.2063
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: c2c7b326-bc0f-40b8-bb46-08dc=
503b1a2b
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-01.secunet.de:TOTAL-HUB=3D0.369|SMR=3D0.326(SMRDE=3D0.004|SMRC=3D0.321(=
SMRCL=3D0.104|X-SMRCR=3D0.322))|CAT=3D0.041(CATRESL=3D0.023
 (CATRESLP2R=3D0.018)|CATORES=3D0.015(CATRS=3D0.015(CATRS-Index Routing
 Agent=3D0.014)));2024-03-29T21:56:35.594Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 6819
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D16.003|SMR=3D0.015(SMRPI=3D0.008(SMRPI-FrontendProxyAgent=3D0.008)=
)|SMS=3D0.003
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-01
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AARMBAAAPAAADH4sIAAAAAAAEADWMQUvD=
QBCFZ9Nsm0SDgn
 9gbh4USdKKkIM99ORBFER7LGuzMYvp7rK7afVX+pecWIThMfPme++H
 PWlcy+Yaqzt8FA6rolpgWdZlVc8XeFXczgtcdUoHofFN6E9CDs4EWe
 fZPb7aRgSJfrDWuCAb7A7BB7GzG/e1aVUfpPO4F/0gPbbG4er5ZX3p
 Maid/MOU/hhrtsKKd9Wr8H2TZ3n2QEQnnUSBTgpvNJ3KI402Aa1wAU
 07Imid3CszeDLDtluOYYAIJhPgEYMTmnGPY8YTBglAwlIOwGE6g2QK
 Mw4ZaQoZfS8gpeDRpwjpKZxncEYm8QwicmKqPRb+Lwmk/BdckThUQw
 EAAAEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwyO1JldHJpZXZlck9w
 ZXJhdG9yLDExLDI7UG9zdERvY1BhcnNlck9wZXJhdG9yLDEwLDA7UG
 9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRCcmVha2Vy
 RGlhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcmVha2VyRG
 lhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3JpdGVyUHJv ZHVjZXIsMjAsNQ=3D=
=3D
X-MS-Exchange-Forest-IndexAgent: 1 496
X-MS-Exchange-Forest-EmailMessageHash: CE720195
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.

Is there a reason this is not part of the previous patch?


