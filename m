Return-Path: <linux-kernel+bounces-137557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EFF89E3DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603561F23823
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7769157A67;
	Tue,  9 Apr 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UQLO3aF0"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F7157A42;
	Tue,  9 Apr 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691835; cv=none; b=dq2E0auOFyaE0HkpHfHxbYUFxTvRb4m9ugs3/Md9fNeUcXq17yTkxnPAoUP5mH0kRuKBAAncCu8oNoOHFIsQTvR9dBRtpNhC1yI4cruPy4Kayhd7mWldHNFhDpnzbpsZUIs79QNj/S7B4TFcqiGyRA7NTQRzunq3IMZ+dP37rrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691835; c=relaxed/simple;
	bh=S3daUGLfKVV4Ti5klsHRtQg8yvQ88JxRkBJee6j3xvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=daHdOTNsMHT3DbPGW6dT6KKo+W+7gROTwoPEb6t/X5rbkuU028ZTY73PPu/ZtV11FVXcGeGtcZK7GYbtoHlnPQKw9arBI9NC7m9FyftU1VETloZGyREjcnSryl8qCKcHJeLIOmvl/VqoNP899so9qHIG19Cz6n13gNCoc4F+SQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UQLO3aF0; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JhlGd016830;
	Tue, 9 Apr 2024 14:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691827;
	bh=ixvpjeiOJMJ4T+FLd4hArdC7rt68RwapbgBLj8mR0Bk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UQLO3aF0N00iFnLy0NJkWDSeMOzzqgz53UkNV58B7l2bYD/XpOYYqTwibZ8NpWDAS
	 6MdCpL1ybXCSZTRzRg8PzRCN0qiNT+HdaS8qmrYGwrkRo3Lyxe2MbRsqo15csES4ts
	 UDi15cD9jBefgz4NFAzMVRccPWQJGyFHvipm8hrI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JhlOq017809
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:43:47 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:43:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:43:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439Jhlvl101119;
	Tue, 9 Apr 2024 14:43:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
Date: Tue, 9 Apr 2024 14:43:46 -0500
Message-ID: <171269175423.645063.3175617595805368025.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403102302.3934932-1-mwalle@kernel.org>
References: <20240403102302.3934932-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Michael Walle,

On Wed, 03 Apr 2024 12:23:02 +0200, Michael Walle wrote:
> The J722S EVM has an on-board eMMC. Enable the SDHC interface for it.
> There is no pinmuxing required because the interface has dedicated pins.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j722s-evm: Enable eMMC support
      commit: ab833a6478e5376f8076be41109d74387ab8460e

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


