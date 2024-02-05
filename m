Return-Path: <linux-kernel+bounces-52808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B222849CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ADD1F277A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725E428E1B;
	Mon,  5 Feb 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Znefeyf3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AFC171C4;
	Mon,  5 Feb 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142977; cv=none; b=elcCpLPH2tr0AZ6D58F5n7jXTxHbwyGucmGEBB7TvbPVdcWnANFGmh8QF/J7RZ5MMLSrPh+/1W3+gQJ0WVUBA4DLVYj+2HOY/w0dgsny+ynrX5ILIW3xtaB9459t5ExSCqVm7xhfn59uzpz7wB2VR5cgLQY1mfIK7BeobtG8h9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142977; c=relaxed/simple;
	bh=65ujZ1DYV3X7/22uLJnm1njhQ8m4e/tGfqAojqL3GWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TmQfCPzVjYiQ4HF7y9+NSFLtG0OJw6Ynh4QcoutMNea1XGJdXniNAtZ+wWk7wlcscUNCc26eT3uYCavsVbt8TOT9Pjs1d6vTUvi/HG4C1aKNcaYuI3L1rFDiRJSfw+CTRuIs84TtUID24gA1/k9KDWDy6pFMFPuJYtPgXmBS3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Znefeyf3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415EMgHT002462;
	Mon, 5 Feb 2024 08:22:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707142962;
	bh=+laNt+C2ZjaOH06Px1FbQ1grr0/4FsooJzicPJqGw7g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Znefeyf3c7jxj4AmmDbWLFXJqUGsA6mpMRdhDovo6PzqtOGcTtX2SfOoVzDozOEOb
	 pR6H0RTpuXPymyLS5tarDlaLjKWcchxGPr91lGjjkAb/PbwzgQNpRH0dECWG3dJHU8
	 bbsJMyc7DFnbEUhH/xCXubbJHGfVdMslIlJXv3Z0=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415EMgrX127045
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:22:42 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:22:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:22:42 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415EMcLf074610;
	Mon, 5 Feb 2024 08:22:39 -0600
Message-ID: <a7ff712e-0454-4c73-89a2-a507e4d34b1a@ti.com>
Date: Mon, 5 Feb 2024 19:52:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm64: dts: iot2050: Add support for new SM
 variant
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1704305544.git.jan.kiszka@siemens.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <cover.1704305544.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 03/01/24 23:42, Jan Kiszka wrote:
> Changes in v2:
>  - LED improvements
>  - factor out DP and USB3 dtsi files
>  - fix subject of last patch
> 
> This bring support for yet another IOT2050 device variant, see last
> patch for details. The rest is binding and refactoring to make that
> happen. Plus, LED nodes are improved by adding function and color
> properties.
> 
> This series needs to go on top of
> https://lore.kernel.org/lkml/cover.1699087938.git.jan.kiszka@siemens.com/
> 
> Jan
> 
> Baocheng Su (2):
>   arm64: dts: ti: iot2050: Disable R5 lockstep for all PG2 boards
>   arm64: dts: ti: iot2050: Support IOT2050-SM variant
> 
> Jan Kiszka (4):
>   arm64: dts: ti: iot2050: Factor out arduino connector bits
>   arm64: dts: ti: iot2050: Factor out enabling of USB3 support
>   arm64: dts: ti: iot2050: Factor out DP related bits
>   arm64: dts: ti: iot2050: Annotate LED nodes
> 
> Su Bao Cheng (1):
>   dt-bindings: arm: ti: Add binding for Siemens IOT2050 SM variant

Sorry, this doesn't apply cleanly on v6.8-rc1 or linux-next.
Please rebase.

-- 
Regards
Vignesh

