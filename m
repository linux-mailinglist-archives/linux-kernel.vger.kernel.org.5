Return-Path: <linux-kernel+bounces-155363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E18AE95A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFCA28798B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F6913B58D;
	Tue, 23 Apr 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wJwrCuZE"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1684135414;
	Tue, 23 Apr 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882188; cv=none; b=cDNeaG4JHGMsUoCVhQYhZwWnB4Oj6VivhPR6SvAfHC2Pjtv6/y1NIoncueFgjoJrjusfVh0zQpTKe/mXpm9kpMiwT8hBzK4XnaC8xo5dZqgBmB63lxrFFjhzQlaZlFnkJRBPmIIkWbFhoj7Rye6fRmBibCCdw6NrAk2oEigHy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882188; c=relaxed/simple;
	bh=PunYx+hyhPJwAfUXA99FVFET50b/2wwq8JPFJnbFN2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GDnDqceAdcYHBGs9fgBGYNBtOHfUzxq5SQTqZm4G6pS6Y9ps4l1UlBlkhc6RKEw73T4yxsivqyDURhj7gB5ymM1/HyatTTKJioyYPPS28TRXlN1soBGDSle7FaKLfoyNt7lBAXRp9mbc2EfQhiiMhTNOcdxhrR8Tt8ONJ7TxOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wJwrCuZE; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43NEMjKH042410;
	Tue, 23 Apr 2024 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713882165;
	bh=0s08x1heCD4VrAg93O2/+gMEE4S9jg0ddCdAwdHSMj0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wJwrCuZECLaXR6FXt4cB4jA9NEiOffGu6sP47W3NcEPAWjIEpKZIpPn0V1xESUjO0
	 WCs67tkkHefFR39u6/LECED+yituQwW4lnLjQcUrjfiXQbcwCFUmy1bqsyQ5EAptA+
	 ZDEnoWQnU3w7tRDcWOzBloLuH4i21JteBRqIg/5Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43NEMiTq008547
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Apr 2024 09:22:45 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 09:22:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 09:22:44 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43NEMiXM097230;
	Tue, 23 Apr 2024 09:22:44 -0500
Message-ID: <59c777d8-3847-49a0-b521-87cc54d0a25f@ti.com>
Date: Tue, 23 Apr 2024 09:22:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable UHS support for
 MMCSD
To: Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>
References: <20240422131840.34642-1-b-kapoor@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240422131840.34642-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Bhavya,

On 4/22/24 8:18 AM, Bhavya Kapoor wrote:
> Enable the UHS modes for MMCSD in J722S by removing the
> no-1-8-v property.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Reviewed-by: Judith Mendez <jm@ti.com>

~ Judith

> ---
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 78032caeb5fc..bf3c246d13d1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -381,7 +381,6 @@ &sdhci1 {
>   	pinctrl-0 = <&main_mmc1_pins_default>;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> -	no-1-8-v;
>   	status = "okay";
>   	bootph-all;
>   };


