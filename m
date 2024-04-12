Return-Path: <linux-kernel+bounces-141950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65148A2570
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2174F1C225D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34537182C3;
	Fri, 12 Apr 2024 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="IOdAEUyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cL1BFCA9"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1011125D5;
	Fri, 12 Apr 2024 05:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712898626; cv=none; b=XN/Vz5k8QNlhtrAek59liSJiBKjnY78T/DWr3zQQE+hylzSCfJj/iWiSzUQanYPfnHoL0M51VlfROwZQ9zfdozya3FMwt5t3Y1PkfzzwVFjcZ0Yi/B3MuILJDkwl12TjGUjpqD5yHKwO+UN3Dqu0sZ1lZlVfBmT8tiJ/G7hwfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712898626; c=relaxed/simple;
	bh=mmw7UBZ/NYh0/8gsyGUAEwtlNcxN961B/jKYuFDAE4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvomRzn26SdXc6vKvEfUyGQ2rDDsbZstudXu3aUtY4L9Czdm0akNgatcQjfTmxYS4xfyY0CCfzQD7EAbTkQZs5J8SYw1Z4FsXGhpLImkzh5wnFy72WN1kdzxsJN9dGbmFLaYQNiG/Pjq35lIlpcjzXnjc4W1fLeGtbRytAr45Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=IOdAEUyX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cL1BFCA9; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B625113802C7;
	Fri, 12 Apr 2024 01:10:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 12 Apr 2024 01:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712898623; x=1712985023; bh=VPZ7kJdh9c
	PLjRKHHVxTUf1hbUVmbHSA0q97FGn9WV4=; b=IOdAEUyXDYiVKbGbFZbRu/PbbL
	e9wo+0jyFCZ9E0FwrFEV7fGpZuT6VTGsRzJbPkxgtBjOxVVjMgQV7DwbR8adnEie
	8uHaYHFw1PSLu3YskQbjK98hH1QC+A+tL4MVQdbIVlN3TruepYUBRJHTfST0FKwX
	Q4B9l8R2ohw0QwPWr0l4GcjjeHD+X4j2+5GDuJjFL09X7hl4jGtcvUSKAULEn+iw
	sjmGVWowfpcwxPl1rF6AMNedtcU6763IGoVVornj1C3RFP7i3c1+LK0IDFhbR0jQ
	KQDDBHVQke6FtDF0+XlMiXhWxA0aeRsFe3TWBwJ5huDCB5I0IhHgzXACuDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712898623; x=1712985023; bh=VPZ7kJdh9cPLjRKHHVxTUf1hbUVm
	bHSA0q97FGn9WV4=; b=cL1BFCA9FcaVisURAZlGYil167ZIhQ4h2RD4txuKqMo+
	63ybBfi53GlsHgLotvTUIhmt9MlLZyLaWuQcsp3ygvty3xqCNOmhpBIpETMd6SFK
	N7oAOvl9CbadpHh70uE9jaR+rN/NvxVPRRu0/wB0uia6D3cRZcpOTdV26ExKHIBX
	0lBnRicg2itzASOgORuJl4FiyTGSSogopIfoad8DMT1D8Xn+qVMFajQ953vjV1JK
	LSfOV/FI1RnYqZSbSIJjRbMrrAMJH6lEl5wTMqC2cWSetiwmQ6RQ1BrdStWQK6Gk
	XpQ9BzzoJYo8pP5uf9AIIRctlXk3G1TPgQuY3fVOPA==
X-ME-Sender: <xms:P8IYZnal6_fiiOzIAmPTB_AiNZ32jNwoBvrgVyk42WeeOPfzcN3oHQ>
    <xme:P8IYZmaTu2rJKevnQe-veNO6jCw0rhenj22T0HjorinTD26H5bD5uJs4MG7WkB27y
    UDfk68NjR8OcQ>
X-ME-Received: <xmr:P8IYZp--s0X167KOClclxdJCdrFZEtPGbEnHNL42j9qub1c_OTB2BOxGRgkynaUJ91JI7Q5nHJBcSJU3Vo4HFf2dtW-5kO7PxYHkug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeitddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:P8IYZtpvQgzUs2t_asAj7-EviUzBNdZTR5Yt2Y_IzSfkxnp4gsZMpg>
    <xmx:P8IYZipAA076L1jtp-WfGIoAPgd1bu7DW-vsLLel6rStuxKwnp732A>
    <xmx:P8IYZjSqpjbtpY2I58US2_AY1Zq8Ua8GxbutF-XiszGlLducdf8hxw>
    <xmx:P8IYZqrBbnSPqWn8Wr7hy9rVFDk9hMMu3JPWhvJdGPS8Ij3xaCHZCA>
    <xmx:P8IYZvgwwjjouRJN8fKzKeayGKbk1UH2KwjHACQ0XTQ9MZKhV8sPqb0g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Apr 2024 01:10:22 -0400 (EDT)
Date: Fri, 12 Apr 2024 07:10:19 +0200
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	PowerPC <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the driver-core.current tree
Message-ID: <2024041201-shrug-carefully-c3a4@gregkh>
References: <20240412084310.035f018d@canb.auug.org.au>
 <87mspzci46.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mspzci46.fsf@mail.lhotse>

On Fri, Apr 12, 2024 at 02:36:25PM +1000, Michael Ellerman wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Hi all,
> >
> > The following commit is also in the powerpc-fixes tree as a different
> > commit (but the same patch):
> >
> >   156539fd6501 ("Documentation: embargoed-hardware-issues.rst: Add myself for Power")
> >
> > This is commit
> >
> >   36627111b568 ("Documentation: embargoed-hardware-issues.rst: Add myself for Power")
> >
> > in the powerpc-fixes tree.
> 
> I can drop my version easily enough.

Either is fine, or both, it doesn't really matter :)

thanks,

greg k-h

