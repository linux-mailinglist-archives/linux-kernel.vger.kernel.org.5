Return-Path: <linux-kernel+bounces-74547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4085D5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ED41C21094
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9BE3D57F;
	Wed, 21 Feb 2024 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7GYZofQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67A3A1A2;
	Wed, 21 Feb 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511938; cv=none; b=p7m1CSClL8RrJrbF/DbVhoIsfpZ4lmSlOf6SGU5mYcizowPuY+uJkh8UOczs8yIu14zn7pPBs/5QXahPIvx8BLAWFJCW2v7D79QlWJac5h9buvwsw/Cv2zbA/+AqrXilt9NOENqTeIEoLC6UAORm5VG1CdZcQlgSlAPVmtnDPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511938; c=relaxed/simple;
	bh=FoY4vTs159m3czgbeJ2M9PAPE4Pi2TpKoQBGmnGalsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCE5y20sStuM2QYtRUbeCsNqJrSPZJJcaRrX6itcXipYnMV6gTkWWI2q81/vAk+QioidvBA2uzuVi1m5jP/TCMtUpeXwYC7eJ04IiGQDcMUJq6RqJNBC22pSC6WibqyHiNYwPNzJzlDaS9IoqwDxm3vcfjgwTVK5+y5sElAWz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7GYZofQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62BEC433C7;
	Wed, 21 Feb 2024 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708511938;
	bh=FoY4vTs159m3czgbeJ2M9PAPE4Pi2TpKoQBGmnGalsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D7GYZofQ8tMBxAKRh3s2vyrT3Y90i84Mvf0xwOWU7Gco2ynTLVz/J11H1m5EvEBQe
	 cS7AbaO/xsPowrSXfYIJNcPmwVCTpHesb/WlSKZ2DgNbx7oqopaLsa23kGsOQIAfyQ
	 wD+vTi+LdqfvhRIkqTILse1iLz5Sa9B+Id4mmLQ2s5PnzjiF0sPtWxCdbFWZEkugIv
	 Q+muVl1bAbVvDX+zn3vDtDXA3235ewwav6YZuTyS9kFNElWnmVerE5A215m0wWPH2H
	 TzbEo9s6znhJNnapqQkVMovZib+0NyJvlYAHLd3aP6AAzSmP5EuaVX8KIHs/U2QalP
	 UkqZmQplAc1kA==
Date: Wed, 21 Feb 2024 10:38:53 +0000
From: Simon Horman <horms@kernel.org>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next v6] bonding: rate-limit bonding driver inspect
 messages
Message-ID: <20240221103853.GD352018@kernel.org>
References: <20240221082752.4660-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221082752.4660-1-praveen.kannoju@oracle.com>

On Wed, Feb 21, 2024 at 01:57:52PM +0530, Praveen Kumar Kannoju wrote:
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
> v6: 
>   - Minor space additions addressed. 
> v5: https://lore.kernel.org/all/20240221050809.4372-1-praveen.kannoju@oracle.com/
>   - Redundant indentation addressed.
> v4: https://lore.kernel.org/all/20240220050437.5623-1-praveen.kannoju@oracle.com/
>   - Rectification in the patch subject and versioning details.
> v3: https://lore.kernel.org/lkml/20240219133721.4567-1-praveen.kannoju@oracle.com/
>   - Commit message is modified to provide summary of the issue, because of
>     which rate-limiting the bonding driver messages is needed.
> v2: https://lore.kernel.org/lkml/20240215172554.4211-1-praveen.kannoju@oracle.com/
>   - Use exising net_ratelimit() instead of introducing new rate-limit
>     parameter.
> v1: https://lore.kernel.org/lkml/20240214044245.33170-1-praveen.kannoju@oracle.com/
> ---
>  drivers/net/bonding/bond_main.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

Hi Praveen,

Thanks for addressing my review of v4.
This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

