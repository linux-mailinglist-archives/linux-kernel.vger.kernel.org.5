Return-Path: <linux-kernel+bounces-51918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98DE8490BA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED3F283079
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E32C684;
	Sun,  4 Feb 2024 21:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bKfnSCcF"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50E2C68A;
	Sun,  4 Feb 2024 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707082479; cv=none; b=kYmtLmtoNwQ2TBxp5FDkTrGh305G3sX1Lm9dQiKu5xmQl3oFS5fDThWDdOwXY28E2sVPq7ml6tSQheMDOwYC5OhIO+tfXw523Hm+p0lT0MTC399GKhJHQzmnsVMHCpVBjd9OeHRwJszlMBbGcT/4Z43H5f3UfWJ6DIgBmQnwfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707082479; c=relaxed/simple;
	bh=S6+Cor30FNIKmQig5SFvyR2A7LzTZxa/w8TG82vjYOU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q7XBYQPfe9mOerSX5tj2usvrUFCJ7FYSSdFIlKJibGkosQCoC8FSWq92LX23DraOB8g3yPF4idzX0OBZOLAj1CL+3rQ+AiBzAMqrkATAervLNOxh6w9igR5dIXMfooLlpz5B7IeVe0mVO3JUHtqf0I29w41aI33UUqkfJSFepHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bKfnSCcF; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M9ID8yS+D8h/DM/QHCMnWaBQN3WKvhfGbZdd32R1aCU=;
  b=bKfnSCcFRlcUMkA7PRsSoyEV2UEKDA61FATCYcO1b2gjd0rhbL3qBIxL
   KVnyrOiLxB4nd4kBYEcuxJ3i+P1XYoAFDld90+oZyzKGwjotCchghX4zw
   +MQkMFBtjf76grAI7fKIM/GI/KiwxKBD9diNfusjF/zW08wskDC1pltxf
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,242,1701126000"; 
   d="scan'208";a="150188504"
Received: from 192-228.83-90.static-ip.oleane.fr (HELO hadrien) ([90.83.228.192])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:34:26 +0100
Date: Sun, 4 Feb 2024 22:34:25 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jonathan Cameron <jic23@kernel.org>
cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-iio@vger.kernel.org, 
    Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
    linux-kernel@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
In-Reply-To: <20240204210804.0febf2fc@jic23-huawei>
Message-ID: <alpine.DEB.2.22.394.2402042224280.3137@hadrien>
References: <20240128160542.178315-1-jic23@kernel.org> <alpine.DEB.2.22.394.2401281903550.3119@hadrien> <20240129114218.00003c34@Huawei.com> <alpine.DEB.2.22.394.2401291455430.8649@hadrien> <20240129195227.3c3adae1@jic23-huawei> <alpine.DEB.2.22.394.2401292120260.32795@hadrien>
 <20240130093854.00000acc@Huawei.com> <alpine.DEB.2.22.394.2401312234250.3245@hadrien> <20240204210804.0febf2fc@jic23-huawei>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 4 Feb 2024, Jonathan Cameron wrote:

> On Wed, 31 Jan 2024 22:38:21 +0100 (CET)
> Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > Here are some loop cases.  The semantic patch is as follows:
> >
> > #spatch --allow-inconsistent-paths
> >
> > @@
> > expression node;
> > identifier child;
> > symbol drop_me;
> > iterator name for_each_child_of_node;
> > @@
> >
> > for_each_child_of_node(node,child) {
> >   ...
> > + of_node_put(drop_me, child);
> > }
> >
> > @@
> > expression node;
> > identifier child;
> > symbol drop_me;
> > iterator name for_each_child_of_node, for_each_child_of_node_scoped;
> > identifier L;
> > @@
> >
> > - struct device_node *child;
> >  ... when != child
> > -for_each_child_of_node
> > +for_each_child_of_node_scoped
> >   (node,child) {
> >    ... when strict
> > (
> > -   {
> > -   of_node_put(child);
> >     return ...;
> > -   }
> > |
> > -   {
> > -   of_node_put(child);
> >     goto L;
> > -   }
> > |
> > -   {
> > -   of_node_put(child);
> >     break;
> > -   }
> > |
> >     continue;
> > |
> > -   of_node_put(child);
> >     return ...;
> > |
> > -   of_node_put(child);
> >     break;
> > |
> > -  of_node_put(drop_me, child);
> > )
> > }
> >  ... when != child
> >
> > @@
> > expression child;
> > @@
> >
> > - of_node_put(drop_me, child);
> >
> > -------------------------------
> >
> > This is quite conservative, in that it requires the only use of the child
> > variable to be in a single for_each_child_of_node loop at top level.
> >
> > The drop_me thing is a hack to be able to refer to the bottom of the loop
> > in the same way as of_node_puts in front of returns etc are referenced.
> >
> > This works fine when multiple device_node variables are declared at once.
> >
> > The result is below.
> >
> Very nice!
>
> One issue is that Rob is keen that we also take this opportunity to
> evaluate if the _available_ form is the more appropriate one.
>
> Given that access either no defined "status" in the child node or
> it being set to "okay" it is what should be used in the vast majority of
> cases.
>
> For reference, the property.h version only uses the available form.
>
> So I think we'll need some hand checking of each case but for vast majority
> it will be very straight forward.

I'm not sure to follow this.  If the check is straightforward, perhaps it
can be integrated into the rule?  But I'm not sure what to check for.

> One question is whether it is worth the scoped loops in cases
> where there isn't a patch where we break out of or return from the loop
> before it finishes.  Do we put them in as a defensive measure?

I wondered about this also.  My thought was that it is better to be
uniform.  And maybe a break would be added later.

> Sometimes we are going to want to combine this refactor with
> some of the ones your previous script caught in a single patch given
> it's roughly the same sort of change.

Agreed.  Some blocks of code should indeed become much simpler.

>
>
> > julia
> >
> > diff -u -p a/drivers/of/unittest.c b/drivers/of/unittest.c
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -2789,7 +2789,7 @@ static int unittest_i2c_mux_probe(struct
> >  	int i, nchans;
> >  	struct device *dev = &client->dev;
> >  	struct i2c_adapter *adap = client->adapter;
> > -	struct device_node *np = client->dev.of_node, *child;
> > +	struct device_node *np = client->dev.of_node;
> >  	struct i2c_mux_core *muxc;
> >  	u32 reg, max_reg;
> >
> > @@ -2801,7 +2801,7 @@ static int unittest_i2c_mux_probe(struct
> >  	}
> >
> >  	max_reg = (u32)-1;
> > -	for_each_child_of_node(np, child) {
> > +	for_each_child_of_node_scoped(np, child) {
>
> This was a case I left alone in the original series because the auto
> cleanup doesn't end up doing anything in any paths.
>
> >  		if (of_property_read_u32(child, "reg", &reg))
> >  			continue;
> >  		if (max_reg == (u32)-1 || reg > max_reg)
> >
>
>
>
> > diff -u -p a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
> > --- a/drivers/regulator/scmi-regulator.c
> > +++ b/drivers/regulator/scmi-regulator.c
> > @@ -297,7 +297,7 @@ static int process_scmi_regulator_of_nod
> >  static int scmi_regulator_probe(struct scmi_device *sdev)
> >  {
> >  	int d, ret, num_doms;
> > -	struct device_node *np, *child;
> > +	struct device_node *np;
> >  	const struct scmi_handle *handle = sdev->handle;
> >  	struct scmi_regulator_info *rinfo;
> >  	struct scmi_protocol_handle *ph;
> > @@ -341,13 +341,11 @@ static int scmi_regulator_probe(struct s
> >  	 */
> >  	of_node_get(handle->dev->of_node);
> >  	np = of_find_node_by_name(handle->dev->of_node, "regulators");
> > -	for_each_child_of_node(np, child) {
> > +	for_each_child_of_node_scoped(np, child) {
> >  		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
> >  		/* abort on any mem issue */
> > -		if (ret == -ENOMEM) {
> > -			of_node_put(child);
> > +		if (ret == -ENOMEM)
> >  			return ret;
> > -		}
> Current code leaks np in this path :(
>
> >  	}
> >  	of_node_put(np);
> >  	/*
>
>
> > diff -u -p a/drivers/crypto/nx/nx-common-powernv.c b/drivers/crypto/nx/nx-common-powernv.c
> > --- a/drivers/crypto/nx/nx-common-powernv.c
> > +++ b/drivers/crypto/nx/nx-common-powernv.c
> > @@ -907,7 +907,6 @@ static int __init nx_powernv_probe_vas(s
> >  {
> >  	int chip_id, vasid, ret = 0;
> >  	int ct_842 = 0, ct_gzip = 0;
> > -	struct device_node *dn;
> >
> >  	chip_id = of_get_ibm_chip_id(pn);
> >  	if (chip_id < 0) {
> > @@ -921,7 +920,7 @@ static int __init nx_powernv_probe_vas(s
> >  		return -EINVAL;
> >  	}
> >
> > -	for_each_child_of_node(pn, dn) {
> > +	for_each_child_of_node_scoped(pn, dn) {
> >  		ret = find_nx_device_tree(dn, chip_id, vasid, NX_CT_842,
> >  					"ibm,p9-nx-842", &ct_842);
> >
> > @@ -929,10 +928,8 @@ static int __init nx_powernv_probe_vas(s
> >  			ret = find_nx_device_tree(dn, chip_id, vasid,
> >  				NX_CT_GZIP, "ibm,p9-nx-gzip", &ct_gzip);
> The handling in here is odd (buggy?). There is an of_node_put()
> in the failure path inside find_nx_device_tree() as well as out here.
> >
> > -		if (ret) {
> > -			of_node_put(dn);
> > +		if (ret)
> >  			return ret;
> > -		}
> >  	}
> >
> >  	if (!ct_842 || !ct_gzip) {
>
> I've glanced at a few of the others and some of them are hard.
> This refactor is fine, but the other device_node handling often
> is complex and I think fragile.  So definitely room for improvement!

I agree with all the above comments.

julia

