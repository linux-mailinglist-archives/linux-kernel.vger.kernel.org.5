Return-Path: <linux-kernel+bounces-52871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3872849DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BED4B2487E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8752C69F;
	Mon,  5 Feb 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePZvZO6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEE2C68C;
	Mon,  5 Feb 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145468; cv=none; b=i65Tlz6kTCWu8HkQcW2LD5YQDwsfCteDojHwSLvz6zW+Dv28r8ZpBMYlygm6rk6H5eDk+AjjSflYq7nyVfhjLYAoCzoXYQ6Dj7n0dldW+JJRnfRfKOIkbYtqdfQrG1OUyg5LsKAdXgni9KdZrrtRJmgnZKzP24S8KEA+j/iN5j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145468; c=relaxed/simple;
	bh=0aZM96cjECYxM3U7ULUcl2ArQahZ2cd3SuFhh6THTnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9h694GObYnMVnDI5uhCbxICuyZ2vkjeevMZnosyhDlaHlJOE1Gkslh3e2MmmsLhNffL5DMGE7XtAAJ3YJ33rQg3fCZi6QfDa51A5v1A2YXQ5Pq9IZ3xveGQvuzc1B8jwqY771ilRllcbytiqfd04BD53OfVPAm0morgBPcS+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePZvZO6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8834BC433F1;
	Mon,  5 Feb 2024 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707145467;
	bh=0aZM96cjECYxM3U7ULUcl2ArQahZ2cd3SuFhh6THTnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePZvZO6HiVSMSEYiqMZFZYdIvJjPVsWrg2FPLETmzjKm46HtuRHhxVB2DyO2hhr+7
	 0ams6lQXLe4rJ7rwr5PYf4QL5UcAFp0x3Oo8rj5a1q7tXRRPKtfLUOZ3VesLFj4IU9
	 uPWJiSIkceSIrltOFXfrHbGW4GSMezflVbpc3Z60wzSKgKFlki0AkbDWG9URRXGEub
	 LH5kWRSddT1ME4Me+3rliFQkbT1V4tMld4SLwPbmUgcDJ5QfT/CdtNQri0LLbwNKru
	 CC9NSvuFhWBofZUZAcg86Yif0Mn9peeLsMvdnXXGkL8N8ylWm0dNZvQlvzDCpEBk3l
	 yhCbzK8uZlsMw==
Date: Mon, 5 Feb 2024 15:04:22 +0000
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
Message-ID: <20240205150422.GC53266@google.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
 <65c0e874.df0a0220.257a.43b1@mx.google.com>
 <20240205143359.GB53266@google.com>
 <65c0f2dc.050a0220.63083.8524@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c0f2dc.050a0220.63083.8524@mx.google.com>

On Mon, 05 Feb 2024, Christian Marangi wrote:

> On Mon, Feb 05, 2024 at 02:33:59PM +0000, Lee Jones wrote:
> > On Mon, 05 Feb 2024, Christian Marangi wrote:
> > 
> > > On Mon, Feb 05, 2024 at 02:41:46PM +0100, Andrew Lunn wrote:
> > > > > > This should have 'net' in the subject line, to indicate which tree its
> > > > > > for.
> > > > > 
> > > > > No, it shouldn't.
> > > > > 
> > > > > Contributors aren't obliged to know anything about merging strategies.
> > > > 
> > > > With netdev, we tend to assume they do, or at least can contribute to
> > > > the discussion. They often know about any dependencies etc which could
> > > > influence the decision. When there are multiple subsystem maintainers
> > > > involved, i tend to use To: to indicate the maintainer i think should
> > > > merge the patch, and Cc: for the rest.
> > > >
> > > 
> > > I'm always a bit confused when I have to send patch to mixed subsystem
> > > (not the case but for net trigger it's almost that). Sorry for the
> > > confusion/noise.
> > 
> > When you have a truly cross-subsystem patch, it's up to you.
> > 
> >  - Mention both e.g. leds/net:
> >  - Mention neither e.g. <device>:
> >  - Mention the one that is most relevant
> > 
> >  An example of the last option might be when the lion's share of the
> >  changes occur in one subsystem and only header files are changed in the
> >  other.
> > 
> > In an ideal world i.e. when there are no build-time/runtime deps between
> > them, changes should be separated out into their own commits.
> >
> 
> Thanks a lot for the explaination and the examples!
> 
> > > > > Why does this need to go in via net?
> > > > 
> > > > It does not, as far as i'm aware. Christian, do you know of any
> > > > reason?
> > > > 
> > > 
> > > This is strictly a fix, no dependency or anything like that. Maybe using
> > > net as target would make this faster to merge (since net is for fix only
> > > and this has to be backported) than using leds-next?
> > 
> > We have leds-fixes for that.
> >
> 
> Oh! No idea, should I add a tag to the patch to target that branch
> specifically?

You don't need to do anything special.

The Fixes: tag is enough to let us know that this is a fix.

If the commit mentioned in Fixes: was accepted as part of the last
merge-window, it'll be sent to the -rcs in good time.  If it fixes a
commit which was introduced in a previous cycle, it'll be submitted
during the next merge-window.

> Anyway Since we have leds-fixes and this is leds related I think it's ok
> to use that and don't disturb net subsystem.

There is no reason why this should be merged via netdev.

> (again IT IS a kernel panic but happens only on some specific situation
> so it's not that critical)

-- 
Lee Jones [李琼斯]

