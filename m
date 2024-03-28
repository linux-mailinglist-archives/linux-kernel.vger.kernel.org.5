Return-Path: <linux-kernel+bounces-123171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA438903A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0F41F2508F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DB12FF73;
	Thu, 28 Mar 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgIbWE6t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348F12FF7E;
	Thu, 28 Mar 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640585; cv=none; b=V0oLBfyuLX3vOzw565s3Qr4vAnP7bQf4tcdrcyCxRzzLKwqrijWNyZiKLudoDKnUwwfplNJVOqPFN1CcZUTtjNsnF+wJCDuKJXl1SXk6t4nDLHSKz5hfCV7fhDq8qus/aJRMrp9RHEfaWnk6UsVJa30cqanYlrS1djiOAu79GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640585; c=relaxed/simple;
	bh=9kfih4GziNloY13pj2SzxAv8FlxUXsugtc/f9w4BBQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGFbwOVAbq1o4DfuDF/pv4uxUjosGjfuIcIJ2qmIdXhK5YB/bDqtee2Xcw958/GgKPKez0q7n1M1JzmBceQ7Pdacsz6gz2JD3JV9ym2aNUVCIq3nNST8qTS/5P2uYrYJOm9hgrCfIxBg3r4stwtfB1UkQ7K6VfIhorPD8rmv6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgIbWE6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D6C433F1;
	Thu, 28 Mar 2024 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640584;
	bh=9kfih4GziNloY13pj2SzxAv8FlxUXsugtc/f9w4BBQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgIbWE6tg6ywCDIYymzV4GG9CfkY1CuiIoxIzFYcTpxYCRJoIsL5Iy9Sw3gUjjOaa
	 2q1y04KWshUMud5cB+HjLMd0yQ85QgMD2yOnr5skY0uVS9XbbiXn2RaiCVsn7qs8Wy
	 GdlI4PHuUwzk+XOs1QDhNoQNswYTC030RMhrHxDV84jHIeRJgpY5ZhdNaXxCAFI6yP
	 T64wg1AgZ80l/fOHkNMljoNv1N2ArcyWZw7P3bfgjs2sl0HfWuaA7IjexpdNzn+R+A
	 BatXoSe+jg249pDnJMK0/o4CnkO7zjOrjgYY8WOq+BVu5cgzpCMd3NaZKJo8qTNUgZ
	 x8Z3y40JfAGQg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rpruM-000000007vv-1mQA;
	Thu, 28 Mar 2024 16:43:15 +0100
Date: Thu, 28 Mar 2024 16:43:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: qcom: add SA8540P gpucc
Message-ID: <ZgWQEuzOmbEd6JEQ@hovoldconsulting.com>
References: <20240326140108.21307-1-johan+linaro@kernel.org>
 <20240326140108.21307-2-johan+linaro@kernel.org>
 <a6fbbfd3-516b-4269-b4b2-611979b62fd7@kernel.org>
 <ZgL6fE8bFx7H41kr@hovoldconsulting.com>
 <7bed14be-2850-42b0-abb4-43aad25a19cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bed14be-2850-42b0-abb4-43aad25a19cb@linaro.org>

On Wed, Mar 27, 2024 at 09:54:09AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 17:40, Johan Hovold wrote:
> > On Tue, Mar 26, 2024 at 04:59:43PM +0100, Krzysztof Kozlowski wrote:
> >> On 26/03/2024 15:01, Johan Hovold wrote:
> >>> The SA8540P platform is closely related to SC8280XP but differs in that
> >>> it uses an external supply for the GX power domain.
> >>>
> >>> Add a new compatible string for the SA8540P GPU clock controller so that
> >>> the OS can determine which resources to look for.
> >>>
> >>> Fixes: e60b95d2b687 ("dt-bindings: clock: qcom: Allow VDD_GFX supply to GX")
> >>
> >> I don't get why adding new device support is a fix. Commit msg did not
> >> help me to understand it.
> > 
> > Yeah, perhaps I could have expanded on the problem a bit more here.
> > 
> > Hopefully it's clear if you look at the cover letter, but the commit
> > referred to above should have added a new compatible for SA8540P which
> > uses the new supply so that the OS can determine when it should try to
> > look it up and when it is required.
> > 
> > The Fixes tag can also be dropped, I admit this is not clear-cut.
> 
> Some sort of short explanation would be good in the commit msg, so Fixes
> can stay.

There is an explanation in the commit message, but I agree that it could
be expanded.

After talking to Bjorn about this yesterday, he convinced me that simply
treating the supply as optional is the right thing to do here.

Apparently it is possible to us an external supply also on sc8280xp.
There's more to the story, and I don't have access to the documentation,
but we'll go with the simpler:

	https://lore.kernel.org/lkml/20240325081957.10946-1-johan+linaro@kernel.org/

for now.

Johan

