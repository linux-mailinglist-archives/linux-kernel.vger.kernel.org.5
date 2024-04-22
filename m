Return-Path: <linux-kernel+bounces-154021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE28AD634
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF31282209
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433A1C68D;
	Mon, 22 Apr 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wfx9/GRZ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347921B964;
	Mon, 22 Apr 2024 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819446; cv=none; b=JkMx20nkoNsU4UDEg1w1Ao18WLSeefWIYlV5it8ULm/W5P3EfIVSrs9F4eDpT0bKg6F2pFmGW+8Z/pK7BpBslq6oaig/GImGeXo45cQ+WnVkBw5AKhK8K9ymBHP9nVeBKnAG3Kkcie8lHebJaRPbDaH5QFzsrZGYyGZIyVf4EcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819446; c=relaxed/simple;
	bh=+93zEKG0MLAVlcgnLU/ozv1ihPiNFvVWGhjV2JgYWrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAYXGY/tC0ArmLabkcDB9WT3JLp29Mrcew13/NPQ6InBgWqyIhX29qN4cXPkl9gE1df5zmLigOyhy5tLrV7uVfVMm5ZvaDelr8uaCz8D8pXb40F/iQtubkX2E45kuH99TKCG2ZKqHHuXkBgzrolAVcSpJLJhsBHKEV++GjWdRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wfx9/GRZ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MKvBgS050366;
	Mon, 22 Apr 2024 15:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713819431;
	bh=QaOor3HniTIs7NtEedNAHcOa6F+c28nHm4cWdMeXink=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Wfx9/GRZZrl5cekvN+IVcQN9r+7aioNSJP2TrmoYJxRuS/nLHiaN4Lte69QPuh9ir
	 aNHbGdhjB6dXau+rK8VOloUtszpKyHt4D0AWsuVBRWsrRZZnG30zyfuTAUSFGUWhBr
	 PthIrwZ59Ao1wvBQiKRYjOeOz9dAR5lbh/aFHZxQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MKvBl5018442
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 15:57:11 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 15:57:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 15:57:11 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MKvBOg064947;
	Mon, 22 Apr 2024 15:57:11 -0500
Message-ID: <1a5e719f-efa0-4c60-8add-ef7c0464d1ce@ti.com>
Date: Mon, 22 Apr 2024 15:57:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jared McArthur
	<j-mcarthur@ti.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Deepak Khatri
	<lorforlinux@beagleboard.org>
References: <20240328191205.82295-1-robertcnelson@gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240328191205.82295-1-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/28/24 2:12 PM, Robert Nelson wrote:
> This board is based on ti,j722s
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> ---
>   Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index 52b51fd7044e..ca23b7e6a35e 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -134,6 +134,7 @@ properties:
>         - description: K3 J722S SoC and Boards
>           items:
>             - enum:
> +              - beagle,j722s-beagley-ai

Recommend "beagle,am67-beagley-ai". The "J722s" is the family
name, the part used on this board is the AM67. We do the same
for the SK boards, for example, the SK-AM69 uses the AM69
part from the J784s4 family, so it is called k3-am69-sk.dts
with compatible = "ti,am69-sk", "ti,j784s4";

This would otherwise be the first board with a specific part
attached but uses the SoC family name instead of that specific
part name in the DT file/name. Only the EVMs should have the
family name since we sell versions of those with all the different
parts swapped onto it. I don't imagine you will be selling
BeagleY's with TDA4VEN, TDA4AEN, DRA82x, etc.. All your
docs and other collateral use "AM67", using the same here
would help avoid confusion.

Andrew

>                 - ti,j722s-evm
>             - const: ti,j722s
>   

