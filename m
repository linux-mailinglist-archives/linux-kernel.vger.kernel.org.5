Return-Path: <linux-kernel+bounces-54323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7E84ADA7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59F7FB2228B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA87A736;
	Tue,  6 Feb 2024 04:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bE68oBrU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBAB7A702;
	Tue,  6 Feb 2024 04:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194550; cv=none; b=kodlY+HjP+ItGBfCMeyuotIgH6AoSOLreSGehRDVK0BDn/zgpMoQmM4F2m43lqC+irdqkfa4o0MnMFKAQFrng3kxbLt0cYNsj5+QHJsEXSXThdWz55sHk3JvmWMHUbgFsNn1OXyaJFLyptWifiEPkwnDaHWiS0u1pEl4Y00mLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194550; c=relaxed/simple;
	bh=sMZeb9gZsKisuOQUz3K5fLMXiywa1N062FpZzYIT/WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo45sktif34KtMHjvmuIC0cQ7LTVQg9ddiHc9Ed4a54690K6f+tkh226/kTtpBygzBk+mVtYxR2n5OKERKSq5y+jaIyksVHfcGtEAgBBdgvDKB07oN41EqBJXfLFAYxkhrEY8sNPeurK3jVOmBNWqXyI9QkulZ6Iw2/6AmGWJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bE68oBrU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164gEhl090923;
	Mon, 5 Feb 2024 22:42:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194535;
	bh=rE/SMAevxerdATWwN9DNt6LHvNDHqhecLdK+qSez9dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bE68oBrUQzP+vfpnsS7cZPj5sqJq4lRZrhM+3lva/BIFZk3K1wG+sSKDuImKF3cON
	 U4uZWXWDNZC1AokAxV+7N2wsGq7K3wVMtVJ/60pfEhx/BX4Cmig+XBwa/rmEhwrfwa
	 zzuLGp+OxekdyZ+k23tlmWNogiEW1RNcVCD5Amd0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164gExY112956
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:42:14 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:42:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:42:14 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164gBCP100515;
	Mon, 5 Feb 2024 22:42:11 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: mallow: add TPM device
Date: Tue, 6 Feb 2024 10:12:05 +0530
Message-ID: <170719349982.2245010.4000049121495842797.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126165136.28543-1-francesco@dolcini.it>
References: <20240126165136.28543-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco Dolcini,

On Fri, 26 Jan 2024 17:51:36 +0100, Francesco Dolcini wrote:
> Add TPM device to Mallow device tree file, the device is connected to
> the SoC with SPI1/CS1, the same SPI interface is also available on an
> extension header together with an additional CS0 signal.
> 
> 

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: mallow: add TPM device
      commit: e55b0bf4c2b31cc0b202b375796f96b2b9af2e6a

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


