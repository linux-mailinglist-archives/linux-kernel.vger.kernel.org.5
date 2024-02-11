Return-Path: <linux-kernel+bounces-60715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26188508D5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CEC1C21B4E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90C5A787;
	Sun, 11 Feb 2024 11:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="J6vZ5afd";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="YtPqEZjE"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E865A4CB;
	Sun, 11 Feb 2024 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650490; cv=pass; b=TCQAkBz2loOX21dKdI7FLI/LQjRqzeeu3OAtKJaIGLxpGVy0aUtx8cnBeIe32n4zyt3Rg2NVU48HagNIAoTxeDn9JvfvHyy5ceODaY6/VwcquuY+ZNvpZQDGNU7S2HY2XMnYcyObArBMeN4E/1xpXJG4qdoUC3iWysr7PvOGEjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650490; c=relaxed/simple;
	bh=6GEspL1NI/n7BUNEbTZV7J7Ca1ti6T3eGL6KpastI+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmFsQTwW2LKuOXr3Ddz6pqcjYwB/7lwkmV0nDu+6nnztn1olDkQ/kECslSbYHwlWf2oXfU58XNDA5C3YhKwbOfsvXXKH1Spm12HJPExiGl1OGdUklGHR657/IynVCeoqjGZ0e1wXp7Cs8NhOkko1AcAwyTPZmHp8sf7FDOh38QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=J6vZ5afd; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=YtPqEZjE; arc=pass smtp.client-ip=85.215.255.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1707649397; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eO/IoGfXJno/1sOUVSi/OV6NtBotF9pz56/zjtMQJMv7twuQRj9UwIqykSoLoepF+L
    PaqAHDEoh2WontcEGEe0m4QSzXQAoytP10MJ4W7UfSZhdkIhl1whXU+8RjX0TlKGiXCL
    eVueAL99iSLQG1m9gBwX07uU/2xlWYRzOH26aXR1Kee/RVH96hokoH7qAFhe988qyyZV
    HX9k4CxH3lRlIKHXYzsE6TeBlPbZDJhFTAsFxQb4ty/cEF7FE9e+QLGnAE5+XQuxakJS
    y8xsfCja126jUaqFq7hftU7N9C6TobVUlM8uTDhelGYu9wmIibBGmo/D/DUZP401370/
    SE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707649397;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9fYpYs2cE7Gjxr6/SXF6Klx/xF/lAbV9phvzIj3g7E0=;
    b=hmkDtzNlKZaQ6RkI1eOzezspmTWa69XVydvmfib+6l4tqMRDvltTDJvO3dCj5b6qjv
    vSACN/RNHsglg2IwqGBtKt6JQPJcXZafn550MSxpPcDmIhoh2l5FftavTomLcFsDSs7v
    k7kEkZFKuhgj4XSmleBDMIBbkfp/qi6wx61o75hNpiSFVjpWoh9WYvA8EXsep1cKBq1j
    yKiK0jTBHi1UQL8bpNiew1MkCkYQir73wwzWHVz7RLZavWY2fzeaNm9/xGjquOiH4AZY
    bf2Tk+ysETPUi7olJdrBXCFcepBSjkFbbdlnLiOzmBy3xMYRLOcwUgmTB2ToX/+el89d
    01wA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707649397;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9fYpYs2cE7Gjxr6/SXF6Klx/xF/lAbV9phvzIj3g7E0=;
    b=J6vZ5afd9d4s69yvyad15+P419Klsuf/FEISHad3en3zWPq4doB7b+C6ZRoSIQB6rG
    czOJEyTooL0cV/CRuRo3KLE0Mk0yCIS6Wb/58Ijf/oHLP4FfHAUDkfu9IK7XnliF6xh9
    GrqPwAt/V3+Cdfs+xrIqtG4qTAbRxYQE1CmYsmbCS6EEeWBWgv5MqUe+4tcD+956Huy5
    A5qQ4i+AGI5lYwUp9mJj4HQsVPMmaJHagvN7uVyG5PfUO30wkp5KEvmrcqTgM3ZenTZ7
    o2XI4lyve8Q9JP2npLW8vw2tEKGIvmiEYGLZvAM3bKr2cmJxNrnBOlQI9m4IG08W8mZA
    K/6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707649397;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9fYpYs2cE7Gjxr6/SXF6Klx/xF/lAbV9phvzIj3g7E0=;
    b=YtPqEZjEZ/YiVu0Jl8bT5up39lSIh4apJLDhHHYqALKhlXxFNgyOMYc20L/sWmbbsp
    UFAHooXNOaAacZ9vXYBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
    with ESMTPSA id ze34f101BB3GwyG
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 11 Feb 2024 12:03:16 +0100 (CET)
Date: Sun, 11 Feb 2024 12:03:15 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: rpmpd: Add MSM8974 power
 domains
Message-ID: <Zcipcz70vEPWLAFg@gerhold.net>
References: <20240210-msm8974-rpmpd-v2-0-595e2ff80ea1@z3ntu.xyz>
 <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210-msm8974-rpmpd-v2-1-595e2ff80ea1@z3ntu.xyz>
Content-Transfer-Encoding: 7bit

On Sat, Feb 10, 2024 at 05:38:56PM +0100, Luca Weiss wrote:
> Add the compatibles and indexes for the rpmpd in MSM8974, both with the
> standard PM8841+PM8941 PMICs but also devices found with PMA8084.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 2 ++
>  include/dt-bindings/power/qcom-rpmpd.h                  | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> index 2ff246cf8b81..929b7ef9c1bc 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
> @@ -24,6 +24,8 @@ properties:
>            - qcom,msm8917-rpmpd
>            - qcom,msm8939-rpmpd
>            - qcom,msm8953-rpmpd
> +          - qcom,msm8974-rpmpd
> +          - qcom,msm8974pro-pma8084-rpmpd
>            - qcom,msm8976-rpmpd
>            - qcom,msm8994-rpmpd
>            - qcom,msm8996-rpmpd

This is maybe more something for the DT reviewers to decide but I wonder
if it is a bit confusing/misleading to describe one particular PMIC with
a generic compatible, and the other with a more specific one. Perhaps it
would be clearer to include the PMIC name in both compatibles, i.e.
"qcom,msm8974-pm8941-rpmpd" instead of "qcom,msm8974-rpmpd".

The "qcom,msm8974-rpmpd" compatible could be maybe added as fallback.
While it wouldn't be used for matching in the (Linux) driver the DT
binding itself *is* "compatible" between the two PMICs because they both
have the same power domain indexes.

i.e.
	compatible = "qcom,msm8974-pm8941-rpmpd", "qcom,msm8974-rpmpd";
	compatible = "qcom,msm8974pro-pma8084-rpmpd", "qcom,msm8974-rpmpd";

Thanks,
Stephan

