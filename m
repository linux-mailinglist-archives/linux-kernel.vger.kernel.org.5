Return-Path: <linux-kernel+bounces-71856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A6C85ABD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0E4284D64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ED250276;
	Mon, 19 Feb 2024 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oom1n7lv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6347F7E;
	Mon, 19 Feb 2024 19:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708370095; cv=none; b=htvwsISvZ/SZokX4nrueo+9kQcbtCiJSL34lZY2bmJ2xCAuFeJXqGbaJcEo8AKFJ8pxcnMmb8hg43hfUNk6X+TzgEZ2xm6qxDnZWQqf30v5K6RAFya5JNL3X78xaXuXy8LwTtfBaCoBqc1/CkaxHs/caEn7kmjMswks65Pmrfig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708370095; c=relaxed/simple;
	bh=QTBG/aGzAOq3/rChRUOGGC1heGIPVEN2ILRn4fyBPaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahh79H8Fea/ne//OilgGusDP3Ci070V5LMwPdWMMAbD2i4HeFVizKL19JFQnG+AlsnLeDQyANbu54Z7Kv5wZC9e05i91NUfufuxZAGREk+y9BZ1XIDYAQ1LfaIsMNMNl8WtwPYqega7wtsXqdBv16YsVO4b7N11jmOSFQVHkXVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oom1n7lv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDD0C433C7;
	Mon, 19 Feb 2024 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708370094;
	bh=QTBG/aGzAOq3/rChRUOGGC1heGIPVEN2ILRn4fyBPaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oom1n7lvtXC1D4z0OR2TpVTNMA8sRzwh5TLdnrF1pWTGRKLZwxUC6KwKh5pPvnFjg
	 ZRTzJzM44PKQaZ8NsNWzSPaeM0OJ48nCXXg03+ss3EkM1DtBnppjM+FhGK70aH7fKM
	 yy7AlkvB7HU7ZWhzlH14GtEMlPOwIz2jeaiERCABY8hWsCxaxXKHxI6CTrhTwkTFEn
	 bEvfp6vkLQHMYv2gyhJ0oVKxYKTR0SiefOZmRyPluDK2/E8PEPR7lg3jCYBDukPKnt
	 Vw2Fn90Gyt7000pEsJWkrgg6aPQRGiXN6DasBn1N7WaKa04qXrl8nyMj5ZajHaKCvQ
	 2LTU6b6bOEzEw==
Date: Mon, 19 Feb 2024 20:14:47 +0100
From: Niklas Cassel <cassel@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"Simek, Michal" <michal.simek@amd.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
 support
Message-ID: <ZdOop9IHRxtIY+Ds@x1-carbon>
References: <ZdMp+QBiays6fprk@x1-carbon>
 <9427c0fd-f48a-4104-ac7e-2929be3562af@web.de>
 <MN0PR12MB59537A9F0EAEAC9E844C8DCDB7512@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN0PR12MB59537A9F0EAEAC9E844C8DCDB7512@MN0PR12MB5953.namprd12.prod.outlook.com>

Hello Radhey, Markus,

On Mon, Feb 19, 2024 at 06:42:49PM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Markus Elfring <Markus.Elfring@web.de>
> > Sent: Monday, February 19, 2024 9:27 PM
> > To: Niklas Cassel <cassel@kernel.org>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Damien Le Moal
> > <dlemoal@kernel.org>; Jens Axboe <axboe@kernel.dk>; Simek, Michal
> > <michal.simek@amd.com>; Philipp Zabel <p.zabel@pengutronix.de>; linux-
> > ide@vger.kernel.org; kernel-janitors@vger.kernel.org
> > Cc: LKML <linux-kernel@vger.kernel.org>; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY
> > support
> > 
> > > > Platform clock and phy error resources are not cleaned up in Xilinx GT
> > PHY
> > > > error path.
> > > >
> > > > To fix introduce the function ceva_ahci_platform_enable_resources()
> > …
> > > Applied:
> > >
> > https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=for-
> > 6.8-fixes
> > 
> > The error code “-EINVAL” was set before the statement “goto
> > disable_resources”
> > multiple times in the adjusted implementation of the function
> > “ceva_ahci_probe”.
> > I suggest to add a jump target so that a bit of exception handling
> > can be better reused at the end of this function.
> > 
> > 
> > How do you think about to apply the following script for the semantic
> > patch language (Coccinelle software) accordingly?
> > 
> > 
> > @replacement1@
> > identifier rc;
> > @@
> >  <+...
> >  if (...)
> >  {
> >     ... when != rc
> > -   rc = -EINVAL;
> >     goto
> > -        disable_resources
> > +        e_inval
> >     ;
> >  }
> >  ...+>
> >  return 0;
> > +
> > +e_inval:
> > +rc = -EINVAL;
> >  disable_resources:
> >  ahci_platform_disable_resources(hpriv);
> > 
> > @replacement2 disable neg_if, drop_else@
> > identifier replacement1.rc;
> > statement is;
> > @@
> >  if (...)
> >     is
> >  else
> >  {
> >     ... when != rc
> > -   rc = -EINVAL;
> >     goto
> > -        disable_resources
> > +        e_inval
> >     ;
> >  }
> > 
> > 
> Thanks for the suggestion. However, taking a look at the existing implementation
> i think we should return error code *as is * from of_property_read() APIs.
> and get rid of rc=-EINVAL reassignment itself. 
> 
> If it sounds ok, I can add it to my to-do list and send out a patch.

Sounds good to me.


Kind regards,
Niklas

