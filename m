Return-Path: <linux-kernel+bounces-164654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48D8B80C4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA4E1C235A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E76199E9E;
	Tue, 30 Apr 2024 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu0o802u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5112B73;
	Tue, 30 Apr 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506584; cv=none; b=LcwHWbDSx6LNGGwpsFStj0sMej4tJH4hMz5fdTADTp2CCIFYsU+3lpWs1pQFzJVAieAqpPtGIsNSSu7OxU+XoxcgBPiwEKMdbjWxp7ELoQ1PpjLj7XyQJEgrIESpw134K8peii7Rz2/pslEAkOE68cj4BK/Pacq53+Q9W8aU14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506584; c=relaxed/simple;
	bh=L44UUlMJiMRqZ33YFvdDMIt0qg//D0t3qFogmLwOHbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEBl1E2OLSAVDzBEqPtRJu1VzyT9+wx83Wh5F9KvRZIhgviWUxSnWUeZ0iJDKvaOqA+K8Yn3Sk7UWM/f3JCJ3I27kvo+ulY7sTVo3Xf6OZYStoWJeIxUOC2WqclALkkWoTQC4pH9xhKbsKlvqnBF45ps4J9A/FmcuLBn7vnPHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu0o802u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6810CC2BBFC;
	Tue, 30 Apr 2024 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714506584;
	bh=L44UUlMJiMRqZ33YFvdDMIt0qg//D0t3qFogmLwOHbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lu0o802uikMvRSH2hVH/ntKAqjFEhQuKLi1pEvnAjtUk6qCI0wuLmfnLNsySFVH9r
	 VtB1Gv3hjuFMKSfFYNM+xpcWj50TZDx2yntBcJC8ll4BfP1M95bZN7+DagyNX1dG4b
	 Fa/jCNaS+C9EyCa5mhI7PyXYV8j6ajxQEhourAW3rkvlkzpyr8kwtoqeIg6YgTsVOd
	 /BxpzCpawAPpQmIhnGqsJahpsq1/8LLTYMNaud7rV7t6AAqQ7pjsXHlNZUQBB6AXh5
	 nGJka9NLm0yhgp4lmwtNR7/hJ07hEOOx+3+6AjSnQWGTL139ib/LUyNwnprn8aZPj9
	 6RDkUflamtg/Q==
Date: Tue, 30 Apr 2024 20:49:38 +0100
From: Simon Horman <horms@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next v3] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <20240430194938.GD2575892@kernel.org>
References: <20240430120634.1558998-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430120634.1558998-1-danishanwar@ti.com>

On Tue, Apr 30, 2024 at 05:36:34PM +0530, MD Danish Anwar wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalescing for TX0
>   ethtool -C eth1 tx-usecs 50
>   - configure TX0
>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>   - configure TX1
>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>   - configure TX0 and TX1
>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
> tx-usecs 100
> 
> Minimum value for both rx-usecs and tx-usecs is 20us.
> 
> Compared to gro_flush_timeout and napi_defer_hard_irqs this patch allows
> to enable IRQ coalescing for RX path separately.
> 
> Benchmarking numbers:
>  ===============================================================
> | Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
> | ==============================================================
> | Default Driver           943 Mbps    31%      517 Mbps  38%   |
> | IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
>  ===============================================================
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> Changes from v2 [2] to v3:
> *) Collected RB tag from Andrew Lunn <andrew@lunn.ch>
> *) Fixed warning caused by {} missing for outer if conditions in
>    emac_napi_tx_poll() and emac_napi_rx_poll() APIs.
> *) Fixed spelling mistake.

Thanks for the updates.
This one looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> 
> Changes from v1 [1] to v2:
> *) Added Benchmarking numbers in the commit message as suggested by
>    Andrew Lunn <andrew@lunn.ch>. Full logs [3]
> *) Addressed comments given by Simon Horman <horms@kernel.org> in v1.
> 
> [1] https://lore.kernel.org/all/20240424091823.1814136-1-danishanwar@ti.com/
> [2] https://lore.kernel.org/all/20240429071501.547680-1-danishanwar@ti.com/
> [3] https://gist.githubusercontent.com/danish-ti/47855631be9f3635cee994693662a988/raw/94b4eb86b42fe243ab03186a88a314e0cb272fd0/gistfile1.txt

..

