Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5880747D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442629AbjLFQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442663AbjLFQEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:04:13 -0500
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B435A10CF;
        Wed,  6 Dec 2023 08:04:03 -0800 (PST)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 8D9FB520422;
        Wed,  6 Dec 2023 17:04:01 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Dec
 2023 17:04:01 +0100
Date:   Wed, 6 Dec 2023 17:03:56 +0100
From:   Hardik Gajjar <hgajjar@de.adit-jv.com>
To:     John Keeping <john@keeping.me.uk>
CC:     Hardik Gajjar <hgajjar@de.adit-jv.com>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <erosca@de.adit-jv.com>, <jlayton@kernel.org>, <brauner@kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <20231206160356.GA3006@vmlxhi-118.adit-jv.com>
References: <20231201145234.97452-1-hgajjar@de.adit-jv.com>
 <ZWtEY0oKS-PcaJ0c@keeping.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWtEY0oKS-PcaJ0c@keeping.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.72.93.77]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 02:51:15PM +0000, John Keeping wrote:
> On Fri, Dec 01, 2023 at 03:52:34PM +0100, Hardik Gajjar wrote:
> > The Apple CarLife iAP gadget has a descriptor with two alternate
> > settings. The host sends the set_alt request to configure alt_setting
> > 0 or 1, and this is verified by the subsequent get_alt request.
> > 
> > This patch implements and sets the get_alt callback. Without the
> > get_alt callback, composite.c abruptly concludes the
> > USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
> > for the endpoint.
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> > changes since version 1:
> > 	- improve commit message to indicate why the get_alt callback
> > 	  is necessary
> > 	- Link to v1 - https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231124164435.74727-2D1-2Dhgajjar-40de.adit-2Djv.com_&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=HVW16RXWO_lhdf8dGUC8lUHmcMmonwJgRYsnIBtUkIvOKiQCwdrs5RXMJKo9Qhh9&s=tbwPiQ25PgliLyyD75FDRJqiFxR-1ExoOMIXOD4WEZI&e=
> 
> This doesn't address my questions about v1 - I understand what the
> get_alt callback does, but I don't see how this is sufficient to make it
> work in all circumstances.
> 
> To use your example of having settings 0 and 1, what happens if the host
> requests setting 2?
> 
> Without this patch, when .get_alt is not set, composite_setup() will
> reject all settings except 0 so there is no need for ffs_func_set_alt()
> to filter its input.  But if .get_alt is set, don't we need to filter
> for valid input here?
> 
> I also do not see how it is acceptable to change alt setting without
> notifying userspace in the general case.  If it works for your specific
> use case, that is one thing, but nothing requires the endpoint setup to
> be the same across alt settings and the userspace component likely needs
> to know if the setup changes.
> 
> For examples, look at afunc_set_alt() or tcm_set_alt() in other gadget
> functions.  If either of these were to be implemented in userspace then
> simply accepting the alt setting is not enough - there are changes that
> must be made to the functionality.

Indeed, we require a filter for the alt value, and my suggestion is to set the filter to allow alt values up to two.

The set_alt callback function in the f_fs driver is currently resetting the associated endpoints by disabling and enabling them again for positive alt values.
Additionally, it sets ffs_event FUNCTIONFS_ENABLE, which provide userspaces notifications about some change.
It appears that the same event mechanism is used when there is a request to set the alt setting to -1, notifying by FUNCTIONFS_DISABLE.
For example, you can find the link to the Android USB daemon utilizing this FFS event in userspace.
https://gerrit.pixelexperience.org/plugins/gitiles/system_core/+/b36b54cf796d722653ad9bea11284815a3f5eda5/adb/daemon/usb.cpp#331

It's evident that the f_fs driver significantly differs from other gadget drivers (e.g., ncm, uac), where major control resides in userspace.

I believe there's no need for a mechanism to notify userspace for the f_fs driver.
Userspace triggers the data read, eventually called by usb_ep_queue() in f_fs.
As soon as set_alt resets the associated endpoint, the UDC driver should call the endpoint callback with an error, smoothly terminating the userspace system call with the appropriate error.

I couldn't find any userspace notification implementation in tcm_set_alt.

Please let me correct if sounds inappropriate.

Thanks,
Hardik
 
> 
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
