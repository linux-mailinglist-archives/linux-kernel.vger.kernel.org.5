Return-Path: <linux-kernel+bounces-46505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690108440AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82AD1F29C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFF7D403;
	Wed, 31 Jan 2024 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cGBqzFDt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD847BB10;
	Wed, 31 Jan 2024 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708117; cv=none; b=juHDikQW4v4wumL3m6ecYDnK6+pHoADS804xBJ6STx2zsrdATvVQAxeAN0Q8FT5DCMtUbB7MUmeEoAiaScIGu85WKfL0vU0tLsMcTfZfwZJM9Y4SIe8kJsjxVhLnQFQHcjvtJ15Dcllg1EMkB5PTdOrZS8ft8As2lgYzYzmc9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708117; c=relaxed/simple;
	bh=Q4jchHsyUSgGgsWg3qeXL0ngWEAkiAaiiTy/MAzG4eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rLfofcioY8nLLUI/Fned9DJQfSIh65NnxiM8/XGNLe1wgh8iiA/MXZZvd597U5gMdiw+zFVrBMxmddJpJqRuIrzKt/vIEeO2C/+1en00/nh4eN1y/B5tEMj+iYiPqSjvR0sSRS0F/v3P3z2oWZNnnCmG+H2UuaLxZgNQGaY6laM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cGBqzFDt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VDZ7nj120425;
	Wed, 31 Jan 2024 07:35:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706708107;
	bh=wYV7fdwKreRS4KsgsXkkx9ORp7Ffj/MSJJ3YQgSu6+c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cGBqzFDttqN/ZsZCgfE+OM7CZ7WyHw0q1CqqRMj7zBK8wUtiUxTQCO7cSJjJaKKMC
	 JqnisxhXRPzJx2z/RG/HdSPIFENWVaMD7dC8j4XE1syjFXgF4XmqFQhUqvmOza1UGk
	 6i2H7j8pZXw4pDfItLGPyKm73thJYyEfvtazOyhU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VDZ7PO068862
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 07:35:07 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 07:35:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 07:35:07 -0600
Received: from [10.249.142.56] ([10.249.142.56])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VDZ1hO102190;
	Wed, 31 Jan 2024 07:35:02 -0600
Message-ID: <5e03e867-b45f-482b-b734-7949e28fc97e@ti.com>
Date: Wed, 31 Jan 2024 19:05:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Add tuning algorithm for delay chain
Content-Language: en-US
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Andrew Davis
	<afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <devicetree@vger.kernel.org>,
        Randolph Sapp <rs@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
From: "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 1/31/2024 6:07 AM, Judith Mendez wrote:
> This patch series introduces a new tuning algorithm for
> mmc. The new algorithm should be used when delay chain is
> enabled. The ITAPDLY is selected from the largest passing
> window and the buffer is not viewed as a circular buffer.
> The new tuning algorithm is implemented as per the paper
> published here [0] and has been tested on the following
> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
> EVM.
> 
> The series also includes a few fixes in the sdhci_am654
> driver on OTAPDLYEN/ITAPDLYEN and ITAPDELSEL. There are
> also device tree node fixes for missing mmc nodes,
> modifying DLL properties, and fixes for OTAP/ITAP delay
> values. 
> 
> MMC0/MMC2 nodes are introduced for AM62ax in this series.
> 
> This series is sent as a RFC mostly to get some feedback
> and/or comments on the new tuning algorithm implementation.
> 
> [0] https://www.ti.com/lit/an/spract9/spract9.pdf
> 


> Judith Mendez (11):
>   drivers: mmc: host: sdhci_am654: Add tuning algorithm for delay chain
>   drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
>   drivers: mmc: host: sdhci_am654: Add missing OTAP/ITAP enable
>   drivers: mmc: host: sdhci_am654: Add ITAPDLYSEL in
>     sdhci_j721e_4bit_set_clock
>   drivers: mmc: host: sdhci_am654: Fix ITAPDLY for HS400 timing

These patches needs to have Fixes: tag as they are bug fixes IMO.

>   arm64: dts: ti: k3-am62a-main: Add sdhci2 instance
>   arm64: dts: ti: k3-am64-main: Update ITAP/OTAP values for MMC
>   arm64: dts: ti: k3-am62-main: Update ITAP/OTAP values for MMC
>   arm64: dts: ti: k3-am62p: Add missing properties for MMC
>   arm64: dts: ti: k3-am6*: Remove DLL properties for soft phys
>   arm64: dts: ti: k3-am6*: Reorganize MMC properties
> 
> Nitin Yadav (2):
>   arm64: dts: ti: k3-am62a-main: Add sdhci0 instance
>   arm64: dts: ti: k3-am62a7-sk: Enable eMMC support
> 

Can the driver changes be merged independent of DT changes? Or are they
meant to go together? Latter would be problematic as it creates cross
tree dependencies.

>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi      |  57 +++--
>  .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   5 -
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     |  45 +++-
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts       |  27 ++-
>  arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     |  44 +++-
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |   7 +-
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |   4 +-
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  17 +-
>  arch/arm64/boot/dts/ti/k3-am642-evm.dts       |   4 +-
>  arch/arm64/boot/dts/ti/k3-am642-sk.dts        |   2 -
>  drivers/mmc/host/sdhci_am654.c                | 215 ++++++++++++++----
>  11 files changed, 321 insertions(+), 106 deletions(-)
> 

