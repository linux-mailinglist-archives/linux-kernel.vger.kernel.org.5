Return-Path: <linux-kernel+bounces-163021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C348B63C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464E1283C04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE91779A9;
	Mon, 29 Apr 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lFVW50JX"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7B1411EF;
	Mon, 29 Apr 2024 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423277; cv=none; b=ElgWhOaNnokOXC49eJ9NKeFG/NkiMUxwUIVOZ7OjxWNp8Z5eVSNz7sgmFgOr9WEu5l2mhO/6xSNwFlytnTY4PobIpUYNyhZdHRZsLMZl8TMGoLnE3YPDx2Wi/gTG0SCjTkl1v9VwfBzhBOVFJ1GapCbhKOqf7Wo8CUo5yCKz5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423277; c=relaxed/simple;
	bh=IBy5vuNdM6tBND8jWE+r9vS2L9OGBZ4fU8CmR7rmuPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fu8dM6S8wvkLUiuWmG3OMHWFRHT63IRh1n1wtRDK2vK+JJwNnaxuBbqDQ3SWwqV2xAQMXncvFyzqc1UWJs0vmqwkmoJaBsH8ngg457tSC9j8Hg0jKX2JbhA2MMc0iiCP9kGPXlVSq/Sz/K9v1kRdo9TfWVF9B3RjNs5lGxExgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lFVW50JX; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TKf3Eh057525;
	Mon, 29 Apr 2024 15:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714423263;
	bh=GABK8szO4+HDKRTLZ25fXfMpPgxdpF438K8WMz+nTlk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lFVW50JXRz5yRKK7gX6uPySNfK+Nxv/IunUcS+k4BPVhTMxaJBSIdD574OsM2msxh
	 CCC6nC2Gx+t3P2wyUubmGOlfbrH7csRPU0pCYl4208ngY+O1WOxytxauWL9ZimUoQ6
	 sj3l4Rzdx7J/PW97mPAKwIYF9jViCUaFK52jd1fQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TKf3D5027579
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 15:41:03 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 15:41:02 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 15:41:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TKf2dr121833;
	Mon, 29 Apr 2024 15:41:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
        <r-gunasekaran@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
Date: Mon, 29 Apr 2024 15:41:01 -0500
Message-ID: <171442325719.132809.18343635173532672947.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240305-b4-for-v6-9-am65-beagleplay-ethernet-reset-v2-1-2bf463a7bf13@kernel.org>
References: <20240305-b4-for-v6-9-am65-beagleplay-ethernet-reset-v2-1-2bf463a7bf13@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger Quadros,

On Tue, 05 Mar 2024 15:15:32 +0200, Roger Quadros wrote:
> The RESET GPIO pinmux should be part of MDIO bus node
> so that they can be in the right state before the PHY
> can be probed via MDIO bus scan.
> 
> The GPIO pin should be setup with PIN_INPUT so that
> input circuitry is enabled in case software wants to
> check pin status. Without this, incorrect status is shown
> in /sys/kernel/debug/gpio.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
      commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40

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


