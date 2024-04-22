Return-Path: <linux-kernel+bounces-153441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D3A8ACE22
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43B01C211AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD3F14F9C9;
	Mon, 22 Apr 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="txIj96E5"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275FD14F137;
	Mon, 22 Apr 2024 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792414; cv=none; b=IBIr0E9GHS2Pw1jXxvfwYqWOtzQdoMeAJOfHsGkREvXjcXLjCB5daf1JVDywaXhSvWiNDWUk2gvEPctfxJSeDZudlEf7skAoKeDe6Z9fs1TWzV4oAMUWEjnhXQrPimPmxAWmmCQRBIQjmPWWr3y9aJypMHZXHksHL2ttKvPp7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792414; c=relaxed/simple;
	bh=rltMGq55ARZCc37gtRnzHBu4Sdh7LfDHlvboSSNO8nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MMWC1aJVTNiWFe4zTYjJsx0R48qA4xv6FsyeT1VDZie7BI9+xRsbZI/wrVMVhhHap1ps0DA894zT6rY7GWJwBvkIYDyhyflDoVsR1kqcZ3sRbMJbFrY29pK93kYuqtT0Ww81cJPLj4GVqNGkFsAiTKj1zzHOCcalk1pTZY14iH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=txIj96E5; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MDQZnT060509;
	Mon, 22 Apr 2024 08:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713792395;
	bh=ukr4TzCuGsbPIJk7tc4dQhxJsKRvx8Mk1fvZwSXwZto=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=txIj96E5Cp7FJQ/3Zjjqya7hKATW7+gSNs7IPDTB/Ns/1euUjusLlIpdcnHEzPi6G
	 v6TdY3rEh9ucchQvSOeJgR89XupJba70emFwNp9MG+vm0ZpsvBjo4IyhqxSggc25Ei
	 uacPvkBPBjJWXaGQLCmaYp2JYp9CoPfDqcXGatNI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MDQZcm103248
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 08:26:35 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 08:26:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 08:26:35 -0500
Received: from [10.250.148.22] ([10.250.148.22])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MDQUws090835;
	Mon, 22 Apr 2024 08:26:31 -0500
Message-ID: <f9b80c20-b15b-470e-a7e4-888ef9f5e8ac@ti.com>
Date: Mon, 22 Apr 2024 18:56:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-evm: Enable UHS support for
 MMCSD
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <robh@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, Bhavya Kapoor <b-kapoor@ti.com>
References: <20240422131840.34642-1-b-kapoor@ti.com>
Content-Language: en-US
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240422131840.34642-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 22/04/24 18:48, Bhavya Kapoor wrote:
> Enable the UHS modes for MMCSD in J722S by removing the
> no-1-8-v property.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
Rebased to next-20240422
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index 78032caeb5fc..bf3c246d13d1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -381,7 +381,6 @@ &sdhci1 {
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	ti,driver-strength-ohm = <50>;
>  	disable-wp;
> -	no-1-8-v;
>  	status = "okay";
>  	bootph-all;
>  };

