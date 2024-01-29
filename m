Return-Path: <linux-kernel+bounces-42880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66F4840815
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817CF28EC01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C517D664D0;
	Mon, 29 Jan 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Dx1cQo0e"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3E664BC;
	Mon, 29 Jan 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706537887; cv=none; b=mgSXuCqZdb3hglzdPOE6MhufwlKxR1y9OnR9b0I7ms/Mu6ctHedqaTdN2QpU4BkApmtAB11xeGQR3WPQkvyOKJ+gkKujb/p3zD4kOiPRoAoL70l1xIJLcuw2cjnO4Hx31JcpdBcuiT6E1Sbxb0mZHg/T7gbteU+MoOJwSxFn0+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706537887; c=relaxed/simple;
	bh=kWxjb4ml+ynyqsVlPQAgRdTWagFtJPgdg5NTdak0Vgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEwSzfJgOB7F4BaDFARvKtvcHgkF9+Fy6q5g/kJzNI+l+fRmwzbb1WglZK1uFjGGC8pwZhwCkzIp4dEPjwHeT84vrQ9uNXm+RJfnj+kvg3zcxNEySk8Fd02Ysby9r1AjI9uc2CFBu8OhopkaI91zBQ1ZbuF91kx6ZBXfCKanaVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Dx1cQo0e; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706537883;
	bh=kWxjb4ml+ynyqsVlPQAgRdTWagFtJPgdg5NTdak0Vgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dx1cQo0eksjy1IF4R7mGyf6fjgGfyGo2p3LnfOahQwW0DsfFpcsODh8KjqtS8w4nu
	 YmOVBkU+2MXNXwiOEzr1soD+Tc0RKQ0+B+EgFuLGed80bHmwc5vaE6L/V4rBLa9e9m
	 m1GIgnKytF3TulAjvhBrEb7Om8HrCjYtyO5GuDd8BAzTgrwPF4RqAVVi3FjjyWrAyc
	 1rxtrTnUYdl5rjbKU6hLaGYpHLKklL3q/uymLgST4jyo9GSxE1eoO18bqIpbBGPU+7
	 NCH3tHg0huh0J5VEy7E0oUXchipPlfjqah6BKwx7wJReu52ieiFIn20WRLr0O2HOCn
	 wAjMIlGpttttg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C08DC3781492;
	Mon, 29 Jan 2024 14:18:02 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] arm64: dts: mediatek: Add MT8186 Corsola Chromebooks
Date: Mon, 29 Jan 2024 15:17:46 +0100
Message-ID: <170653783721.1024557.10198191746987942354.b4-ty@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126083802.2728610-1-wenst@chromium.org>
References: <20240126083802.2728610-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 26 Jan 2024 16:37:49 +0800, Chen-Yu Tsai wrote:
> This is v5 of the MT8186 Chromebook device tree series. This series also
> depends on MT7921S Bluetooth [1] and IT6505 audio [2] bindings.
> 
> Changes since v4:
> - Rebase and fit in mt8188-evb in board DT binding
> - Change "touchpad" to "trackpad" in descriptions and commit logs
> - Drop #address-cells and #size-cells from it6505 and usb_host1 nodes
> - Drop "ports" nodes from type-c nodes
> - Fix pinmux node names
> - Split anx7625 reset and power-en pins into separate pinmux nodes
> 
> [...]

Applied to v6.8-next/dts64, thanks!

[1/9] dt-bindings: arm: mediatek: Sort entries by SoC then board compatibles
      commit: ab7e0bfc2ce6d9e81f096e4058e1ea5f9d3c11fe
[2/9] dt-bindings: arm: mediatek: Add MT8186 Tentacruel / Tentacool Chromebooks
      commit: 72d721234de52837d84f9a8ffe78e04a61bb9b37
[3/9] dt-bindings: arm: mediatek: Add MT8186 Steelix Chromebook
      commit: 0f20d2a2ff103ac9aa757357ddf1cb137f767d3e
[4/9] dt-bindings: arm: mediatek: Add MT8186 Rusty Chromebook
      commit: 66135c73d2dc43f7f0fab6e7fdf44fa8e42a9b97
[5/9] dt-bindings: arm: mediatek: Add MT8186 Magneton Chromebooks
      commit: a597b13dc92cee39547e894908f787210cbb1a99
[6/9] arm64: dts: mediatek: Add MT8186 Krabby platform based Tentacruel / Tentacool
      commit: 660324894cc56e60711a12de51d94398f4e794b6
[7/9] arm64: dts: mediatek: Introduce MT8186 Steelix
      commit: 5252fa5b5ecbd65fdab2dfec0c14b96d00ae4b97
[8/9] arm64: dts: mediatek: Add MT8186 Steelix platform based Rusty
      commit: 498a5b6f8b67f60e5859bdd3d582274ae3aa2bbb
[9/9] arm64: dts: mediatek: Add MT8186 Magneton Chromebooks
      commit: 71e147d069291d0c92e4df903a2895eb5587b559

Best regards,
-- 
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

