Return-Path: <linux-kernel+bounces-78419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C3861337
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E901F24097
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91807F7D9;
	Fri, 23 Feb 2024 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPRzz/XL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253722EF5;
	Fri, 23 Feb 2024 13:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696098; cv=none; b=b+UWBITo2IdXQ/REhnXiosQbC5FAlJXOH40T+onQUKsPGdSBRqSll844EcProrh+O7+RACD+Ypce6JBTK70ipvGhz2MmB5nnbt1ous25GBGf2vdsKkv6hLnPW9u5ineL8vKuzuyIZkcbAnOanjkk2NxiMy99X9wsIgivrjkqkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696098; c=relaxed/simple;
	bh=Dkmut1aY9L+BcdJ4rpNL1JAvxJpVtlBFbV/vIEyFtrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUAbqCzvzTR5pfxYzUCxq5HTcm1e4uMrPQ/xLOVT0UKz3fRZ4Q86CvxeYoxJ5QgPehytMQrdpFvYKb8mvADWeEy99fdH/ny68NyARUJyAqIhhQFRsWZHPzzUW/DiPnoq/hUf8ykeafcEvCCcnNkf1kpIiABl32QHWD60CeK0mkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPRzz/XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CD5C433C7;
	Fri, 23 Feb 2024 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696097;
	bh=Dkmut1aY9L+BcdJ4rpNL1JAvxJpVtlBFbV/vIEyFtrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPRzz/XLograqBje6REd30q2onNAyizTFJC/OFxDqrznJjIHogcNK6qYWBczm68O3
	 1T1xkAPJHcdMllBEDIhTSaZSj1PzylEmwsOyct5QoTJjdvnuG4LW+dcRyZn6cPUOOY
	 G+ONL/GqqCFZFQz/ixs8fqmwxO6cqm3sdYdb0oS+t1QKQoWFE079K9focrljujjcYo
	 CetPc/KjI2dSMRzAG2iaGRO3uFIbl9bSKzzhBMCYfjD5VCj8hg4TmyE4SAJy0Z0HFs
	 7nYNciZOqAOH/wvAhD1KbNPWQNkibMRFosTTsb6W2HshQLkBsgYxfnJDuS+juGfvvF
	 Mvmtfk5vN+P7A==
Date: Fri, 23 Feb 2024 06:48:15 -0700
From: Rob Herring <robh@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-rockchip@lists.infradead.org, Takashi Iwai <tiwai@suse.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 2/7] ASoC: dt-bindings: Add Rockchip RK3308 internal
 audio codec
Message-ID: <170869609254.1763035.9305540137750026528.robh@kernel.org>
References: <20240221-rk3308-audio-codec-v3-0-dfa34abfcef6@bootlin.com>
 <20240221-rk3308-audio-codec-v3-2-dfa34abfcef6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-rk3308-audio-codec-v3-2-dfa34abfcef6@bootlin.com>


On Wed, 21 Feb 2024 11:22:46 +0100, Luca Ceresoli wrote:
> Add device tree bindings document for the internal audio codec of the
> Rockchip RK3308 SoC.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> ---
> 
> Changed in v3:
>  - fix underscore in DT label
> 
> Changed in v2:
>  - reword commit title
>  - add maxItems to resets
>  - remove quotes from reset-names
>  - use percent values for rockchip,micbias-avdd-multiplier
>  - use name compliant to the docs in the example
> ---
>  .../bindings/sound/rockchip,rk3308-codec.yaml      | 98 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 103 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


