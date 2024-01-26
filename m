Return-Path: <linux-kernel+bounces-39750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E383D5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA551C26148
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD686BB45;
	Fri, 26 Jan 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="VHVMvPeZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DerVIPga"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909171401E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256670; cv=none; b=FfAb7ZPNmdGIwbiTwowrPLw3zUp7HFe1qfEZQbk35shr0pcw085HtuaEr7QtgwsvZlf4FQc4uechLOhMimK8khqezZ2zVcazgT6z84jdRWxcCc59XsdBf8Xsf8y1In2a2yM3wLZVJEAP6RtwjPf+F5Mz/QRFArNPMJlnHqKO6qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256670; c=relaxed/simple;
	bh=FCKAlcDbdu/WUlXZP4jFOVFb4lOdexmFIi8g/nSe5Qw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=n8phn90VcEItubeLgJmBp7fR0O5cWpq/YWLc+V63i30gr0XmJvEIYGnBlrYCC5DVYg24B6ii/QagGtsaMn3rTArTKnwn+XEPvyqa5EXc5+Zc2M9ET/1eOKumP+NPw8UjY6TKpsXL8AwdYYkcygXh4Lfkls9GgjNlW2aIdInhSY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=VHVMvPeZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DerVIPga; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 84D3F3200A44;
	Fri, 26 Jan 2024 03:11:04 -0500 (EST)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Fri, 26 Jan 2024 03:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1706256664; x=1706343064; bh=ZSH7ixKFqF
	IHWwtAx0naj/Z7GfbEswo8MhtgRHt9sw0=; b=VHVMvPeZev34ZUSV3soDdU5lEF
	oP392jvFwe00okOo3xJwC9st2yJQm65o4+2aZfpmFL+XKfKcMTm9vxOHFWXe7uOh
	P6xw6jxXNHGHD0cAOwHYRy3KHDSCkIibFSzMHFQ1hxgE8XUqWRDVeJ+1W+XM+2fL
	olKV/m7syLrnANDE0RZ4CYb0zeIOxTkBbt3BYAFFQBb9LpTD9cf2yeXEsHek0ICc
	6i0lYaHeNY93i6vOS3rq0Jrg/Fzzt1zPg+xyliPsV58yeNpZT9vS0tEcrO5NczwA
	DPzAEZNbCwLONNRwCc6qg1MZ7j1fs190LQbpVFEWRXa91SK9tha01sXcKZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706256664; x=1706343064; bh=ZSH7ixKFqFIHWwtAx0naj/Z7GfbE
	swo8MhtgRHt9sw0=; b=DerVIPgaKX1w6yVjmksU9ueVMig8rETzVko1yhlH8eUP
	c7uyVU+J3aQIuiFRLjsWVnh4UfpIk4K/QMD376aQcPpErhTL2yaCqsT7AVFCoUCg
	pQPiPZk+0mCpC7xRYwF0h7uisgHR4HTOTkgbJn2s95OBM0NW7wsgvBxNBcKAwYeu
	HXnn21gu1Fne/BwA7fSfg/afuyQFpeEWLFM0nYpV2l+MFtUi+3CgmUIW1uwcx03F
	EG/XZxYvaBU1imnjhFPiqOSRdS9hGqqJ8dY1pp1zsfwEH+7Xgnw2zhjgqiH+1uxq
	MTld+Gclw11W1oci3APWxv4t7iLGMtca1LryRTxm2Q==
X-ME-Sender: <xms:F2mzZYfREBZ6W34ZnNROZfpc8Qlx1If-jX7iva6XIu8UnYN0Je27NA>
    <xme:F2mzZaOc0gPcrsRG7JBXA6HW_RFfhYWVHG_FL-i4eHRjqyivoGB_uYAYLehu1gbKG
    gI6v5cgbSVVd1ArvPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeliedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfnfhu
    khgvucflohhnvghsfdcuoehluhhkvgeslhhjohhnvghsrdguvghvqeenucggtffrrghtth
    gvrhhnpedugedvhfelheejhfekvdeuudekfeefledtueegvddtteffheevjedukeejleev
    tdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:F2mzZZh7C5GlvqKGXQgWCmpPlThiF9BIMUGewkH9y2B0SlnxmSXh0g>
    <xmx:F2mzZd-b8RcgGD1Wd5897EGQLXD13Rp1XCyhfzSZuAJgDLwAXWuxsw>
    <xmx:F2mzZUt8wZPK3zFFqU2R6223RifSwhKsW1urb_ajF4KYuP110H61NA>
    <xmx:GGmzZd6gwp3d9pOxiwGQ9myk69XAhL9aa9H0TEzSY1M5T3FEHsng3A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BE0752340080; Fri, 26 Jan 2024 03:11:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9db5a3c1-40b1-43fb-9c31-53c28d2b63c6@app.fastmail.com>
In-Reply-To: <da062d7e-c06c-40f8-b2ad-9dd5e82ff596@redhat.com>
References: <20240115211829.48251-1-luke@ljones.dev>
 <da062d7e-c06c-40f8-b2ad-9dd5e82ff596@redhat.com>
Date: Fri, 26 Jan 2024 21:10:41 +1300
From: "Luke Jones" <luke@ljones.dev>
To: "Hans de Goede" <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add Luke Jones as maintainer for asus notebooks
Content-Type: text/plain



On Tue, 16 Jan 2024, at 11:45 PM, Hans de Goede wrote:
> Hi,
> 
> On 1/15/24 22:18, Luke D. Jones wrote:
> > Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
> > DRIVERS" as suggested by Hans de Goede based on my history of
> > contributions.
> > 
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f5c2450fa4ec..e7843beaa589 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3147,6 +3147,7 @@ F: drivers/hwmon/asus-ec-sensors.c
> >  
> >  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
> >  M: Corentin Chary <corentin.chary@gmail.com>
> > +M: Luke D. Jones <luke@lones.dev>
> 
> heh there is a typo there that should be @ljones.dev ,
> I have fixed this up now in my review-hans branch.

Thanks for spotting that. The laptop I have been testing has issues with key presses sometimes.

> Regards,
> 
> Hans
> 
> 
> >  L: acpi4asus-user@lists.sourceforge.net
> >  L: platform-driver-x86@vger.kernel.org
> >  S: Maintained
> 
> 

