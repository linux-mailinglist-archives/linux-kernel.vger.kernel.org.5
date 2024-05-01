Return-Path: <linux-kernel+bounces-165462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590EE8B8CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5711F261CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2112FF70;
	Wed,  1 May 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehRJ8Np1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE7A12F58F;
	Wed,  1 May 2024 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576744; cv=none; b=C3tVLq71KWSkZKqfCV1lpp8DJFUGGBxtXQqgMt0QnNrSbHq/y+fHNkbGjnPwmc6NA+uGIkbYclTW+wTPkckKIM8cLZmS/+sXEjaF9xN4Pg/oFldonUAuOLaPVR8RXa6l6NZUj8stFu+1inSzhSJAYpNurayDezc22guol8V72nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576744; c=relaxed/simple;
	bh=ODOt5F2jmlQNOAtHuc9ZH0qnQBxpoOZ+nGaBsWattgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjmOcvgGrkpiaZiEetYq3E7QES0a5o41ke0RVpTlgTOI+WceLNfK3xk18yGK6bT2zJTWY3hlxSA5hXenXvekkKv7ZjZkkgE4rmbN/DbanyPsW64RkTl+cmJonLmgsGrDRohzPTtIzTLTgLO5zpRL3uOjrKNRnbOnKzdbQOuVDyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehRJ8Np1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B24C072AA;
	Wed,  1 May 2024 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714576743;
	bh=ODOt5F2jmlQNOAtHuc9ZH0qnQBxpoOZ+nGaBsWattgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehRJ8Np1mBScJdT5V1GmRfk0V/zG9p7ZMk4iaxIOrH7Kt5EXAlCHIlOoURGmNkWGJ
	 ZNHOy5iJSy0z+wmupcHRtCOU9da+as4ZsqwYNvHebxQStZ0w4SL3uYs2hM99Yjd1B7
	 hrFb9gx+dElj/OZ7PGpBPna6dlePvokisra5LC/er99gZ6PENVUdYTVLmfZ6Qysvha
	 s8lc0iPjzGkcS7Q7dM8XKEewDTMzhjD/GUrw2P3P1OTL1VMF8u2QfJWq7PATfwV4C2
	 jNLctVNY8f/Az+FbVK0rKADZC1tX/D2S5awFr05wrFoJAUsXHdWTvyirVmhUHndeNA
	 725TnEOgKTtcw==
Date: Wed, 1 May 2024 16:17:26 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@ti.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20240501151726.GU2575892@kernel.org>
References: <20240429103022.808161-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429103022.808161-1-danishanwar@ti.com>

On Mon, Apr 29, 2024 at 04:00:22PM +0530, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> ICSSG dual-emac f/w supports Enhanced Scheduled Traffic (EST – defined
> in P802.1Qbv/D2.2 that later got included in IEEE 802.1Q-2018)
> configuration. EST allows express queue traffic to be scheduled
> (placed) on the wire at specific repeatable time intervals. In
> Linux kernel, EST configuration is done through tc command and
> the taprio scheduler in the net core implements a software only
> scheduler (SCH_TAPRIO). If the NIC is capable of EST configuration,
> user indicate "flag 2" in the command which is then parsed by
> taprio scheduler in net core and indicate that the command is to
> be offloaded to h/w. taprio then offloads the command to the
> driver by calling ndo_setup_tc() ndo ops. This patch implements
> ndo_setup_tc() to offload EST configuration to ICSSG.
> 
> Also move icss_iep structure and it's dependencies to icss_iep.h in
> order to access iep->def_inc from driver files.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Simon Horman <horms@kernel.org>


