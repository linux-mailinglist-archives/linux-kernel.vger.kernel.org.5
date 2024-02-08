Return-Path: <linux-kernel+bounces-57681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BF84DC25
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2D1B22EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2064B6BB4F;
	Thu,  8 Feb 2024 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="F9T3NV7s"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C96BB2A;
	Thu,  8 Feb 2024 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382697; cv=none; b=Ws3l4JijacEDYbzguVQqu1smqbi8eW+veNU9ESukB9Ksto2RPeWun1MX3H9a/gqtEWgsKykuOKpDuCI65NUK1CfOG3hy3GgOekwjpACoZ1EChOaV6P2uzbUDsnXYV6CWADtIwEhXskSn4un8bOWRmG6L1VmoD6USpoxPwXYwxTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382697; c=relaxed/simple;
	bh=kI9j7iBEd96eElLpI/6TbzKOlcN8Y0JMueTGYYnQrt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eC+k3pHgl+96hvE8XRddt+izEy4lOZQwKacFCT8hulK1yvNLHJBDM8uOxfmmmaGApCYy74LfSOI8GMZRSaJOJbd3ilGWn1Xp/ywIbYqnICqk8v5ELpAeyJRTUC6rTrcLzYKYWyFiQAo8Yvltf27VG3whUNakwPD0qmTRIEw46i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=F9T3NV7s; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4188wAPd024440;
	Thu, 8 Feb 2024 02:58:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707382690;
	bh=cypFUdIfHaTakYLY0/w4t+OklF5LtH+YZtKbMyrpG+o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=F9T3NV7sdbPnnsNSizDN5T+GX3p3gFFLXc/SBH7S73hSxq1DOuTqQPNXUGHlos6jh
	 r3B/rwri099/ZxyjltBQTLcXDanYwNeXKXxKY817Fk8MuIxVrFIyCRtkltmb8DdHAO
	 0/t4MTn4Ty+3gzupeV66gA/CUPgqV7h6bDJZE16w=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4188wA9r057886
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 02:58:10 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 02:58:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 02:58:10 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4188w6RD049373;
	Thu, 8 Feb 2024 02:58:06 -0600
Message-ID: <d6bdb2e7-56f0-4f7d-afbc-a12ba4c5fd4b@ti.com>
Date: Thu, 8 Feb 2024 14:28:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce J722S SoC and EVM
Content-Language: en-US
To: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 06/02/24 15:36, Vaishnav Achath wrote:
> This series adds basic support for J722S family of SoCs. Also add
> J722S EVM support with basic peripheral like MMC and UART.
> 
> TRM: https://www.ti.com/lit/zip/sprujb3
> EVM Schematics: https://www.ti.com/lit/zip/sprr495
> 
> Bootlog (6.8.0-rc3-next-20240206):
> https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371
> 

I missed to add link to V1 here, this a V2 of the below series with the 
feedback addressed:

https://lore.kernel.org/all/20231213124930.3012-1-vaishnav.a@ti.com/

Thanks and Regards,
Vaishnav

> Changelog:
> V1->V2:
>    * Address feedback from Nishanth to reuse from AM62P5 dtsi.
>    * Remove bootph-all from root nodes.
>    * Change License to GPL-2.0-only OR MIT as followed for other
>      K3 files.
> 
> Vaishnav Achath (3):
>    dt-bindings: arm: ti: Add bindings for J722S SoCs
>    arm64: dts: ti: Introduce J722S family of SoCs
>    arm64: dts: ti: Add support for TI J722S Evaluation Module
> 
>   .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
>   arch/arm64/boot/dts/ti/Makefile               |   3 +
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 251 ++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j722s.dtsi          |  89 +++++++
>   arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
>   5 files changed, 352 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi
> 

