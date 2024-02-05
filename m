Return-Path: <linux-kernel+bounces-54103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A084AACA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132001C24562
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D134BAA4;
	Mon,  5 Feb 2024 23:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5CaDjy/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FF1EB49;
	Mon,  5 Feb 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176691; cv=none; b=l8yXM1Oxbn3uiu89cQ/b3f2AYmtc4nUH659sCCXT5JXyy6wZZIU6jlkrH0Yaro7KyvPUVMs4wKSd64znZOZ6b4eQ0HV53cv++osy6/rClfWDFDoYlt9XHxCvSmBD15YWSHaWwId8Pi9uhDMQ1htQDLkpPiDz7b/5BfibLkRVpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176691; c=relaxed/simple;
	bh=SxLaOpN/aBErJ9kXh6d9dU6KlKpKu99pWHS/STEMU8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbDxozMIvorEf5/rKabDZZeP72C8ZhJacJ1qCs+3o0sLSEUqAAF9L/2KJo5ByZ6LmzIkZ8qblmggt63xAWvDh0W+OKfXzRc9EC3VElWGQCkA9Lth4FeJP6TVXTFHN9HFtaGhmDCXSclPHH9U177vqmT6UdhdS4BJ3s27MJGnvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5CaDjy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1413C433F1;
	Mon,  5 Feb 2024 23:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707176690;
	bh=SxLaOpN/aBErJ9kXh6d9dU6KlKpKu99pWHS/STEMU8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j5CaDjy/VjxbeQbdgNT8rBul3sjRJv85BNfhU7NBA3ouFRrZ9V9uxMt7N8/1Fxd18
	 meUCBNTQblbFgDEQJe+UT9h1L8dqhim7LslBtyeknQzuzRhdhMQ9JaFjmoAO8zepYs
	 nJZb2IxMHfZXpZ579O++i4hrpSVSRqECbx0e1IRiCKjkWv3IsDOgkgWkp5HhFoPZYl
	 DiZjuRNBA2X/EI09LTQgegSqHCwSWb4bY2xNNdpL9KG/A8CefmjnXwYw7TCbixR+8j
	 OdXgjcfz6VUfd6A0VCwlCLIJpAct5EjHtn0jkuf8N6d1XaR2rdhtcy7fbsEEsuLRkt
	 M0tiRWjOa/Yqg==
Date: Mon, 5 Feb 2024 15:44:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>, Sathesh B Edara
 <sedara@marvell.com>, "egallen@redhat.com" <egallen@redhat.com>,
 "mschmidt@redhat.com" <mschmidt@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "wizhao@redhat.com" <wizhao@redhat.com>, "kheib@redhat.com"
 <kheib@redhat.com>, "konguyen@redhat.com" <konguyen@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jonathan
 Corbet <corbet@lwn.net>, Veerasenareddy Burru <vburru@marvell.com>,
 Satananda Burla <sburla@marvell.com>, Shannon Nelson
 <shannon.nelson@amd.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew@lunn.ch>, Jacob
 Keller <jacob.e.keller@intel.com>
Subject: Re: [EXT] Re: [PATCH net-next v5 1/8] octeon_ep_vf: Add driver
 framework and device initialization
Message-ID: <20240205154448.1c5a5ad8@kernel.org>
In-Reply-To: <PH0PR18MB47345E3ADCC35D0ECA763DBBC7412@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240129050254.3047778-1-srasheed@marvell.com>
	<20240129050254.3047778-2-srasheed@marvell.com>
	<20240131161406.22a9e330@kernel.org>
	<PH0PR18MB47345E3ADCC35D0ECA763DBBC7412@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Feb 2024 05:35:21 +0000 Shinas Rasheed wrote:
> > You haven't masked any IRQ or disabled NAPI. What prevents the queues
> > from getting restarted right after this call?  
> 
> The napi functionality (along with disabling it when stopping), is introduced (and used) in the patch after this one [2/8]. Also we disable interrupts in the 
> disable_interrupt hook which is also called in the next patch [2/8]. 

You gotta make the patches reviewable :(

> > > +static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int  
> > txqueue)  
> > > +{
> > > +	struct octep_vf_device *oct = netdev_priv(netdev);
> > > +
> > > +	queue_work(octep_vf_wq, &oct->tx_timeout_task);
> > > +}  
> > 
> > I don't see you canceling this work. What if someone unregistered
> > the device before it runs? You gotta netdev_hold() a reference.  
> 
> We do cancel_work_sync in octep_vf_remove function.

But the device is still registered, so the timeout can happen after you
cancel but before you unregister.

> > > +static int __init octep_vf_init_module(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	pr_info("%s: Loading %s ...\n", OCTEP_VF_DRV_NAME OCTEP_VF_DRV_STRING);  
> > > +
> > > +	/* work queue for all deferred tasks */
> > > +	octep_vf_wq =  
> > create_singlethread_workqueue(OCTEP_VF_DRV_NAME);
> > 
> > Is there a reason this wq has to be single threaded and different than
> > system queue? All you schedule on it in this series is the reset task.  
> 
> We also schedule the control mailbox task on this workqueue. The
> workqueue was created with the intention that there could be other
> driver specific tasks to add in the future. It has been single
> threaded for now, but we might optimize implementation in the future,
> although for now as far as to service our control plane this has been
> enough.

I haven't spotted the mailbox task in this series, if it's not here,
let's switch to system wq, and only add your own when needed.

