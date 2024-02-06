Return-Path: <linux-kernel+bounces-54327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B113284ADB0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A21D28295D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9EC78B41;
	Tue,  6 Feb 2024 04:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tDAgollU"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E8677F12;
	Tue,  6 Feb 2024 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194616; cv=none; b=J4NvqqEeeahDeJucPh6KOfAt7PGDVeL1YX/Rkk62IULWGVEtebfhFgWtGW9I7N7kKtEL4Oyv1RYOmjaBLSKB16lnNxutyQUSX5MyQrGtErz/2eRoyK3/4GD/aI/yUe/cY7Xhpwszh064bvp1R523Qtb6umQdF/T6WyXEjYORKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194616; c=relaxed/simple;
	bh=LS1KrxtP59Fb91vkMh5NAIuixfILIL/8DogIfqJBR0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1T3F9NmqxivkHDd+y2Ht7rawOfyhEuvdzh4kBWFK5FzzMrqGQwf0RfxE1IO/9Z9aIZJ/psaVONxApqM5IUz+++EYvHc3aS8wh6IUSsQtzXEWo21WhWMVtwr4wejSfcpHntCWpkpwd3aXihw8uRVoAIX+gPMGF+3nSeoAy54qBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tDAgollU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164hPNa025424;
	Mon, 5 Feb 2024 22:43:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194605;
	bh=P9Brm4oSTXiiBclrcVJ3PCSaz+EcMSnBjpIYP2cMhlY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tDAgollU6CsHtb4OxsYg0ES60kT+RcAsaOHdLrRpb+gF/84CrpJHRnOMlpCs+xMpk
	 2SJTKTYnhY2OC5g4xxEzZLq97yaRC9vwTXUylzMbUcIBR+Q6kiVpyb8IblmPOUTk/2
	 xO0cIHwNiiWF17VjHcM2GAPiAdJJdmwy7BW6Q3DI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164hPMw003726
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:43:25 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:43:25 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:43:25 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164hJQx117444;
	Mon, 5 Feb 2024 22:43:20 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Tony
 Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Richard
	<thomas.richard@bootlin.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-omap@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <gregory.clement@bootlin.com>,
        <theo.lebrun@bootlin.com>, <u-kumar1@ti.com>
Subject: Re: (subset)[PATCH 0/3] pinctrl: pinctrl-single: fix suspend/resume on j7200
Date: Tue, 6 Feb 2024 10:13:03 +0530
Message-ID: <170719349987.2245010.13900750309896394285.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
References: <20231128-j7200-pinctrl-s2r-v1-0-704e7dc24460@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Thomas Richard,

On Tue, 28 Nov 2023 16:34:58 +0100, Thomas Richard wrote:
> On j7200, during suspend to ram the SoC is powered-off. So the pinctrl
> contexts are lost.
> The flag PCS_CONTEXT_LOSS_OFF shall be set to restore the pinctrl
> contexts.
> 
> A new compatible (ti,j7200-padconf) was created to enable this flag only
> for j7200.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[3/3] arm64: dts: ti: k3-j7200: use ti,j7200-padconf compatible
      commit: 4eb42afed5d488c4707be5362e8e0f0771f5218e

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
Vignesh


