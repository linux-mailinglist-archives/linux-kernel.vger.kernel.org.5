Return-Path: <linux-kernel+bounces-63719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C05853398
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E3628D49C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D085E3CD;
	Tue, 13 Feb 2024 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLOvO8N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20405DF1F;
	Tue, 13 Feb 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835894; cv=none; b=ItV0Cit+4p+1AbO/5MH14mqMIEdM6nrPCO3c56KCh2HVvbfvpFC5Zit8PYGgoZ+3ZPbdSq4n5IRv6Vbx41NkK/XNF77NTOgu82KZxyQdV5Lv93IbHU8v3dmX699o1W7SLUEGaSKAWvEmMC5Vw32HcO4uiMbWS5zgaJmI+AhSMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835894; c=relaxed/simple;
	bh=DA7XyugR56rHmd6lff3TrQPIS1ykFC2LcDFfHg0VqqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKwnjnzKJ0l+JPL8D1A6bDCE2v/A1uXaM1oZlZDnTz9WZEkpTSPoq4gZNTdGP3qdYHrf2YqFXUt5IhA7NJ4KYy9hLbjuV/2JjQDsaFp2a9HITaa4b3sV+Vitdxx8TxZ20sjYp/Xtqnlo/fm9RW4fzTOa0Jk6wOfq2uF5YdKTzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLOvO8N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C57EC43399;
	Tue, 13 Feb 2024 14:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835894;
	bh=DA7XyugR56rHmd6lff3TrQPIS1ykFC2LcDFfHg0VqqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLOvO8N+mj5s1gLoQ4l8kWQPX94KxNmu1vXJXLq2m+fVEaUb25XDWhvAjQ5vuX0QE
	 ps5rf3S0cxBRShYe9DGQa1uaPGk/2LKPA8VOUd4fzyqwNgdXcU9mmGB1bujJ/1RleC
	 zhTmt+MoWeGPVJTpFVezCaYdnzoIiNyXSlXgFbe26nw+wZMDLHGRwtJnkenU+Qnp9X
	 ZwiFWpwKtHsNB23prNGZjopxtxhxyBE4+0WQ6dNrJ/QLbcJHw57mE877diGmLsKrzQ
	 3vfHBGFKCT74PeHpf/g4XzLTNFfroEXK48lpQ+tgmo+KwjfMtW676GtguxyipYddy7
	 FHqJ6qdcjHGuw==
Date: Tue, 13 Feb 2024 08:51:31 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Saravana Kannan <saravanak@google.com>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Message-ID: <20240213145131.GA1180152-robh@kernel.org>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
 <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
 <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aed988a09cb4347ec7ac1b682c4ee53b7d2a840b.camel@gmail.com>

On Mon, Feb 12, 2024 at 01:10:27PM +0100, Nuno Sá wrote:
> On Mon, 2024-02-05 at 13:09 +0100, Nuno Sa wrote:
> > Device links will drop their supplier + consumer refcounts
> > asynchronously. That means that the refcount of the of_node attached to
> > these devices will also be dropped asynchronously and so we cannot
> > guarantee the DT overlay assumption that the of_node refcount must be 1 in
> > __of_changeset_entry_destroy().
> > 
> > Given the above, call the new fwnode_links_flush_queue() helper to flush
> > the devlink workqueue so we can be sure that all links are dropped before
> > doing the proper checks.
> > 
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> >  drivers/of/dynamic.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> > index 3bf27052832f..b7153c72c9c9 100644
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/proc_fs.h>
> > +#include <linux/fwnode.h>
> >  
> >  #include "of_private.h"
> >  
> > @@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
> >  
> >  static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
> >  {
> > +	/*
> > +	 * device links drop their device references (and hence their of_node
> > +	 * references) asynchronously on a dedicated workqueue. Hence we need
> > +	 * to flush it to make sure everything is done before doing the below
> > +	 * checks.
> > +	 */
> > +	fwnode_links_flush_queue();
> >  	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
> >  	    of_node_check_flag(ce->np, OF_OVERLAY)) {
> >  		if (kref_read(&ce->np->kobj.kref) > 1) {
> > 
> 
> Hi Rob and Frank,
> 
> Any way you could take a look at this and see if you're ok with the change in the
> overlay code? 
> 
> On the devlink side , we already got the ok from Rafael.

Didn't Saravana say he was going to look at this? As of yesterday, he's 
also a DT maintainer so deferring to him.

Rob

