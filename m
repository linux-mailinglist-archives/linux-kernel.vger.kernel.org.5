Return-Path: <linux-kernel+bounces-160741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7988B4239
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4CE1F22CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854AE38F86;
	Fri, 26 Apr 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WJ+hILl5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A673B781;
	Fri, 26 Apr 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714171167; cv=none; b=ftga3Q2A4tn6KsKX46izJ4azKCm8gxDTwn3E4lY8yWPv14mysaWGuWsTKiGZcnEXiUBa4eqQIzZ6YFfusIlhE7b3RvHEKgZGfiLENLNfChSevt/sDXW5Cym7fQ7L52uVInDyy2haCTOUvVQsesZ/Qbi6PcY2k2vulmrgl8+rAUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714171167; c=relaxed/simple;
	bh=onkpg9+IozTYZV3NdeQ1ZxkC0+T+82Gh/+NBw0419Qs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYJ8zGdtM6W0DPZcKJrzyzDVz57vsmtevftslUZlr4AgwM3yRUfYBzJz56bzjinBgBcQLVR6DMDQxlxhYPGgdBCdhPtLbXutEawuTX5Qmt3fgNvZjcELRweoCmAFeaqw69kb5xmEBgdgafG2As1P6r2FH0+Tl4YMrYhXQ97xw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WJ+hILl5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QMd7LA059002;
	Fri, 26 Apr 2024 17:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714171147;
	bh=UL/1epvh+z2v1182jzKmsU63RNj24NPJBBnlLcibofQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WJ+hILl51tEsDYgCkhS6Lvq/+Bz11eFCI6BScVLTYoGLSBcLtQ7Wz0xtpn3hoG172
	 tSAbstcddOf5azDikn8BjSNhDJKw4ayybf/uXTYd/85UkwoflwQu3hrUt3Gb6OvEoX
	 pkqyjDltqBCWgqxINCsyZKpdGcgYNodJwbB93POQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QMd7eG059713
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 17:39:07 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 17:39:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 17:39:07 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QMd63G079046;
	Fri, 26 Apr 2024 17:39:06 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, <b-liu@ti.com>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 0/3] arm64: dts: ti: am62: Add USB support for k3-am62p
Date: Fri, 26 Apr 2024 17:39:05 -0500
Message-ID: <171417113552.3482855.12058522443772473219.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
References: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
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

On Fri, 12 Apr 2024 15:01:57 +0300, Roger Quadros wrote:
> This series first adds device nodes for USB0_PHY_CTRL and USB1_PHY_CTRL
> in the wkup_conf node and fixes up the USB nodes to use the newly
> added nodes.
> 
> Then it adds USB support for AM62P SoC and AM62P5-SK board.
> 
> cheers,
> -roger
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-am62/a: use sub-node for USB_PHY_CTRL registers
      commit: c6e9f107eb0f1cab3514f551343892ca93c46628
[2/3] arm64: dts: ti: k3-am62p: add the USB sub-system
      commit: ae33c9d1646989c5c1b0257e0e4ff1aee1ba7491
[3/3] arm64: dts: ti: k3-am62a: Disable USB LPM
      commit: 9f8372e3a595452a204db409003e802273a81b30

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


