Return-Path: <linux-kernel+bounces-164117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3028B7938
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8361F230E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7EE1BED8F;
	Tue, 30 Apr 2024 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fisz1Kdp"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC9B17A93D;
	Tue, 30 Apr 2024 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486459; cv=none; b=dJkGKqm31TzwVljHUmDZeDrpbzTAAr1Ovy1UbffdSPn485SvEyy7jnnfmmbBxncAChHMwk+1xpwMKNHDimuYXhk+FL1/bNwoZvbh5jlfS8wXJ0jmbTQm8Ykl4a02ar6cm4qdv8GYbbmErBEJu0TyuN/dtVF1T8MvdrbaNBpYRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486459; c=relaxed/simple;
	bh=ENdoDuLwfsRKNzcTx8bsgX96EEjDRozpgGFsMolVNPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfjCBTrx6j6Bd2YVM7hUgyYfSogsg3ayxX+OJojkLcS5D+bChc//AiKTXohj18/Rd5Q+DFS03WQ2Fb3xXsIz7UbWNpnWCaWXiuVihvJn0jkHRrVfpXVaoT7QXm6K4RE4Y9vZQ4bQo4bmM6Lasiyalhm7nzu5CF2UOz2QtdVsFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fisz1Kdp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yJ1XxJMQ5M4P8jDVlymHQ15RBEASqivIdtexJWW2a98=; b=fisz1KdpdOh41mp9RFPSz1o7tW
	7gW0hNiQhLW0rJoOyJ0O2qTek0DJKhbGZrwXJp15ugMa2otOdd+XbTgStjNXNW4P+dUvcZv3upBVn
	+GwP7FxkNS/9ytEzWezlQ1zSqMa12f1ggO0PWECAVjTsMZ5U8fkqxUejwVAnqvV+utss=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1oF9-00ELdZ-9N; Tue, 30 Apr 2024 16:14:03 +0200
Date: Tue, 30 Apr 2024 16:14:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch,
	ramon.nordin.rodriguez@ferroamp.se
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <a7c43359-5d5a-47a9-a9b5-819e164457d4@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <dd9da345-e056-4f34-8e39-6901bf9c1636@microchip.com>
 <Zi94jdVg8a5MaB3E@builder>
 <eaa4eb3e-d82a-4b52-a375-1fc84be7225a@lunn.ch>
 <a3719443-153b-49d5-b039-fa0a7928de28@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3719443-153b-49d5-b039-fa0a7928de28@microchip.com>

> In the spec, external RESET pin is mentioned as "if implemented", in my 
> understanding it is MAC-PHY vendors choice of implementing it where 
> Microchip is implemented it. Using this reset, can be a application 
> requirement/decision. It can be controlled from an external application 
> where it is not needed SPI to operate.

Since it is optional, controlling the reset pin is clearly not
something for the TC6 core.

However, i doubt having an external application controlling the reset
is a good idea. You don't want to reset during operation. So to me,
this reset should be controlled by the driver. I tend to agree, that
actually performing a reset is optional, but i would expect the driver
to ensure the device is taken out of reset during probe, if the power
on default of the board is to hold it in reset.

   Andrew

