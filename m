Return-Path: <linux-kernel+bounces-41484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6598983F294
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211812869AC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B21362;
	Sun, 28 Jan 2024 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GIlyJFvw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8423645;
	Sun, 28 Jan 2024 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706402055; cv=none; b=Y5Uu5geeldD3kWVcSPE0AFNh56s6l2xp8UIFaP2w0QYyEY6w0g0sDgYQ9l8kR/nTIphtBrQphjUxj1kV/rv6RpT6k8uL9X6ZOyigfYFg8ZxiwWcvdl1cTFYPpclNBzg+S+BebMl4Ojcl4eZmmaekhxI2EExAxliXL0wVWmP9JJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706402055; c=relaxed/simple;
	bh=spRHzYMhJX+uS5Ja/p6wMFDEhvTvQP4Bof3uxeB4/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBQnEB0VtP/vLZ5fbDx74MALcqz4zG0P0dhgXVf/Le7VcDiMbnoxlyEguDh9d4seLXqcTqizulSRCKUj9K6oc5niNGZqz6iNcGdHX1UOrjXW9busz2XUKzuPg+tRGhVuGVAWXU329CEgEbIrgGZCzkZvImkfF3ObJTfCrJM4LF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GIlyJFvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB24C433F1;
	Sun, 28 Jan 2024 00:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706402055;
	bh=spRHzYMhJX+uS5Ja/p6wMFDEhvTvQP4Bof3uxeB4/Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIlyJFvwLUJ9L59b98MMX8QDD4y7RhC9GOAdfNj1RsNvoVVPeAlC+NFcQxFUr8xsP
	 zxMNwQHkojO1UoQztCzHZOGWpBEARSiLxvdcJZ1a5ptsI5H4wW6xPwTORr86TgayA0
	 2dEthDUc09h1B1GzGlJ1Q7qulKrkQVCtpAPjfaGQ=
Date: Sat, 27 Jan 2024 16:34:14 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
Message-ID: <2024012705-pantry-synapse-749a@gregkh>
References: <20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de>
 <2024012400-subtitle-magnitude-45ff@gregkh>
 <63a1bfa2acb84bc24b87a8dbd60b665c733d13cd.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63a1bfa2acb84bc24b87a8dbd60b665c733d13cd.camel@pengutronix.de>

On Wed, Jan 24, 2024 at 01:56:18PM +0100, Philipp Zabel wrote:
> On Mi, 2024-01-24 at 04:39 -0800, Greg Kroah-Hartman wrote:
> > On Wed, Jan 24, 2024 at 12:26:20PM +0100, Philipp Zabel wrote:
> > > Use of_reset_control_array_get_optional_exclusive() instead, it is
> > > implemented as:
> > > 
> > >   static inline struct reset_control *
> > >   of_reset_control_array_get_optional_exclusive(struct device_node *node)
> > >   {
> > >           return of_reset_control_array_get(node, false, true, true);
> > >   }
> > > 
> > > This makes the code easier to understand and removes the last remaining
> > > direct use of of_reset_control_array_get(). No functional changes.
> > > 
> > > Fixes: f4cc91ddd856 ("usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles")
> > 
> > No functional change, but a Fixes: tag?  That doesn't make sense to me,
> > sorry.
> 
> The referenced patch made the boolean parameters const but missed that
> there is a static inline wrapper for this combination. I can drop the
> Fixes: tag and describe this in the text.

That would be best, thanks.

greg k-h

