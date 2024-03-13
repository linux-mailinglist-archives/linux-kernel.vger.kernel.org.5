Return-Path: <linux-kernel+bounces-102447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7953F87B234
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D61CB2B4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0884D4D108;
	Wed, 13 Mar 2024 19:44:46 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301F679DD;
	Wed, 13 Mar 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359085; cv=none; b=jJwawDDydHcStaEIatBrW6yyamGHb2TeNjaN7BuD51JTxB6iwOX1b4DZNg2/nlranDRHlKIDnhex6Y8Wm9ofv/26fD4mD+1mawwdBxOcIIinNCkQimwthz6g1abyvBkGzuw+Sl55R61LraYk/FS9G3bczBedTrbwJzGLP8UKsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359085; c=relaxed/simple;
	bh=xfzrj84MmcdTlfzKc7G9HIN3Vlh4qU4DUvE050cAj9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjgFL9AxI7GGTzK8OW3RhvKGuIK9tAGwcYInGPOMjlUB/Ixz8sDLaTahlB+ian2uUCiQ7RJkA962tAh5BPoEJ1SR7zAQG+8Pw4Bl7sRGp4FOc93mx1OPe4cyMII3iq2DqDOu2kCkI/5+7UKV3dkO+lf/3t4/Frq6vIjLJIDFz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rkUWl-0002Gm-Th; Wed, 13 Mar 2024 20:44:39 +0100
Date: Wed, 13 Mar 2024 20:44:39 +0100
From: Florian Westphal <fw@strlen.de>
To: Linus =?iso-8859-15?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Message-ID: <20240313194439.GA7400@breakpoint.cc>
References: <20240306141805.17679-1-linus.luessing@c0d3.blue>
 <20240307101254.GL281974@kernel.org>
 <ZfIBQbPeP8SYc3jf@sellars>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfIBQbPeP8SYc3jf@sellars>
User-Agent: Mutt/1.10.1 (2018-07-13)

Linus Lüssing <linus.luessing@c0d3.blue> wrote:
> Also this related fix introduced in v2.6.29 should hint to the
> age of this issue:
> 
>   3f9007135c1d netfilter: nf_conntrack_ipv6: don't track ICMPv6 negotiation message
> 
> Which only picked/fixed a few ICMPv6 types but not ICMPv6 MRD
> though.
> 
> tl;dr: for me this would be ok, if it were ok for others, too, that I
> couldn't fully bisect to it in practice... :
> 
> Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

Thats fine, its clear that this is isn't a regression this way.

