Return-Path: <linux-kernel+bounces-111374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA9886B6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C3A28641F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5E3F9CE;
	Fri, 22 Mar 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik50+Tid"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA517564;
	Fri, 22 Mar 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107679; cv=none; b=S/rbW1hb3ylq63bTZ9X9YPcHTyytMmqwxLX0nrXEPScWPU7A4yK3O/0uENRSCYlOdw6ZAkKgZXtFvr0/1onlduFa+cvBZj90zSkZhERfgG5CydgKowDu6P5IIWIoECinja/MTR0NE92eBlaUesvufzUM91LGy1tN7esLfG9lQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107679; c=relaxed/simple;
	bh=LF2rr9dOfpEZuuPPXmvnPc6f8+IaaJWMgYsu8binxPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSiYUfRSQbOhMOXwrW9c3VQyVCe/YZrGly9B9ytm0jeABlD6YNSHhPXbllwW8wSf/X5FWsIKaumj2QLdNY4d2zbDvY2DHslCdZVhFCqDCcRgualTgmGP9XN/oADaMC4Q2p5O8olyQtDso251BM7qZMIVSE1+H5KgXdA8/DX+WIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik50+Tid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8858CC433C7;
	Fri, 22 Mar 2024 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711107679;
	bh=LF2rr9dOfpEZuuPPXmvnPc6f8+IaaJWMgYsu8binxPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik50+Tid+IK1cuGjNPX272PhSxzPR9jT24fFkvLmo3GWTuS5DKQIuKnQhRqcUwDdg
	 2R9X6ilqTc5Kb8nWL29j5GJtA+DVqsRNXPHUHg9/2uZiaBtiT7nknbvSHwBFJTxR/T
	 YxQUOl1eL2DWupnzUon8IDpAo5hNoz58YUb8tnAaSmULOQVQTes9UlMeNqNpxAZtT7
	 KC5qFgOhLUYLJ5O3kgMhLpOnO5wRNdyR6joTx96nrgeV61X4bTAwZ7D2J7RpZ6GGNJ
	 y5tMlsgPA5yVeNSkaWhIW4QAtbrX4vlZOGymzjb+JIH8oUEgOTIz9890u7HRCsWi4j
	 NXTHG1lAiqKMQ==
Date: Fri, 22 Mar 2024 11:41:15 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Message-ID: <20240322114115.GB372561@kernel.org>
References: <Zfrmv4u0tVcYGS5n@nanopsycho>
 <20240321123446.7012-1-abelova@astralinux.ru>
 <CANn89iK1SO32Zggz5fh4J=NmrVW5RjkdbxJ+-ULP8ysmKXLGvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK1SO32Zggz5fh4J=NmrVW5RjkdbxJ+-ULP8ysmKXLGvg@mail.gmail.com>

On Thu, Mar 21, 2024 at 06:16:30PM +0100, Eric Dumazet wrote:
> On Thu, Mar 21, 2024 at 1:35 PM Anastasia Belova <abelova@astralinux.ru> wrote:
> >
> > skb is an optional parameter, so it may be NULL.
> > Add check defore dereference in eth_hdr.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow dissector.")
> > Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> > ---
> >  net/core/flow_dissector.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 272f09251343..68a8228ffae3 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
> >
> >         if (dissector_uses_key(flow_dissector,
> >                                FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> > +               if (!skb)
> > +                       goto out_bad;
> >                 struct ethhdr *eth = eth_hdr(skb);
> >                 struct flow_dissector_key_eth_addrs *key_eth_addrs;
> >
> 
> 
> I think you ignored my prior feedback.
> 
> In which case can we go to this point with skb == NULL ?
> How come nobody complained of crashes here ?
> 
> I think we need to know if adding code here is useful or not.
> 
> You have to understand that a patch like this might need days of work
> from various teams in the world,
> flooded by questionable CVE.

Hi Eric and Anastasia,

I have conducted a review of the callers of __skb_flow_dissect()
that I could find in net-next and my conclusion is that, given
current usage, the code path above will not be hit with a NULL skb.

A summary of the analysis is as follows.

bond_flow_dissect:
- Analysis: skb parameter may be NULL but FLOW_DISSECTOR_KEY_ETH_ADDRS
  is not included in flow_keys_bonding_keys
- Conclusion: Code path in question is not hit for this user

skb_flow_dissect:
skb_flow_dissect_flow_keys:
fib6_rules_early_flow_dissect:
fib4_rules_early_flow_dissect:
__skb_get_hash_symmetric:
- Analysis: data parameter is NULL, which means that skb must be non-NULL
  else a crash would occur in the following code near the top of
  __skb_flow_dissect().
	if (!data) {
		data = skb->data;
- Conclusion: Calling eth_hdr(skb) is safe for these users

Assuming my analysis is correct (please check!) then
as this code is in the fast path for many users I think it is best
not to add this unnecessary check (which I assume is Eric's concern too).

