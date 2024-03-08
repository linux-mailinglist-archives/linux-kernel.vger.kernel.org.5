Return-Path: <linux-kernel+bounces-96961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23BD8763B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620641F21767
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630E056745;
	Fri,  8 Mar 2024 11:55:20 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802F2C1A2;
	Fri,  8 Mar 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898919; cv=none; b=DrpDVsoPVQfbht+MGC4HsWCpafffKJQLT8nazpZ1u32ePsW6H82TBoSd+SOXd2RNVBqKQCdvS/Hbru2Ipuxoc75dmA5gB7B5ijBGLo7BtBjTRIs4pSLguSqDJI53YTQ1WBSQJYM/EJnHIMJuPxT9bkO/fHRqEgsQYnW/+yIV9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898919; c=relaxed/simple;
	bh=EbeuyHMf7cqWISlltIAPJ/9bpRlnrmVKQt4kVAcX4Tg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWEOI0yaqA/8movwpKKnM005IvOekHujhw8Dm3o79BC2Po3kGQn3nX4rDkl79PmPk3ULlixKpSD7OTxByOmGrpnLipgTH6t/beQrsGvNTPg9taDBMmGF7iZg5SnALjGSDViavNv71bMTThFhdh+YEM7Ojr4XcXo573zzMijTg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 082375202BC;
	Fri,  8 Mar 2024 12:55:12 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 8 Mar
 2024 12:55:11 +0100
Date: Fri, 8 Mar 2024 12:55:06 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, <gregkh@linuxfoundation.org>,
	<maze@google.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <guofeng.li@gm.com>,
	<hardik.gajjar@bosch.com>, <eugeniu.rosca@bosch.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
Message-ID: <20240308115506.GA5631@vmlxhi-118.adit-jv.com>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
 <8d116b78-9227-4e48-8d37-3a0cb0465dfd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d116b78-9227-4e48-8d37-3a0cb0465dfd@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Mar 07, 2024 at 11:12:07PM +0530, Krishna Kurapati PSSNV wrote:
> 
> On 3/7/2024 9:48 PM, Hardik Gajjar wrote:
> > In the scenario where the system enters suspend to RAM mode (STR) triggers
> > the disconnection of Dual Role USB Hub, and the UDC platform driver calls
> > usb_del_gadget_udc() to cleanup and delete the associated gadget.
> > 
> > However, at this point, the usb0 interface is not yet deleted, leading to
> > a race condition with the TCP/IP stack attempting to access the network
> > device parent (gadget pointer), through operations like the GETLINK net
> > message.
> > 
> > This patch addresses the issue by clearing the netdevice's parent device
> > pointer when the ncm unbinds, effectively preventing the race condition
> > during this critical phase.
> > 
> 
> Hi Hardik,
> 
>  Would this the case be same with other network functions as well ? I see
> that for all gadget functions, the network interface exists although the
> unbind is done and deleted only upon function instance removal. Should we
> move the gether_cleanup at unbind as a reverse operation of what we do on
> first bind ? If we do so, I think this current problem too would be gone.
> 
> Greg, if you have idea why we don't destroy the network interface upon
> unbind and keep it till the lifetime of the function instance, can you help
> with that info. I was trying to see if we can move the gether_cleanup call
> to unbind, but I don't know why it was kept in free_inst to begin with, so I
> didn't touch that part of code so far.
> 
> Regards,
> Krishna,

Hi Krishna, 

I believe using gether_cleanup altogether may not be an optimal solution.
The creation and deletion of network interfaces should align with the behavior of each specific network driver.

For instance, in the case of NCM, the usb0 interface is created upon the creation of a directory
in config/usb_gadget/gX/functions/ncm.usb0, and it is removed when the corresponding directory
is deleted. This follows a standard flow observed in many network drivers, where interfaces are
created during driver loading/probing and deleted during removal.

Typically, deleting the gadget on every disconnection is not considered a good practice, as it can
negatively impact the user experience when accessing the gadget.

In our specific scenario, retaining the usb0 network interface has proven to enhance performance
and stabilize connections. Previous attempts to remove it resulted in an observed increase in time of 300ms,
particularly at the start of Apple CarPlay sessions.

Furthermore, it's important to highlight that in Qualcomm products and msm kernels, the inclusion of gether_cleanup
in the unbind process was eventually reverted. While the specific reason for reverting the patch is unknown,
it suggests that the addition may not have yielded the intended or required results

Following is the revert patch details in msm-5.4 kernel, if you want check it.

Revert "usb: gadget: f_ncm: allocate/free net device upon driver bind/unbind"

This reverts commit 006d8adf555a8c6d34113f564ade312d68abd3b3.

Move back the allocation of netdevice to alloc_inst(), one-time
registration to bind(), deregistration and free to rm_inst(). The
UI update issue will be taken up with proper stakeholders.

Change-Id: I56448b08f6796a43ec5b0dfe0dd2d42cdc0eec14

Thanks,
Hardik
 

> 
> > Followinfg is the backtrace of such race condition
> > [ 3566.105792] Call trace:
> > [ 3566.105984] if_nlmsg_size+0x48/0x3b0
> > [ 3566.107497] rtnetlink_rcv_msg+0x1cc/0x408
> > [ 3566.107905] netlink_rcv_skb+0x12c/0x164
> > [ 3566.108264] rtnetlink_rcv+0x18/0x24
> > [ 3566.108851] netlink_unicast_kernel+0xc4/0x14c
> > [ 3566.109192] netlink_unicast+0x210/0x2b0
> > [ 3566.109606] netlink_sendmsg+0x2ec/0x360
> > [ 3566.110046] __sys_sendto+0x1b8/0x25c
> > [ 3566.111594] __arm64_sys_sendto+0x28/0x38
> > [ 3566.112599] el0_svc_common+0xb4/0x19c
> > [ 3566.112978] el0_svc_handler+0x74/0x98
> > [ 3566.113269] el0_svc+0x8/0xc
> > 
> > - code: if_nlmsg_size call the following function
> > 
> > static inline int rtnl_vfinfo_size(const struct net_device *dev,
> > 				   u32 ext_filter_mask)
> > {
> > 	// dev->dev.parent is not NULL
> > 	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
> > 		// dev_num_vf use the dev->dev.parent->bus lead to kernel panic.
> > 		int num_vfs = dev_num_vf(dev->dev.parent);
> > 		size_t size = nla_total_size(0);
> > 		size += num_vfs *
> > 			(nla_total_size(0) +
> > 			 nla_total_size(sizeof(struct ifla_vf_mac)) +
> > 			 nla_total_size(sizeof(struct ifla_vf_vlan)) +
> > 			 nla_total_size(0) + /* nest IFLA_VF_VLAN_LIST *
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> >   drivers/usb/gadget/function/f_ncm.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> > index e2a059cfda2c..fdfb5b3460c7 100644
> > --- a/drivers/usb/gadget/function/f_ncm.c
> > +++ b/drivers/usb/gadget/function/f_ncm.c
> > @@ -1728,9 +1728,12 @@ static void ncm_free(struct usb_function *f)
> >   static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
> >   {
> >   	struct f_ncm *ncm = func_to_ncm(f);
> > +	struct f_ncm_opts   *ncm_opts;
> >   	DBG(c->cdev, "ncm unbind\n");
> > +	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
> > +
> >   	hrtimer_cancel(&ncm->task_timer);
> >   	kfree(f->os_desc_table);
> > @@ -1746,6 +1749,10 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
> >   	kfree(ncm->notify_req->buf);
> >   	usb_ep_free_request(ncm->notify, ncm->notify_req);
> > +
> > +	mutex_lock(&ncm_opts->lock);
> > +	SET_NETDEV_DEV(ncm_opts->net, NULL);
> > +	mutex_unlock(&ncm_opts->lock);
> >   }
> >   static struct usb_function *ncm_alloc(struct usb_function_instance *fi)

