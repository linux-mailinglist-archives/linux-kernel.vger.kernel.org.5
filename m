Return-Path: <linux-kernel+bounces-74907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575A85DFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B028354D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919A1374D9;
	Wed, 21 Feb 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnaKv/hV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBC41E4AF;
	Wed, 21 Feb 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526202; cv=none; b=HtrMxRkrBqjgZCeoGOQg2Ib19OsdCDSaCbOwvQ/o8lSK7WMBCTRWLuwRvzGyWyVqZqvKvjBkhjD+6HBsbz2yKJ+afVUQ5YtYk/Eon+GY6F0f4ip2qm+YLhOm9v9QVY1+uQUXYVcD1I02BHYWiSgbd1GpIhbW8oAUQ5298mLIpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526202; c=relaxed/simple;
	bh=qymbLOvSqp3zbYXm3A5nPTmLA9AeUS9MX95POI2/9Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8dNh9EOlNvxTgdd7jiOox0yOcXhdYGuDuS9L/NnntJI+RpJ8u6KbfuiToe5fMt/zwv5QG8IVImE/VYh1SV7MEYYZprybmpclPZnr6aCPz/XaIsvjIpAXz/oHImlrj5KzGfWLgkRFmMg5Dv23BGhoBgeo7g3a/OtXVczduUrYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnaKv/hV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE92C433F1;
	Wed, 21 Feb 2024 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708526202;
	bh=qymbLOvSqp3zbYXm3A5nPTmLA9AeUS9MX95POI2/9Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnaKv/hVzf/EMifF/czM+KXQ1HuU0M890L6xiokixoMqPExzkG1F5h560IEudKtlP
	 cnoiuJ9kIZ5P6bO9J5vNa2EhGsKlkMV2yr2krsYSlFdRthEgMVpZEdGltQT97i9Y7Q
	 EkUHh89SY2Gz25UGOlFbcOOtD0tvmY+U77GcaHSORjHlmJHjQgVbWwX5m8DjOj2KJb
	 UmuWMzb6yVCaZjv1LsJj1Geq1/MQcF+91LcIcwizcZ/Tb83DzyYjtDw8XmY8TRZLHV
	 8akLQddRz+yxUdxYr5E50JGZkdStjIQQZ5TxqsvONHPpnHRfuB7UQICPiNQXT9eFkV
	 kxkYT7+AvY2gQ==
Date: Wed, 21 Feb 2024 07:36:40 -0700
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20240221143640.GA2779189-robh@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
 <20240215105846.6dd48886@kernel.org>
 <20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
 <20240216173638.4bb12af2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216173638.4bb12af2@kernel.org>

On Fri, Feb 16, 2024 at 05:36:38PM -0800, Jakub Kicinski wrote:
> On Fri, 16 Feb 2024 10:42:11 +0100 Köry Maincent wrote:
> > > On Thu, 15 Feb 2024 17:02:46 +0100 Kory Maincent wrote:  
> > > > Introduce an enumeration to define PSE types (C33 or PoDL),
> > > > utilizing a bitfield for potential future support of both types.
> > > > Include 'pse_get_types' helper for external access to PSE type info.    
> > > 
> > > I haven't read the series, just noticed this breaks the build:
> > > 
> > > error: ../include/uapi/linux/pse.h: missing "WITH Linux-syscall-note" for
> > > SPDX-License-Identifier  
> > 
> > By curiosity how do you get that error? 
> > Is it with C=1? I didn't faced it with W=1.
> > C=1 is broken for several architecture like arm64, indeed I forgot to run it.
> 
> Not 100% sure, TBH, I suspect it's somehow enabled by allmodconfig.
> I don't think it's a C=1 thing because our clang build doesn't do C=1
> and it also hit it.

Probably from scripts/spdxcheck.py? IIRC, it has some dependencies which 
have to be installed to enable it.

Rob

