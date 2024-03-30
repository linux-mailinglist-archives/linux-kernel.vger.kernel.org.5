Return-Path: <linux-kernel+bounces-126259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D516089345E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7BB25D30
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAA149DE6;
	Sun, 31 Mar 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AgKIFxWL"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C35149C57;
	Sun, 31 Mar 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903377; cv=pass; b=Z0jCAmy1CUD2l/qPymo7cE9t504/bT75JXTctEDn479ff652QhAhwI4Cbk3J6ZE2B3BIy72gMdYCv7OvPu7oqrBZxIIu8rXZL9c51++5fzPC50wiViJD+tpeRtFiFc9/LOJDmLz6rkrj2fmwDJwvXU9rYYDlYdB5sEdk0SiKcDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903377; c=relaxed/simple;
	bh=gJx0oB7ZzuoCNKkwsr1UzGLJ3CRfFELmHureG9uOYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz+IQ/JletZIyJL+WGLz7Unf9RWEL4KIdUJCJPZgAPsMg7USoR2n6gYHzQVVbAgG6OLsg4SPedgW/FDlXLXIlaOpoSERFWNQvmBkXFq2WN9xYf3ma0QXR9n2b3ILbfwpzstnUSM0mY9All1BTO2nt6LykFP//s8oT0CTR/3DYbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=fail smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AgKIFxWL; arc=none smtp.client-ip=156.67.10.101; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=lunn.ch
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E33C1208B7;
	Sun, 31 Mar 2024 18:42:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-Trwkfp0syw; Sun, 31 Mar 2024 18:42:54 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6DBFE207D5;
	Sun, 31 Mar 2024 18:42:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6DBFE207D5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 5F89C80005E;
	Sun, 31 Mar 2024 18:42:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:42:54 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:04 +0000
X-sender: <netdev+bounces-83507-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAMJCmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 8468
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=netdev+bounces-83507-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com C1C5D2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AgKIFxWL"
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
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Mar 29, 2024 at 03:56:57PM +0100, Kory Maincent wrote:
> On Thu, 28 Mar 2024 17:24:17 +0100
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static int tps23881_flash_fw_part(struct i2c_client *client,
> > > +				  const char *fw_name,
> > > +				  const struct tps23881_fw_conf *fw_conf)  
> > 
> > Does the device actually have flash? Or is this just downloading to
> > SRAM?
> 
> It is downloading to SRAM.

So maybe rename these functions.

	Andrew


