Return-Path: <linux-kernel+bounces-23355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359CF82AB82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B841C21E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051C12E52;
	Thu, 11 Jan 2024 10:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vE1AA7fU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD22B12E47;
	Thu, 11 Jan 2024 10:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE793C433C7;
	Thu, 11 Jan 2024 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704967397;
	bh=XKju82+bUIQUC2/IEKI3rWnSmsS5G+w7eqtJG86hh90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vE1AA7fUthH45yZcRUBa4OzJIYWGm2k2UED9/2miba5n74LCLpqMXf3CcA56sdNwd
	 RIjFQwZwSuqpk/s6FCLAQSGE9bEsCRc9uq0drr43QB+1NTB5heMTEzweqs+s0U1WMV
	 INM5Zrvf1NpL4bcpYm9UnSqoHRliv8nfYP8xIl50=
Date: Thu, 11 Jan 2024 11:03:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au,
	andriy.shevchenko@linux.intel.com, linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kunwu.chan@hotmail.com,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: aspeed: Check return value of kasprintf in
 ast_vhub_alloc_epn
Message-ID: <2024011132-gigolo-cornmeal-844f@gregkh>
References: <20231122014212.304254-1-chentao@kylinos.cn>
 <2023112236-bullseye-pranker-491e@gregkh>
 <346b631c-8b46-4b41-9188-8cbaaa1ff178@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <346b631c-8b46-4b41-9188-8cbaaa1ff178@kylinos.cn>

On Thu, Jan 11, 2024 at 05:31:35PM +0800, Kunwu Chan wrote:
> Sorry, I didn't find out about this email until now because it was
> intercepted by my company's email server.
> 
> On 2023/11/22 20:10, Greg KH wrote:
> > On Wed, Nov 22, 2023 at 09:42:12AM +0800, Kunwu Chan wrote:
> > > kasprintf() returns a pointer to dynamically allocated memory
> > > which can be NULL upon failure. Ensure the allocation was successful
> > > by checking the pointer validity.
> > > 
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > > ---
> > >   drivers/usb/gadget/udc/aspeed-vhub/epn.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/epn.c b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > > index 148d7ec3ebf4..e0854e878411 100644
> > > --- a/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > > +++ b/drivers/usb/gadget/udc/aspeed-vhub/epn.c
> > > @@ -826,6 +826,8 @@ struct ast_vhub_ep *ast_vhub_alloc_epn(struct ast_vhub_dev *d, u8 addr)
> > >   	ep->vhub = vhub;
> > >   	ep->ep.ops = &ast_vhub_epn_ops;
> > >   	ep->ep.name = kasprintf(GFP_KERNEL, "ep%d", addr);
> > > +	if (!ep->ep.name)
> > > +		return NULL;
> > 
> > This will break things if this ever triggers.  How was this tested?  The
> It's my fault, I think it's too simplistic. Compiled test only.
> Cause I don't know how to test effectively. I didn't find a way to test this
> in 'Documentation/usb/gadget-testing.rst'.
> > "slot" for this device will still be seen as used and so the resources
> > never freed and then you can run out of space for real devices, right?
> > 
> > Looks like the other error handling in this function below this call is
> > also broken, can you fix that up too?Yes, after reading the relevant code, I found that this is indeed a problem.
> So I write the v2 patch below, but the same question bothering me, about how
> to test effectively and what hardware equipment is needed? I'm new to this
> area, do you have any suggestions?

That is up to you, but you need to test stuff like this if you wish to
change it as your previous patch obviously would have broken things.

good luck!

greg k-h

