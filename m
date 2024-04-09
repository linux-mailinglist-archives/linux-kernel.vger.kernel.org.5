Return-Path: <linux-kernel+bounces-137548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E389E3C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9D11F2418F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58704157A42;
	Tue,  9 Apr 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wZTSaEb4"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B7157495;
	Tue,  9 Apr 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691485; cv=none; b=b9KAVcRCffWGt4FKPrl1n/tmV+eoDrVuzuWRZ6KLQd1nEUle03+/iIoDkrggEMT8/+HBmSvbDopT48oJXV+E4XZXujvUaI/xaJxc/8IOe/CY2SdPF7fKqt2/14XAx1Gx05/zKXNRvFwv+M/pxH5J7m7gkF9NnsimjMebdCHhtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691485; c=relaxed/simple;
	bh=sNbHPOEFR5mGujxmmBnY1j5uAJMW6fPsNSHsguPKjBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HfZJ5T9F0SDztnzOzCh3TTZMDuGK61/zF8xYInl4itin0CZekw/b34rNJgP9K3/cvJPAV5Rs+uE1oNQNVSbdVhIlSP8docmDQ62Y0aBwFO7Y7RfViKx6coJM2s59p0nRgURyiQMBoLeq21uFPK01NEuF4y21QmZ5A+lLCbKdOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wZTSaEb4; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JbpFm106003;
	Tue, 9 Apr 2024 14:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691471;
	bh=sjvEKjJDTB4PoCOWllF8pdReIMnbh77rwHUap0DuCrc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wZTSaEb42aAO+5HtYiaA5a9GGwR82UjDdikURibLnos24Ipxu02CFNquqB34e1FxZ
	 /6chdK3wx0h2YJtMPSTbXeHNjfsA4A535f4kylBzHw5HEGq2vh/SatjnYBtvXCRS6Q
	 8evQxQRP4gKiNTZ5T0bw8KzhI1+1Zwtk8Jv3Bd7k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JbpRw013326
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:37:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:37:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:37:50 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439Jbo0b091680;
	Tue, 9 Apr 2024 14:37:50 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
CC: Nishanth Menon <nm@ti.com>,
        Francesco Dolcini
	<francesco.dolcini@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Silva=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>
Subject: Re: [PATCH v2] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
Date: Tue, 9 Apr 2024 14:37:49 -0500
Message-ID: <171269144959.643040.15393463689272047525.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325083340.89568-1-francesco@dolcini.it>
References: <20240325083340.89568-1-francesco@dolcini.it>
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

On Mon, 25 Mar 2024 09:33:40 +0100, Francesco Dolcini wrote:
> TI SDHCI instance has a hardware debounce timer of 1 second as described
> in commit 7ca0f166f5b2 ("mmc: sdhci_am654: Add workaround for card detect
> debounce timer"), because of this the boot time increases of up to 1
> second.
> 
> Workaround the issue the same way that is done on
> arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts, using the SD1 CD as
> GPIO.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: verdin-am62: use SD1 CD as GPIO
      commit: 08efdb8c41db2ea7a13e6a7e15bc167c1d96c456

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


