Return-Path: <linux-kernel+bounces-135436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D6F89C28A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B661C21E14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342B7F46F;
	Mon,  8 Apr 2024 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnJwoFd7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974327EF00;
	Mon,  8 Apr 2024 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582860; cv=none; b=ZCSpePY2AyuwjRkoEyc9/sL7IHs0jo6VApJrkMOGYrFGDc2KKjCriU+AuJ3moyAcdjpGtKD6wJsawT99NQO7IJR/NUawqCpxSlHcLDnSTHPhArABZXJFHDLFyWCOxnSodfFv1xzby6WKjgDFxg586hYkwh9Vr2N+ATukhzoMPTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582860; c=relaxed/simple;
	bh=oKmlzsu1mzXeyzsroGlcDIypRVHUX7fZH8394HWhSzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WtuZ8J5BnClm1mfHDwX0D0vTUu9i8OMBKvWdfxN2xfC8t9wqCwN882roZOmsFsPGdds7uUP0jmoMS3TTpNOViwmTobDqfPbTUTZSO1/uUR1R14pXxFEnNofzZ17bTOtQklT4bE/jAAbLWOxXgCvpeQs8Opt5RUuz97DXrdvq40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnJwoFd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9355BC433F1;
	Mon,  8 Apr 2024 13:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582860;
	bh=oKmlzsu1mzXeyzsroGlcDIypRVHUX7fZH8394HWhSzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnJwoFd70UCXRfAS7Zwt8djjohdK4218pY5tlhXCDcGN9qViHzY5MzHUiDnqxSVom
	 oAuiiMhDSrRoZwn3R8j0e8XgbViJB7J9yVCzkqpMK9wSv/L+fOmcJsQhiESul6jkbv
	 RYYfvZVqVjKf8Ov6uJttJIbrKvQ9sXlkYKYmxJyMLpsXfJ4sLTGCac18iOSiwnQGvL
	 WXYIJudvUpCOvPioBgTRFf3pLFFpS3Z54chQzZjrCd++haXMqzzxUK24JBFsMuZO1C
	 1h9h9U5LPeT/WBlz+2o97SPqYDxL+yM7jNLMtHFMT7ToR8Y5R7V4IgodsmDr0g691x
	 j35qXDlexMwLw==
Date: Mon, 8 Apr 2024 14:27:32 +0100
From: Simon Horman <horms@kernel.org>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, wojciech.drewek@intel.com,
	sumang@marvell.com, jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pmenzel@molgen.mpg.de,
	jiri@resnulli.us, michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com, aharivel@redhat.com, vchundur@redhat.com,
	cfontain@redhat.com
Subject: Re: [PATCH v8] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <20240408132732.GH26556@kernel.org>
References: <20240404075917.4347-1-ksundara@redhat.com>
 <20240404075917.4347-2-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404075917.4347-2-ksundara@redhat.com>

On Thu, Apr 04, 2024 at 01:29:17PM +0530, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs is currently unsupported via devlink.
> Add the function handlers to set and get the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>

Hi Karthik,

I think this series should be targeted at iwl-next [1]
but it does not seem to apply against the dev-queue branch of
that tree (or net-next).

Please consider rebasing and reposting with the target tree specified
in the subject. e.g.

   Subject: [PATCH iwl-next v9] ...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git

Otherwise the patch looks good to me.

