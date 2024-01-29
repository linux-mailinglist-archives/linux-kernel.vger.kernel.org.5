Return-Path: <linux-kernel+bounces-43153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA18840C80
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9EDB2237D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F415703C;
	Mon, 29 Jan 2024 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wboEuH0q"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19847156967;
	Mon, 29 Jan 2024 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547288; cv=none; b=B8h8KisXezPHHDu3eAdIdy2Yl6BLzVgAdYaISJRJTzxpR1xpuTdO50xH9+3vWdIOEPqN4VComqq///0EZjFN2xD/JK6xJkRQKkW2FfdxGDak7q0AzK16fHR/vaV3HmXpnspNwavVSuEoQfOvjEHXsBaMLDu1xc7zeBrQZyfUfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547288; c=relaxed/simple;
	bh=9g45N6/MADpyEGs1h43irAmI5VQUJUrNHZl1OlCSX+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNIX+uy4hn2tdaQ2HBHKhjcCO8rXT5LKDt8FD3Ot5N0Yc2xWyGrG77yg1o9CNsJMx6lwSy4i3dskxWb9tcHPdJ/Ldxa6PBmO9lLWENGzVxPAOKtuLUjbDVP0GMbnnhh7ryxHPxvS6EsmVxukakBNK7o3uiKCbFR1o4KXBrpJX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wboEuH0q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jVE+ke8oHRNLw6ovCoac3QPP9D2Or5p/ykbfeULK/JM=; b=wboEuH0qdKTwrGwunnLYH4BPPy
	aFRzEaeDha1B60zPjw3n1PLzrTh2zsicbVTNQer1YeBcm4spDdqd/LiAAQSEVNo9LNPaOoT/0r6TO
	LlvSt652JHIJ0AxGsNz3av1VyyPwzDdz46TbU9CwPNkgnMUHuutYRb06nLdAQBp6W8Cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rUUto-006P1D-9x; Mon, 29 Jan 2024 17:54:20 +0100
Date: Mon, 29 Jan 2024 17:54:20 +0100
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
Message-ID: <e99e72b3-e0f6-4a80-82c8-bd60c36d180a@lunn.ch>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
 <20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
 <0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
 <e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
 <56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
 <8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>

On Mon, Jan 29, 2024 at 06:38:27PM +0200, Cristian Ciocaltea wrote:
> On 1/29/24 15:34, Andrew Lunn wrote:
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> Thank you for the review!
> >>
> >> Could you please apply it to the RESEND version [1] instead, as this one 
> >> had an issue collecting the latest tags, as indicated in [2].
> >>
> >> Regards,
> >> Cristian
> > 
> > Hi Cristian
> > 
> > IT is your job as developers to collect together such reviewed-by:
> > tags add apply them to the latest version. So long as there are no
> > major changes, they are still consider applicable.
> 
> Hi Andrew,
> 
> Jakub requested a rebase, but I missed a tag and that's why I submitted
> the RESEND.  Now we got this new tag which is not on the RESEND
> submission, that's why I asked Krzysztof if he could add his R-b on that
> one.  Unless the maintainers' tooling is able to fetch tags from both
> submissions?!

Well, b4 can do that:

https://b4.docs.kernel.org/en/latest/contributor/trailers.html

But i've no idea if the netdev tooling actual does.

    Andrew

