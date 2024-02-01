Return-Path: <linux-kernel+bounces-48864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484A5846280
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DEA28D12B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAD3E491;
	Thu,  1 Feb 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FtacmHPF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395CF3CF5D;
	Thu,  1 Feb 2024 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822056; cv=none; b=ie42kLu35Z7uPXeAClAA8F1I3IRjxpk8KQHRC0UM7c0tPfMXAYmSSOJsa1MFHdKJMhsTmHTxlEIzuPd6jIJBlWV0gqTmVU21ipSegvnJBVii9LbP5yPKvbzMV7MuwcRd7lLFuF7AsjrEvT1X3fZl7NPu4/hn6j57R5Hz6hWmEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822056; c=relaxed/simple;
	bh=9om5/uHJZU5XBcVgAeZIRJGYJUvAq7Y1kYG+2l1D41M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBeZiNzVYKHWfah4OvhbR1U7rgWwEN2oil8yP4mjv+yxeonamhlO7NZMjP8OKo/pM49etRG1uDTQSKK4im61cO693pkYd+4YUtqiuB/ntHxWegywSj3jeqkKgICaVdrgEl2eDnH7lLE7vx3IxxLnTayPDE6gL3xtXtYASzllBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FtacmHPF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411LE2MV100921;
	Thu, 1 Feb 2024 15:14:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706822043;
	bh=pEAsrojppbvro419UF7rpGJv30BuKmWk+tcLVk+eenQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=FtacmHPF72QEDzuSyCA5vjFHJFnXLWxyY9tnRvzCMGWw3NRVMSDBWE0zfBGXoF9LQ
	 8PfgLZ1psWpVLNdbjG6iHdb1/LQ6mfXyX6LHvjXva7mK0Cvzq/PKwttPAaT1B7Ue7M
	 BInzEVk0dUiPuLabIVEwrwHfuofNK1JH8UjHKyqI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411LE2kI062853
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 15:14:02 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 15:14:02 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 15:14:02 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411LE2ir109903;
	Thu, 1 Feb 2024 15:14:02 -0600
Date: Thu, 1 Feb 2024 15:14:02 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 00/12] Add TI-SCI reboot driver
Message-ID: <20240201211402.nldc6x2iosi4fkxq@morbidity>
References: <20240131221957.213717-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240131221957.213717-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:19-20240131, Andrew Davis wrote:
> Hello all,
> 
> While PCSI normally handles reboot for K3, this is an available
> fallback in case PCSI reboot fails. This driver is registered 
> with low priority as we want PSCI to remain the main way these
> devices are rebooted.
> 
> The important part is the binding/DT changes. Currently in
> U-Boot (which use the Linux device trees) we may not have
> PSCI available yet (pre TF-A) and so we need this node
> to correctly reboot. Adding this node in U-Boot is one of
> the last remaining deltas between the two project DT files. 
> 
> Thanks,
> Andrew
> 
> Andrew Davis (12):
>   dt-bindings: power: reset: Document ti,sci-reboot compatible
>   dt-bindings: arm: keystone: ti-sci: Add reboot-controller child node
>   power: reset: Add TI-SCI reboot driver
>   arm64: dts: ti: k3-am64: Add reboot-controller node
>   arm64: dts: ti: k3-am62: Add reboot-controller node
>   arm64: dts: ti: k3-am62a: Add reboot-controller node
>   arm64: dts: ti: k3-am62p: Add reboot-controller node
>   arm64: dts: ti: k3-am65: Add reboot-controller node
>   arm64: dts: ti: k3-j7200: Add reboot-controller node
>   arm64: dts: ti: k3-j721e: Add reboot-controller node
>   arm64: dts: ti: k3-j721s2: Add reboot-controller node
>   arm64: dts: ti: k3-j784s4: Add reboot-controller node

Maybe after the driver has been accepted, a defconfig patch(module) might be
useful?

> 
>  .../bindings/arm/keystone/ti,sci.yaml         |  8 +++
>  .../bindings/power/reset/ti,sci-reboot.yaml   | 33 ++++++++++
>  MAINTAINERS                                   |  2 +
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  5 ++
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  4 ++
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     |  5 ++
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  5 ++
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  4 ++
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  4 ++
>  .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  4 ++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  4 ++
>  .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  5 ++
>  drivers/power/reset/Kconfig                   |  7 +++
>  drivers/power/reset/Makefile                  |  1 +
>  drivers/power/reset/ti-sci-reboot.c           | 63 +++++++++++++++++++
>  15 files changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ti,sci-reboot.yaml
>  create mode 100644 drivers/power/reset/ti-sci-reboot.c

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

