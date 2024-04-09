Return-Path: <linux-kernel+bounces-137550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F589E3C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC961281977
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC3A157E63;
	Tue,  9 Apr 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BD0zXLTd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E6157A71;
	Tue,  9 Apr 2024 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691538; cv=none; b=bdXTporBWUgddJ3ulxuHvgORbaLxwemjqVrTPG8iraI7hG6xHqgzzuD1Dqfa7nIf6nEcJCVgzeizOeVecmo2xp9DSjf0Cuni0LCl6NEaCyldqwrr30s5JPE4wFnE4BjEzSyfc/BeCuJNbv170SgbtmdkxeyP/CkLK9BNX147HD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691538; c=relaxed/simple;
	bh=8CiuLjT8SYyHW8CYKyCQNs8I0ckuvccHwDNQ5TsQY04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5L8w95veW77eOArSUoOcKiLzVGmCPReF4+nD34wDNDMNnDqbZs3Dw4IJRNYAYWimrMrM/E30jW2k0x2yW2qYI9V4ickoRyU94joZKN4xOXqh45kfo8mG7Tn17C1Q/8CBRAGi1f0KZv5It9VvSKAveVNZGfrkDHESWT3x3a0TEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BD0zXLTd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JcoLo106152;
	Tue, 9 Apr 2024 14:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691530;
	bh=Nf2oFc62KEq/tI8eB+W0WJoLyI0NYoNEasGeOioyT6A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BD0zXLTdXacGLRBlLjvj24DYRQneOP1vie4nEErvcSpvwBxN15LawFcGgvOS96LBA
	 +/6az4U2WfbYl9cCiGvzzLioH2qdEIGB59EnePawElsvo1xBCGOsf2ivra79VISD45
	 v5nLHkR6xEmVQUL1Fj8sGdjwCug3Y9fZq7+ig4ic=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439Jco26055213
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:38:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:38:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:38:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JcoZ7093153;
	Tue, 9 Apr 2024 14:38:50 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-lp-sk: Remove tps65219 power-button
Date: Tue, 9 Apr 2024 14:38:48 -0500
Message-ID: <171269152122.643229.15373522506888565634.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325152029.2933445-1-msp@baylibre.com>
References: <20240325152029.2933445-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Markus Schneider-Pargmann,

On Mon, 25 Mar 2024 16:20:29 +0100, Markus Schneider-Pargmann wrote:
> On am62-lp-sk the PMIC is not wired up to a power button. Remove this
> property. This fixes issues observed when entering a very deep sleep
> state that is not yet available upstream.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-lp-sk: Remove tps65219 power-button
      commit: 20b7a6af07b80771043d3beddd80720a40dce60c

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D


