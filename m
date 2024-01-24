Return-Path: <linux-kernel+bounces-37098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67E83AB82
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC421C20C59
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72377A720;
	Wed, 24 Jan 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1m4Kxua"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7477F2E;
	Wed, 24 Jan 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105850; cv=none; b=TlJYsNvAPmUZUbuiER8dxbyU1yAiECIdQwb6zlnSCiChsb5HyyguLlq6HH5X+8GVs41x/Hv693c1iL7dtYBrtstIJzuMF+/xDX3Y54xcqpGdrNlOP/8xuEuzBCJsi5A/Qcot0cqU84tjvW+L3/mSVJMUzw5DTDCHqCLTHw0XTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105850; c=relaxed/simple;
	bh=eVqN57aJT3+vy4UOpfoRo4r0Q0FGTipSEN//MpMMrQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6NqY/gk6apc+0Rb84MtAkEpZu1gwsHfM+UANdQ+8IecX30oAQUX7xCOHla+c2duL4nc/ATTdelzVw6+83okbX98ZOMm8V147knUBy5dGxYyey4sjNKWXFfsk8QRgVIEpBB0OwkR8Lt6phbj9sUuIf38ZUqjoTTwc6YtDJYtCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1m4Kxua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3769C43390;
	Wed, 24 Jan 2024 14:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706105849;
	bh=eVqN57aJT3+vy4UOpfoRo4r0Q0FGTipSEN//MpMMrQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1m4KxuabkVmac4BIwVougZSrd75bRKG+57PJJiGGNT5+XfwolOarUyv6JcGatQSg
	 aTop6llwUaw/K5JMe26AOkfsg/tK2vBRJxQl+Yu8g8t5MehOqr2TJ2reHOXp5bIcSR
	 XQ02F4l1NV/8ZCeK3qp1Nwx3xgLKzC67c0VQAmTY=
Date: Wed, 24 Jan 2024 06:17:27 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Prashant Malani <pmalani@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@google.com>,
	linux-usb@vger.kernel.org, jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <2024012405-stung-freckles-e196@gregkh>
References: <20240123223039.1471557-1-abhishekpandit@google.com>
 <20240123143026.v1.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
 <CACeCKaftJSGba3ebs58=cB5aRLuOnbvhQX2V6+5=t9GPC08_Uw@mail.gmail.com>
 <ZbEV/qp/EhUkHVhA@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbEV/qp/EhUkHVhA@kuha.fi.intel.com>

On Wed, Jan 24, 2024 at 03:51:58PM +0200, Heikki Krogerus wrote:
> On Wed, Jan 24, 2024 at 12:12:26AM -0800, Prashant Malani wrote:
> > Hi Abhishek,
> > 
> > On Tue, Jan 23, 2024 at 2:30 PM Abhishek Pandit-Subedi
> > <abhishekpandit@google.com> wrote:
> > >
> > > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > >
> > > Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> > > increased from 16 to 256. In order to avoid overflowing reads for older
> > > systems, add a mechanism to use the read UCSI version to truncate read
> > > sizes on UCSI v1.2.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > I have one nit (mentioned in side-band but reproducing here for consistency),
> > but will defer to the maintainer on that.
> > 
> > The above notwithstanding, FWIW:
> > Reviewed-by: Prashant Malani<pmalani@chromium.org>
> > 
> > > @@ -1556,6 +1569,15 @@ int ucsi_register(struct ucsi *ucsi)
> > >         if (!ucsi->version)
> > >                 return -ENODEV;
> > >
> > > +       /*
> > > +        * Version format is JJ.M.N (JJ = Major version, M = Minor version,
> > > +        * N = sub-minor version).
> > > +        */
> > > +       dev_info(ucsi->dev, "Registered UCSI interface with version %x.%x.%x",
> > > +                UCSI_BCD_GET_MAJOR(ucsi->version),
> > > +                UCSI_BCD_GET_MINOR(ucsi->version),
> > > +                UCSI_BCD_GET_SUBMINOR(ucsi->version));
> > 
> > nit: I think this doesn't need to be dev_info() and can be just
> > dev_dbg(), but will
> > defer to the maintainer.
> 
> I think that's okay.
> 
> Reviewewd-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

No, when drivers are working properly they are quiet, this needs to be
dev_dbg().

thanks,

greg k-h

