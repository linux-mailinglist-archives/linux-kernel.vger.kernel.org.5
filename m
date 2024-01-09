Return-Path: <linux-kernel+bounces-21114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E720A828A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9152C286672
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A4B3A267;
	Tue,  9 Jan 2024 16:37:03 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC603A1CE;
	Tue,  9 Jan 2024 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 0F427520442;
	Tue,  9 Jan 2024 17:27:38 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Jan
 2024 17:27:37 +0100
Date: Tue, 9 Jan 2024 17:27:32 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: John Keeping <john@keeping.me.uk>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, <gregkh@linuxfoundation.org>,
	<stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <erosca@de.adit-jv.com>,
	<jlayton@kernel.org>, <brauner@kernel.org>
Subject: Re: [PATCH v3] usb: gadget: f_fs: Add the missing get_alt callback
Message-ID: <20240109162732.GA22184@vmlxhi-118.adit-jv.com>
References: <20240102123419.13491-1-hgajjar@de.adit-jv.com>
 <ZZaTl3mqeCY5xD_d@keeping.me.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZaTl3mqeCY5xD_d@keeping.me.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Jan 04, 2024 at 11:16:39AM +0000, John Keeping wrote:
> On Tue, Jan 02, 2024 at 01:34:19PM +0100, Hardik Gajjar wrote:
> > The Apple CarLife iAP gadget has a descriptor with two alternate
> > settings. The host sends the set_alt request to configure alt_setting
> > 0 or 1, and this is verified by the subsequent get_alt request.
> > 
> > This patch implements and sets the get_alt callback. Without the
> > get_alt callback, composite.c abruptly concludes the
> > USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
> > for the endpoint.
> 
> I still do not understand what happens if different alternate settings
> have different endpoints.
> 
> Changing the alternate calls ffs_func_eps_disable() /
> ffs_func_eps_enable() but those functions affect _all_ the configured
> endpoints.  If f_fs moves to support multiple alternate settings, then
> isn't there a problem with that behaviour?  Don't we need
> ffs_func_eps_enable() to enable only the endpoints used by the current
> alternate setting?
> 
> The commit message does not explain why this patch can be as simple as
> it is and why there is no need to address any wider issues that there
> seem to be from supporting multiple alternate settings.
>
If I understand correctly, for example, there are two alt settings: one with bNumEndpoint 3
and the other with bNumEndpoint 2. So when there is a request from the host to switch to the
alt setting that has two endpoints, with this patch, all three endpoints are reset and reconfigured
again as altsetting one instead of altsetting two. This happens because there is no input yet from
userspace about the endpoint descriptor for the newly requested alt-settings.

I believe this should not happen in the case of the f_fs gadget because the composite/f_fs driver
initializes all endpoints of all interfaces during the bind process, creates epfile, and increments the eps count.
This means that when reinitializing the endpoints during the set_alt, it reinitializes all the endpoints, including
the endpoints of the proposed alt setting.

Userspace drivers need to ensure that they write the correct epfile after switching in altsettings.
Also, they should make sure that the endpoints are not overridden when defining the descriptor.
Below is an example of the descriptors we are using from userspace.

			// Interface descriptor - fs_descs
            // interface: 0 band width
            (byte) 0x09, (byte) 0x04, (byte) 0x01, (byte) 0x00, (byte) 0x00, (byte) 0xFF,
            (byte) 0xF0, (byte) 0x01, (byte) 0x01,

            // interface: alt 1
            (byte) 0x09, (byte) 0x04, (byte) 0x01, (byte) 0x01, (byte) 0x02, (byte) 0xFF,
            (byte) 0xF0, (byte) 0x01, (byte) 0x01,
            //  Endpoint descriptor
            (byte) 0x07, (byte) 0x05, (byte) 0x81, (byte) 0x02, (byte) 0x00, (byte) 0x00, (byte) 0x00,
            (byte) 0x07, (byte) 0x05, (byte) 0x02, (byte) 0x02, (byte) 0x00, (byte) 0x00, (byte) 0x00,

            // Interface descriptor - hs_descs
            // interface: 0 band width
            (byte) 0x09, (byte) 0x04, (byte) 0x01, (byte) 0x00, (byte) 0x00, (byte) 0xFF,
            (byte) 0xF0, (byte) 0x01, (byte) 0x01,

            // Initialize high-speed interface descriptors
            (byte) 0x09, (byte) 0x04, (byte) 0x01, (byte) 0x01, (byte) 0x02, (byte) 0xFF,
            (byte) 0xF0, (byte) 0x01, (byte) 0x01,
            // Initialize high-speed end-point descriptors
            (byte) 0x07, (byte) 0x05, (byte) 0x81, (byte) 0x02, (byte) 0x00, (byte) 0x02, (byte) 0x00,
            (byte) 0x07, (byte) 0x05, (byte) 0x02, (byte) 0x02, (byte) 0x00, (byte) 0x02, (byte) 0x01,

Please confirm and share your view.
 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> > changes since version 1:
> > 	- improve commit message to indicate why the get_alt callback
> > 	  is necessary
> > 	- Link to v1 - https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231124164435.74727-2D1-2Dhgajjar-40de.adit-2Djv.com_&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=vWvELMp9SHJnKh1jvRtJiGjnwn47jqfKsAjBDdMGF1-wjK3hGliKdP2ap6Az4efB&s=ajL0PmatFt2otvpDyZsjbMozcLP3OI4VhspIzjoUTLE&e=
> > 
> > changes since version 2:
> > 	- Add the limit to allow set up to 2 alt settings.
> > 	- Link to v2 - https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_20231201145234.97452-2D1-2Dhgajjar-40de.adit-2Djv.com_&d=DwICAg&c=euGZstcaTDllvimEN8b7jXrwqOf-v5A_CdpgnVfiiMM&r=SAhjP5GOmrADp1v_EE5jWoSuMlYCIt9gKduw-DCBPLs&m=vWvELMp9SHJnKh1jvRtJiGjnwn47jqfKsAjBDdMGF1-wjK3hGliKdP2ap6Az4efB&s=BSvxAb0iHeXEhufs_mU2MfCKbsrAwJMe7cCiAZq53yY&e=
> > ---
> >  drivers/usb/gadget/function/f_fs.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> > index efe3e3b85769..22200d618184 100644
> > --- a/drivers/usb/gadget/function/f_fs.c
> > +++ b/drivers/usb/gadget/function/f_fs.c
> > @@ -42,6 +42,7 @@
> >  #include "configfs.h"
> >  
> >  #define FUNCTIONFS_MAGIC	0xa647361 /* Chosen by a honest dice roll ;) */
> > +#define MAX_ALT_SETTINGS	2		  /* Allow up to 2 alt settings to be set. */
> >  
> >  /* Reference counter handling */
> >  static void ffs_data_get(struct ffs_data *ffs);
> > @@ -75,6 +76,7 @@ struct ffs_function {
> >  	short				*interfaces_nums;
> >  
> >  	struct usb_function		function;
> > +	int				cur_alt[MAX_CONFIG_INTERFACES];
> >  };
> >  
> >  
> > @@ -98,6 +100,7 @@ static int __must_check ffs_func_eps_enable(struct ffs_function *func);
> >  static int ffs_func_bind(struct usb_configuration *,
> >  			 struct usb_function *);
> >  static int ffs_func_set_alt(struct usb_function *, unsigned, unsigned);
> > +static int ffs_func_get_alt(struct usb_function *f, unsigned int intf);
> >  static void ffs_func_disable(struct usb_function *);
> >  static int ffs_func_setup(struct usb_function *,
> >  			  const struct usb_ctrlrequest *);
> > @@ -3232,6 +3235,15 @@ static void ffs_reset_work(struct work_struct *work)
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
> > @@ -3239,6 +3251,9 @@ static int ffs_func_set_alt(struct usb_function *f,
> >  	struct ffs_data *ffs = func->ffs;
> >  	int ret = 0, intf;
> >  
> > +	if (alt > MAX_ALT_SETTINGS)
> > +		return -EINVAL;
> > +
> >  	if (alt != (unsigned)-1) {
> >  		intf = ffs_func_revmap_intf(func, interface);
> >  		if (intf < 0)
> > @@ -3266,8 +3281,10 @@ static int ffs_func_set_alt(struct usb_function *f,
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
> > @@ -3574,6 +3591,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
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

