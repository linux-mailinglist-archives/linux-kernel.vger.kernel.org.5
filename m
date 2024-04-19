Return-Path: <linux-kernel+bounces-151700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7848AB246
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808A31F2250B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373C1304B5;
	Fri, 19 Apr 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IdnBr154"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D4D12FB34;
	Fri, 19 Apr 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541638; cv=none; b=lPrTpvtKOG4Nk+7Lre8OoWs+fc2uf9fqyNP06iYuLxhZ+esTuKl/nyvlf4FY/e17eIl1/OL6ca302VId6Iwu6YrGz9oKtqm3RZ2lKRj8inRI9eBphSWPhL05xVDWrp3jWo2rJ4SMLadnQPQNxSHpKk3a4SZIcfPwqcQE4RPW3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541638; c=relaxed/simple;
	bh=EL9kCsTV22lvYw6+slnwCr5qeD8Oo1czDJiqY4Q9Kwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiipVfu77P9T0bRDUP+pr6qK1tKJDOJaDfu0x9hcaTZkAIKW8iHE3FLTKpY5KbAbVCCl4YKbOH7fT2otDEqHRNG1Wh9pW3UIUwcDd9GmfHc93go57cEyME61e7/BAjsZ9P1vf5xBNpp5GYLVTW8HMpiEj54uoF7IbspcJphQGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IdnBr154; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JLXEF/5VB2hcB1dYfUi8oj/pSt/FLjk9X5NuzMP6VaU=; b=IdnBr15472jY5I52M21qLM7ixL
	43CCwNezqBDlC3cUaCOsoyfDJO7Bi19fT7afae4F14aeBNn5R/bikFzt3U7MW9BtYCPcXUISx13pk
	M/V2QS7uzu6ltce8i7LCBVEHBBKUb0RZxyWI7JDcNvxSL5YfJ5Cc5c29ATNCvW6e8ll8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rxqS8-00DSp2-Iz; Fri, 19 Apr 2024 17:47:04 +0200
Date: Fri, 19 Apr 2024 17:47:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Tachici <alexandru.tachici@analog.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jon Nettleton <jon@solid-run.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: adin: add support for setting
 led-, link-status-pin polarity
Message-ID: <65411c68-c76a-499d-88c7-e80ca59a3027@lunn.ch>
References: <20240419-adin-pin-polarity-v1-0-eaae8708db8d@solid-run.com>
 <20240419-adin-pin-polarity-v1-2-eaae8708db8d@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419-adin-pin-polarity-v1-2-eaae8708db8d@solid-run.com>

On Fri, Apr 19, 2024 at 05:35:18PM +0200, Josua Mayer wrote:
> ADIN1300 supports software control over pin polarity for both LED_0 and
> LINK_ST pins.
> 
> Configure the polarity during probe based on device-tree properties.
> 
> Led polarity is only set if specified in device-tree, otherwise the phy
> can choose either active-low or active-high based on external line
> voltage. Link-status polarity is set to active-high as default if not
> specified, which is always the reset-default.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Hi Josua

Please take a look at:

commit 447b80a9330ef2d9a94fc5a9bf35b6eac061f38b
Author: Alexander Stein <alexander.stein@ew.tq-group.com>
Date:   Wed Jan 31 08:50:48 2024 +0100

    net: phy: dp83867: Add support for active-low LEDs
    
    Add the led_polarity_set callback for setting LED polarity.
    
    Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
    Reviewed-by: Andrew Lunn <andrew@lunn.ch>
    Signed-off-by: David S. Miller <davem@davemloft.net>


    Andrew

---
pw-bot: cr

