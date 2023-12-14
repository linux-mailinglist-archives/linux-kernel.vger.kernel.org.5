Return-Path: <linux-kernel+bounces-25-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA0813AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971EE1C20FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438F06A024;
	Thu, 14 Dec 2023 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfUXXzrP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262B697AF;
	Thu, 14 Dec 2023 19:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9F9C433C8;
	Thu, 14 Dec 2023 19:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702583129;
	bh=lYNWxD8VhKRxBVZogY1MoqzSA2del0XNZc5v4TOfhCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cfUXXzrP8XyHmFUWDcYjKEcMHEUHBERJX61bkW9aGMuHv1oLnEMc1Fj9hQkcqvfaY
	 PmQBuWLg6aXd/jw3FAtkDub7NjGiH9v0BvMSJpFeE6kXrfxAHZHmT6aWAEf8WhSG+E
	 16M3WNr9OwXidM/4QubN2ewgpAqQW7dmkKH3FkP2ALkSjozXyMKwuO9oVsCAoKPQ6N
	 hABCJRvZJ4aepBbtaej76Vd7Y0ubhVlx15KW3ner8Dvp6a5umTojVy7OKh3SuPkjDX
	 XpgBHTTD5oBsVGs9cj55ncmJ8ek3ogH4efuskHTPEl8b1WGcFDb6BW7R+ofIx3I2xA
	 5c1QRFNeoVW7w==
Date: Thu, 14 Dec 2023 19:45:24 +0000
From: Simon Horman <horms@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, sgoutham@marvell.com, sbhatta@marvell.com,
	jerinj@marvell.com, gakula@marvell.com, hkelam@marvell.com,
	lcherian@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, wojciech.drewek@intel.com
Subject: Re: [net-next PATCH v2] octeontx2-af: Fix multicast/mirror group
 lock/unlock issue
Message-ID: <20231214194524.GT5817@kernel.org>
References: <20231213095349.69895-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213095349.69895-1-sumang@marvell.com>

On Wed, Dec 13, 2023 at 03:23:49PM +0530, Suman Ghosh wrote:
> As per the existing implementation, there exists a race between finding
> a multicast/mirror group entry and deleting that entry. The group lock
> was taken and released independently by rvu_nix_mcast_find_grp_elem()
> function. Which is incorrect and group lock should be taken during the
> entire operation of group updation/deletion. This patch fixes the same.
> 
> Fixes: 51b2804c19cd ("octeontx2-af: Add new mbox to support multicast/mirror offload")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Note: This is a follow up of
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_netdev_net-2Dnext_c_51b2804c19cd&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=7si3Xn9Ly-Se1a655kvEPIYU0nQ9HPeN280sEUv5ROU&m=NjKPoTkYVlL5Dh4aSr3-dVo-AukiIperlvB0S4_Mqzkyl_VcYAAKrWhkGZE5Cx-p&s=AkBf0454Xm-0adqV0Os7ZE8peaCXtYyuNbCS5kit6Jk&e=
> 
> v2 changes:
> - Addresed review comments from Simon about a missed unlock and re-org the code
>   with some goto labels.

Thanks Suman,

this one looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

