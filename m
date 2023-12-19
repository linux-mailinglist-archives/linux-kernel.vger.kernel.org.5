Return-Path: <linux-kernel+bounces-5796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54957818F94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E351C2516D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3843D0BF;
	Tue, 19 Dec 2023 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fMcxRgA0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4A3D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8319FC433C8;
	Tue, 19 Dec 2023 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703009585;
	bh=LPaEVsI1WdhCKCTN3sP4iLdz4YB74R0k2T+UOI2ugCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMcxRgA0wqBB/v32dxHnl8xDSGNkzjSK0llDH98uVSm7uXZHKuZv+fv99fRGEs3zs
	 UvyToxzClXvMSx1ALgfrhKXI15to4JixvrGoZHqnx4HKnOOVj5vfw4mbB5EFPo1OgT
	 Kf2N9hyuZkIRCgTWEZB2h+Zy089AF0Vfz+wihEEs=
Date: Tue, 19 Dec 2023 19:13:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ertman, David M" <david.m.ertman@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Weiny, Ira" <ira.weiny@intel.com>,
	William Breathitt Gray <william.gray@linaro.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Kevin Hilman <khilman@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] driver core: mark remaining local bus_type variables as
 const
Message-ID: <2023121943-slather-collide-f61c@gregkh>
References: <2023121908-paver-follow-cc21@gregkh>
 <MW5PR11MB5811AB2DDE57E309A329F5BEDD97A@MW5PR11MB5811.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5811AB2DDE57E309A329F5BEDD97A@MW5PR11MB5811.namprd11.prod.outlook.com>

On Tue, Dec 19, 2023 at 06:02:33PM +0000, Ertman, David M wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Tuesday, December 19, 2023 7:35 AM
> > To: rafael@kernel.org; linux-kernel@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Ertman, David M
> > <david.m.ertman@intel.com>; Weiny, Ira <ira.weiny@intel.com>; William
> > Breathitt Gray <william.gray@linaro.org>; David Hildenbrand
> > <david@redhat.com>; Oscar Salvador <osalvador@suse.de>; Kevin Hilman
> > <khilman@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Brown, Len
> > <len.brown@intel.com>
> > Subject: [PATCH] driver core: mark remaining local bus_type variables as
> > const
> > 
> > Now that the driver core can properly handle constant struct bus_type,
> > change the local driver core bus_type variables to be a constant
> > structure as well, placing them into read-only memory which can not be
> > modified at runtime.
> > 
> > Cc: Dave Ertman <david.m.ertman@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: William Breathitt Gray <william.gray@linaro.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/auxiliary.c    | 2 +-
> >  drivers/base/isa.c          | 2 +-
> >  drivers/base/memory.c       | 2 +-
> >  drivers/base/node.c         | 2 +-
> >  drivers/base/power/domain.c | 2 +-
> >  drivers/base/soc.c          | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
> > index 4d4c2c8d26c4..d3a2c40c2f12 100644
> > --- a/drivers/base/auxiliary.c
> > +++ b/drivers/base/auxiliary.c
> > @@ -244,7 +244,7 @@ static void auxiliary_bus_shutdown(struct device
> > *dev)
> >  		auxdrv->shutdown(auxdev);
> >  }
> > 
> > -static struct bus_type auxiliary_bus_type = {
> > +static const struct bus_type auxiliary_bus_type = {
> >  	.name = "auxiliary",
> >  	.probe = auxiliary_bus_probe,
> >  	.remove = auxiliary_bus_remove,
> > diff --git a/drivers/base/isa.c b/drivers/base/isa.c
> > index 675ad3139224..e23d0b49a793 100644
> > --- a/drivers/base/isa.c
> > +++ b/drivers/base/isa.c
> 
> LGTM - ACK

So, is that an "Acked-by:" type response?  We need something standard
for our tools to pick up...

thanks,

greg k-h

