Return-Path: <linux-kernel+bounces-137551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15989E3CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F2D2832BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07524157A51;
	Tue,  9 Apr 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UwsNC70x"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D581E89E;
	Tue,  9 Apr 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712691564; cv=none; b=GEaf9lQOpL5pRf21T8kjVmcBi3wZxiycRkMdI/3VRuLGbuv7Tjx6sRd5Hw3obFNMkischaVMs5Jbdd+BrYo3RoB63Mypcmq5q/iRTqvksVRkWB5LVStDyDmJ72BrxpoAZst2aI+Vb8n5VaONaB91MGzamA4gw/saFbfXqLK3Ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712691564; c=relaxed/simple;
	bh=jvfqdllxszzWIO3omrAadvdVw9I8LcR+WJ++GLM8mx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GunTm4hXXdbxzWSY0ts14qXdUb+ikapiyQjP3VSUhCsUstBNkd5IN7Yp5WCVU5j1/tKx/da5rS8iJMBcNnxckHssjsoU2jeOMOM+NzQ/tlkQ9SxwqjiZ0ToZfdayTwPDGrQkxWKBGZ2YSpctXZ6oZNkgH05MvAr96eSZzxa5NSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UwsNC70x; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439JdF0q016084;
	Tue, 9 Apr 2024 14:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712691555;
	bh=0kXWr09pO7Mlq1CB1JbZnar3+SauEhZ6UIneplQ2frs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UwsNC70xyshHU3V1OS3TYB4PkLZ09VovuZAbS3x1T9ZIhLc7/cK2iQPz7gAgoipj3
	 mYH2zQsNyeTbC69ViY+q0sqF3atVyvu4dFIPsJezEOP9cykss6QXV1p2GIOh34pZTE
	 BTEslTthvpgFMO0c+cv6tgKBygka2jadfyLYIz8Q=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439JdFYI055483
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 14:39:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 14:39:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 14:39:15 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439JdFQx093803;
	Tue, 9 Apr 2024 14:39:15 -0500
From: Nishanth Menon <nm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
CC: Nishanth Menon <nm@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] arm64: dts: ti: k3-am65: Remove UART baud rate selection
Date: Tue, 9 Apr 2024 14:39:13 -0500
Message-ID: <171269153957.643321.7481119560022583706.b4-ty@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326185441.29656-1-afd@ti.com>
References: <20240326185441.29656-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew Davis,

On Tue, 26 Mar 2024 13:54:36 -0500, Andrew Davis wrote:
> As described in the binding document for the "current-speed" property:
> 
> "This should only be present in case a driver has no chance to know the
> baud rate of the slave device."
> 
> This is not the case for the UART used in K3 devices, the current
> baud-rate can be calculated from the registers. Having this property
> has the effect of actually skipping the baud-rate setup in some drivers
> as it assumes it will already be set to this rate, which may not always
> be the case.
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/6] arm64: dts: ti: k3-am65: Remove UART baud rate selection
      commit: 9a1cedcdb98387bfc5d4fb9f1a1ada9121d32757
[2/6] arm64: dts: ti: k3-am64: Remove UART baud rate selection
      commit: 78331a044106f7022915058376ac56ec5d048124
[3/6] arm64: dts: ti: k3-j7200: Remove UART baud rate selection
      commit: 69dfa876d4b03f7bc043b196c472fca5d339722a
[4/6] arm64: dts: ti: k3-j721e: Remove UART baud rate selection
      commit: 14e556b08380b20833c5e2f6a5826d0669e0e0fa
[5/6] arm64: dts: ti: k3-j721s2: Remove UART baud rate selection
      commit: cfcfcd47c9f049be4ebcee90eafaf78b03cdf05f
[6/6] arm64: dts: ti: k3-j784s4: Remove UART baud rate selection
      commit: bd305a20fd338690fdd8ab8c4a50ab9d14066dfe

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


