Return-Path: <linux-kernel+bounces-46414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCB843F58
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1A5B23B50
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A855C14;
	Wed, 31 Jan 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKWUsnvX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017A7690E;
	Wed, 31 Jan 2024 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703941; cv=none; b=XcMQ9bPDOlZi+WwHwaKfQDX8w1JQKbnKI14mHecBRs5hf6PFZWfJtvZO3GJQaGkgWXb+tFhN5a53imkD/yJd5a8a5U99BmTBrQ4pJxKaSf3SZ6YAE/5jrkV1YlxYxtCxuxBcO63hXeci5evUxsn96AiRr+dNG+Ru3Fd4UaEwkmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703941; c=relaxed/simple;
	bh=pFsCpJSLk0dh72t0fhH3sbqbPwdiOraKzWAQDmmK2Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gas2w6z+DyUUPAZhmEqcDDKQ6bTP6JxskTy7KNK30lRgTIEPWoSSoyKHcEQiecrK4UtNl+WZDGCcbivBtq8u9/P4E+YZLfoZXAJDeZ0O65G6030LvHg+YzCdPKMy8bM3p1XtsZ2O+JXQl1h62sz8gaPuOXq/ZgQvj1bOSl7d+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKWUsnvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3575FC433C7;
	Wed, 31 Jan 2024 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703940;
	bh=pFsCpJSLk0dh72t0fhH3sbqbPwdiOraKzWAQDmmK2Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BKWUsnvXlCFIsCKmwvsVgtprb4GpHXt7/kVarXgzN9FU+EqkG3aUPMHTGnwceQR4h
	 VojfTgj3McCQ1IAayF4Jqy+eO5iQ3ZWjO1WENIP26Cg6lrDn2YvzDBbArS/l2VI+r5
	 8O1bXx27TXwTLe+c1L94liTE1gO/v/cq1T9IRu7/6d2rbzBE2/D9a/SsgA6uFF8XOq
	 canyBdS75OzFpREQbXSnVbRHAJHRwKyW32ME+HLt4rLsPuZqaiC5pFzpLDObJHjw3e
	 mB1b7SthXpeHcdVlZ1XECxatH0arF7IfJiYKCGWghX2/eBwTJM/orChLn6kWL1Y1/P
	 t3CacpRqXGJZg==
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v6 0/4] Enable networking support for StarFive JH7100 SoC
Date: Wed, 31 Jan 2024 12:25:30 +0000
Message-ID: <20240131-sitter-parabola-8a2e86faa77f@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
References: <20231220211743.2490518-1-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=QpjxKADVuxDHO2HHz1mJLhLzOw0DBvtxFU1iut/HhaM=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKm7bCyjD5d2OlRF8PLW7+z+duVV4xQZhtszgq8axl4Ib TJrlfnYUcrCIMbBICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgIlcmsrIsHbKbM4q7dOH3UPN g3u+C264YKjs8PpRb9Lv5o67C2V3dTEy7Lv3YLK2exd3R1fLkZe5Lw8fvqb1xjF07uOUS1PsNP6 b8gIA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 20 Dec 2023 23:17:38 +0200, Cristian Ciocaltea wrote:
> This patch series adds ethernet support for the StarFive JH7100 SoC and
> makes it available for the StarFive VisionFive V1 and BeagleV Starlight
> boards, although I could only validate on the former SBC.  Thank you Emil
> and Geert for helping with tests on BeagleV!
> 
> The work is heavily based on the reference implementation [1] and depends
> on the SiFive Composable Cache controller and non-coherent DMA support
> provided by Emil via [2] and [3].
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/4] riscv: dts: starfive: jh7100: Add sysmain and gmac DT nodes
      https://git.kernel.org/conor/c/5ca37ca2a483
[2/4] riscv: dts: starfive: jh7100-common: Setup pinmux and enable gmac
      https://git.kernel.org/conor/c/6e204aa2116c
[3/4] riscv: dts: starfive: visionfive-v1: Setup ethernet phy
      https://git.kernel.org/conor/c/e16d3dc0a2d7
[4/4] riscv: dts: starfive: beaglev-starlight: Setup phy reset gpio
      https://git.kernel.org/conor/c/2db68ddbf33a

Thanks,
Conor.

