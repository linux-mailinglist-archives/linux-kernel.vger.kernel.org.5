Return-Path: <linux-kernel+bounces-43465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA0841440
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A201B24F23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E405151CE0;
	Mon, 29 Jan 2024 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="al9pC9Lu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3DD76048;
	Mon, 29 Jan 2024 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560014; cv=none; b=JcnSRhUr0BpZ4ocUN0V/+fIGTZA3bzmILQy1EBWu2v6Gs52OGV3AAN0Hv2medqVSJNM8SShx/SGIyvOYKIGMh4DeSWghm4q+or9/kosluWmefGyqKivg6GQ8ZXCcKvacvam9gDI7TY/n3o6FatPQJHRtjD/RyOr92zOYvIlykbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560014; c=relaxed/simple;
	bh=30G65tljw/tJBwMTFx2tDliaqMNSFJuAgSbb75kyu5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/aOt2Uh3MzSEGD1iFVH19VWD8S4lBwxQ/iwCXibPzjaQ40uw7Q4KFgvEN4wIuMoINX9lshxxIUWXpqTWJWA8DUhowZTFk/mx5yRh6Vpyq1FdFdQuZiAGH3+eLP7R2+ZiQvxudIBNfk+wHEWFKbior8S7n+oK3+WG6OeXyr/uu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=al9pC9Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B0C433F1;
	Mon, 29 Jan 2024 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560013;
	bh=30G65tljw/tJBwMTFx2tDliaqMNSFJuAgSbb75kyu5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=al9pC9Lu3KFW10x9B84NrzhDsftSFRDCJZ0f3O/jzI/eb9sjfyWFaMSOobqxSCUaH
	 UVu6DQ4qTzeXkGPklD+uAcJreG3DAwPLVdo1vZa4v7hZWKmoJmzDkH+HHHH/k+xYta
	 NGIF0zRhcWr+9W/tOu+bMwc6GFKLsnx9cNGAgmbY90ov4GcNJkE5eXxbvH8w/AkBDx
	 YSvi5C4ql1aCk+IaK2Tu47nLOjnos9InsBbzXrlzeaUUbrD7addpi2fmi3VkfheLvb
	 9Z2w4jf1AXfTQdW3emp13eROLa+d4GyOwWEW2j70g5yfWMUlvj8n6ZbKIoHQwd1JHK
	 qOw8pp+udcLcQ==
Date: Mon, 29 Jan 2024 12:26:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Samin Guo
 <samin.guo@starfivetech.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v4 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Message-ID: <20240129122651.4b3c7b8e@kernel.org>
In-Reply-To: <f113c4b6-a074-4566-b69b-f25c9590d23f@collabora.com>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
	<20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
	<0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
	<e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
	<56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
	<8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>
	<e99e72b3-e0f6-4a80-82c8-bd60c36d180a@lunn.ch>
	<f113c4b6-a074-4566-b69b-f25c9590d23f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 20:51:43 +0200 Cristian Ciocaltea wrote:
> > Well, b4 can do that:
> > 
> > https://b4.docs.kernel.org/en/latest/contributor/trailers.html
> > 
> > But i've no idea if the netdev tooling actual does.  
> 
> Jakub, please let me know how should we proceed further!
> 
> The problem is that we ended up with a RESEND to include a missing R-b
> tag from Rob, but afterwards we also got this new R-b from Krzysztof
> here.  If it's not possible for you to collect both tags, I could
> prepare a v5 to avoid having another RESEND.

First off, have another read of our rules:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
:)

IMHO forwarding the review tag to a newer version of the set yourself
(like I just did) is fine. None of the tooling I know checks if that
the person posting the tag matches the From:

