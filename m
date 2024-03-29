Return-Path: <linux-kernel+bounces-126204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1898933AB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA281F2041A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B172314B064;
	Sun, 31 Mar 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QriMG5bP"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F614D434;
	Sun, 31 Mar 2024 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903112; cv=fail; b=ey/4ANJgikqEQ2zYgyWIiDiAH8zJC5kq1xWwBMnnPs5LgUSOdYAvKy2EZrSIxep0jZAIljfxG6fxckYLnRw/6aFYJ9Il/qqFkC5EE3OJa5Mz0oDYLMtJymFMEQuVD7l77FMk4tboxO5sYvOVPPhp2maxdWzpv0TaDtstnHoSPM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903112; c=relaxed/simple;
	bh=zeKKmfiPhv7ZDxdmh8DHrc6KvFoCLxDqV++HNXxHp7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-ID:Date:References:
	 In-Reply-To:To:Cc; b=N+8ahLCXxvT6WO2zirLbLOrSO8HjY85Q0SQG8hAf+6012WbFIjgB6oPBr9JrbQxkO5rYxt9HOAHqGifBMW6pRBmra4uUn0chAzRZ0vXdGm4SKvfOBwBhD4/OqSyBnYcWOzWRdAXEne+JCA6NTf1v08MQ1/nC4lV+0471qol0IeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QriMG5bP reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D3E9B2083E;
	Sun, 31 Mar 2024 18:38:27 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mv0wT67bn7g9; Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7CDC0207BB;
	Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7CDC0207BB
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 6EBCF800050;
	Sun, 31 Mar 2024 18:38:24 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:38:24 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:17 +0000
X-sender: <netdev+bounces-83482-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAWUmmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGgAAAHBldGVyLnNjaHVtYW5uQHNlY3VuZXQuY29tBQAGAAIAAQUAKQACAAEPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgBkAAAAzYoAAAUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12131
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83482-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 9D6E3200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QriMG5bP"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752631; cv=none; b=eLispVzL4Rucdj5yrzfRgnSRePLp+Y1FD2BRZyUX76ykzaZw7VHi9YXASU31baAxoYFmxYlpOQR4UYS8gEjEpjt1zGwq62prz06qhAHc+483Hh1xmTXYFXP7I4YViQd6l9vns1N932S+E0brudJT0ir0I9KRIrHiq60XZoaVoX0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752631; c=relaxed/simple;
	bh=1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xg3OsV9Hn217vm8daSQu1usYD3ksPWTEpVZ2YL8e46SgPg+BrESFujNuqbVuhFeJowZ00pl26chFLpmFOjszBnk+xcfKA2Lv8VGoUK8QewV5y96v44UHH8h1j3HJYz3vCS+bWN/aej6pX4824HBLNpa31QWPvcxKcQWmCuSFNkM=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QriMG5bP; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711752630;
	bh=1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QriMG5bPxFDJal3+iK1Pb0iH9WyOvvWgwweQ2/D86v3oy/13nMNRcnZgIMYLJopSY
	 7KLJczmMCVMHyE0HUKo16Zlrh+oM1jIPi5sy2qLvR1xNCT85FR5iD28bsq3bhCic2E
	 9agT52MvYHoRihMvi5B1sSF3/Py9XPrQj9IBRigclTJz6rtPhf6vSl/5FSEsRqKbd5
	 AG+Y/Btm/xHAuRSBzBp5kwOLojbL6e2YNlyWE+0YcxgNg53lc484ELHLR7HwPJHh3Q
	 zxW5r1DkUTeEdz0tQrKVSD3O2p8NxXZGc3WAWBi8z8L8dwVHWkG0HVZicER5qqp8k6
	 laI6AElXluGGw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 0/1] Add property in dwmac-stm32 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175263052.1693.263504657362042828.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240328185337.332703-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240328185337.332703-1-christophe.roullier@foss.st.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, joabreu@synopsys.com, lgirdwood@gmail.com,
 broonie@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 19:53:36 +0100 you wrote:
> Introduce property in dwmac-stm32 documentation
>=20
>  - st,ext-phyclk: is present since 2020 in driver so need to explain
>    it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/ar=
m/boot/dts/st/stm32mp157c-dk2.dtb:
> ethernet@5800a000: Unevaluated properties are not allowed
> ('st,ext-phyclk' was unexpected)
>    Furthermore this property will be use in upstream of MP13 dwmac glue. =
(next step)
>=20
> [...]

Here is the summary with links:
  - [v6,1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
    https://git.kernel.org/netdev/net-next/c/929107d3d2a3

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



X-sender: <linux-kernel+bounces-125481-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAWUmmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2Vj=
dW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwA=
AAAAABQAFAAIAAQUAYgAKAGUAAADNigAABQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12168
Received: from cas-essen-01.secunet.de (10.53.40.201) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:50:58 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-01.secunet.de
 (10.53.40.201) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 23:50:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 51EB6202E4
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:50:58 +0100 (CET)
X-Virus-Scanned: by secunet
X-Spam-Flag: NO
X-Spam-Score: -5.399
X-Spam-Level:
X-Spam-Status: No, score=3D-5.399 tagged_above=3D-999 required=3D2.1
	tests=3D[BAYES_00=3D-1.9, DKIMWL_WL_HIGH=3D-0.099, DKIM_SIGNED=3D0.1,
	DKIM_VALID=3D-0.1, DKIM_VALID_AU=3D-0.1, MAILING_LIST_MULTI=3D-1,
	RCVD_IN_DNSWL_MED=3D-2.3, SPF_HELO_NONE=3D0.001, SPF_PASS=3D-0.001]
	autolearn=3Dunavailable autolearn_force=3Dno
Authentication-Results: a.mx.secunet.com (amavisd-new);
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAo-ZgBbYr2Z for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:50:57 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.199.223; helo=3Dny.mirrors.kernel.org; envelope-from=3Dlinux-kern=
el+bounces-125481-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 5F257200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"QriMG5bP"
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223=
])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id 5F257200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A8F1C21134
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD84C13E6BB;
	Fri, 29 Mar 2024 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"QriMG5bP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D1613D62A;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711752631; cv=3Dnone; b=3DeLispVzL4Rucdj5yrzfRgnSRePLp+Y1FD2BRZyUX76y=
kzaZw7VHi9YXASU31baAxoYFmxYlpOQR4UYS8gEjEpjt1zGwq62prz06qhAHc+483Hh1xmTXYFX=
P7I4YViQd6l9vns1N932S+E0brudJT0ir0I9KRIrHiq60XZoaVoX0=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711752631; c=3Drelaxed/simple;
	bh=3D1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=3D;
	h=3DContent-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=3DXg3OsV9Hn217vm8daSQu1usYD3ksPWTEpVZ2YL8e46SgPg+BrE=
SFujNuqbVuhFeJowZ00pl26chFLpmFOjszBnk+xcfKA2Lv8VGoUK8QewV5y96v44UHH8h1j3HJY=
z3vCS+bWN/aej6pX4824HBLNpa31QWPvcxKcQWmCuSFNkM=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3DQriMG5=
bP; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AA7FC43609;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711752630;
	bh=3D1rWdaEawfYR3LfAF31PiRtpuMF8rLJZ44iKkxh0MscI=3D;
	h=3DSubject:From:Date:References:In-Reply-To:To:Cc:From;
	b=3DQriMG5bPxFDJal3+iK1Pb0iH9WyOvvWgwweQ2/D86v3oy/13nMNRcnZgIMYLJopSY
	 7KLJczmMCVMHyE0HUKo16Zlrh+oM1jIPi5sy2qLvR1xNCT85FR5iD28bsq3bhCic2E
	 9agT52MvYHoRihMvi5B1sSF3/Py9XPrQj9IBRigclTJz6rtPhf6vSl/5FSEsRqKbd5
	 AG+Y/Btm/xHAuRSBzBp5kwOLojbL6e2YNlyWE+0YcxgNg53lc484ELHLR7HwPJHh3Q
	 zxW5r1DkUTeEdz0tQrKVSD3O2p8NxXZGc3WAWBi8z8L8dwVHWkG0HVZicER5qqp8k6
	 laI6AElXluGGw=3D=3D
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.loc=
aldomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8=
16E5D2D0EB;
	Fri, 29 Mar 2024 22:50:30 +0000 (UTC)
Content-Type: text/plain; charset=3D"utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/1] Add property in dwmac-stm32 documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175263052.1693.263504657362042828.git-patchwork-notify@kern=
el.org>
Date: Fri, 29 Mar 2024 22:50:30 +0000
References: <20240328185337.332703-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240328185337.332703-1-christophe.roullier@foss.st.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.c=
om,
 richardcochran@gmail.com, joabreu@synopsys.com, lgirdwood@gmail.com,
 broonie@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Return-Path: linux-kernel+bounces-125481-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:50:58.3672
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: d4d0ffc8-2bb7-4705-a7dd-08dc=
5042b329
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.201
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-01.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-es=
sen-02.secunet.de:TOTAL-HUB=3D0.387|SMR=3D0.325(SMRDE=3D0.004|SMRC=3D0.320(=
SMRCL=3D0.101|X-SMRCR=3D0.320))|CAT=3D0.060(CATOS=3D0.001
 |CATRESL=3D0.028(CATRESLP2R=3D0.002)|CATORES=3D0.029(CATRS=3D0.028(CATRS-I=
ndex
 Routing Agent=3D0.027 )));2024-03-29T22:50:58.771Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-essen-02.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-01.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7690
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-01.secunet.de:TO=
TAL-FE=3D0.017|SMR=3D0.008(SMRPI=3D0.006(SMRPI-FrontendProxyAgent=3D0.006))=
|SMS=3D0.009
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-essen-02
X-MS-Exchange-Organization-RulesExecuted: mbx-essen-02
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAUADAAAPAAADH4sIAAAAAAAEAF1TX2/b=
NhA/2ZJsK9E6bB
 j2entqgtmSbC9tIwxFH4qt3RBswLKHoegDLXERIYkURMpqvvM+xI6U
 k6WDBVom737/jv4nfMebRuVxFEe3ldDYMVNUODKNrOsawUs0CiU3JT
 +m9LWR/JNJ7oTBi5YJeRlHh3v8hdXDAX8VhZC6Fvgj/WJvat5L3iSq
 v3vt0H+TeFsNa9y9whvW4y7b/YDb6/xqn+9f4PfZNsvwXg049spwan
 iN76XpVTkUHLtedbw39ygklmPLio027X6HpSqGlkvDjFCSWmwXblCb
 NYncdNV90dQ5WlM911SHWkiCI+rMQfXiyHvU1t/kk3/qGnLlcBDJJJ
 MlsqMSJZbmoLGoeFEToB445ngUfNTp5DMdOm16ztrHkFLWFxUtbXpQ
 yqSl0ak2qRPedturl8WmrHcJwTqz3FQWx7y5epVlLMuyHP+U/MiagR
 nSdkpAcBpLz1EqkkZjG3lpmy+ef2b5uRvfQCI6XlD35cnPT0NvWVpF
 CMbN+iHXUTQNHjgOmttgHryg+htvft/up9Dxrhl4ghfWHGXMu8tT5B
 +SJPloR/yOEzLhEgvqoW1Zb6FNhY2QtSafdjofji/W23T7kRLdHIQs
 hbzTub1h+UST49vTWPGP2xua8qPKz0xaMMTKmE7naUoXMvnvwqX/u6
 9pkV7vrrfZy3Jf7tjeSv2LrppNko1cq5avSTOTtb2B38XRZhNHbzk1
 lzQ5Wswa3yPFwfCgTBJHD6w1cSV0CfVTbvcHGlVfp91oyyvTNpbRfg
 ACiHwIAgjn4C9gOYN56MHXsFjCag6BDwvaodMllXnwDIIQFnNY0Sad
 zjw4o8e++74XLAGW3iqwmBaNkFcQLV1xYMtC2o/hW9vrQQR+6OiINP
 BCH4BkWHbHOL0v4AtHRFDhJDKwxfAzhKFTSA/tW3a3UvEz+HIOS3cU
 ncF5BGe076zFT3lpJ4KvqIAaJ5CJiNZJ8ERH9n0bwjePBaTWHcUzj8
 DA82Z2hfnM5UCkc3tqtbnQVk9Iz0n5laN2GZ5WQvNgdm5lTzpXLj2b
 dmypyZctIBxa55SAB1unwT/NwqeQrdR/AY8Sojk5BQAAAQrVATw/eG
 1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNiI/Pg0KPEVt
 YWlsU2V0Pg0KICA8VmVyc2lvbj4xNS4wLjAuMDwvVmVyc2lvbj4NCi
 AgPEVtYWlscz4NCiAgICA8RW1haWwgU3RhcnRJbmRleD0iODMiPg0K
 ICAgICAgPEVtYWlsU3RyaW5nPmt1YmFAa2VybmVsLm9yZzwvRW1haW
 xTdHJpbmc+DQogICAgPC9FbWFpbD4NCiAgPC9FbWFpbHM+DQo8L0Vt
 YWlsU2V0PgEL+gI8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPS
 J1dGYtMTYiPz4NCjxVcmxTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4w
 PC9WZXJzaW9uPg0KICA8VXJscz4NCiAgICA8VXJsIFN0YXJ0SW5kZX
 g9IjcwMSIgVHlwZT0iVXJsIj4NCiAgICAgIDxVcmxTdHJpbmc+aHR0
 cHM6Ly9naXQua2VybmVsLm9yZy9uZXRkZXYvbmV0LW5leHQvYy85Mj
 kxMDdkM2QyYTM8L1VybFN0cmluZz4NCiAgICA8L1VybD4NCiAgICA8
 VXJsIFN0YXJ0SW5kZXg9IjgxOSIgVHlwZT0iVXJsIj4NCiAgICAgID
 xVcmxTdHJpbmc+aHR0cHM6Ly9rb3JnLmRvY3Mua2VybmVsLm9yZy9w
 YXRjaHdvcmsvcHdib3QuaHRtbDwvVXJsU3RyaW5nPg0KICAgIDwvVX
 JsPg0KICA8L1VybHM+DQo8L1VybFNldD4BDOgDPD94bWwgdmVyc2lv
 bj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8Q29udGFjdFNldD
 4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+DQogIDxDb250
 YWN0cz4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PSI2NyI+DQogIC
 AgICA8UGVyc29uIFN0YXJ0SW5kZXg9IjY3Ij4NCiAgICAgICAgPFBl
 cnNvblN0cmluZz5KYWt1YiBLaWNpbnNraTwvUGVyc29uU3RyaW5nPg
 0KICAgICAgPC9QZXJzb24+DQogICAgICA8RW1haWxzPg0KICAgICAg
 ICA8RW1haWwgU3RhcnRJbmRleD0iODMiPg0KICAgICAgICAgIDxFbW
 FpbFN0cmluZz5rdWJhQGtlcm5lbC5vcmc8L0VtYWlsU3RyaW5nPg0K
 ICAgICAgICA8L0VtYWlsPg0KICAgICAgPC9FbWFpbHM+DQogICAgIC
 A8Q29udGFjdFN0cmluZz5KYWt1YiBLaWNpbnNraSAmbHQ7a3ViYUBr
 ZXJuZWwub3JnPC9Db250YWN0U3RyaW5nPg0KICAgIDwvQ29udGFjdD
 4NCiAgPC9Db250YWN0cz4NCjwvQ29udGFjdFNldD4BDs8BUmV0cmll
 dmVyT3BlcmF0b3IsMTAsMDtSZXRyaWV2ZXJPcGVyYXRvciwxMSwxO1
 Bvc3REb2NQYXJzZXJPcGVyYXRvciwxMCwwO1Bvc3REb2NQYXJzZXJP
 cGVyYXRvciwxMSwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcG
 VyYXRvciwxMCwwO1Bvc3RXb3JkQnJlYWtlckRpYWdub3N0aWNPcGVy
 YXRvciwxMSwwO1RyYW5zcG9ydFdyaXRlclByb2R1Y2VyLDIwLDEz
X-MS-Exchange-Forest-IndexAgent: 1 2145
X-MS-Exchange-Forest-EmailMessageHash: B35CD68A
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 19:53:36 +0100 you wrote:
> Introduce property in dwmac-stm32 documentation
>=20
>  - st,ext-phyclk: is present since 2020 in driver so need to explain
>    it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/ar=
m/boot/dts/st/stm32mp157c-dk2.dtb:
> ethernet@5800a000: Unevaluated properties are not allowed
> ('st,ext-phyclk' was unexpected)
>    Furthermore this property will be use in upstream of MP13 dwmac glue. =
(next step)
>=20
> [...]

Here is the summary with links:
  - [v6,1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
    https://git.kernel.org/netdev/net-next/c/929107d3d2a3

You are awesome, thank you!
--=20
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




