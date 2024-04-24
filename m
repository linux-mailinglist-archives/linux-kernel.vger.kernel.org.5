Return-Path: <linux-kernel+bounces-156875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3898B09BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465681C23E47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF01422AC;
	Wed, 24 Apr 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="POS7GywA"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A0F2F52;
	Wed, 24 Apr 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961923; cv=none; b=Hvr0XASRiqdzISqQX7GcXG47Xe6Ye5AVIBX5tmuhQF7PnuWbCJxQVDiBq1hIh81aQUdaHSEC/g4z7p7VnRJNt4hIdUURi2J2gwTf+MhhzpjBewMBIdDdgcsHJYNqALJWPuvZyUbOqSXrvzSdskykVjzDdw493N3ZQHVsmrJSr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961923; c=relaxed/simple;
	bh=U0euOlY6tiB7c15NB3mxk++7fzTgXW2igHdpXo+Lays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGFSkmGYIqS8Wti/uYpceiddunqHbDxjgG9Fx9a+yiynxY6oYfDrLt4m26t6PRU2mfnlWUPvEkV28kIAhrR0nQiJwyb/83fXcSLyXd1+Y7h9PG+IPLoZJfnMbduJRsInvkyTiaOSc0WQahrOPhUA4O33nzLHweMA9DRcVmO80GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=POS7GywA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0NRQThXot6y/Efk0nWO5jKrrMvhMpA3ZVgH7fSZlQUo=; b=POS7GywASdyiIAJZqgJmFTKi3a
	ja/i/bUjaZniVkU3XCjHqBEHAPikV0oUPTerGzDtYx9TTMM6pWK7nBFlo7gYBNZjc4v3+FSQeA8NV
	Hiv5Pb44pkStFYthN8aeRwsE5IFKtOyf9s/UKPj82MpzH1k3TQVonQV/oIwYC9AwCTfE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzbmv-00DoQJ-04; Wed, 24 Apr 2024 14:31:49 +0200
Date: Wed, 24 Apr 2024 14:31:48 +0200
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
Message-ID: <98588a89-4970-4d75-be8a-ac410d77789f@lunn.ch>
References: <20240424091823.1814136-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424091823.1814136-1-danishanwar@ti.com>

On Wed, Apr 24, 2024 at 02:48:23PM +0530, MD Danish Anwar wrote:
> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
> driver, which can be enabled by ethtool commands:
> 
> - RX coalescing
>   ethtool -C eth1 rx-usecs 50
> 
> - TX coalescing can be enabled per TX queue
> 
>   - by default enables coalesing for TX0
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

Do you have some benchmark numbers?

Did you see this patch on the mailing list:

https://lore.kernel.org/all/20240415094804.8016-1-paul.barker.ct@bp.renesas.com/T/#md50cb07bbdd6daf985f3796508cf4b246b085268

This is basically a one line change, which brings big performance
gains. Did you try something as simple as that, rather than all your
hrtimer code?

	Andrew

