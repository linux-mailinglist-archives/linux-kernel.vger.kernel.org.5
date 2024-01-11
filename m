Return-Path: <linux-kernel+bounces-23889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE9D82B340
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F0F28AC08
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E75450279;
	Thu, 11 Jan 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1EcrgGZ5"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACA487BF;
	Thu, 11 Jan 2024 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4nAUSt6yFq4qLCYsE347w2X/tEMdQNOumHIBIo0CZe4=; b=1EcrgGZ51fFPyiy7XX0/qgvruN
	4Dray1N7UtvxeG7hOiLQ2ziZe2a57eeK7ZGzKSw/c4nKyulEyOQijozOkrF80Cl/aV2bZfDvZzDOb
	P8g4fYXBw4Ek7xb4k8ra6FxGTXlalknbhgvggXbYsGPA07JNMie6H8uysQGYlC08xaaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNyBb-0050yR-9I; Thu, 11 Jan 2024 17:45:43 +0100
Date: Thu, 11 Jan 2024 17:45:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: phy: dp83826: add support for voltage tuning of
 logical levels
Message-ID: <0323cb84-14fe-422b-9423-3b1599f8452b@lunn.ch>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <20240111161927.3689084-3-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111161927.3689084-3-catalin.popescu@leica-geosystems.com>

> +u8 dp83826_cfg_dac_minus_raw[DP83826_CFG_DAC_RAW_VALUES_MAX] = {0x38, 0x37, 0x36, 0x35, 0x34, 0x33,
> +								0x32, 0x31, 0x30, 0x2f, 0x2e, 0x2d,
> +								0x2c, 0x2b, 0x2a, 0x29, 0x28};
> +u8 dp83826_cfg_dac_plus_raw[DP83826_CFG_DAC_RAW_VALUES_MAX] = {0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
> +							       0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13,
> +							       0x14, 0x15, 0x16, 0x17, 0x18};

Both of these should be static const.

However, they appear pointless. Plus is just a shift. minus is some
simple arithmetic and a shift.

       Andrew

