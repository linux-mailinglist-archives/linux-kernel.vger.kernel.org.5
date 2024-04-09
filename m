Return-Path: <linux-kernel+bounces-137545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813089E3AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499321C228E4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FFB157A40;
	Tue,  9 Apr 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SoI7TEqw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C191386C0;
	Tue,  9 Apr 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691427; cv=none; b=YQJCi0BEZGDVKA4UNtTpEcJGjtaSCgfq/R6CwIIFou5ykzZbF6aVMVXrN9M7GxqnFygt0VZXyvJKrFaPEBSmMHdtE0fgWhzBsjJhgVBA+r7iMErzAckLUKnSl1JdYg+QNLwNNL8jGU+80u5CyFiUo/2gT58ugupRaGV5Y9253Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691427; c=relaxed/simple;
	bh=G8TI8HYxBGOKwFa860i9qbi4wv4r4/W/X7hOcjuztos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1OqlRsT4l8KGcSqyu/+8LNWU7vzK00kgcvMl2L9L+b5HXf1VucZJXrtHdNQ0GfV2NFGP0tJsoTsFXY1MxSU7bG4KfCkiSrl6hxE7I/IIosCH5c/0bRlVFWqLRMG28NWqYrPI6LKXdONx6kZAV3nWAAWIIH5wcgoPbAKpDgAzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SoI7TEqw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JatlE064249;
	Tue, 9 Apr 2024 14:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691416;
	bh=yfKK38yevMbRAQP/cnjxOpppNyIcNwk3BqMX49snWIg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SoI7TEqw7QUIhqIBCR4mbyLAuiSFaGbQub9aq+pbTUqva8KI/hpQBe3roIA+ZRS0c
	 GXpUvoH/ezvt2dSBIkhBxAlXo/SqslCN28K4sdtIK1hgZRPz2hDAXm6ZKeEKF+FUNM
	 P5SLGW4t4diYrXgkAOqREMEgQz5q/hKWcwVEhCrQ=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JatVv005561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:36:55 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:36:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:36:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JatOI089867;
	Tue, 9 Apr 2024 14:36:55 -0500
From: Nishanth Menon <nm@ti.com>
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Nishanth Menon <nm@ti.com>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
Date: Tue, 9 Apr 2024 14:36:53 -0500
Message-ID: <171269138685.642844.11136653326464585397.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Krzysztof Kozlowski,

On Thu, 08 Feb 2024 11:51:45 +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> 
As discussed offline, I am picking this patch up.

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/2] arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
      commit: 45ab8daed512258c07fd14536a3633440dabfe84

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


