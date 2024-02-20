Return-Path: <linux-kernel+bounces-73055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5010C85BCD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEBB1F2379F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9426A02E;
	Tue, 20 Feb 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojKrj4cO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045269D0B;
	Tue, 20 Feb 2024 13:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434460; cv=none; b=b7cpL575ZgslamE+f+czdYIAfVflaW3pEeub5DiPEu0Wf1TTUaiCVEXl070y21WIM150LOWdDDoIMg/xyhLzejiUS4OsHkVNTAHjN+oU1dKJLHg63gBhHUJvKJKDnWd1bLOSZSw9JgRObYKtzcmvhLdIdTfvyaC2RFPxRXalcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434460; c=relaxed/simple;
	bh=ehswDltK3/4NFo3wnSiDCuhI7Mpdtyxc0vlD7vfoB6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pklBNPlqnIG7l3sIvmJilkQgdYkjWhLtSl/QPODx7h7AYQyWKsfZ2NJRawFlsghtUyoe9tRYyU2CHeXdc9LFD8gcdbhoxUhGBYtpju5cGZUnXEnXTQGI6+PucMgrce3ljRMOYluhkrfw6yiOxeQFWOxig15U5/+ZpN1SvIkPesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojKrj4cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D70C433C7;
	Tue, 20 Feb 2024 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708434460;
	bh=ehswDltK3/4NFo3wnSiDCuhI7Mpdtyxc0vlD7vfoB6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojKrj4cO7lNYmywHneIX4t4r7Lws02ZhWpIwyKPHHxdOYDe8F2Fc8kfam1bDLEleb
	 AsoBgNjuNRe8UUvvNh4wyMTUaRkTTz+awpZEWwqUEZjgHsdgvZRvdgvsqpp5Xehs+e
	 Y3iWNo0hwKX6AySrVePYFUXsTB/Cj+Qpc/sO2RTfAM3o+SZLVm9tWcAgtSlrPJwDqI
	 KP5ly5tyvfiQe2oH8ihoVlq+PTIvhTydpCYgxEH/I5y2I4gqmFyiynmpgfc9Y+Mo1H
	 ES9hkMt+Bbh3Zv4UrCogSwVv+i08b1huUYTPeWuAq2yDrkI9qLeaaiBHRtli9F0AAK
	 UACD0b9YmbeAw==
Date: Tue, 20 Feb 2024 13:07:35 +0000
From: Simon Horman <horms@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next v4] bonding: rate-limit bonding driver inspect
 messages
Message-ID: <20240220130735.GI40273@kernel.org>
References: <20240220050437.5623-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220050437.5623-1-praveen.kannoju@oracle.com>

On Tue, Feb 20, 2024 at 10:34:37AM +0530, Praveen Kumar Kannoju wrote:
> Through the routine bond_mii_monitor(), bonding driver inspects and commits
> the slave state changes. During the times when slave state change and
> failure in aqcuiring rtnl lock happen at the same time, the routine
> bond_mii_monitor() reschedules itself to come around after 1 msec to commit
> the new state.
> 
> During this, it executes the routine bond_miimon_inspect() to re-inspect
> the state chane and prints the corresponding slave state on to the console.
> Hence we do see a message at every 1 msec till the rtnl lock is acquired
> and state chage is committed.
> 
> This patch doesn't change how bond functions. It only simply limits this
> kind of log flood.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
> v4:
>   - Rectification in the patch subject and versioning details.
> v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
>   - Commit message is modified to provide summary of the issue, because of
>     which rate-limiting the bonding driver messages is needed.
> v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
>   - Use exising net_ratelimit() instead of introducing new rate-limit
>     parameter.
> v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
> ---
>  drivers/net/bonding/bond_main.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4e0600c..e92eba1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			commit++;
>  			slave->delay = bond->params.downdelay;
>  			if (slave->delay) {
> -				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
> -					   (BOND_MODE(bond) ==
> -					    BOND_MODE_ACTIVEBACKUP) ?
> -					    (bond_is_active_slave(slave) ?
> -					     "active " : "backup ") : "",
> -					   bond->params.downdelay * bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
> +						   (BOND_MODE(bond) ==
> +						   BOND_MODE_ACTIVEBACKUP) ?
> +						   (bond_is_active_slave(slave) ?
> +						   "active " : "backup ") : "",
> +						   bond->params.downdelay * bond->params.miimon);
>  			}

Hi Praveen,

As this is used several times I think that it would be worth introducing
a slave_info_ratelimit() helper. That is  assuming slave_info() is still used
without a rate limit. If not, you could just add net_ratelimit directly
to slave_info().

If none of this is desirable for some reason, then could you consider
reducing indentation somehow. f.e.:

		if (slave->delayi && net_ratelimit())
			slave_info(...

