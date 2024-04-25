Return-Path: <linux-kernel+bounces-158025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B97D8B1A53
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D83F1C213FB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86C3BB27;
	Thu, 25 Apr 2024 05:30:36 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D73B29D;
	Thu, 25 Apr 2024 05:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714023036; cv=none; b=o/ZRDEmsEMfhRkKkMkw14bIXmMz9gZlncOTWaI9/qTBQXiv1E/wkwD5L7RmGnMWN2WxobTaWkr6CTwnT7e1ciAV75pMTkW0K2/PxZ7Ni0sZzZlgxWxW5p2FjdSqJBvxGcNVOKv4UjPP0maoKvxc53uY+AFiVUTNlLYukVenjsFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714023036; c=relaxed/simple;
	bh=PxnWSNCcigJPq/bb8G7Q7F9qAzsfKTYveGy/K6+CaKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwdbFDrrYgH5C5/XgNJE2axTJM1FhyQUqY/2EgX1TlIqvWjLVQEUkAodAz9RE/WMoQn2d3w2FoHNDNV1/4v1fLXTs1g55B3RQikal3bvjU25OJSyb1jH9KIUQklWmjUJUNYZ/4kGa1xgbq0+klOq8NzfEUGfGKqYqqGAy6bDsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1374D14055B; Thu, 25 Apr 2024 07:30:24 +0200 (CEST)
Date: Thu, 25 Apr 2024 07:30:23 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com,
	andersson@kernel.org, fabrice.gasnier@foss.st.com,
	gregkh@linuxfoundation.org, hdegoede@redhat.com,
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com,
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <Zinqbx1lofe0/Otz@cae.in-ulm.de>
References: <20240424014821.4154159-1-jthies@google.com>
 <20240424014821.4154159-2-jthies@google.com>
 <CAA8EJpq_DujhwoJ87Cg4gZ4LNdPu4i93EQ0VeKrCJPkeDj9ThQ@mail.gmail.com>
 <CANFp7mVGYhMYXdCGEJQ9GoqB-kpk4UquUWEcvqVnRFMrih+R9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mVGYhMYXdCGEJQ9GoqB-kpk4UquUWEcvqVnRFMrih+R9Q@mail.gmail.com>


Hi,

On Wed, Apr 24, 2024 at 05:00:24PM -0700, Abhishek Pandit-Subedi wrote:
> On Tue, Apr 23, 2024 at 7:06 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Wed, 24 Apr 2024 at 04:48, Jameson Thies <jthies@google.com> wrote:
> > >
> > > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > >
> > > ucsi_register_altmode checks IS_ERR on returned pointer and treats
> > > NULL as valid. This results in a null deref when
> > > trace_ucsi_register_altmode is called. Return an error from
> > > ucsi_register_displayport when it is not supported and register the
> > > altmode with typec_port_register_altmode.
> > >
> > > Reviewed-by: Jameson Thies <jthies@google.com>
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > > Changes in V2:
> > > - Checks for error response from ucsi_register_displayport when
> > > registering DisplayPort alternate mode.
> > >
> > >  drivers/usb/typec/ucsi/ucsi.c | 3 +++
> > >  drivers/usb/typec/ucsi/ucsi.h | 2 +-
> > >  2 files changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > > index cb52e7b0a2c5c..f3b413f94fd28 100644
> > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > @@ -361,6 +361,9 @@ static int ucsi_register_altmode(struct ucsi_connector *con,
> > >                 switch (desc->svid) {
> > >                 case USB_TYPEC_DP_SID:
> > >                         alt = ucsi_register_displayport(con, override, i, desc);
> > > +                       if (IS_ERR(alt) && PTR_ERR(alt) == -EOPNOTSUPP)
> >
> > This makes it ignore EOPNOTSUPP if it is returned by the non-stub
> > implementation. I think the current state is actually better than the
> > implementation found in this patch. I'd suggest adding a comment to
> > ucsi_register_displayport() stub instead.
> 
> So originally on my system, I didn't have the displayport driver
> config enabled. My expectation was that the alt-mode would show up but
> would not be controllable (like all other alt-modes without drivers).
> What ends up happening is that no alt-mode shows up and trying to
> enable the trace crashes.
> 
> When the displayport support isn't there, I think it should just be
> enumerated as a normal, unsupported alt-mode.

This sounds reasonable. Thus if displayport support is not compiled in
ucsi_register_displayport() should just call typec_port_register_altmode(),
I guess.

Best regards,
Christian

