Return-Path: <linux-kernel+bounces-144536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB98A4787
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759412818F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3274C9B;
	Mon, 15 Apr 2024 05:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fzOuenNS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57289F9C8;
	Mon, 15 Apr 2024 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713158503; cv=none; b=nb8SqY2QLWw16b/qbIXFKfO5W9MreY2uxg4DAmlYTQBYUrUDxSyLV+sZE+8l80+p5F9FEc7ui11lIoBFXfE4BciedNgBtqvktlHaT/qBoG0h1iDFXKAy4KML3rbmWRk78L4QIGbxC4Iyl4HzdutJuygtVTKOv5n7uK/hZvReb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713158503; c=relaxed/simple;
	bh=nlsa6YgRAFchswkyn7KkmzAVbBm3XbY20uZqZXRwrnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exiapsBbAp0+ZZ3TfAwadstCrKAq8OPNuUR2+3SnbKQujCG4aB4oXX0oGLqjapncYW4rJvUrrwyPUxaUIn10poDHY6LXGlJyLbaks8qyEXF7VeHxbxmLaFPmjFO/lFLjX5uLsLkMR28/jJr0VKPH2G9GtxkOavdGTvbpfZ6o86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fzOuenNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF97C113CC;
	Mon, 15 Apr 2024 05:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713158502;
	bh=nlsa6YgRAFchswkyn7KkmzAVbBm3XbY20uZqZXRwrnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzOuenNSgx06ppXJccfIqUwcs1fhWSId1+Mz3jtnG34Ep+W9tUwIcwm91dFZqJYgD
	 84sKXjWf9fJ3QY9u489oGiR33PkxTyyD4+I+0mfDnV/FNxNG4F/MxhC2hPl7LxtDWU
	 DIKpgrRKfPy8i4BH7hjtnK4g1SjKZiJBu0UcFn5M=
Date: Mon, 15 Apr 2024 07:21:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Alex Elder <elder@linaro.org>, corbet@lwn.net,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <2024041503-affidavit-stopwatch-72d7@gregkh>
References: <20240414170850.148122-1-elder@linaro.org>
 <20240414194835.GA12561@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414194835.GA12561@pendragon.ideasonboard.com>

On Sun, Apr 14, 2024 at 10:48:35PM +0300, Laurent Pinchart wrote:
> Hi Alex,
> 
> Thank you for the patch.
> 
> On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
> > Several times recently Greg KH has admonished that variants of WARN()
> > should not be used, because when the panic_on_warn kernel option is set,
> > their use can lead to a panic. His reasoning was that the majority of
> > Linux instances (including Android and cloud systems) run with this option
> > enabled. And therefore a condition leading to a warning will frequently
> > cause an undesirable panic.
> > 
> > The "coding-style.rst" document says not to worry about this kernel
> > option.  Update it to provide a more nuanced explanation.
> > 
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > ---
> >  Documentation/process/coding-style.rst | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 9c7cf73473943..bce43b01721cb 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
> >  to trigger easily, for example, by user space actions. pr_warn_once() is a
> >  possible alternative, if you need to notify the user of a problem.
> >  
> > -Do not worry about panic_on_warn users
> > -**************************************
> > +The panic_on_warn kernel option
> > +********************************
> >  
> > -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> > -available kernel option, and that many users set this option. This is why
> > -there is a "Do not WARN lightly" writeup, above. However, the existence of
> > -panic_on_warn users is not a valid reason to avoid the judicious use
> > -WARN*(). That is because, whoever enables panic_on_warn has explicitly
> > -asked the kernel to crash if a WARN*() fires, and such users must be
> > -prepared to deal with the consequences of a system that is somewhat more
> > -likely to crash.
> > +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
> > +a WARN*() call whose condition holds leads to a kernel panic.  Many users
> > +(including Android and many cloud providers) set this option, and this is
> > +why there is a "Do not WARN lightly" writeup, above.
> > +
> > +The existence of this option is not a valid reason to avoid the judicious
> > +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
> > +issue warnings but do **not** cause the kernel to crash. Use these if you
> > +want to prevent such panics.
> 
> Those options are not equivalent, they print a single message, which is
> much easier to ignore. WARN() is similar to -Werror in some sense, it
> pushes vendors to fix the warnings. I have used WARN() in the past to
> indicate usage of long-deprecated APIs that we were getting close to
> removing for instance. dev_warn() wouldn't have had the same effect.

If you want to reboot a box because someone called an "improper" api,
then sure, use WARN(), but that feels like a really bad idea.  Just
remove the api and fix up all in-kernel users instead.  Why wait?

If you want to show a traceback, then just print that out, but I've seen
that totally ignored as well, removing the api is usually the only way
to get people to actually notice, as then their builds break.

thanks,

greg k-h

