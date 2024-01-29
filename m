Return-Path: <linux-kernel+bounces-43500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844F8414D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9901C23C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3D159569;
	Mon, 29 Jan 2024 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YblNVKav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D85158D64;
	Mon, 29 Jan 2024 21:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562271; cv=none; b=Xx2NQuB3TmvY4Q54xBR9nsWEBOIWDIabkFHwcW+Isv9SZrXm20FmDtS6ZniwYgo/v/GgMoyL2TU1T3VPReKmJXZvEgXAk0EfuddQ3pEtwoocSMQrHNzUkEMsFDATwHL45dc4DTBjMd7OIl8z8GZeWnT7B9KEOB2XjnnBwzauAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562271; c=relaxed/simple;
	bh=XDN/zIhlQxTNPGPKvJfrKfrDPmIin/uSBcSP0Tsu0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwuyGlZ7hW70sil5xWp9Tqa6sxprEqGS8kI8p0RRk2qlwk8LTCwRXGLQxzqnNS9tY7FrAhKr3n2F5CApbA0FrxwH7uI/7H8l5WxNtylHvuwKRgfFHUpPF2rYmWZt2ZVBMVUk6qBVl3A6gu0pJ08zy3ItZkXyEYF9FIYLTet+Kto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YblNVKav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A83FC43399;
	Mon, 29 Jan 2024 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706562271;
	bh=XDN/zIhlQxTNPGPKvJfrKfrDPmIin/uSBcSP0Tsu0yY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YblNVKavSXi8rgGT1xsktmVVJKTR+Z6woc4IBj6FaYb8zhPGwCSHXipE1+a2dZO91
	 RNBou8glk8TSuv/Z+FHplscPy4MHwIgb6O8nGQGGdOOXbQQig362CBEriQMatrrHbK
	 /662rwz80lYbn99z6PM/lV2/W0InWNzZ8Zvu7a/5SWdRt4Q8g4Wk21lHFEx2rFuDdJ
	 ojNmXpBBBmtjAS74X4/PJlU14Ybn/eR84VLpXliR0gCTXiRIEsYY3F6+ddKkymn8PY
	 efTxrtQkXL+wFM9iTnqJ3NzyiRl1zP8c1W76cBeQvPDxVVUIf61rGUpCdm/ZNHAXQR
	 LMfccwKmRHKbw==
Date: Mon, 29 Jan 2024 13:04:29 -0800
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
Message-ID: <20240129130429.34094446@kernel.org>
In-Reply-To: <1fa5aeee-a205-438a-a0fa-54643ffa41d0@collabora.com>
References: <20240126191319.1209821-1-cristian.ciocaltea@collabora.com>
	<20240126191319.1209821-2-cristian.ciocaltea@collabora.com>
	<0a6f6dcb-18b0-48d5-8955-76bce0e1295d@linaro.org>
	<e29ae12b-5823-4fba-8029-e8e490462138@collabora.com>
	<56f3bd3c-c099-405b-837b-16d8aeb4cc4b@lunn.ch>
	<8c4cfc54-bd23-4d56-a4ae-9f3dd5cedb59@collabora.com>
	<e99e72b3-e0f6-4a80-82c8-bd60c36d180a@lunn.ch>
	<f113c4b6-a074-4566-b69b-f25c9590d23f@collabora.com>
	<20240129122651.4b3c7b8e@kernel.org>
	<1fa5aeee-a205-438a-a0fa-54643ffa41d0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 22:57:11 +0200 Cristian Ciocaltea wrote:
> > First off, have another read of our rules:
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
> > :)  
> 
> Oh, net/net-next suffix is required, will make sure to add it next time!
> 
> The 24h period restriction is still applicable for a RESEND that is
> meant to quickly fix a previous submission issue?

Yes, reposting too quickly often leads to reviewers looking at 
the wrong version.

> > IMHO forwarding the review tag to a newer version of the set yourself
> > (like I just did) is fine. None of the tooling I know checks if that
> > the person posting the tag matches the From:  
> 
> Hmm, I didn't actually test, but according to the link Andrew posted
> above, for b4 it might be necessary to make use of the
> `--sloppy-trailers` flag:
> 
> "Accept trailers where the email address of the sender differs from the
> email address found in the trailer itself."

Hah, interesting. Using a corporate address for the tag but ML-friendly
account for sending the email is quite common. I'm surprised. In any
case, our tools don't do this. I think it's kinda pointless unless the
tool can also prove provenance of the tags already in the patch...

