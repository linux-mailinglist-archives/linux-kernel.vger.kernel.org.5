Return-Path: <linux-kernel+bounces-155416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A058AEA19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D271A1C21F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A213C909;
	Tue, 23 Apr 2024 15:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRKw3MN+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBD13C69A;
	Tue, 23 Apr 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884602; cv=none; b=dbI9AsO+P1gwpnOVfRh2VGkFv+3g1Y95pMxMB17IIDskd8LRvMKos44a5BP7esZxHlzg6apMQJADOPx9LxGfINuzSdL9qyrEi3tc3j8ADGNEOyC4LNoz5comRNS4iGw3Nlqa9ustNmMvGfDuNXxW2D/lrXvLbkG1Xse+WJ60hNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884602; c=relaxed/simple;
	bh=rXF2vz4uK5Xl3yr0fnyG4Hh3/2Am/UC88pXu/D2wJxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WOspRaI8Q43fDYiWdgzObn86UZehx5hHV/LEB02ZJlO0mN71jeWadyz9BpObEsfoxO8BL9MPQPMl5LXcLli7RvVBV+bscXs044nATl/fUB/1Tx+CfHEhU0xasaLnyhvofnGtYKMhFs0qobuDbId8YA7kAWaeoqEa5Y8h56Csv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRKw3MN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2B3C116B1;
	Tue, 23 Apr 2024 15:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713884601;
	bh=rXF2vz4uK5Xl3yr0fnyG4Hh3/2Am/UC88pXu/D2wJxA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LRKw3MN+nfIFP4OFkRgjyLXJBvAol+Mx4tC2jL2BgABZ/X9aBOcGpG+DtVLkMtFw2
	 1E1N70diol1uuIU6I+JDs7bfImsg1CAyT+DM3uSQrZ1RnmqFZ9XarRrBSuah1ugPaj
	 Uxlv9BqsgG0nWUbxm20DKITANTRk7zUVWouhuHzI1ox0IiDWK0ji1tAsBpGtjfZtHe
	 A/Tk+dqA/RKBMLwyf1ik9qbZ0v0DdPfLBelHwS/a7tT+bTDk9aWS/cHV+JIZFqYixd
	 Xcae8mEWDNL1XvhJHWSuu9DqTyTIPc2mrS9nRCnP5Mnd+5Jn0E0/9FdVqXwPZmL5Kp
	 YrGYLy3czdLAQ==
Message-ID: <7537ed21-4fc5-47c1-9c06-58982a308419@kernel.org>
Date: Tue, 23 Apr 2024 09:03:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: add TCP fraglist GRO support
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240423094117.93206-1-nbd@nbd.name>
 <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 4:15 AM, Eric Dumazet wrote:
> I think we should push hard to not use frag_list in drivers :/

why is that? I noticed significant gains for local delivery after adding
frag_list support for H/W GRO. Fewer skbs going up the stack is
essential for high throughput and reducing CPU load.

> 
> And GRO itself could avoid building frag_list skbs
> in hosts where forwarding is enabled.

But if the egress device supports SG and the driver understands
frag_list, walking the frag_list should be cheaper than multiple skbs
traversing the forwarding path.

> 
> (Note that we also can increase MAX_SKB_FRAGS to 45 these days)

Using 45 frags has other side effects and not something that can be done
universally (hence why it is a config option).

45 frags is for Big TCP at 4kB and that is ~ 3 skbs at the default
setting of 17 which means an skb chain 2 deep. 1 skb going up the stack
vs 3 skbs - that is a big difference.

Was there a conference talk or a discussion around tests performed
comparing use of frag_list with MAX_SKB_FRAGS at 17 vs expanding
MAX_SKB_FRAGS to 45?

