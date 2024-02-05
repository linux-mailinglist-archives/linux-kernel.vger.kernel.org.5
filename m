Return-Path: <linux-kernel+bounces-52295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD243849670
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BBDB22C24
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201112B88;
	Mon,  5 Feb 2024 09:27:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2E125C0;
	Mon,  5 Feb 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125253; cv=none; b=a35xqss8OIkpE2GpmztzfNdpvS81c7gJxVU3/WJLrS+U97JpET203SSr4XbJEr+Gk+nTz7XUNhVEq9HHWd8OKBTN1wf2a1Fl4Si7MplFwGajfy/KIvfsU71kzBcd8YnHyuVZBGYs0hPdoB02MLa31OFEVhcwFkJp2CkcPTfvwJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125253; c=relaxed/simple;
	bh=2nBbOXY86fuqehjGOV18bjyj+i/6FqOKkuzJddpv0JU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1AQ+biC1+OPtfScrDOr2oYNOAOlVNp+FzgRtnogc34WsVN7yWGqF31RVkCn4OaRU/g+byYY5e/DDasRdpCutMpUPDGuUzl7rCJrC13nQsXbBrlGI/lH00sjAeT7ubSnbVc9ja5uzfdfQqjaLGuQQn++j5EMNqxIT2z8r2qa7eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT1Cz5cGjz6GBQk;
	Mon,  5 Feb 2024 17:24:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6229F140A36;
	Mon,  5 Feb 2024 17:27:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 5 Feb
 2024 09:27:26 +0000
Date: Mon, 5 Feb 2024 09:27:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
	"Sumera Priyadarsini" <sylphrenadin@gmail.com>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240205092726.00002eb0@Huawei.com>
In-Reply-To: <alpine.DEB.2.22.394.2402042224280.3137@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org>
	<alpine.DEB.2.22.394.2401281903550.3119@hadrien>
	<20240129114218.00003c34@Huawei.com>
	<alpine.DEB.2.22.394.2401291455430.8649@hadrien>
	<20240129195227.3c3adae1@jic23-huawei>
	<alpine.DEB.2.22.394.2401292120260.32795@hadrien>
	<20240130093854.00000acc@Huawei.com>
	<alpine.DEB.2.22.394.2401312234250.3245@hadrien>
	<20240204210804.0febf2fc@jic23-huawei>
	<alpine.DEB.2.22.394.2402042224280.3137@hadrien>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 4 Feb 2024 22:34:25 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 4 Feb 2024, Jonathan Cameron wrote:
> 
> > On Wed, 31 Jan 2024 22:38:21 +0100 (CET)
> > Julia Lawall <julia.lawall@inria.fr> wrote:
> >  
> > > Here are some loop cases.  The semantic patch is as follows:
> > >
> > > #spatch --allow-inconsistent-paths
> > >
> > > @@
> > > expression node;
> > > identifier child;
> > > symbol drop_me;
> > > iterator name for_each_child_of_node;
> > > @@
> > >
> > > for_each_child_of_node(node,child) {
> > >   ...
> > > + of_node_put(drop_me, child);
> > > }
> > >
> > > @@
> > > expression node;
> > > identifier child;
> > > symbol drop_me;
> > > iterator name for_each_child_of_node, for_each_child_of_node_scoped;
> > > identifier L;
> > > @@
> > >
> > > - struct device_node *child;
> > >  ... when != child
> > > -for_each_child_of_node
> > > +for_each_child_of_node_scoped
> > >   (node,child) {
> > >    ... when strict
> > > (
> > > -   {
> > > -   of_node_put(child);
> > >     return ...;
> > > -   }
> > > |
> > > -   {
> > > -   of_node_put(child);
> > >     goto L;
> > > -   }
> > > |
> > > -   {
> > > -   of_node_put(child);
> > >     break;
> > > -   }
> > > |
> > >     continue;
> > > |
> > > -   of_node_put(child);
> > >     return ...;
> > > |
> > > -   of_node_put(child);
> > >     break;
> > > |
> > > -  of_node_put(drop_me, child);
> > > )
> > > }
> > >  ... when != child
> > >
> > > @@
> > > expression child;
> > > @@
> > >
> > > - of_node_put(drop_me, child);
> > >
> > > -------------------------------
> > >
> > > This is quite conservative, in that it requires the only use of the child
> > > variable to be in a single for_each_child_of_node loop at top level.
> > >
> > > The drop_me thing is a hack to be able to refer to the bottom of the loop
> > > in the same way as of_node_puts in front of returns etc are referenced.
> > >
> > > This works fine when multiple device_node variables are declared at once.
> > >
> > > The result is below.
> > >  
> > Very nice!
> >
> > One issue is that Rob is keen that we also take this opportunity to
> > evaluate if the _available_ form is the more appropriate one.
> >
> > Given that access either no defined "status" in the child node or
> > it being set to "okay" it is what should be used in the vast majority of
> > cases.
> >
> > For reference, the property.h version only uses the available form.
> >
> > So I think we'll need some hand checking of each case but for vast majority
> > it will be very straight forward.  
> 
> I'm not sure to follow this.  If the check is straightforward, perhaps it
> can be integrated into the rule?  But I'm not sure what to check for.

I don't think it will be easy.  Perhaps Rob can help on when the
_available_ case is the wrong one?  Is this ever a characteristic of
the binding. I guess in some cases it might be a characteristic of
the binding?

> 
> > One question is whether it is worth the scoped loops in cases
> > where there isn't a patch where we break out of or return from the loop
> > before it finishes.  Do we put them in as a defensive measure?  
> 
> I wondered about this also.  My thought was that it is better to be
> uniform.  And maybe a break would be added later.

Rob and other DT folk, what do you think on this?
Shall we convert cases where there isn't currently a path in which the
autocleanup receives anything other than a NULL.

i.e.

for_each_available_of_child_node_scoped(x, y) {
	no breaks or returns form in here.
}

on basis it's not 'wrong' and is defensive against future changes that
would require manual cleanup or the scoped for loop.

> 
> > Sometimes we are going to want to combine this refactor with
> > some of the ones your previous script caught in a single patch given
> > it's roughly the same sort of change.  
> 
> Agreed.  Some blocks of code should indeed become much simpler.
> 
> >
> >  
> > > julia
> > >
> > > diff -u -p a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > --- a/drivers/of/unittest.c
> > > +++ b/drivers/of/unittest.c
> > > @@ -2789,7 +2789,7 @@ static int unittest_i2c_mux_probe(struct
> > >  	int i, nchans;
> > >  	struct device *dev = &client->dev;
> > >  	struct i2c_adapter *adap = client->adapter;
> > > -	struct device_node *np = client->dev.of_node, *child;
> > > +	struct device_node *np = client->dev.of_node;
> > >  	struct i2c_mux_core *muxc;
> > >  	u32 reg, max_reg;
> > >
> > > @@ -2801,7 +2801,7 @@ static int unittest_i2c_mux_probe(struct
> > >  	}
> > >
> > >  	max_reg = (u32)-1;
> > > -	for_each_child_of_node(np, child) {
> > > +	for_each_child_of_node_scoped(np, child) {  
> >
> > This was a case I left alone in the original series because the auto
> > cleanup doesn't end up doing anything in any paths.
> >  
> > >  		if (of_property_read_u32(child, "reg", &reg))
> > >  			continue;
> > >  		if (max_reg == (u32)-1 || reg > max_reg)
> > >  
> >
> >
> >  
> > > diff -u -p a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
> > > --- a/drivers/regulator/scmi-regulator.c
> > > +++ b/drivers/regulator/scmi-regulator.c
> > > @@ -297,7 +297,7 @@ static int process_scmi_regulator_of_nod
> > >  static int scmi_regulator_probe(struct scmi_device *sdev)
> > >  {
> > >  	int d, ret, num_doms;
> > > -	struct device_node *np, *child;
> > > +	struct device_node *np;
> > >  	const struct scmi_handle *handle = sdev->handle;
> > >  	struct scmi_regulator_info *rinfo;
> > >  	struct scmi_protocol_handle *ph;
> > > @@ -341,13 +341,11 @@ static int scmi_regulator_probe(struct s
> > >  	 */
> > >  	of_node_get(handle->dev->of_node);
> > >  	np = of_find_node_by_name(handle->dev->of_node, "regulators");
> > > -	for_each_child_of_node(np, child) {
> > > +	for_each_child_of_node_scoped(np, child) {
> > >  		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
> > >  		/* abort on any mem issue */
> > > -		if (ret == -ENOMEM) {
> > > -			of_node_put(child);
> > > +		if (ret == -ENOMEM)
> > >  			return ret;
> > > -		}  
> > Current code leaks np in this path :(
> >  
> > >  	}
> > >  	of_node_put(np);
> > >  	/*  
> >
> >  
> > > diff -u -p a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
> > > --- a/drivers/crypto/nx/nx-common-powernv.c
> > > +++ b/drivers/crypto/nx/nx-common-powernv.c
> > > @@ -907,7 +907,6 @@ static int __init nx_powernv_probe_vas(s
> > >  {
> > >  	int chip_id, vasid, ret = 0;
> > >  	int ct_842 = 0, ct_gzip = 0;
> > > -	struct device_node *dn;
> > >
> > >  	chip_id = of_get_ibm_chip_id(pn);
> > >  	if (chip_id < 0) {
> > > @@ -921,7 +920,7 @@ static int __init nx_powernv_probe_vas(s
> > >  		return -EINVAL;
> > >  	}
> > >
> > > -	for_each_child_of_node(pn, dn) {
> > > +	for_each_child_of_node_scoped(pn, dn) {
> > >  		ret = find_nx_device_tree(dn, chip_id, vasid, NX_CT_842,
> > >  					"ibm,p9-nx-842", &ct_842);
> > >
> > > @@ -929,10 +928,8 @@ static int __init nx_powernv_probe_vas(s
> > >  			ret = find_nx_device_tree(dn, chip_id, vasid,
> > >  				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);  
> > The handling in here is odd (buggy?). There is an of_node_put()
> > in the failure path inside find_nx_device_tree() as well as out here.  
> > >
> > > -		if (ret) {
> > > -			of_node_put(dn);
> > > +		if (ret)
> > >  			return ret;
> > > -		}
> > >  	}
> > >
> > >  	if (!ct_842 || !ct_gzip) {  
> >
> > I've glanced at a few of the others and some of them are hard.
> > This refactor is fine, but the other device_node handling often
> > is complex and I think fragile.  So definitely room for improvement!  
> 
> I agree with all the above comments.
> 
> julia


