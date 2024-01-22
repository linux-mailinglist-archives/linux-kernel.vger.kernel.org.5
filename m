Return-Path: <linux-kernel+bounces-33582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BD836C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BC9B239EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89A40C1B;
	Mon, 22 Jan 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYvxLSKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F440C0E;
	Mon, 22 Jan 2024 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937090; cv=none; b=Lgwz1OnSql9cqEvLY/md6r1iP+J20bb0ADO4j9GIqCulxUjCcJbbMzTeXel0QYsU/za+8e4YWR5kInwL1bCC3V28fh2kmy5SYNOQ6fd645UdTAl538yGuryWl9jdxZs8eTtGJ8BKpec9Q8dRgCKdTB/YsOsAnibfsKoklQoa3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937090; c=relaxed/simple;
	bh=X2zo+ADx0iUXUH1+mwwJszLY24v0cg/zzYMyoTglDME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT51gS2vdhM1XWdIGM77cgSiBfrxS300hJTO9hDHdla841W7CW7jr6SUOGygHqDtQfPdV/m82aGy6flw8C6rDuH9eGDc9jp4uhNir1wUYvYK+rnc0uqbV+SQug9P+oY9Qe3wOPf4KeeEguUbNtAtaeBv6OZgUvpBAe7/lvfTaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYvxLSKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07092C43390;
	Mon, 22 Jan 2024 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937090;
	bh=X2zo+ADx0iUXUH1+mwwJszLY24v0cg/zzYMyoTglDME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYvxLSKeXpiJhD6o1BNKpjox7eBzuJVUcUqucdZhOIFjbD9d5sqwrCEKR/97Nl10X
	 +YXLvK08hl2hwZuK8i6C1vYxn9siET18kDdkVeOPj6Hf7yjZjr801cQbMrjNBXtiYF
	 3+RmWchfyDM9ZgaNpu2zZyptKJFIJMp0UM/tDfWT0vaARGuZBIbFRf6ewrdl/BnoHq
	 9Y7nKU1Ud45XWGgc1fMmecNo7R16LRIyS237vwwxnryjwQI5tlMgZA/bOD+9ZtDVYC
	 qy/5dJd6h9AjTlSK848mqMkcvLbiS3PJENFUDCFLDUUfGjNwHxSRbNOf3ftr6+WRD+
	 k7QXkGwzV0RGQ==
Date: Mon, 22 Jan 2024 09:24:48 -0600
From: Rob Herring <robh@kernel.org>
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Ayush Singh <ayushdevel1325@gmail.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Garrett Giordano <ggiordano@phytec.com>,
	Guillaume La Roque <glaroque@baylibre.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Jason Kridner <jkridner@beagleboard.org>,
	Jerome Neanne <jneanne@baylibre.com>,
	Julien Panis <jpanis@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Le Jin <le.jin@siemens.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Robert Nelson <robertcnelson@gmail.com>,
	Roger Quadros <rogerq@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Sarah Walker <sarah.walker@imgtec.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH V2 00/16] arm64: dts: ti: Additional licensing and
 clarification
Message-ID: <20240122152448.GA644286-robh@kernel.org>
References: <20240122145539.194512-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122145539.194512-1-nm@ti.com>

On Mon, Jan 22, 2024 at 08:55:23AM -0600, Nishanth Menon wrote:
> Thank you all for the detailed acks on various patches on V1,
> consolidated all of these with V2 and noted some missing acks below.
> Since it has been 12 days since I posted v1 and v6.8-rc1 is now
> tagged, looks like a good time to refresh the series.
> 
> As part of my 2023 LPC talk[1] about the difficulty in ensuring
> device tree is same across multiple s/w ecosystems, I mentioned about
> Licensing, and Rob had indicated that other SoC vendors have MIT
> license option that allows co-existance with Apache.
> 
> So, bunch of internal paper work later (during which GPL-2.0-only
> had to be retained due to certain user community), here is the
> update to sync TI K3 device trees with addition of MIT license in
> addition to existing GPL-2.0 license.
> 
> After querying BeagleBoard Foundation folks, they'd also like to
> follow suit, so those platforms have been added to the list as well.
> 
> While at this, clarify existing licenses to be compatible with latest
> SPDX specifications for iot2050 and phycore.
> 
> Verdin platforms look already sane, so no action required there.
> 
> The CC list is based on (Since I am representing @ti.com for this
> series):
> git log --no-merges --pretty="%ae" $files|grep -v "@ti.com"|sort -u
> 
> Requesting Acked by from the CC list at the earliest so that we can
> merge this for next baseline. - patches 6, 8 and 10 need some
> love.
> 
> - "Alexander A. Klimov" <grandmaster@al2klimov.de> (patch #6, #8)
> - Rob Herring <robh@kernel.org> (patch #6)
> - Peng Fan <peng.fan@nxp.com> (patch #8)
> - Jerome Neanne <jneanne@baylibre.com> (patch #8, #10)
> 
> Changes since V1:
> * Just picked up acks, most patches are clean now except for 6, 8 and
>   10.
> * As requested, Switched Phytec license from GPL2.0-only to Adding MIT
>   along with it.
> 
> V1: https://lore.kernel.org/all/20240110140903.4090946-1-nm@ti.com/
> 
> 
> Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> Cc: Ayush Singh <ayushdevel1325@gmail.com>
> Cc: Chao Zeng <chao.zeng@siemens.com>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Esteban Blanc <eblanc@baylibre.com>
> Cc: Garrett Giordano <ggiordano@phytec.com>
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Cc: Jerome Neanne <jneanne@baylibre.com>
> Cc: Julien Panis <jpanis@baylibre.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Le Jin <le.jin@siemens.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Pierre Gondois <pierre.gondois@arm.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Ronald Wahl <ronald.wahl@raritan.com>
> Cc: Sarah Walker <sarah.walker@imgtec.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> 
> Nishanth Menon (16):
>   arm64: dts: ti: Use https for urls
>   arm64: dts: ti: k3-am62a7: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-am625: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-am62p: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-am64: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-am65: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-j7200: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-j721e: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-j721s2: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-j784s4: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-pinctrl: Add MIT license along with GPL-2.0
>   arm64: dts: ti: k3-serdes: Add MIT license along with GPL-2.0
>   arm64: dts: ti: beagle*: Add MIT license along with GPL-2.0
>   arm64: dts: ti: phycore*: Add MIT license along with GPL-2.0
>   arm64: dts: ti: iot2050*: Clarify GPL-2.0 as GPL-2.0-only
>   arm64: dts: ti: Makefile: Clarify GPL-2.0 as GPL-2.0-only

For the series:

Acked-by: Rob Herring <robh@kernel.org>

