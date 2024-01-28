Return-Path: <linux-kernel+bounces-41485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1783F296
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5042874E6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA601362;
	Sun, 28 Jan 2024 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yJF0FdT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AF38B;
	Sun, 28 Jan 2024 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706402293; cv=none; b=izCoFG/dU6/kqgD9xY/k8Mh8An24+LNQ1yCqa1KJI/ywoJFu/4Z924ht6Od+yyX/MBKM05luLTM+05u5CVou71JG2p62v4fcN48jY2dFnIpU5Ya2iKlR7d+WzpsWRz5KZMdvUIlE0gVTD1MzlLo1md/ZA7tPb3alw6MYt0FB904=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706402293; c=relaxed/simple;
	bh=f1JwIbdBjUssU7NR7CQ0VJJn3U/J1RElaxkhWnn95rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Xvxk/N5men/pa9ZG5ui6IcFrsGKgQGUmrFvpHsgQpok6kaXTQ/ZdF5p640RVH32ngV/YaFDpGYIQwFybh5YK8E2/uY0povW/miL0JL3M7RwgAyGQ4jtU4UAkQV5ldXDfKl+6Ar4i0mCwPoHbOlbJXy/0kJMvcL/R+1cFyn3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yJF0FdT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5A5C433F1;
	Sun, 28 Jan 2024 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706402292;
	bh=f1JwIbdBjUssU7NR7CQ0VJJn3U/J1RElaxkhWnn95rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yJF0FdT0GiVwZjD718RftAjYV6JM07PCxik3HhvJlojlA6KSfWKEJ8cj7tH7OgUKm
	 IAqC5+AkjgKKn/MnwMe66xAiqBYu4huu+zuhaj44mOh2AF4LmJstMJJbnG0vo/PsAo
	 x87RtBj/qZelGTOwxatEMQz28hVZpQ6VqlPULzWI=
Date: Sat, 27 Jan 2024 16:38:11 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3-of-simple: Stop using
 of_reset_control_array_get() directly
Message-ID: <2024012705-rabid-slighting-8d50@gregkh>
References: <20240124-dwc3-of-simple-reset-control-array-fix-v1-1-808182cc3f0e@pengutronix.de>
 <2024012400-subtitle-magnitude-45ff@gregkh>
 <63a1bfa2acb84bc24b87a8dbd60b665c733d13cd.camel@pengutronix.de>
 <2024012705-pantry-synapse-749a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012705-pantry-synapse-749a@gregkh>

On Sat, Jan 27, 2024 at 04:34:14PM -0800, Greg Kroah-Hartman wrote:
> On Wed, Jan 24, 2024 at 01:56:18PM +0100, Philipp Zabel wrote:
> > On Mi, 2024-01-24 at 04:39 -0800, Greg Kroah-Hartman wrote:
> > > On Wed, Jan 24, 2024 at 12:26:20PM +0100, Philipp Zabel wrote:
> > > > Use of_reset_control_array_get_optional_exclusive() instead, it is
> > > > implemented as:
> > > > 
> > > >   static inline struct reset_control *
> > > >   of_reset_control_array_get_optional_exclusive(struct device_node *node)
> > > >   {
> > > >           return of_reset_control_array_get(node, false, true, true);
> > > >   }
> > > > 
> > > > This makes the code easier to understand and removes the last remaining
> > > > direct use of of_reset_control_array_get(). No functional changes.
> > > > 
> > > > Fixes: f4cc91ddd856 ("usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles")
> > > 
> > > No functional change, but a Fixes: tag?  That doesn't make sense to me,
> > > sorry.
> > 
> > The referenced patch made the boolean parameters const but missed that
> > there is a static inline wrapper for this combination. I can drop the
> > Fixes: tag and describe this in the text.
> 
> That would be best, thanks.

Ah you already did so, thanks!

