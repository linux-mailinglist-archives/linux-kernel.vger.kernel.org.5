Return-Path: <linux-kernel+bounces-59110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C684F158
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05B61F24BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98165BC6;
	Fri,  9 Feb 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="smibZTC1"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA7B8493;
	Fri,  9 Feb 2024 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467303; cv=none; b=sqb2BCr8ZMabhFX11PIwu5uFSNsxZnqDeYSDlMZCxVOw4W4dsns5UkVAv2Xm449YmnokP0ds4uNyN8OgGRm4S8qQd55q24DFQ568FG7qOnbyQ0yXi+MxK76k6/zv3ym2ZNdsdn+OW1QE3bIrX2pBAfujpjyDGdbcixIKp18NWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467303; c=relaxed/simple;
	bh=+QH+553GL+SWjO0XkO+qLFoo/G4FjOEM6rMs8ZmIinI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VRUBazyUcL53v/94qDo8+CyUgYCGDKbX+WJPRRjBdeK0Rr74gum3ginOdli4iBx3wgn73RhT1W0JCI34iu6I2OlXt0iO+Grm3cFdhuyLjlRwcSQ4dGemfBJtfYP0bb39Kenr3cKnclstEBzj4Gd9CFrSV8A0vJBZkgjhD4YcQh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=smibZTC1; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4198SBBa119876;
	Fri, 9 Feb 2024 02:28:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707467291;
	bh=i+ZqXAvXX2eRIpqy23tFyQ2Wt1ZQp9tSOqqUg7PIwAw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=smibZTC1NbIzgz3XEZ/CUyQZgyXIZOwznhwpFmAgt7xGmhrFtLk5Bam0rGqg/9P57
	 d3WamESEtTuXIRhjP8XsRYPR0G5bnQY7HF0bUHGEdMwHtGnpHq8UsF1J81XqwTelX4
	 HUyTbp2op6fcjcJNJwP1vI1LGjFx1GRairiVmq54=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4198SAWg023122
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 02:28:10 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 02:28:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 02:28:10 -0600
Received: from [10.249.128.244] ([10.249.128.244])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4198Rkh6056265;
	Fri, 9 Feb 2024 02:27:49 -0600
Message-ID: <f3548adc-4256-4b05-b072-631133bda4da@ti.com>
Date: Fri, 9 Feb 2024 13:57:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: ti: am65x: Fix dtbs_install for
 Rocktech OLDI overlay
To: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Vignesh
 Raghavendra" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Andrew Davis <afd@ti.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240208-for-v6-9-am65-overlays-2-0-v2-0-70bae3e91597@kernel.org>
 <20240208-for-v6-9-am65-overlays-2-0-v2-1-70bae3e91597@kernel.org>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240208-for-v6-9-am65-overlays-2-0-v2-1-70bae3e91597@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 08-Feb-24 19:21, Roger Quadros wrote:
> Add the overlay dtbo file to a Makefile target so it can be
> picked by the dtbs_install command.
> 
> Fixes: b8690ed3d1d1 ("arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya

> ---
> Changelog:
> 
> v2: no change
> v1: https://lore.kernel.org/all/20240126114530.40913-2-rogerq@kernel.org/
> ---
>  arch/arm64/boot/dts/ti/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 4a570dffb638..bfcc86ff8e24 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -57,6 +57,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-gp-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am654-idk.dtb
> +dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board-rocktech-rk101-panel.dtbo
>  
>  # Boards with J7200 SoC
>  k3-j7200-evm-dtbs := k3-j7200-common-proc-board.dtb k3-j7200-evm-quad-port-eth-exp.dtbo
> 

