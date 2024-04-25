Return-Path: <linux-kernel+bounces-158550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EE98B21ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9646B2716E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0C81494D3;
	Thu, 25 Apr 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qTgf5U0F"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119827715;
	Thu, 25 Apr 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049386; cv=none; b=Vhtob1+9dKZt0fZN+iNBSR1tZGPg9nC2a1dq12C90H1SdzSV8t739xh7KF0ZrSl0PIXqYkiMhjfgMb4F+QJRcUQItjYmSzopYoRWF7iqzC5W52syoK4Oy3YqAZYlKolhlw8LBnFahvBQwyafRgXIgSNrczIuWolBidyLHis+f9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049386; c=relaxed/simple;
	bh=Q0rC6Dg58DuHJs63AQMz3PHeklpFh0kC3hGfFEJpx5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLtN5nRoqRsiu+u01vmm22xxUX98rkaaXpp3dDtH6IQfdCY9uPPTZbpbCGP0G+vWdGMTuqsK7RR10utWFbfe6JukB8K5MVhky9F1qiYTEQwZgaHd0L9hh1L0+9IdLDx5jktbt6xArMixmweI7JdiUd1NX7PZzVoW4Uz0LNbKmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qTgf5U0F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qG/+pHxKsF0EjW0aqfIbxlagHCNmLhwnFQVaN8EkrzI=; b=qTgf5U0FU8QWZno94l4Qit5vhd
	2gOVOZHD/qrfAxf9yqFl/Gui9Xh8UKSAv+qlpXToy+NUlp8TEdhg11ZE4fr/scCGtsLssCnNF9WGm
	BHytA9YXTYwqGGn7WL5Y7QimDOeh5bPA8EA1V53qxsh83fWMsARGbgKwoe83TAYeYY8w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzyXa-00DywX-3U; Thu, 25 Apr 2024 14:49:30 +0200
Date: Thu, 25 Apr 2024 14:49:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX
 Coalescing based on hrtimers
Message-ID: <2a4bea87-04bf-4373-8220-69650b435710@lunn.ch>
References: <20240424091823.1814136-1-danishanwar@ti.com>
 <98588a89-4970-4d75-be8a-ac410d77789f@lunn.ch>
 <1c5809f2-b69d-48d1-8c27-285f164ebeb8@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5809f2-b69d-48d1-8c27-285f164ebeb8@ti.com>

> I did some benchmarking today with,
> 	1. Default driver (without any IRQ coalescing enabled)
> 	2. IRQ Coalescing (With this patch)
> 	3. Default IRQ Coalescing (Suggested by you in the above patch)
> 
> I have pasted the full logs at [1].
> 
> Below are the final numbers,
> 
> ==============================================================
> Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
> ==============================================================
> Default Driver           943 Mbps    31%      517 Mbps  38%   |
> IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
> Default IRQ Coalescing   942 Mbps    32%      521 Mbps  25%   |
> ==============================================================
> 
> I see that the performance number is more or less same for all three
> methods only the CPU load seems to be varying. The IRQ coalescing patch
> (using hrtimer) seems to improve the cpu load by 3-4% in TX and 13% in
> RX. Whereas the default method that you have suggested doesn't give any
> improvemnet in tx however cpu load improves in RX with the same amount
> as method 2.
> 
> Please let me know if this patch is OK to you based on the benchmarking?

It is good to include benchmark results in patches which claim to
improve performance. Please add the default and the patch version
results to the commit message.

The numbers show your more complex version does bring benefits, so it
is O.K. to use it. I just wounder how many other drivers would benefit
from a one line change.

	Andrew

