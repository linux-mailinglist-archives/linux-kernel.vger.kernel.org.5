Return-Path: <linux-kernel+bounces-34709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F5838670
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD2028A445
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A2210D;
	Tue, 23 Jan 2024 04:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRLX+7K4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7831FB2;
	Tue, 23 Jan 2024 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705985449; cv=none; b=l7r8jA6eXN0/Bb9hKwJh9IM3eFK8HK5RHsS6oTqoKW7k+BAorWfaj4eFahzG1oFoC4+t8BfgB3pme566rmnqnRKCpGbWAdlCOzr7ANQSHOSbDUNeYhsDAyPWBfNwMB9vHGYmclFeQrB5aXxAeiPzicbErwuLcz/YCtfr6bkWnq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705985449; c=relaxed/simple;
	bh=IdSvEOKbJIYd++hbA82AHUZUcqgNsBgNh82BmM0dfCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA79FYTr62sV3ZOV0T1gHdCr/rFkrgmPNoYVNpdelcV3Ff7uW59R1wjSahGLtfYviECOC1Ozvz7H5unn4pX5pVHySbs3v1BRc+f4MAi4Mdg9hxBekPUZ+JnG8JrK5umIAsFzZfyTGAOTDQ0Y0ZD2VOOKwzWAnjkR7o9kWFBV6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRLX+7K4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060A1C433F1;
	Tue, 23 Jan 2024 04:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705985449;
	bh=IdSvEOKbJIYd++hbA82AHUZUcqgNsBgNh82BmM0dfCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRLX+7K4zEfU6/5y/VdkTajG7rUbsaKiVVo08APsiJVIn/P3i7xLnSXPbK4+R12yI
	 4olHYqoiSxCHitkm9qACSw9qpFOMQA6AlxVJqJ7lEhWTdZBBLI+QFhN/VubICdYk0b
	 uK+zIlTJBthFfFXXXK+/tAN7XF78HsLRnYC3iM5OrovBqe0JyOZns2nmIazk/no9p+
	 jP8HiFa/ohDcYXK2KRdqLolhZ7t0ZEmmqjaduTrcHEEq+APN0ZdoYsPDrYifSMgDmX
	 fZqmUCrdFtlh5hiNwNHBirmSdPvjXLgx18srvdMaP/qfYtSO/rvpxQanC8T3NzEG+L
	 y5ml+eABrkTNw==
Date: Mon, 22 Jan 2024 20:50:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
 <sdf@google.com>, <kory.maincent@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
 <przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
 <richardcochran@gmail.com>, <shayagr@amazon.com>,
 <paul.greenwalt@intel.com>, <jiri@resnulli.us>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mlxsw@nvidia.com>, <petrm@nvidia.com>, <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 3/9] ethtool: Add an interface for flashing
 transceiver modules' firmware
Message-ID: <20240122205046.5bb0ffe7@kernel.org>
In-Reply-To: <20240122084530.32451-4-danieller@nvidia.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-4-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 10:45:24 +0200 Danielle Ratson wrote:
> +The firmware update process can take several minutes to complete. Therefore,
> +during the update process notifications are emitted from the kernel to user
> +space updating it about the status and progress.

We should state more explicitly that the op just starts the process,
and does not block. Looks like cable test already uses _ACT as a
suffix, is it based on some standard? Doesn't seem all that intuitive
to me (or at least less intuitive than calling it _START...)

