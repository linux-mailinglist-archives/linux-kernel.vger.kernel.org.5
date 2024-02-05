Return-Path: <linux-kernel+bounces-52830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938C849D27
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF001C2201B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7502C6A9;
	Mon,  5 Feb 2024 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UP0EPS4B"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF56E2C1AF;
	Mon,  5 Feb 2024 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143751; cv=none; b=Ze7E+e1Uvh+6coSQglUUTiRC8AM5oz0haqRSZGJmkYKl7muX1tbN6Kr+ZGEZYbPKFJV2O9EFvO6xbevxfsQFcryRFzMKSm8Lh/mpPcnuTNqbM04YoDcJNwCnYE91vytiPnFgbn3fky4XnYFkrhi1LBYHnEOHeGj1xqaVYo3C3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143751; c=relaxed/simple;
	bh=VftlQV/0Nz85qEFGVCEfbLKWEzmB59s/VkZg4x/j3xA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HbxRkO+o5/qhU1wXbfwmgxIMF372RdMEHjroI1KKqlcKCAIymSzlzBeqnAnxb+/YomCfOF6xpGv+p5XcmI3FKxhynVBnnMjsPi6AS7hNp9T7uPWlj9mWf09ToI8IGBGbd55O9+0jelDSD7Wy8OFqV0qgqzjmG9rQl6NZOxo86as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UP0EPS4B; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415EZXBQ055004;
	Mon, 5 Feb 2024 08:35:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707143733;
	bh=xwgxhraPwsNiLY+gig+/w1kE47Cnd1dvjtVmfSWQiro=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UP0EPS4BcD9ePs1z/3PUVle9Ti0xd08fKUonSkq2W/4q4GApym58zrwIdG9hxoEBb
	 qqsEdSW9TfFpGCi24ikEhQ7u0Zrd8kD7YxD7exGw6YDkXFeAFJ4I6XOdYhhi7Kl58+
	 pDFQZkOUyDzi0LvJ0Ok0y4vnst9Nd8NyFFDSxXr4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415EZXpO122232
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:35:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:35:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:35:32 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415EZT4B093484;
	Mon, 5 Feb 2024 08:35:29 -0600
Message-ID: <ffeb1902-332c-445b-a16a-7fc293cad2eb@ti.com>
Date: Mon, 5 Feb 2024 20:05:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add PCIe DT support for TI's J784S4 SoC
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>
References: <20240129114749.1197579-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240129114749.1197579-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 29/01/24 17:17, Siddharth Vadapalli wrote:
> Hello,
> 
> TI's J784S4 SoC has two Gen3 x4 Lane PCIe Controllers. This series adds
> the necessary device-tree support to enable both PCIe instances in Root
> Complex mode of operation by default. The device-tree overlay to enable
> both instances in Endpoint mode of operation is also present in this
> series.
> 
> **NOTE**
> This series depends on:
> 1. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240124122936.816142-1-s-vadapalli@ti.com/
>    for adding the Device ID in the bindings for J784S4 SoC.
> 
> 2. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240129104958.1139787-1-s-vadapalli@ti.com/
>    for enabling support for configuring the PCIe mode of operation,
>    number of lanes and link speed when the System Controller node
>    in the device-tree is modelled as a "simple-bus" which happens to
>    be the case for J784S4 SoC:
>    https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#L45
> 
> 3. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240125100501.4137977-2-c-vankar@ti.com/
>    for fixing the "serdes_ln_ctrl" node in order to ensure that the PCIe
>    lanes are mapped correctly to the corresponding Serdes Lanes.

Sorry, too many dependencies for me to keep track of. I am ignoring  the
 series, please resubmit once dependencies are resolved.

-- 
Regards
Vignesh

