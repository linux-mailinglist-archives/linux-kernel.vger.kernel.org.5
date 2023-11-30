Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707117FEDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbjK3LaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345228AbjK3LaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:30:01 -0500
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F01715;
        Thu, 30 Nov 2023 03:29:59 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 78457520115;
        Thu, 30 Nov 2023 12:29:58 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Thu, 30 Nov
 2023 12:29:58 +0100
Date:   Thu, 30 Nov 2023 12:29:53 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     John Keeping <john@keeping.me.uk>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <quic_ugoswami@quicinc.com>,
        <brauner@kernel.org>, <jlayton@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>
Subject: Re: [PATCH] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <20231130112953.GA120825@vmlxhi-118.adit-jv.com>
References: <20231124164435.74727-1-hgajjar@de.adit-jv.com>
 <ZWM864zH3M8W9B2f@keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWM864zH3M8W9B2f@keeping.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 12:41:15PM +0000, John Keeping wrote:
> On Fri, Nov 24, 2023 at 05:44:35PM +0100, Hardik Gajjar wrote:
> > Some USB OTG hubs have multiple alternate configurations to offer,
> > such as one for Carplay and another for Carlife.
> > 
> > This patch implements and sets the get_alt callback to retrieve the
> > currently used alternate setting. The new function allows dynamic
> > retrieval of the current alternate setting for a specific interface. The
> > current alternate setting values are stored in the 'cur_alt' array
> > within the 'ffs_function' structure.
> 
> Doesn't the alt setting need to be forwarded to userspace?
> 
> What happens if the available endpoints change - doesn't that mean the
> available endpoint files change?
> 
> It's not sufficient to just blindly accept any alt setting and assume it
> will work, that may be the case in one specific constrained scenario,
> but it's not true in general.  At the very least we must not accept an
> alt setting that is not defined in the descriptors.

The commit message appears a bit confusing.
The user space creates an FFS/iAP (Apple) gadget and writes an ep0 descriptor
with multiple alt settings. The host then sends the set_alt request to configure
alt_setting 0 or 1, verified by the subsequent get_alt request. Without this
patch, the Host/Phone consistently sets alt 0 and retrieves alt 0, even when
the request is for alt 1.

Given that f_fs is a user space-controlled gadget, creating a descriptor seems
quite flexible for this type of gadget.

I intend to submit an upstream patch v2 with a clearer commit message.

> 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index efe3e3b85769..37c47c11f57a 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -75,6 +75,7 @@ struct ffs_function {
> >  	short				*interfaces_nums;
> >  
> >  	struct usb_function		function;
> > +	int				cur_alt[MAX_CONFIG_INTERFACES];
> >  };
> >  
> >  
> > @@ -98,6 +99,7 @@ static int __must_check ffs_func_eps_enable(struct ffs_function *func);
> >  static int ffs_func_bind(struct usb_configuration *,
> >  			 struct usb_function *);
> >  static int ffs_func_set_alt(struct usb_function *, unsigned, unsigned);
> > +static int ffs_func_get_alt(struct usb_function *f, unsigned int intf);
> >  static void ffs_func_disable(struct usb_function *);
> >  static int ffs_func_setup(struct usb_function *,
> >  			  const struct usb_ctrlrequest *);
> > @@ -3232,6 +3234,15 @@ static void ffs_reset_work(struct work_struct *work)
> >  	ffs_data_reset(ffs);
> >  }
> >  
> > +static int ffs_func_get_alt(struct usb_function *f,
> > +			    unsigned int interface)
> > +{
> > +	struct ffs_function *func = ffs_func_from_usb(f);
> > +	int intf = ffs_func_revmap_intf(func, interface);
> > +
> > +	return (intf < 0) ? intf : func->cur_alt[interface];
> > +}
> > +
> >  static int ffs_func_set_alt(struct usb_function *f,
> >  			    unsigned interface, unsigned alt)
> >  {
> > @@ -3266,8 +3277,10 @@ static int ffs_func_set_alt(struct usb_function *f,
> >  
> >  	ffs->func = func;
> >  	ret = ffs_func_eps_enable(func);
> > -	if (ret >= 0)
> > +	if (ret >= 0) {
> >  		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
> > +		func->cur_alt[interface] = alt;
> > +	}
> >  	return ret;
> >  }
> >  
> > @@ -3574,6 +3587,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
> >  	func->function.bind    = ffs_func_bind;
> >  	func->function.unbind  = ffs_func_unbind;
> >  	func->function.set_alt = ffs_func_set_alt;
> > +	func->function.get_alt = ffs_func_get_alt;
> >  	func->function.disable = ffs_func_disable;
> >  	func->function.setup   = ffs_func_setup;
> >  	func->function.req_match = ffs_func_req_match;
> > -- 
> > 2.17.1
> > 

Thanks,
Hardik
