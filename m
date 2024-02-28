Return-Path: <linux-kernel+bounces-85189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB086B1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D13FB23B58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A315A4A5;
	Wed, 28 Feb 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tykAATqm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411A914EFCD;
	Wed, 28 Feb 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130845; cv=none; b=sXkfcAl8s5OG0UqKVurf4mpMru7w8ssqOZWuo/Aut5TroQuN4fB55DbUsUvUFbbm9BsWM5EBozoq9NhSVq1KybAco+AHPur22qJ7aH6q0Gq74Xgri70N4pFnNePqEtxStA6GQGH/IimYbV3A/JYO+o3bjXFo8zaFufWJbZ58w/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130845; c=relaxed/simple;
	bh=srM0SpEWHS7SZXQGlLSr6ylprr3w8Mmldv4L7MWNCZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJK5QJIZyPtZKKaRPAp5GOeHzWm5DIFv/tdl8Az6sJdcPh1BuAenM7NPHivRAknDtYLHPWOegs7EeHFPlv1h7n8PFrOSQm5ULOWV6uHRRnuRxqtogwgy+FT2vsHWzZppS8Ab4SAhkfjWapuBjjiZsXdWKj1JACg8pijAXK/h/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tykAATqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C81EC433C7;
	Wed, 28 Feb 2024 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709130844;
	bh=srM0SpEWHS7SZXQGlLSr6ylprr3w8Mmldv4L7MWNCZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tykAATqmIQt3vy30l4Tr3k28GTDF8BasUcuxCtMy2Xn/7V10FyR/YDYOyufXrO5Pj
	 hMfSTVqxj3/YCaaEB13GtYgsCVeDf7CIO9fF+3K1Qfv17g7mBS5Z1MVzB5J8QgWBWc
	 3eXk88PbnlY7/UHmk791qRDQuYWBiu+Mao7BaoPrDUqKukuVsBrXTd6jEAnnGawmbx
	 AzNpnNNIBPm5bjQ4a3OMS8qpyC9rk2mn0o+P2gUW8qyQ95z3vnjQyKEDrb25a3yO4F
	 j6x9X3k/Tdg92KAmESE8PT7vQe+Etl8lfq+8Y0KJVdkvrEdi7b/ovv10Zd6bYuQFsz
	 f9zYZIimnJwRg==
Date: Wed, 28 Feb 2024 14:34:00 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dsahern@kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>
Subject: Re: [PATCH net-next 1/2] net: get stats64 if device if driver is
 configured
Message-ID: <20240228143400.GG292522@kernel.org>
References: <20240228113125.3473685-1-leitao@debian.org>
 <20240228113125.3473685-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228113125.3473685-2-leitao@debian.org>

On Wed, Feb 28, 2024 at 03:31:21AM -0800, Breno Leitao wrote:
> If the network driver is relying in the net core to do stats allocation,
> then we want to dev_get_tstats64() instead of netdev_stats_to_stats64(),
> since there are per-cpu stats that needs to be taken in consideration.
> 
> This will also simplify the drivers in regard to statistics. Once the
> driver sets NETDEV_PCPU_STAT_TSTATS, it doesn't not need to allocate the
> stacks, neither it needs to set `.ndo_get_stats64 = dev_get_tstats64`
> for the generic stats collection function anymore.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


