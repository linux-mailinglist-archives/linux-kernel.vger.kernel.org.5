Return-Path: <linux-kernel+bounces-42810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3235684070D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94981B2462A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FF6519B;
	Mon, 29 Jan 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ymukBF1m"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7578A64CF8;
	Mon, 29 Jan 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535277; cv=none; b=VnZDzGZC3rW1bIdTmeVxcIZhuhsW8h+TZNB+YG0FX1ag8/5xCYlD3dEzsrU4asfs1VD5/S1qUpn5JZEh2gV/+9WFeovK/a5FpvvCpYi+beiJMJnAky2NJRhPXkQ/+w9p05DMExoc9CwklwgjD8USb8QGbxJ0zF2OQ/r/++EIv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535277; c=relaxed/simple;
	bh=/v6jv4eq+mfToHNxJ6RHn6Z5EZCjZlX7IDopru1EQvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZx/LVUhZlTrc60lxiBFEkaDnRgU+gLckNc5TtraDLOEya04CITZdv8wMSR6Ksdoz6TZl5lnAhZIrOHFiin5vkb0ovxkZ3iSrYAjMSK1UYl1gIzyvxskLi6N8wZrkDlBNJeWMOwhbcX/iYNih0ZtiyewVlg3baeu6WPn80kr214=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ymukBF1m; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Sw+Uc8eIUTOSmcpYyqc0Pr30gRLyGicqOuK7mBwSw0Y=; b=ymukBF1mJOtwGiyHpcUelZv6sQ
	63xYTF/lfTF2ATMCsUEPgXODnKa2XIWjBFZp9W1OF7lNIViDmsczfg9EbE+TbJylYFdmCP2i9GXWr
	onVSVf6tp4Kv6vkPtgi+ap0JxlJwIuZSZdhIAXpZ//2ikqatf1QUXT0Gf37wHTE0QeRc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rURmB-006NkS-Kr; Mon, 29 Jan 2024 14:34:15 +0100
Date: Mon, 29 Jan 2024 14:34:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Message-ID: <56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
 <20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
 <0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
 <e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>

> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thank you for the review!
> 
> Could you please apply it to the RESEND version [1] instead, as this one 
> had an issue collecting the latest tags, as indicated in [2].
> 
> Regards,
> Cristian

Hi Cristian

IT is your job as developers to collect together such reviewed-by:
tags add apply them to the latest version. So long as there are no
major changes, they are still consider applicable.

	 Andrew

