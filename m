Return-Path: <linux-kernel+bounces-76148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B81D985F37C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7269D284312
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1392C697;
	Thu, 22 Feb 2024 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JfHC2e37"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43E101E2;
	Thu, 22 Feb 2024 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591973; cv=none; b=OOrMkm3b9/DotyeK2Ithbgynm9K+Y13IytYPzgEmAY7zpcA68hlsKpKFSwiTUkZGasQHrTjIsjsgsOwaxeUIlF3NXk5TkbMfP0y/krbqELNUan7za6wdPiFWDerErqaREcgQgDINpOOVnnQsUvLsZpamge97K9l8XlZF3uXYgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591973; c=relaxed/simple;
	bh=HhyIAFhfmYxvvQ4YbuD4UhydZwbAhPElw+ftsMDtJo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=imeLcKGqg9LCSOrRKQropsnseOkhmNiTSAIkdU5viQA7JoR9/oqCCVzGTgwk3KhYItmliO4YmsM1odCdSAMUSqo/KLbrkvxC1eXPFdqH5fm+w+PZi8tA4vM9ayABCBtqha9U1x3pkDzupzWUhEdK+6tmQ9zG6spNi6S4qsQBpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JfHC2e37; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41M8pXmJ112199;
	Thu, 22 Feb 2024 02:51:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708591893;
	bh=L+QH1DdyaG28pz3tpj2p29mGCa8LpdDYcKZjkRLnst4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JfHC2e37oo6no4i3H1nBhqabsjylgzpbxiFA4DUTTqSNQWjIrEKrACGzyMYwQROWp
	 Tg020/nItzMfC2EFmhGPS5hnG7w+uQBEBuYgPwww9TKCGIlqICBHIVDHNDrWGikVif
	 2D54ogy8dN2nwowv8FyqP6EzkDNFgneRS9cIQfxQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41M8pXp4094945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 22 Feb 2024 02:51:33 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 02:51:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 02:51:32 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41M8pSfi041056;
	Thu, 22 Feb 2024 02:51:28 -0600
Message-ID: <8a1efca0-9a63-472a-8c0f-0aeb3efa2baa@ti.com>
Date: Thu, 22 Feb 2024 14:21:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl
 compatible
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>
CC: <afd@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>, <b-liu@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
References: <20240205135908.54656-1-rogerq@kernel.org>
 <20240205135908.54656-2-rogerq@kernel.org>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240205135908.54656-2-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Roger,

On 05/02/24 19:29, Roger Quadros wrote:
> Add the compatible for TI AM62 USB PHY Control register. This
> register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
> is used to indicate the USB PHY PLL reference clock rate and
> core voltage level to the USB controller.
> 
> [1] - https://www.ti.com/lit/pdf/spruiv7
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     Changelog:
>     
>     v4 - no change. Added Rob's Acked-by
>     
>     v3 - add compatibles in alphabetical order
>     https://lore.kernel.org/all/20240201120332.4811-2-rogerq@kernel.org/
>     
>     v2 - New patch
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml

You don't have right maintainer in CC for this file.

> index 084b5c2a2a3c..9437705af92f 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -72,6 +72,7 @@ properties:
>                - rockchip,rk3588-qos
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
> +              - ti,am62-usb-phy-ctrl
>                - ti,am654-dss-oldi-io-ctrl
>  
>            - const: syscon

-- 
Regards
Vignesh

