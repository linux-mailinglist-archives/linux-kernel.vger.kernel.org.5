Return-Path: <linux-kernel+bounces-71143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E83D85A141
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2927A2824CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AE28DC9;
	Mon, 19 Feb 2024 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S88iPmBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8B1C10;
	Mon, 19 Feb 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339596; cv=none; b=B55DHfw2AkPkk+xa79B0U+j9DAh5t1L6NPytAfKph9RFNQ2adQ4nvoXnKG851N6ZufLL8ttbrsu+vqQveA0AQdVD7KZi3ZUkB9E1ZcWzSRx2a9BJ1GkbLdp2uEz7gcj9RCHiFuEOohqV4CYxHetNeh2JhdrruAl1DOErb5CBCG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339596; c=relaxed/simple;
	bh=5XDPx675FUDjasxUQK3VEjkHE+gDS2SgWTJPoUGJWNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLRQNbLGhlowi8d7NFpsQ+m0u2Z+trRoNI7didZNTTSmix52E5AmQVtZPBV8a0id7vxJiZv6k3Q1U7SgOQGmgd2Uv5wfS2bBXPG7HE2XaLgyrxlnViTFxlKx4LsUF85qRt3xCGawPWVwF0FHY/mqmiOR/UXp7d9TrJH5EOB2210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S88iPmBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C97C433C7;
	Mon, 19 Feb 2024 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339595;
	bh=5XDPx675FUDjasxUQK3VEjkHE+gDS2SgWTJPoUGJWNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S88iPmBCTMreeRSofnpsvFuhqX5TDo0UzX1zEwIiHSQNvrFWsiM1jcXWLmXb4FLSJ
	 M12o3uTAGqLlpM3sDKSJXihVF2LRBj+D/PpGpnhiSX4johOZeWARKWbfFGb2VbvhYE
	 TxC42US/XCjGn+SwS537II+NbJQh9OJ+xtRqKmjH+IyrQXQO6+hQhbhh7R5CoO9Yf/
	 u0PpYZ/+6QwdMGxTYKh9o1RL8UvlTIlVhiwPVhGmCLB3eigFkEBknmrYWAGOjeYw5Y
	 gkF8xnsu4Pq6xdyGgk72bRRsZIu/UXzP6tmEL2uGhuGlRk2H+KzJu6P7O/l0N23zBH
	 puw81h2zrEj1w==
Date: Mon, 19 Feb 2024 10:46:31 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Breno Leitao <leitao@debian.org>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240219104631.GX40273@kernel.org>
References: <20240216094154.3263843-1-leitao@debian.org>
 <20240216092905.4e2d3c7c@hermes.local>
 <0e0ba573-1ae0-4a4b-8286-fdbc8dbe7639@gmail.com>
 <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+5F7d4i7Ds4V6TtkzzAjQjNQ8xOeoYqZr8tY6tWWmMEg@mail.gmail.com>

On Fri, Feb 16, 2024 at 07:45:37PM +0100, Eric Dumazet wrote:
> On Fri, Feb 16, 2024 at 7:41 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 2/16/24 09:29, Stephen Hemminger wrote:
> > > On Fri, 16 Feb 2024 01:41:52 -0800
> > > Breno Leitao <leitao@debian.org> wrote:
> > >
> > >> +static bool netdev_uses_bql(const struct net_device *dev)
> > >> +{
> > >> +    if (dev->features & NETIF_F_LLTX ||
> > >> +        dev->priv_flags & IFF_NO_QUEUE)
> > >> +            return false;
> > >> +
> > >> +    return IS_ENABLED(CONFIG_BQL);
> > >> +}
> > >
> > > Various compilers will warn about missing parens in that expression.
> > > It is valid but mixing & and || can be bug trap.
> > >
> > >       if ((dev->features & NETIF_F_LLTX) || (dev->priv_flags & IFF_NO_QUEUE))
> > >               return false;
> > >
> > > Not all drivers will be using bql, it requires driver to have that code.
> > > So really it means driver could be using BQL.
> > > Not sure if there is a way to find out if driver has the required BQL bits.
> >
> > There is not a feature flag to be keying off if that is what you are
> > after, you would need to audit the drivers and see whether they make
> > calls to netdev_tx_sent_queue(), netdev_tx_reset_queue(),
> > netdev_tx_completed_queue().
> >
> > I suppose you might be able to programmatically extract that information
> > by looking at whether a given driver object file has a reference to
> > dql_{reset,avail,completed} or do that at the source level, whichever is
> > easier.
> 
> Note that the suggested patch does not change current functionality.
> 
> Traditionally, we had sysfs entries fpr BQL for all netdev, regardless of them
> using BQL or not.
> 
> The patch seems to be a good first step.
> 
> If anyone wants to refine it further, this is great, but I suspect
> very few users will benefit from
> having less sysfs entries for real/physical devices....
> 

From my point of view the main advantage in not having these entries
would be that it is really a bit confusing for them to be there
that don't use BQL. But I agree, that is (also) likely to benefit
few users.

In any case, I agree this is a good first step.


