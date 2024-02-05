Return-Path: <linux-kernel+bounces-52828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BDF849D21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3D61F22B18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAF2C19A;
	Mon,  5 Feb 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJX3U8uv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377D2C688;
	Mon,  5 Feb 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143645; cv=none; b=J8+8JYTnGyg/n+dfe8Z1T/YkdwAB/41yS8MF9CI89ji7XH4djvVTjXww1a7vHZALFD1nn0e3xMYTJ5AWKDDIRxb08M9MnbzhV8NQutsvkeRfV4eg2gRGnAImZDTaP24Yz7qvJpgI4DYbjwFLKLKwO57+3A803x6bUH4Pttj2LNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143645; c=relaxed/simple;
	bh=iBEoat+OSUZc6lnPLh2AanULhM+rpP8BzE4RZbNK5z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksB1nhIbxyTMvCQQUYbePXpaAAeWHiSbbK++zDvWfu6a3F+DIbXZo8nwRyyhFX9jgmZxN4VRO7jKR2YEFxW5OKHthk24Tou7dybafvbFMcwkjpILayYst/w8oyCgATVUiEg34XhNisU2sudW9dFBFHB6Zl70bZUnWJR6/qTqvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJX3U8uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD81C433F1;
	Mon,  5 Feb 2024 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707143644;
	bh=iBEoat+OSUZc6lnPLh2AanULhM+rpP8BzE4RZbNK5z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJX3U8uvH5HXjL4C/OEXRtNtDYD89dJ7oms9PFEVAaAn8XVtPBMXKQr5hvTm+y9Gy
	 gfBL4Jcez1RpKXmz0LWF0lDwKf6ZS1AsPEIWK/KozH6g3X1cjz5EM4BwlUOAwHuqm6
	 wf4ZGvcc/ZObkBLVKAT9yfIf9FLSBxOYC/zp0K231vnLs8ynig29DsqXzSlK92p6i4
	 QX+BIjk0HV4/W2uuiOfeXlmte/RFV2UZdhJIdORjBwGKm6A6lt7n9OBepiLcwOCvna
	 IKAp2QLORaRKAAd/mzaDhArRXFYo8MP6Bq+PUjLvNKW6uHakgeTMHHjbKgQ0LG7+Ak
	 WosUh47y4XRig==
Date: Mon, 5 Feb 2024 14:33:59 +0000
From: Lee Jones <lee@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <20240205143359.GB53266@google.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
 <65c0e874.df0a0220.257a.43b1@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c0e874.df0a0220.257a.43b1@mx.google.com>

On Mon, 05 Feb 2024, Christian Marangi wrote:

> On Mon, Feb 05, 2024 at 02:41:46PM +0100, Andrew Lunn wrote:
> > > > This should have 'net' in the subject line, to indicate which tree its
> > > > for.
> > > 
> > > No, it shouldn't.
> > > 
> > > Contributors aren't obliged to know anything about merging strategies.
> > 
> > With netdev, we tend to assume they do, or at least can contribute to
> > the discussion. They often know about any dependencies etc which could
> > influence the decision. When there are multiple subsystem maintainers
> > involved, i tend to use To: to indicate the maintainer i think should
> > merge the patch, and Cc: for the rest.
> >
> 
> I'm always a bit confused when I have to send patch to mixed subsystem
> (not the case but for net trigger it's almost that). Sorry for the
> confusion/noise.

When you have a truly cross-subsystem patch, it's up to you.

 - Mention both e.g. leds/net:
 - Mention neither e.g. <device>:
 - Mention the one that is most relevant

 An example of the last option might be when the lion's share of the
 changes occur in one subsystem and only header files are changed in the
 other.

In an ideal world i.e. when there are no build-time/runtime deps between
them, changes should be separated out into their own commits.

> > > Why does this need to go in via net?
> > 
> > It does not, as far as i'm aware. Christian, do you know of any
> > reason?
> > 
> 
> This is strictly a fix, no dependency or anything like that. Maybe using
> net as target would make this faster to merge (since net is for fix only
> and this has to be backported) than using leds-next?

We have leds-fixes for that.

-- 
Lee Jones [李琼斯]

