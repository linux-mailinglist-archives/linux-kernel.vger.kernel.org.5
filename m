Return-Path: <linux-kernel+bounces-95310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A88874C0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B77283AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2985289;
	Thu,  7 Mar 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1aHm13R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F924839E8;
	Thu,  7 Mar 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806380; cv=none; b=peIG8ohfllDTZReEzfWLeE2+9v8EPkiCAKYda3QrOfgeqae3hXbyFqyb4qy4MrSfxRccjxtj9HAmx1VJc5lrWV0pzUsSLmTBzZRUKGvIzImQibeFAnpu0i8c4VP91S9W1RRoIuD0cL+gtPsfi9+07DRbyS5UhjR0+cPG/wOyhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806380; c=relaxed/simple;
	bh=ZySz9QgrBQQybSsyTJI7icgjidm8aIqzTfwrcnzHJms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avSdQQwFfAtqDUFuQIC1uvOmpNMOuVhAJphDDKK5oZqbOyKzIQFyvVMcvU3dATDUxAuMor+rOxnJVyCawK4eEzbOd3sOvtSggVrESUyjbKrDiAUxpUbMe2hKATG+j5njRK+CEtxEiImrnmVQtsrCF7uJ+BrAtE1OtN0VwXd6k8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1aHm13R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B72C43390;
	Thu,  7 Mar 2024 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709806380;
	bh=ZySz9QgrBQQybSsyTJI7icgjidm8aIqzTfwrcnzHJms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1aHm13Rd9cU4L1C0ihNRRyWGQGhtcPSwBvQlTcpiYBn0WZvltr3HJy1iuh1j3SeA
	 Yl8Qdz/V+RAKjZKC36Y6erLAkyoeKBpDQESZihqS9OdkhPyJlJEkaFFNTeQPglm2tP
	 K6CaD17M8k/D9o6oS543k52x6O5BwaDlBA/B/Nls2ydii5GTpoMAfyZifiX7o4nsbv
	 OiMlKQFUZj3HOgst/4CcvimrtXS4xXQ1iQTgybS98gjT5OIFNjKIC/HLZo8uxkGjw7
	 nKJs8cWqInxz7llY78uMMlTWOhenZJpz2rQd3f4q9Aj67cLfoWY9KQzP5MCG6gJ2xf
	 YRvyeusvppWlQ==
Date: Thu, 7 Mar 2024 10:12:54 +0000
From: Simon Horman <horms@kernel.org>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dietmar Maurer <dietmar@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	Alexandre Derumier <aderumier@odiso.com>
Subject: Re: [PATCH net] netfilter: conntrack: fix ct-state for ICMPv6
 Multicast Router Discovery
Message-ID: <20240307101254.GL281974@kernel.org>
References: <20240306141805.17679-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306141805.17679-1-linus.luessing@c0d3.blue>

On Wed, Mar 06, 2024 at 03:18:04PM +0100, Linus Lüssing wrote:
> So far Multicast Router Advertisements and Multicast Router
> Solicitations from the Multicast Router Discovery protocol (RFC4286)
> would be marked as INVALID for IPv6, even if they are in fact intact
> and adhering to RFC4286.
> 
> This broke MRA reception and by that multicast reception on
> IPv6 multicast routers in a Proxmox managed setup, where Proxmox
> would install a rule like "-m conntrack --ctstate INVALID -j DROP"
> at the top of the FORWARD chain with br-nf-call-ip6tables enabled
> by default.
> 
> Similar to as it's done for MLDv1, MLDv2 and IPv6 Neighbor Discovery
> already, fix this issue by excluding MRD from connection tracking
> handling as MRD always uses predefined multicast destinations
> for its messages, too. This changes the ct-state for ICMPv6 MRD messages
> from INVALID to UNTRACKED.
> 
> This issue was found and fixed with the help of the mrdisc tool
> (https://github.com/troglobit/mrdisc).
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>

Hi Linus,

this appears to be a fix and as such I think it warrants a Fixes tag.
You should be able to just add it to this thread if no other changes
are required - no need for a v2 just to address this.

..

