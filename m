Return-Path: <linux-kernel+bounces-117273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138588A981
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8B5322532
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F78161909;
	Mon, 25 Mar 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkpAcbia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6E58135;
	Mon, 25 Mar 2024 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377583; cv=none; b=stPgsTdePX/DMFUfbgaUSHKObh2t0Yy5+uFkutCKCG28XZJNxD8qJAqAcHuM9HMbSJ9yq7nsihuXFD+AEvsKWGMtpWuNWHNpucZ7/zoalxKyMat+TpfC+sRB8nmTZwWdgDVKHYAhaqxYv/L2IWodv3F9Kp7eWfsVOhoYItWvHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377583; c=relaxed/simple;
	bh=FjnS44ng3NPsn9900ILtiMh5uro5/JiC38NCbn+WTYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+QJrwnRELQgDJPapey3vg9dEFwBMb05Dprv/GA3s9yJ2QTsu9Wtpyl7C1DuV9KoVYaOnylenrpRiLct2rWorKgp1pEzVZi6YVatbTwKo3TfBBGi8TwYx4IO0EszEs2Vpx1a6S4YWlCNb9FePtckyHD+l/PwTI8kazrSResj+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkpAcbia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE25C41674;
	Mon, 25 Mar 2024 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377582;
	bh=FjnS44ng3NPsn9900ILtiMh5uro5/JiC38NCbn+WTYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkpAcbiawu2zrTNsSnZevVXPSjwCNl7i9z7hG0I0A/7jZ6i6zvL1/9OrDI9MBg6LE
	 x3udYirwdM7/VCWp6qcMvNWE//aqcmEUyrqKaVfZpGKkz9UjuF11Z+pNo1WTfsaWUQ
	 uo9BQwFdP6Uxigvupxzgwmvw7CGjVbJS1DbF/TYibY7UZTSNDknpt9CCA7WnQVw96T
	 eLw+ezpKL6ilfx4tTV/QsDBPtSRmybf/pUAMb3H/MjyFORS24NISod0DZiGqQMg8ew
	 IfKIE1b/Rq8pksjUMb/+xqE3NcFUTUM2gmhHQI/YtsIni3oz5aomYN4d9LqyHZrol+
	 GWNbUFuNmPf7Q==
Date: Mon, 25 Mar 2024 09:39:40 -0500
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
	linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	dri-devel@lists.freedesktop.org, Conor Dooley <conor+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4] dt-bindings: display: atmel,lcdc: convert to dtschema
Message-ID: <171137757831.3350156.9187326461669491839.robh@kernel.org>
References: <20240318-lcdc-fb-v4-1-c533c7c2c706@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-lcdc-fb-v4-1-c533c7c2c706@microchip.com>


On Mon, 18 Mar 2024 11:10:13 +0530, Dharma Balasubiramani wrote:
> Convert the atmel,lcdc bindings to DT schema.
> Changes during conversion: add missing clocks and clock-names properties.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> This patch converts the existing lcdc display text binding to JSON schema.
> The binding is split into two namely
> lcdc.yaml
> - Holds the frame buffer properties
> lcdc-display.yaml
> - Holds the display panel properties which is a phandle to the display
> property in lcdc fb node.
> 
> These bindings are tested using the following command.
> 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> ---
> Changes in v4:
> - Add maximum for atmel,guard-time property.
> - Add constraints for bits-per-pixel property.
> - Update the atmel,lcd-wiring-mode property's ref to point single string
>   rather than an array.
> - Add constraints for atmel,lcd-wiring-mode property.
> - Add maxItems to the atmel,power-control-gpio property.
> - Link to v3: https://lore.kernel.org/r/20240304-lcdc-fb-v3-1-8b616fbb0199@microchip.com
> 
> Changes in v3:
> - Remove the generic property "bits-per-pixel"
> - Link to v2: https://lore.kernel.org/r/20240304-lcdc-fb-v2-1-a14b463c157a@microchip.com
> 
> Changes in v2:
> - Run checkpatch and remove whitespace errors.
> - Add the standard interrupt flags.
> - Split the binding into two, namely lcdc.yaml and lcdc-display.yaml.
> - Link to v1: https://lore.kernel.org/r/20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com
> ---
>  .../bindings/display/atmel,lcdc-display.yaml       | 103 +++++++++++++++++++++
>  .../devicetree/bindings/display/atmel,lcdc.txt     |  87 -----------------
>  .../devicetree/bindings/display/atmel,lcdc.yaml    |  70 ++++++++++++++
>  3 files changed, 173 insertions(+), 87 deletions(-)
> 

Applied, thanks!


