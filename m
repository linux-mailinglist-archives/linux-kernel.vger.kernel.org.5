Return-Path: <linux-kernel+bounces-164688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3438B8113
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BCA1F26360
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0F1C233C;
	Tue, 30 Apr 2024 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5xcVyFd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589C1A0AFB;
	Tue, 30 Apr 2024 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507385; cv=none; b=r67fq/8GaB14LKZci2B2QGJXc+Sor+uGnP7MwiOZKCfJWRzejH7IPAkWs8DEc7tmWcMnV1JMLw7U2QcGzo+uy1asI5burNJlJzBqB2XL7fIXaBsRCBCEAktnQJmZy5kNbnE9E0VN9FmWsD8K6ZlMZLjlWVJSQTV2gZ5m/vPEl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507385; c=relaxed/simple;
	bh=4MMWKqrqMWleDHuXwmb7LFjDvAuwnnOwOjLO3S5FiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsVbPA3r4tunor2JDX1bN6NFmqHwZJ9+jZtcDEsXc7W4z9CWDTtiQT4pfetO2AZyRtaBySPc24AinmMpeMZdNdjR/ROFPaNhFOB7iI4MY4oRZ+QKce4MMxcwSNFkSQn2h9ZfrUl176KPsxeYQjbWL5vbk6mgx7CyuFSOSVDwPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5xcVyFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1608C4AF14;
	Tue, 30 Apr 2024 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714507384;
	bh=4MMWKqrqMWleDHuXwmb7LFjDvAuwnnOwOjLO3S5FiZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G5xcVyFdVtl54uX/hFKtu4Xp8ZRHZksXd2T0ai5bqu/MORN2M96uFMG3sxxhhlC/H
	 eHLdTwN8NWUooPxQ72fGu9LdqjzUmnah1c2GzOzi2h8rbZafOHK2kv26V7JnufrNT3
	 FS3XrMYp1cQi7Vr3IIh3A5PG79xUjoRRE1nLVXb2HxBEGVREkdwqfpGaXwh9e9tumO
	 iKEzdopuvWlfen73mZa1yyUmfV/7ehba2fXmcYLk3PirbFwn6MblWfFEvlwWXWNqEr
	 fCTfvdHw/bns0ZwhYpfTEEduzixTLb6RQ2S9Gj4MQz4/0QySN6OeMzY9QlGyLntwA9
	 WXLgMwh/P4Pkg==
Date: Tue, 30 Apr 2024 13:03:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Message-ID: <20240430130302.235d612d@kernel.org>
In-Reply-To: <DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
	<20240429201130.5fad6d05@kernel.org>
	<DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 18:11:18 +0000 Danielle Ratson wrote:
> > Do we want to blast it to all listeners or treat it as an async reply?
> > We can save the seq and portid of the original requester and use reply, I
> > think.  
> 
> I am sorry, I am not sure I understood what you meant here... it
> should be an async reply, but not sure I understood your suggestion.
> 
> Can you explain please?

Make sure you have read the netlink intro, it should help fill in some
gaps I won't explicitly cover:
https://docs.kernel.org/next/userspace-api/netlink/intro.html

"True" notifications will have pid = 0 and seq = 0, while replies to
commands have those fields populated based on the request.

pid identifies the socket where the message should be delivered.
ethnl_multicast() assumes that it's zero (since it's designed to work
for notifications) and sends the message to all sockets subscribed to 
a multicast / notification group (ETHNL_MCGRP_MONITOR).

So that's the background. What you're doing isn't incorrect but I think
it'd be better if we didn't use the multicast group here, and sent the
messages as a reply - just to the socket which requested the flashing.
Still asynchronously, we just need to save the right pid and seq to use.

Two reasons for this:
 1) convenience, the user space socket won't have to subscribe to 
    the multicast group
 2) the multicast group is really intended for notifying about
    _configuration changes_ done to the system. If there is a daemon
    listening on that group, there's a very high chance it won't care
    about progress of the flashing. Maybe we can send a single
    notification that flashing has been completed but not "progress
    updates"

I think it should work.

> > > +void ethnl_module_fw_flash_ntf_err(struct net_device *dev,
> > > +				   char *err_msg, char *sub_err_msg) {
> > > +	char status_msg[120];
> > > +
> > > +	if (sub_err_msg)
> > > +		sprintf(status_msg, "%s, %s.", err_msg, sub_err_msg);
> > > +	else
> > > +		sprintf(status_msg, "%s.", err_msg);  
> > 
> > Hm, printing in the dot, and assuming sizeof err_msg + sub_err < 116 is a bit
> > surprising. But I guess you have a reason...
> > 
> > Maybe pass them separately to ethnl_module_fw_flash_ntf() then you can
> > nla_reserve() the right amount of space and sprintf() directly into the skb?  
> 
> I can get rid of the dot actually, would it be ok like that?

It'd still be better to splice the two strings and the comma directly
to the skb, rather than on the stack using a function which doesn't
check the bounds of the buffer :S

