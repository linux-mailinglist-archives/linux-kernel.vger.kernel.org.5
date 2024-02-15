Return-Path: <linux-kernel+bounces-66551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39230855E49
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79DA0B304BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16517745;
	Thu, 15 Feb 2024 09:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cG8ZiY/T"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F21BC3C;
	Thu, 15 Feb 2024 09:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989563; cv=none; b=UqoYUav0A/S4vs8U6W+obt5480IxHUUNies7F4dQUBQ0dev50LUsm7XDdAcj34FqFJsO4t/eiZ4CVeHHgjml2HZOZFV/udPMzPkyORN+Fa1omaTko93Hv4VyFlM6jncebh27gxrld0CCxWELx1lVMgH2xf9Kv1VzCLrrifvG0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989563; c=relaxed/simple;
	bh=1hpSQbpkIw0+P3onlkNPtfkGkPgtz2wSsdJChOLmuhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccUKEnzGiuT2AB3phwNeTPSy9NVirJBL6Ik85AQsAX0aUrpQv9Xy/bKdgG+lE2wAimK03q/L2H0h0VcFfLT93+tq5SOpw4PhikyAOOtBOhQU7q1rFqfsrhyTyPaNTXDeyfgZ86y7H2iVIijtU/inpFaaY7RQux1xFnIxsxxgepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cG8ZiY/T; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41F9WIeg079935;
	Thu, 15 Feb 2024 03:32:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707989538;
	bh=sjYVLw1rUUvV7fpxEZp2wtym68kPwovkcx9LV5NGMHk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=cG8ZiY/TJWtbOqBTvGiPWe3sBoE5CbFhw+IvF9An+6hcnsyDbzCW9smkXUIC9zu8S
	 g7XGuGmi8QzgTs4jwcnbiairQ9o938aFE+S8t0jzkxpur7I+/n2kG6dXMTMQainSDN
	 doVLUjTWtYDdDbqZY/k2iQIL5wKnArPO3/u+h/Lg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41F9WIqi112265
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 03:32:18 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 03:32:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 03:32:17 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41F9WEds109957;
	Thu, 15 Feb 2024 03:32:15 -0600
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
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V
Date: Thu, 15 Feb 2024 15:02:10 +0530
Message-ID: <170798813445.1487216.11059927145774998794.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213155622.18309-1-francesco@dolcini.it>
References: <20240213155622.18309-1-francesco@dolcini.it>
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

On Tue, 13 Feb 2024 16:56:22 +0100, Francesco Dolcini wrote:
> Set VDD_CORE minimum voltage to 0.75V, TI AM62 can run at either 0.75V
> or 0.85V depending on the actual speed grade and on the maximum
> configured speed (1.4GHz frequency requires 0.85V).
> 
> The actual value is programmed into the PMIC EEPROM during manufacturing
> (according to the SOC speed grade) and this ensure that both the voltage
> values are valid and therefore the OS will not overwrite the value
> programmed into the PMIC.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: Set VDD CORE minimum voltage to 0.75V
      commit: 2af8358ad64fb4bf012a6dc2917fbfc78a2093b2

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


