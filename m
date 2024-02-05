Return-Path: <linux-kernel+bounces-52818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F80849D06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA41F28E74
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676072C195;
	Mon,  5 Feb 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Djc83Lpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FAB1CA9E;
	Mon,  5 Feb 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143261; cv=none; b=JB6S8gA4L8TUapqHp1MTjZseVF9JuO0PdE7KevNzykefWGNIVod8fbDCfhVt10DLgKN1tT1qOTLGi3xBQW6avcShMYjlWiPNPiGVQpv4t5OjOWkpeSwj2PG0rb1C0BsqGTGaKWMPTo/NzqwfCKpJGvhLQMHBrxxfiXqMiSqMP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143261; c=relaxed/simple;
	bh=B8TpQw2Jaip2TPWJ9RND2ETvhmZ3Nd2W09imw/Jdy90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9ivVpKcfEblze7wqxGQ9WkzuPpErKmdt1crSXsedwtLT+gJWIGpF9g6lF2BJMJWWgHOU/bMrvgejtN/fgamITVljZPq61GHH5jtJ9TCXi1HRD8iOU0Fo0u3FaFJfA4F61Yrj3e8IXT6rnUzSU4QCNwBZKybgERgMdBe5nqNBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Djc83Lpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C70C433C7;
	Mon,  5 Feb 2024 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707143261;
	bh=B8TpQw2Jaip2TPWJ9RND2ETvhmZ3Nd2W09imw/Jdy90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Djc83LpaFVG47BdcdzPc+EfjNgWxUFm2Hd4k/0dOoei9ttuoj9WKmAzsmgd+DaQf3
	 VxEM7aL7O1qwXZx6Z5I/tBNtLjxjYSosvpGRosjGnAjI+slFnFxf9y20PswHxmDKGO
	 VaROituVdfOKtXiXPObSuILx2DuKSHK5MavMDYU/z0NGrXoQP3XM2igV2uIK+upsv3
	 OEgpLYH/f8BB+6qIuK1xWUR1UlajnVDGlq2AMy3ZGOb1AieO3VoVL7OS/Bz5L+teOr
	 EjG0e1e4QY3DAGu25g25fKyFHgbvPwNUXw8IvQFTHcIz9AkM6XrRGHeqojj6KbadAZ
	 Fo6RMCJtYg74Q==
Date: Mon, 5 Feb 2024 14:27:35 +0000
From: Lee Jones <lee@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Pavel Machek <pavel@ucw.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: Fix kernel panic on interface
 rename trig notify
Message-ID: <20240205142735.GA53266@google.com>
References: <20240203235413.1146-1-ansuelsmth@gmail.com>
 <8d51f09b-e6d2-4ee1-9e7d-b545d561798a@lunn.ch>
 <20240205085007.GA19855@google.com>
 <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cf84815-f9b6-4a0a-a3b4-d23628a89aa4@lunn.ch>

On Mon, 05 Feb 2024, Andrew Lunn wrote:

> > > This should have 'net' in the subject line, to indicate which tree its
> > > for.
> > 
> > No, it shouldn't.
> > 
> > Contributors aren't obliged to know anything about merging strategies.
> 
> With netdev, we tend to assume they do, or at least can contribute to
> the discussion. They often know about any dependencies etc which could
> influence the decision. When there are multiple subsystem maintainers
> involved, i tend to use To: to indicate the maintainer i think should
> merge the patch, and Cc: for the rest.

This isn't a netdev patch. :)

We make no such stipulation for any of the subsystems I maintain.

The subject line should indicate which subsystem the commit pertains to,
not which maintainer will merge it or which tree it's merged via.  In
this case, it's drivers/leds, so "leds: " is fine.

> > Why does this need to go in via net?
> 
> It does not, as far as i'm aware. Christian, do you know of any
> reason?

It's pretty early in the cycle and there are no cross-subsystem deps
yet, as far as I'm aware.

-- 
Lee Jones [李琼斯]

