Return-Path: <linux-kernel+bounces-126152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B58932E2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52874281315
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575FA146A66;
	Sun, 31 Mar 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E31465A9;
	Sun, 31 Mar 2024 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902388; cv=fail; b=KThCill23YY8T9FDhTI/UF01F/L5dmg/gqUP3lPq9dR8x+NRjt3HbPlopsu8GcIpgolVz3XH5SQlgK3UjcXxoTzcTdjW6vatnGXxrfda/8ZpjG1rMLoqyUSHEkU1LO9xwf5mQNbYq6TnLzt+lLKVgmr4iIhUX4VOMe7OrgfZFSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902388; c=relaxed/simple;
	bh=bQiaBgbnJfruDRNxZHJsjBhq8yh+NLjqPA3osyrNOXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+2gZ7pIvChlREPr7kmN1opSA4ulPi08+fpSE+Hnor9mhe6gjVdQM31NOB05qWadu1iFREp2h4dG1cA/0C7878Z3rRfsT5vz5urDwVlooiNKlktmYZoT7N8vCaGpapZRGrkfYDYsCBt3Pcig+j99heO4fXw89+AA+R9LmLGY/Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6 reason="signature verification failed"; arc=none smtp.client-ip=10.30.226.201; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id BF4EA20851;
	Sun, 31 Mar 2024 18:26:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2zuROhDnFHsk; Sun, 31 Mar 2024 18:26:21 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4FA7820896;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4FA7820896
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 4342480004A;
	Sun, 31 Mar 2024 18:26:20 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:26:20 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <netdev+bounces-83471-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAq5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAJAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZlbi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10902
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.199.223; helo=ny.mirrors.kernel.org; envelope-from=netdev+bounces-83471-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 4C0D5200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCDVp1+6"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749678; cv=none; b=TOauJdfJGKU0duUd8J4pHoHhAwsXcDn6HiMRRbIxMC8w4F8N/R6CuN8UW0dSXad7zTr71uirgCxvjz3p8yWCCy8Lua4blaGweObu3zF4POrf+k9u15OLletc265FFN5y6QWVgkTghnrO2lA7BPEgSHApf/YoTu1URgNAYZ6V86c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749678; c=relaxed/simple;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0voKxc3wu4aN9dqdlqCvCcRErWY477ia2U3s+zapOl4w1ETHJYUStVobjEYNexg0unHlP7Tb6mRFUmIC7L9k9Abt8vOwswUXlovEv/RYRNqCZh58Etm9FyIYE6rOXh15uvgsy9g+fHu21flV2ooGENu10WR0Qfm9Eo1N8RV3k8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCDVp1+6; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749677;
	bh=nq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HCDVp1+6GYWN8GFmGWMO5xXfiuZa6bY/GlLwKiqaSa1TLzIxcYJihxRE0e5VLztHR
	 5zX4huDJPpeCfgrjlALPODEyY9ok6t6XZyC94u9P4uGbsdD+Vf7/goAP4qAxHkI24l
	 Vp+Ec9ugCQi0u85nWx6u6+59B7MSXHvK7H7/fZ+H3lv3tvBPDnMR4RgmsEhvVyxon1
	 xplQn51eQjcegvhK7Sath6j4gOuf2pbrolfo17ILhabO8CfloJKPB+aXedyLdVRpG7
	 sAjIkjQeyiL63kut8QYGl9CThsDY1mDSdXu6r8nXPwWsINSIlXd0gVG41OCygsqiwZ
	 FdtrYL4sDV2IA==
Date: Fri, 29 Mar 2024 15:01:16 -0700
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
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable
 PTP RX HW timestamp using CPTS FIFO
Message-ID: <20240329150116.67da2b07@kernel.org>
In-Reply-To: <20240327054234.1906957-1-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
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

On Wed, 27 Mar 2024 11:12:32 +0530 Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
> of received packets from CPTS FIFO.
>=20
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_find_rx_ts()" function and timestamps the received
> PTP packets.

Maybe i'm unusually tied today but reading this patch without reading
the next one makes no sense. I mean, you say:

  CPTS module supports capturing timestamp for every packet it
  receives...

How is that relevant here.

When you post v5 please make sure to include a cover letter, explaining
the overall goal and impact of the series.

> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);

list_move() ?
--=20
pw-bot: cr

X-sender: <linux-kernel+bounces-125472-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAq5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgALAAAAjIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 10845
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Fri, 29 Mar 2024 23:01:54 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Fri, 29 Mar 2024 23:01:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id 43FD620270
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:01:54 +0100 (CET)
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
	with ESMTP id rUKtVu_udyEK for <steffen.klassert@secunet.com>;
	Fri, 29 Mar 2024 23:01:53 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125472-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com BE1E4200BB
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"HCDVp1+6"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id BE1E4200BB
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 23:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8338A1F22B6F
	for <steffen.klassert@secunet.com>; Fri, 29 Mar 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A474313DDAE;
	Fri, 29 Mar 2024 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (2048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org he=
ader.b=3D"HCDVp1+6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.or=
g [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDD13CF9A;
	Fri, 29 Mar 2024 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D10.30.226.201
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711749678; cv=3Dnone; b=3DTOauJdfJGKU0duUd8J4pHoHhAwsXcDn6HiMRRbIxMC8=
w4F8N/R6CuN8UW0dSXad7zTr71uirgCxvjz3p8yWCCy8Lua4blaGweObu3zF4POrf+k9u15OLle=
tc265FFN5y6QWVgkTghnrO2lA7BPEgSHApf/YoTu1URgNAYZ6V86c=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711749678; c=3Drelaxed/simple;
	bh=3Dnq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=3DY0voKxc3wu4aN9dqdlqCvCcRErWY477ia2U3s+zapO=
l4w1ETHJYUStVobjEYNexg0unHlP7Tb6mRFUmIC7L9k9Abt8vOwswUXlovEv/RYRNqCZh58Etm9=
FyIYE6rOXh15uvgsy9g+fHu21flV2ooGENu10WR0Qfm9Eo1N8RV3k8=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dkim=3Dpass (2=
048-bit key) header.d=3Dkernel.org header.i=3D@kernel.org header.b=3DHCDVp1=
+6; arc=3Dnone smtp.client-ip=3D10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53666C433C7;
	Fri, 29 Mar 2024 22:01:17 +0000 (UTC)
DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/simple; d=3Dkernel.org;
	s=3Dk20201202; t=3D1711749677;
	bh=3Dnq/FsIJaEug5d9vw9MG+IgQd5liVDY8TkXYaFDuOCdo=3D;
	h=3DDate:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3DHCDVp1+6GYWN8GFmGWMO5xXfiuZa6bY/GlLwKiqaSa1TLzIxcYJihxRE0e5VLztHR
	 5zX4huDJPpeCfgrjlALPODEyY9ok6t6XZyC94u9P4uGbsdD+Vf7/goAP4qAxHkI24l
	 Vp+Ec9ugCQi0u85nWx6u6+59B7MSXHvK7H7/fZ+H3lv3tvBPDnMR4RgmsEhvVyxon1
	 xplQn51eQjcegvhK7Sath6j4gOuf2pbrolfo17ILhabO8CfloJKPB+aXedyLdVRpG7
	 sAjIkjQeyiL63kut8QYGl9CThsDY1mDSdXu6r8nXPwWsINSIlXd0gVG41OCygsqiwZ
	 FdtrYL4sDV2IA=3D=3D
Date: Fri, 29 Mar 2024 15:01:16 -0700
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
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpts: Enable
 PTP RX HW timestamp using CPTS FIFO
Message-ID: <20240329150116.67da2b07@kernel.org>
In-Reply-To: <20240327054234.1906957-1-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3D"US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: linux-kernel+bounces-125472-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 29 Mar 2024 22:01:54.3136
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: f786ccae-300d-498c-b6e0-08dc=
503bd85e
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.406|SMR=3D0.337(SMRDE=3D0.035|SMRC=3D0.30=
2(SMRCL=3D0.100|X-SMRCR=3D0.302))|CAT=3D0.067(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.011))|CATRESL=3D0.039(CATRESLP2R=3D0.017)|CATORES=3D0.014
 (CATRS=3D0.014(CATRS-Index Routing Agent=3D0.013)));2024-03-29T22:01:54.72=
9Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7441
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.025|SMR=3D0.024(SMRPI=3D0.022(SMRPI-FrontendProxyAgent=3D0.022))
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAc4CAAAPAAADH4sIAAAAAAAEAKVSW0vc=
QBSe1WQv0diX0u
 dDC1ZxV3StLWzBUgrSPohCpT4uY3LWHUxmQmbiuv+iP7nfTFylYNuH
 hiHM5budM/Ozd67pivMhjT/QmaxpfDB+R4eHk8Px5GhMewfHRwf0Za
 60k5p+SH0LyKI2jidpckJfLi6/U2nypmCyTVWZ2lnKZOWaWukbcqpk
 62RZ0czUxHdcL6mS2S07Uo5qzljdsR16JZnnJEnzgmaNzpwymrQsOa
 fXsnx/PM0qZ6czpfNpfT91dmf3NTlDNxByc37y8UpmtlLOH8wszWpT
 tmFPv52e7wPmkZ+9pzZQqP/i6g1X+t53MVfZnNAQrrUsiqVXyjCxf4
 76KC51/hTWhuyrrF7m4vJiFRkZ0+RMLq+Z1NuSGt3YxruBjnjO5HJJ
 141vosxDq+fKgusQbaHc3DwdpYm30XzvyGimUt6yJW3Isra8T9+oZK
 mHtDQNWbmceF/6r4v1/NXd7u+HQr6aBSlfr/SxCr6T2hHazuH0as46
 +FfGOro7pqpgaduocK/Z37XSWdHkjEeSGfhRwQ43MCS+rwqp9GOh/h
 CNohsji9BvVSKZ88/CH1uuFbfdPaE9eu4rlHXTnIspVN3ONqrTbnTi
 d3c//oOFV/wbYUjb/jmMTipjCs9Ok4ArkXJnlz6lyWiUJtVidG3chL
 LaA4RYE+vrIl7riA0MP4+iTtzviL4Q/c4gFiIW3Z7od0UvFkkkYkz6
 YjAQCQbAOMUORPoixbIj1vAHIBY9LF6KOAoDgDXRDV4RxkCkgTKAcv
 SA2cQ+lo/cVysiwHBJxNazmsCDmIiN4NuKbAIfXHzgdt4atbX0AgXL
 Nj90oIzkUUCu/61M2L3AEhRgAIj8iFs1bALzmA1G0AzEfrKqrgW3HQ
 uTN6gofVDo+gIFRb752InDEqMbIVJHDLzyFm6q217ZLwZfdwROBQAA
 AQLxAjw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9InV0Zi0xNi
 I/Pg0KPFRhc2tTZXQ+DQogIDxWZXJzaW9uPjE1LjAuMC4wPC9WZXJz
 aW9uPg0KICA8VGFza3M+DQogICAgPFRhc2sgU3RhcnRJbmRleD0iNj
 QyIj4NCiAgICAgIDxUYXNrU3RyaW5nPldoZW4geW91IHBvc3QgdjUg
 cGxlYXNlIG1ha2Ugc3VyZSB0byBpbmNsdWRlIGEgY292ZXIgbGV0dG
 VyLCBleHBsYWluaW5nPC9UYXNrU3RyaW5nPg0KICAgICAgPEFzc2ln
 bmVlcz4NCiAgICAgICAgPEVtYWlsVXNlciBJZD0iYy12YW5rYXJAdG
 kuY29tIj5DaGludGFuIFZhbmthcjwvRW1haWxVc2VyPg0KICAgICAg
 PC9Bc3NpZ25lZXM+DQogICAgPC9UYXNrPg0KICA8L1Rhc2tzPg0KPC
 9UYXNrU2V0PgEOzgFSZXRyaWV2ZXJPcGVyYXRvciwxMCwwO1JldHJp
 ZXZlck9wZXJhdG9yLDExLDA7UG9zdERvY1BhcnNlck9wZXJhdG9yLD
 EwLDA7UG9zdERvY1BhcnNlck9wZXJhdG9yLDExLDA7UG9zdFdvcmRC
 cmVha2VyRGlhZ25vc3RpY09wZXJhdG9yLDEwLDA7UG9zdFdvcmRCcm
 Vha2VyRGlhZ25vc3RpY09wZXJhdG9yLDExLDA7VHJhbnNwb3J0V3Jp
 dGVyUHJvZHVjZXIsMjAsNw=3D=3D
X-MS-Exchange-Forest-IndexAgent: 1 1312
X-MS-Exchange-Forest-EmailMessageHash: F51E6461
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Wed, 27 Mar 2024 11:12:32 +0530 Chintan Vankar wrote:
> CPTS module supports capturing timestamp for every packet it receives,
> add a new function named "am65_cpts_find_rx_ts()" to get the timestamp
> of received packets from CPTS FIFO.
>=20
> Add another function named "am65_cpts_rx_timestamp()" which internally
> calls "am65_cpts_find_rx_ts()" function and timestamps the received
> PTP packets.

Maybe i'm unusually tied today but reading this patch without reading
the next one makes no sense. I mean, you say:

  CPTS module supports capturing timestamp for every packet it
  receives...

How is that relevant here.

When you post v5 please make sure to include a cover letter, explaining
the overall goal and impact of the series.

> +			list_del_init(&event->list);
> +			list_add(&event->list, &cpts->pool);

list_move() ?
--=20
pw-bot: cr


