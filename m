Return-Path: <linux-kernel+bounces-75344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2649E85E6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9357EB22A0E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B285C44;
	Wed, 21 Feb 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2/2zmYd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FC79DD6;
	Wed, 21 Feb 2024 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542594; cv=none; b=ry6er6clkdY0JcbbXPe24ZQWJfm08clRc6kuXvZeSApXBswho2EzkGNMZU3LJD00GxL7hl8RLQUGsHAT+Sv4cJYcXyxTAp4KOGytWpwrsZk22f1Unot8h5nn99ZBqqeYYGJYKwqLzIBrdui69kqub6rRqUgpu5b88Ewv4GpGRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542594; c=relaxed/simple;
	bh=Mt5aF6Hr76ak8o2cE1OJ5mzFoU6w/C5uo9s6FRkcdgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlP+FjG5Ul7pn8DM2JipqwcGjq9L4VJ2GZDC3+IaBp/HAWuI7vgKRpNrHv/F34nH5FFmfI8JOCVsC+X0IeJTymxM9IU0NOIaAx2J8pA5xqAIbwLywnZZkW4BpEgheFwypCEQXuWKv+WoXwGbsKf9Iy1LaHVPS6HnoqVwy7XwI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2/2zmYd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCCC433F1;
	Wed, 21 Feb 2024 19:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708542593;
	bh=Mt5aF6Hr76ak8o2cE1OJ5mzFoU6w/C5uo9s6FRkcdgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g2/2zmYdvzqYK4cj8AmYHmwN5yICBtAIKuHg5Sqd3MvR/UIvL/Grr9eb/tPRMlJ6c
	 3/uVSI4/ldPebzp1xz66czAakEUVVCUF+/1Vd9wE2t9r/2OY3TlFIXEBmxjxGwbpqx
	 9xIOMA1rLb5GPk4/nCJkJSDlkJDkwPLJcQhhG7yl0AmLrvLZH66jRRpN73EhmKIX4s
	 Mn3UiacmcxDbx6eHPoizRNG3d72/+xDrP+LYWug3f03N13WdnXOMUafRKltHbJo//F
	 VG4TquIc07EeZX6udOTeZXFwoN4h73D4WJiqXaOENZf67wCpt/wfjykelTASTzQOYG
	 7hiSVJ31oooEA==
Date: Wed, 21 Feb 2024 11:09:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Amritha Nambiar <amritha.nambiar@intel.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Larysa Zaremba
 <larysa.zaremba@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Paolo Abeni <pabeni@redhat.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Stanislav Fomichev
 <sdf@google.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/2] Expose netdev name in netdev netlink APIs
Message-ID: <20240221110952.43c0ae6e@kernel.org>
In-Reply-To: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 07:57:28 -0800 Joe Damato wrote:
> Greetings:
> 
> The netdev netlink APIs currently provide the ifindex of a device
> associated with the NIC queue or NAPI when the netlink API is used. In
> order for user applications to map this back to a human readable device
> name, user applications must issue a subsequent ioctl (SIOCGIFNAME) in
> order to map an ifindex back to a device name.

To be clear, if_indextoname() is doing it, right? I wanted to be sure
the concern is really number of syscalls, not the difficulty in getting
the name.

> This patch set adds ifname to the API so that when queue or NAPI
> information is retrieved, the human readable string is included. The netdev
> netlink YAML spec has been updated to include this field, as well.
> 
> This saves the subsequent call to ioctl and makes the netlink information
> more user friendly. Applications might use this information in conjunction
> with SO_INCOMING_NAPI_ID to map NAPI IDs to specific NICs with application
> specific configuration (e.g. NUMA zone and CPU layout information).

For context, the reason why I left the names out is that they can change
at any moment, but primarily because there are also altnames now:

2: eth0:
[...]
    altname enp2s0np0

Most of the APIs try to accept altnames as well as the "main" name.
If we propagate the name we'll step back into the rtnetlink naming
mess :(

