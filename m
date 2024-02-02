Return-Path: <linux-kernel+bounces-49067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02A846579
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88F41F267B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4D6FBB;
	Fri,  2 Feb 2024 01:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BfcRPwjK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C1C53B9;
	Fri,  2 Feb 2024 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837908; cv=none; b=rNS5iiUVf8AFtdG+uuuG+1vcVy6C+xKT48r5A1Haoqr7EHp9OvE1bH+QJNjHdiewAbq4Gr+KVkJ6n1xzMN01A2RkH2lW/O8URQFOr20D5ryqQ14zvitoNFMtd7Ntu5wJIPKXB3ub9JTz0cPeQlDVBrlNib0pTxMX9TyiIlkLmlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837908; c=relaxed/simple;
	bh=YcpLpVCdlye1BoPJKLYYkusS/fcIkeSV6M2HV65jNfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLOD90AIk7qyu+wDMsuIHp/cEkIn0CWj6fwThHdV8Hkpd9gwwDx08qVMuEH8fZ3C5SItX7QrcOZCTNBXXRP/0fu94FUtglY/UJ4HuuBdJTCtyF3Liw7Y8rk48rEQXT2/G8z2h9M+kzbov52wWeW2/VEitzqQzsEAjYPjzCLSbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BfcRPwjK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wV4rR0AKtPj1WIddqkyqKOAXUe6Ps5Ee+7NgRDAA0Yg=; b=BfcRPwjK3LbmSGRbFxgpQfDM41
	jC7xyB9dbGsDvwdeHchIuQGXduQbs3cYwJ9GgrdepNy0Z+d1O6989t5t90dJOxOV9Hk2O3sMWYDd0
	y6RzlqDkxjODnqGP0GyH3SHCzT6iXhfrZ+11uZ4jAc4xtn2wSfKMBUg6unvMINOCm+wo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rViVW-006jkd-BL; Fri, 02 Feb 2024 02:38:18 +0100
Date: Fri, 2 Feb 2024 02:38:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 8/9] net: phy: qcom: generalize some qca808x
 LED functions
Message-ID: <56fb487f-4358-4c1f-9c8c-c6d75991972d@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-9-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-9-ansuelsmth@gmail.com>

On Thu, Feb 01, 2024 at 04:17:34PM +0100, Christian Marangi wrote:
> Generalize some qca808x LED functions in preparation for qca807x LED
> support.
> 
> The LED implementation of qca808x and qca807x is the same but qca807x
> supports also Fiber port and have different hw control bits for Fiber
> port. To limit code duplication introduce micro functions that takes reg
> instead of LED index to tweak all the supported LED modes.

Please could you split this up. Do the move first, no changes. Then
add the macros and other refactoring. That will make this easier to
review.

	Andrew

