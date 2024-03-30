Return-Path: <linux-kernel+bounces-126170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544A893315
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E0D1F2649E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA462145B00;
	Sun, 31 Mar 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AgKIFxWL"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FC14600D;
	Sun, 31 Mar 2024 16:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902485; cv=fail; b=MbhteM3Ilx4ig5iSJl3rEOVbrgFJBjbBNsV0qlzV4QTERbwqlGVt7n3HOElQ0ofl3acsNkwwf7yhtc8gv6mLWu7WteHnnDTDPPVaEellw+YQUMEDUF8gNz9oTvd2uJ0afPU3aE3/IV52Xz0AJQND9TquvFShQc9OzTa/pmlMiww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902485; c=relaxed/simple;
	bh=7vMNjIQTTLzF5+Qpjv6y2HZaO1EeCqI4ON+1sm6e4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdM+1edOyHBgA3BWZQ9CMWMx+S3TgFWG/4xSGbDtQm6IBLbNQw6voW+gU5S/e9T28YS+9lLFl/Pqor2G4GSQEckgOAVqcT7i+JXWkezIBXO9+mthvnBoP11l3YdGngK3KQ0DVUwEKpwNQ3jnYkutwfxi9yEAlAmEGmyL1jg91Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lunn.ch; spf=fail smtp.mailfrom=lunn.ch; dkim=fail (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AgKIFxWL reason="signature verification failed"; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lunn.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 78AD620728;
	Sun, 31 Mar 2024 18:28:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dl2jSrIytgLT; Sun, 31 Mar 2024 18:28:00 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E302E20820;
	Sun, 31 Mar 2024 18:27:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E302E20820
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id D4ED1800057;
	Sun, 31 Mar 2024 18:27:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:27:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:50 +0000
X-sender: <netdev+bounces-83507-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAJ05ab4WgQhHsqdZ7WUjHykPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGAAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249UGV0ZXIgU2NodW1hbm41ZTcFAAsAFwC+AAAAQ5IZ35DtBUiRVnd98bETxENOPURCNCxDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUADgARAC7JU/le071Fhs0mWv1VtVsFAB0ADwAMAAAAbWJ4LWVzc2VuLTAxBQA8AAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADwAAAFNjaHVtYW5uLCBQZXRlcgUADAACAAAFAGwAAgAABQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAwNjp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBpAAAAnIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAZAAPAAMAAABIdWI=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11491
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83507-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E1FC520847
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810403; cv=none; b=VrO6J8Hi+SBymX6+G5k3Ud8x7blzHf4q7Un8U6HDTfCcAzT4feZ1IAepX0YzqrNRbWaj6sVRlwcJW0hQh2XaqpefkR4Sl2gkocyv4v1p3KRon1liM9mPgLHk8XrtVDkI9/lTyxhV5mKiovFXgO/D2P2uamXtEBKUKCzDezwG5NM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810403; c=relaxed/simple;
	bh=gJx0oB7ZzuoCNKkwsr1UzGLJ3CRfFELmHureG9uOYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDelDfSdHTx21mIJ0hem715uqMg/JEbBvu+QI/n4j2Dk5mc8GbK+VtSdOJISO50a39BBZcXcTZecoAszKR55fvrHsgPXRjIkkmjNpNVTs/51Np0JtRcq77T52D8q+mY13M2OFNo9qBat6UJf/PFGufjBrguPYjOpPuK3LA1Ni/8=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AgKIFxWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=caGVOX2RZ69c4hjscPFCuCKDrFK7z35V6qvgjgO6mvs=; b=AgKIFxWLgU4PMlGPkeuWts4Sdx
	C1uk2GClcr5WI35QPJ/c+zppgblTWKdov5NwQ4Y/rlf4kRO+pXEefeYiuH/9vvqcMMhtsW5bKoOSc
	ptiP23T99yvkYQ4yFYT1LkW6GjFn1aaNnXMQ/2LbdTSWKkldN1777vtFbSTbTQ5A4V60=;
Date: Sat, 30 Mar 2024 15:52:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
 <6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
 <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> On Thu, 28 Mar 2024 17:24:17 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > +				  const char *fw_name,
> > > +				  const struct tps23881_fw_conf *fw_conf) =20
> >=20
> > Does the device actually have flash? Or is this just downloading to
> > SRAM?
>=20
> It is downloading to SRAM.

So maybe rename these functions.

	Andrew

X-sender: <netdev+bounces-83507-steffen.klassert=3Dsecunet.com@vger.kernel.=
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
X-ExtendedProps: BQBjAAoAwNjp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBtAAAAnIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 11630
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 15:53:36 +0100
Received: from b.mx.secunet.com (62.96.220.37) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 15:53:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by b.mx.secunet.com (Postfix) with ESMTP id AFDEC20322
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 15:53:36 +0100 (CET)
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
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch
Received: from b.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1bKMfFGP__Qt for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 15:53:35 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D147.75.80.249; helo=3Dam.mirrors.kernel.org; envelope-from=3Dnetdev+boun=
ces-83507-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=3Dsteffe=
n.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C1C5D2025D
Authentication-Results: b.mx.secunet.com;
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch header.b=
=3D"AgKIFxWL"
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by b.mx.secunet.com (Postfix) with ESMTPS id C1C5D2025D
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 15:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0831F21EBE
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BFD383B5;
	Sat, 30 Mar 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch header.b=
=3D"AgKIFxWL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8311C0DEF;
	Sat, 30 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D156.67.10.101
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711810403; cv=3Dnone; b=3DVrO6J8Hi+SBymX6+G5k3Ud8x7blzHf4q7Un8U6HDTfC=
cAzT4feZ1IAepX0YzqrNRbWaj6sVRlwcJW0hQh2XaqpefkR4Sl2gkocyv4v1p3KRon1liM9mPgL=
Hk8XrtVDkI9/lTyxhV5mKiovFXgO/D2P2uamXtEBKUKCzDezwG5NM=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711810403; c=3Drelaxed/simple;
	bh=3DgJx0oB7ZzuoCNKkwsr1UzGLJ3CRfFELmHureG9uOYGw=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=3DoDelDfSdHTx21mIJ0hem715=
uqMg/JEbBvu+QI/n4j2Dk5mc8GbK+VtSdOJISO50a39BBZcXcTZecoAszKR55fvrHsgPXRjIkkm=
jNpNVTs/51Np0JtRcq77T52D8q+mY13M2OFNo9qBat6UJf/PFGufjBrguPYjOpPuK3LA1Ni/8=
=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlunn.ch; spf=3Dpass smtp.mailfrom=3Dlunn=
ch; dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch head=
er.b=3DAgKIFxWL; arc=3Dnone smtp.client-ip=3D156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlunn.ch
DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxed; d=
=3Dlunn.ch;
	s=3D20171124; h=3DIn-Reply-To:Content-Disposition:Content-Type:MIME-Versio=
n:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject=
:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3DcaGVOX2RZ69c4hjscPFCuCKDrFK7z35V6qvgjgO6mvs=3D; b=3DAgKIFxWLgU4PMlGPk=
euWts4Sdx
	C1uk2GClcr5WI35QPJ/c+zppgblTWKdov5NwQ4Y/rlf4kRO+pXEefeYiuH/9vvqcMMhtsW5bKo=
OSc
	ptiP23T99yvkYQ4yFYT1LkW6GjFn1aaNnXMQ/2LbdTSWKkldN1777vtFbSTbTQ5A4V60=3D;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqa4f-00Bj1W-9i; Sat, 30 Mar 2024 15:52:49 +0100
Date: Sat, 30 Mar 2024 15:52:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
 <6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
 <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dus-ascii
Content-Disposition: inline
In-Reply-To: <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Return-Path: netdev+bounces-83507-steffen.klassert=3Dsecunet.com@vger.kerne=
l.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 14:53:36.7613
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: bcacc45f-6eaf-4034-2c6e-08dc=
50c92dd9
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.37
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.415|SMR=3D0.342(SMRDE=3D0.035|SMRC=3D0.30=
6(SMRCL=3D0.101|X-SMRCR=3D0.306))|CAT=3D0.073(CATOS=3D0.014
 (CATSM=3D0.014(CATSM-Malware
 Agent=3D0.013))|CATRESL=3D0.041(CATRESLP2R=3D0.018)|CATORES=3D0.014
 (CATRS=3D0.014(CATRS-Index Routing
 Agent=3D0.013))|CATORT=3D0.001(CATRT=3D0.001(CATRT-Journal Agent=3D0.001
 )));2024-03-30T14:53:37.211Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7920
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.034|SMR=3D0.007(SMRPI=3D0.004(SMRPI-FrontendProxyAgent=3D0.004))=
|SMS=3D0.027
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAdkBAAAPAAADH4sIAAAAAAAEAJWRTU/b=
QBCGx5+xDalQD5
 znWEiEHANNalVQpKpS1UZUpXdru9nUrswa2Wus/AV+NTNrCuqhh9qr
 zc7M+z4z6zz41xo/tdUc16LF7N0cszQ7Q2EwPc3P3+bny29rnKWLNJ
 3jl6bdkazSUmmDQ9sYlU+TCyTCj7In52qEMGCxzLOzfLEcvay60ptW
 Dfi11xrfCxt8qCk4keXFC4yV/M46I0wlsaJO5q7LTlerRbGtRVcW26
 G4E61505m2lwarTBayrnik4/F3/gzBfz+y0Z1BWdLAx0TU4lb9h++p
 98tkQ0GFrUXx4ciiRt7HRnVoSoUbdV9JhUKaXtT1Dktxr9De6RKvW6
 xYRdvvnhpsmkHXjdhU+heaZgTdfL9aXz59o8+G9X+rrOBkmkyTmwZv
 xe6nwlbxxbh7R616LU1F81vNnwuN/wtnAFzwPAg8B/Zpge+C70PgOl
 7kQAS0IjoHAAFMKB9BHEAyWlwH9mjx2fedgMVObJVxyOIwdOCVdREz
 gNeUJCVhDxkSEoRKnHQgAT+EKIQZ5clI5AlXjygkAVkOILb659IBeT
 12TWgkOtN4JBiZtPZg34XI552TNqQSQ0Ym7TEcho/Hww3DCwMAAAEK
 6gE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz
 4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNp
 b24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ij
 ExNyIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxT
 dHJpbmc+YW5kcmV3QGx1bm4uY2g8L0VtYWlsU3RyaW5nPg0KICAgID
 wvRW1haWw+DQogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BDKIEPD94
 bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8Q2
 9udGFjdFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+
 DQogIDxDb250YWN0cz4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PS
 IxMDQiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgPFBlcnNv
 biBTdGFydEluZGV4PSIxMDQiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICA8UGVyc29uU3RyaW5nPkFuZHJldyBMdW5uPC9QZXJz
 b25TdHJpbmc+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbH
 M+DQogICAgICAgIDxFbWFpbCBTdGFydEluZGV4PSIxMTciIFBvc2l0
 aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICAgIDxFbWFpbFN0cmluZz
 5hbmRyZXdAbHVubi5jaDwvRW1haWxTdHJpbmc+DQogICAgICAgIDwv
 RW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YWN0U3
 RyaW5nPkFuZHJldyBMdW5uICZsdDthbmRyZXdAbHVubi5jaDwvQ29u
 dGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udGFjdH
 M+DQo8L0NvbnRhY3RTZXQ+AQ7OAVJldHJpZXZlck9wZXJhdG9yLDEw
 LDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMDtQb3N0RG9jUGFyc2VyT3
 BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQ
 b3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3
 N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFu
 c3BvcnRXcml0ZXJQcm9kdWNlciwyMCw2
X-MS-Exchange-Forest-IndexAgent: 1 1482
X-MS-Exchange-Forest-EmailMessageHash: BAB86D88
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> On Thu, 28 Mar 2024 17:24:17 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > +				  const char *fw_name,
> > > +				  const struct tps23881_fw_conf *fw_conf) =20
> >=20
> > Does the device actually have flash? Or is this just downloading to
> > SRAM?
>=20
> It is downloading to SRAM.

So maybe rename these functions.

	Andrew

X-sender: <linux-kernel+bounces-125749-steffen.klassert=3Dsecunet.com@vger.=
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
X-ExtendedProps: BQBjAAoAwNjp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc2=
9mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAA=
AAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgBuAAAAnIoAAAUABAAUIAEAAAAcAAAAc3RlZmZl=
bi5rbGFzc2VydEBzZWN1bmV0LmNvbQUABgACAAEFACkAAgABDwAJAAAAQ0lBdWRpdGVkAgABBQA=
CAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1Yg=3D=3D
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 11449
Received: from cas-essen-02.secunet.de (10.53.40.202) by
 mbx-dresden-01.secunet.de (10.53.40.199) with Microsoft SMTP Server
 (version=3DTLS1_2, cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Sat, 30 Mar 2024 15:53:46 +0100
Received: from a.mx.secunet.com (62.96.220.36) by cas-essen-02.secunet.de
 (10.53.40.202) with Microsoft SMTP Server (version=3DTLS1_2,
 cipher=3DTLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Fronte=
nd
 Transport; Sat, 30 Mar 2024 15:53:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0092E2087C
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 15:53:46 +0100 (CET)
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
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q78oTPU6yoBB for <steffen.klassert@secunet.com>;
	Sat, 30 Mar 2024 15:53:45 +0100 (CET)
Received-SPF: Pass (sender SPF authorized) identity=3Dmailfrom; client-ip=
=3D139.178.88.99; helo=3Dsv.mirrors.kernel.org; envelope-from=3Dlinux-kerne=
l+bounces-125749-steffen.klassert=3Dsecunet.com@vger.kernel.org; receiver=
=3Dsteffen.klassert@secunet.com=20
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 3C0B120847
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99]=
)
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3C0B120847
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 15:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.2=
5.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423C9282229
	for <steffen.klassert@secunet.com>; Sat, 30 Mar 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648539FD4;
	Sat, 30 Mar 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch header.b=
=3D"AgKIFxWL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8311C0DEF;
	Sat, 30 Mar 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=3Dnone smtp.client-ip=
=3D156.67.10.101
ARC-Seal: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org; s=3Darc-20240116;
	t=3D1711810403; cv=3Dnone; b=3DVrO6J8Hi+SBymX6+G5k3Ud8x7blzHf4q7Un8U6HDTfC=
cAzT4feZ1IAepX0YzqrNRbWaj6sVRlwcJW0hQh2XaqpefkR4Sl2gkocyv4v1p3KRon1liM9mPgL=
Hk8XrtVDkI9/lTyxhV5mKiovFXgO/D2P2uamXtEBKUKCzDezwG5NM=3D
ARC-Message-Signature: i=3D1; a=3Drsa-sha256; d=3Dsubspace.kernel.org;
	s=3Darc-20240116; t=3D1711810403; c=3Drelaxed/simple;
	bh=3DgJx0oB7ZzuoCNKkwsr1UzGLJ3CRfFELmHureG9uOYGw=3D;
	h=3DDate:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=3DoDelDfSdHTx21mIJ0hem715=
uqMg/JEbBvu+QI/n4j2Dk5mc8GbK+VtSdOJISO50a39BBZcXcTZecoAszKR55fvrHsgPXRjIkkm=
jNpNVTs/51Np0JtRcq77T52D8q+mY13M2OFNo9qBat6UJf/PFGufjBrguPYjOpPuK3LA1Ni/8=
=3D
ARC-Authentication-Results: i=3D1; smtp.subspace.kernel.org; dmarc=3Dpass (=
p=3Dnone dis=3Dnone) header.from=3Dlunn.ch; spf=3Dpass smtp.mailfrom=3Dlunn=
ch; dkim=3Dpass (1024-bit key) header.d=3Dlunn.ch header.i=3D@lunn.ch head=
er.b=3DAgKIFxWL; arc=3Dnone smtp.client-ip=3D156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=3Dpass (p=3Dnone di=
s=3Dnone) header.from=3Dlunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=3Dpass smtp.mailfrom=
=3Dlunn.ch
DKIM-Signature: v=3D1; a=3Drsa-sha256; q=3Ddns/txt; c=3Drelaxed/relaxed; d=
=3Dlunn.ch;
	s=3D20171124; h=3DIn-Reply-To:Content-Disposition:Content-Type:MIME-Versio=
n:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject=
:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3DcaGVOX2RZ69c4hjscPFCuCKDrFK7z35V6qvgjgO6mvs=3D; b=3DAgKIFxWLgU4PMlGPk=
euWts4Sdx
	C1uk2GClcr5WI35QPJ/c+zppgblTWKdov5NwQ4Y/rlf4kRO+pXEefeYiuH/9vvqcMMhtsW5bKo=
OSc
	ptiP23T99yvkYQ4yFYT1LkW6GjFn1aaNnXMQ/2LbdTSWKkldN1777vtFbSTbTQ5A4V60=3D;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqa4f-00Bj1W-9i; Sat, 30 Mar 2024 15:52:49 +0100
Date: Sat, 30 Mar 2024 15:52:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v6 17/17] net: pse-pd: Add TI TPS23881 PSE
 controller driver
Message-ID: <8186fea6-c1f4-403b-b717-83c1dd3ad826@lunn.ch>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
 <20240326-feature_poe-v6-17-c1011b6ea1cb@bootlin.com>
 <6bbc6b86-3947-4679-ac0b-fde50129d0f6@lunn.ch>
 <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dus-ascii
Content-Disposition: inline
In-Reply-To: <20240329155657.7939ac4b@kmaincent-XPS-13-7390>
Return-Path: linux-kernel+bounces-125749-steffen.klassert=3Dsecunet.com@vge=
r.kernel.org
X-MS-Exchange-Organization-OriginalArrivalTime: 30 Mar 2024 14:53:46.0227
 (UTC)
X-MS-Exchange-Organization-Network-Message-Id: 4173286b-f2f8-48eb-586a-08dc=
50c9335e
X-MS-Exchange-Organization-OriginalClientIPAddress: 62.96.220.36
X-MS-Exchange-Organization-OriginalServerIPAddress: 10.53.40.202
X-MS-Exchange-Organization-Cross-Premises-Headers-Processed: cas-essen-02.s=
ecunet.de
X-MS-Exchange-Organization-OrderedPrecisionLatencyInProgress: LSRV=3Dmbx-dr=
esden-01.secunet.de:TOTAL-HUB=3D0.409|SMR=3D0.340(SMRDE=3D0.035|SMRC=3D0.30=
5(SMRCL=3D0.100|X-SMRCR=3D0.305))|CAT=3D0.068(CATOS=3D0.011
 (CATSM=3D0.011(CATSM-Malware
 Agent=3D0.010))|CATRESL=3D0.040(CATRESLP2R=3D0.018)|CATORES=3D0.014
 (CATRS=3D0.014(CATRS-Index Routing Agent=3D0.013)));2024-03-30T14:53:46.46=
7Z
X-MS-Exchange-Forest-ArrivalHubServer: mbx-dresden-01.secunet.de
X-MS-Exchange-Organization-AuthSource: cas-essen-02.secunet.de
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-FromEntityHeader: Internet
X-MS-Exchange-Organization-OriginalSize: 7799
X-MS-Exchange-Organization-HygienePolicy: Standard
X-MS-Exchange-Organization-MessageLatency: SRV=3Dcas-essen-02.secunet.de:TO=
TAL-FE=3D0.034|SMR=3D0.007(SMRPI=3D0.005(SMRPI-FrontendProxyAgent=3D0.005))=
|SMS=3D0.028
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-Recipient-Limit-Verified: True
X-MS-Exchange-Organization-TotalRecipientCount: 1
X-MS-Exchange-Organization-Rules-Execution-History: 0b0cf904-14ac-4724-8bdf=
-482ee6223cf2%%%fd34672d-751c-45ae-a963-ed177fcabe23%%%d8080257-b0c3-47b4-b=
0db-23bc0c8ddb3c%%%95e591a2-5d7d-4afa-b1d0-7573d6c0a5d9%%%f7d0f6bc-4dcc-487=
6-8c5d-b3d6ddbb3d55%%%16355082-c50b-4214-9c7d-d39575f9f79b
X-MS-Exchange-Forest-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Organization-RulesExecuted: mbx-dresden-01
X-MS-Exchange-Forest-IndexAgent-0: AQ0CZW4AAdkBAAAPAAADH4sIAAAAAAAEAJWRTU/b=
QBCGx5+xDalQD5
 znWEiEHANNalVQpKpS1UZUpXdru9nUrswa2Wus/AV+NTNrCuqhh9qr
 zc7M+z4z6zz41xo/tdUc16LF7N0cszQ7Q2EwPc3P3+bny29rnKWLNJ
 3jl6bdkazSUmmDQ9sYlU+TCyTCj7In52qEMGCxzLOzfLEcvay60ptW
 Dfi11xrfCxt8qCk4keXFC4yV/M46I0wlsaJO5q7LTlerRbGtRVcW26
 G4E61505m2lwarTBayrnik4/F3/gzBfz+y0Z1BWdLAx0TU4lb9h++p
 98tkQ0GFrUXx4ciiRt7HRnVoSoUbdV9JhUKaXtT1Dktxr9De6RKvW6
 xYRdvvnhpsmkHXjdhU+heaZgTdfL9aXz59o8+G9X+rrOBkmkyTmwZv
 xe6nwlbxxbh7R616LU1F81vNnwuN/wtnAFzwPAg8B/Zpge+C70PgOl
 7kQAS0IjoHAAFMKB9BHEAyWlwH9mjx2fedgMVObJVxyOIwdOCVdREz
 gNeUJCVhDxkSEoRKnHQgAT+EKIQZ5clI5AlXjygkAVkOILb659IBeT
 12TWgkOtN4JBiZtPZg34XI552TNqQSQ0Ym7TEcho/Hww3DCwMAAAEK
 6gE8P3htbCB2ZXJzaW9uPSIxLjAiIGVuY29kaW5nPSJ1dGYtMTYiPz
 4NCjxFbWFpbFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNp
 b24+DQogIDxFbWFpbHM+DQogICAgPEVtYWlsIFN0YXJ0SW5kZXg9Ij
 ExNyIgUG9zaXRpb249IlNpZ25hdHVyZSI+DQogICAgICA8RW1haWxT
 dHJpbmc+YW5kcmV3QGx1bm4uY2g8L0VtYWlsU3RyaW5nPg0KICAgID
 wvRW1haWw+DQogIDwvRW1haWxzPg0KPC9FbWFpbFNldD4BDKIEPD94
 bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTE2Ij8+DQo8Q2
 9udGFjdFNldD4NCiAgPFZlcnNpb24+MTUuMC4wLjA8L1ZlcnNpb24+
 DQogIDxDb250YWN0cz4NCiAgICA8Q29udGFjdCBTdGFydEluZGV4PS
 IxMDQiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg0KICAgICAgPFBlcnNv
 biBTdGFydEluZGV4PSIxMDQiIFBvc2l0aW9uPSJTaWduYXR1cmUiPg
 0KICAgICAgICA8UGVyc29uU3RyaW5nPkFuZHJldyBMdW5uPC9QZXJz
 b25TdHJpbmc+DQogICAgICA8L1BlcnNvbj4NCiAgICAgIDxFbWFpbH
 M+DQogICAgICAgIDxFbWFpbCBTdGFydEluZGV4PSIxMTciIFBvc2l0
 aW9uPSJTaWduYXR1cmUiPg0KICAgICAgICAgIDxFbWFpbFN0cmluZz
 5hbmRyZXdAbHVubi5jaDwvRW1haWxTdHJpbmc+DQogICAgICAgIDwv
 RW1haWw+DQogICAgICA8L0VtYWlscz4NCiAgICAgIDxDb250YWN0U3
 RyaW5nPkFuZHJldyBMdW5uICZsdDthbmRyZXdAbHVubi5jaDwvQ29u
 dGFjdFN0cmluZz4NCiAgICA8L0NvbnRhY3Q+DQogIDwvQ29udGFjdH
 M+DQo8L0NvbnRhY3RTZXQ+AQ7OAVJldHJpZXZlck9wZXJhdG9yLDEw
 LDE7UmV0cmlldmVyT3BlcmF0b3IsMTEsMTtQb3N0RG9jUGFyc2VyT3
 BlcmF0b3IsMTAsMDtQb3N0RG9jUGFyc2VyT3BlcmF0b3IsMTEsMDtQ
 b3N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTAsMDtQb3
 N0V29yZEJyZWFrZXJEaWFnbm9zdGljT3BlcmF0b3IsMTEsMDtUcmFu
 c3BvcnRXcml0ZXJQcm9kdWNlciwyMCw2
X-MS-Exchange-Forest-IndexAgent: 1 1482
X-MS-Exchange-Forest-EmailMessageHash: BAB86D88
X-MS-Exchange-Forest-Language: en
X-MS-Exchange-Organization-Processed-By-Journaling: Journal Agent

On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> On Thu, 28 Mar 2024 17:24:17 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > +				  const char *fw_name,
> > > +				  const struct tps23881_fw_conf *fw_conf) =20
> >=20
> > Does the device actually have flash? Or is this just downloading to
> > SRAM?
>=20
> It is downloading to SRAM.

So maybe rename these functions.

	Andrew


