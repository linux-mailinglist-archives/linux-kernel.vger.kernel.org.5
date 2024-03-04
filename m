Return-Path: <linux-kernel+bounces-90812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCE870555
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF794B2A409
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804F47793;
	Mon,  4 Mar 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnqT6sH8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6214ABC;
	Mon,  4 Mar 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565725; cv=none; b=p12GF/aQcauO8HCQah4cFBuH1d4U2d+nvWWB/Na+c2S7OxyCWTZ8zg788BH28ekYJHZYfeVldvEG+NNv+UoBP2atWg9RMe9FPdivHOfw2Ug3CSBDcj27tiOp2BA0n83odVqLWc7SZfMq6YPduv0i2cMjA0IsQOFQEaFFPaE76G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565725; c=relaxed/simple;
	bh=0J2+33p5a+aTwSIDVi9UTSdR58s5N2JFzwkPJEshxqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr2k6fqFBGdkGm67y8YcQy4q+8vcRQM7Ad9yvPVIT3B0n+nEGUoLL5hwzpQX3LJYmrsER78O4d7M3hYASuPWBAbKL15Kuu6Z8o5LclpWEKM8NUGaWIkCOqirz9cQZXdhDq9FmAiTheUSzsFzWrFgPoFCftRIE00g0D2E0nKhf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnqT6sH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B369BC43390;
	Mon,  4 Mar 2024 15:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565725;
	bh=0J2+33p5a+aTwSIDVi9UTSdR58s5N2JFzwkPJEshxqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnqT6sH8hlYUxWnS009nN43I4h1roAfI3QqtNzSaeKc0aQREiBEU0baxR6Cjb6BCq
	 mpPg/87hpW9dSsv/jqlRQ+16BVc5EjxFoOCxuASQEP3NNaL6zipSVTFZe9KnGiZD1C
	 AuHHzzeCdQ0A71A9C8pXfCdoGsHYLKpjJJtzitdBu7TmCiVLhBJa95LmSLiY6e7SLv
	 U4FgjUWoZZbW46eDVTmIZofPtcsbScWWbXuA4z4szoQxuzW6ePvNC32MFyNDN2kBVq
	 cF9xhqKEeArjTP+o2Ot5YudXjWJXsjdNyklTwTt91MRO0vKsMyKvhbjDvzMzrP7e7x
	 hzAP4ZwuT8urg==
Date: Mon, 4 Mar 2024 09:22:02 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] of: overlay: Synchronize of_overlay_remove() with
 the devlink removals
Message-ID: <20240304152202.GA222088-robh@kernel.org>
References: <20240229105204.720717-1-herve.codina@bootlin.com>
 <20240229105204.720717-3-herve.codina@bootlin.com>
 <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acb69aa8c1a4c4e9849123ef538b9646a71507a0.camel@gmail.com>

On Thu, Feb 29, 2024 at 12:18:49PM +0100, Nuno Sá wrote:
> On Thu, 2024-02-29 at 11:52 +0100, Herve Codina wrote:
> > In the following sequence:
> >   1) of_platform_depopulate()
> >   2) of_overlay_remove()
> > 
> > During the step 1, devices are destroyed and devlinks are removed.
> > During the step 2, OF nodes are destroyed but
> > __of_changeset_entry_destroy() can raise warnings related to missing
> > of_node_put():
> >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> > 
> > Indeed, during the devlink removals performed at step 1, the removal
> > itself releasing the device (and the attached of_node) is done by a job
> > queued in a workqueue and so, it is done asynchronously with respect to
> > function calls.
> > When the warning is present, of_node_put() will be called but wrongly
> > too late from the workqueue job.
> > 
> > In order to be sure that any ongoing devlink removals are done before
> > the of_node destruction, synchronize the of_overlay_remove() with the
> > devlink removals.
> > 
> > Fixes: 80dd33cf72d1 ("drivers: base: Fix device link removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/of/overlay.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 2ae7e9d24a64..7a010a62b9d8 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -8,6 +8,7 @@
> >  
> >  #define pr_fmt(fmt)	"OF: overlay: " fmt
> >  
> > +#include <linux/device.h>
> 
> This is clearly up to the DT maintainers to decide but, IMHO, I would very much
> prefer to see fwnode.h included in here rather than directly device.h (so yeah,
> renaming the function to fwnode_*).

IMO, the DT code should know almost nothing about fwnode because that's 
the layer above it. But then overlay stuff is kind of a layer above the 
core DT code too.

> But yeah, I might be biased by own series :)
> 
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -853,6 +854,14 @@ static void free_overlay_changeset(struct
> > overlay_changeset *ovcs)
> >  {
> >  	int i;
> >  
> > +	/*
> > +	 * Wait for any ongoing device link removals before removing some of
> > +	 * nodes. Drop the global lock while waiting
> > +	 */
> > +	mutex_unlock(&of_mutex);
> > +	device_link_wait_removal();
> > +	mutex_lock(&of_mutex);
> 
> I'm still not convinced we need to drop the lock. What happens if someone else
> grabs the lock while we are in device_link_wait_removal()? Can we guarantee that
> we can't screw things badly?

It is also just ugly because it's the callers of 
free_overlay_changeset() that hold the lock and now we're releasing it 
behind their back.

As device_link_wait_removal() is called before we touch anything, can't 
it be called before we take the lock? And do we need to call it if 
applying the overlay fails?

Rob

