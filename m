Return-Path: <linux-kernel+bounces-99528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CDA87899C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21491F21FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948454BFD;
	Mon, 11 Mar 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy7t7w+Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5483CF6A;
	Mon, 11 Mar 2024 20:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189706; cv=none; b=rXbL/ro/tvfj84CMm09KZRiGOxPUb4BpXlaAF+/2n5cPwQOxfoJgKijSJs2QO/J3xyqoKeLtu2sz+9Pj0gmCASvJ8jqj1LxJqkpFGk+8YQr4weaNcqNEGCC8jSoEPR/44S3kit9a/9DuA1tau/DkrkP+Ca9v9znA2jZ4A+ETB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189706; c=relaxed/simple;
	bh=zCrAyipAu34X8H/QzFwggTciVlrm34ebhAgGLc4sySE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgl4wjqx9CYU2f+gT+r02FZSAeC5qvycSNyXXsjLFkiExf6spd9K+9M9/iYiHCF5zE05e6LB/lsgnZCXh/Xw469KgkA3HfuS32BcMMoyccyZ+704GSbetf7otyVv0dIUM3PcKJJjlFYl8zBQFYOEQbtfzGi/TaVRdFSsefR9Gag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy7t7w+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B796C433F1;
	Mon, 11 Mar 2024 20:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189706;
	bh=zCrAyipAu34X8H/QzFwggTciVlrm34ebhAgGLc4sySE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vy7t7w+Qcu/Nfn9x1re1G4djimbGTDqzBjtSLMjxQH8BHw089k+IxU0l7c5AuPUKf
	 O9nLgJw8tC8t/m6Q9Hd39Qaemsb3mz2M1cOUiK2i87yCSK6hFQDfGyvWRhOIUBM4FA
	 9CClBFeArVDmwTKE9lDes2z8YQrJjQ1d1lDwvDI5teoJ5GBQnXvGrMPUl5UYLbmfCC
	 Uqls39WKbokTSujVmDMDixz6K2Dy1iPETb3WvVuLqzB7OAWzaBgvMpgy6JndIwFWif
	 Wv0MuRdZPBBfBKEB8xlSp4CesRNyMmRx29QYlLijqiIfYDRsLOG6mn5Cn2IWPW2HzS
	 jbF4ua2qJj7ug==
Date: Mon, 11 Mar 2024 13:41:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: fix rx queue priority assignment
Message-ID: <20240311134144.7b1e1a34@kernel.org>
In-Reply-To: <20240303190339.52496-1-piotrwejman90@gmail.com>
References: <20240303190339.52496-1-piotrwejman90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Mar 2024 20:03:38 +0100 Piotr Wejman wrote:
> The driver should ensure that same priority is not mapped to multiple
> rx queues. Currently rx_queue_priority() function is adding
> priorities for a queue without clearing them from others.

Do you know what user-visible mis-behavior this may result in?

> From DesignWare Cores Ethernet Quality-of-Service
> Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> "[...]The software must ensure that the content of this field is
> mutually exclusive to the PSRQ fields for other queues, that is,
> the same priority is not mapped to multiple Rx queues[...]"
> 
> After this patch, rx_queue_priority() function will:
> - assign desired priorities to a queue
> - remove those priorities from all other queues

But also you seem to remove clearing all other prios from the queue:

-	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);

and 

-	value &= ~XGMAC_PSRQ(queue);

is that intentional? Commit message should explain why.

> The write sequence of CTRL2 and CTRL3 registers is done in the way to
> ensure this order.

Ensure which order? Looks like you're actually writing in the opposite
order than what I'd expect :S First the register you want to assign to,
and then the register you only clear from.

When you repost please include a Fixes tag.
-- 
pw-bot: cr

