Return-Path: <linux-kernel+bounces-61089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4E5850D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB075B23050
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894846FCA;
	Mon, 12 Feb 2024 04:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tY8/JvBP"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA026FBF;
	Mon, 12 Feb 2024 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707711061; cv=none; b=nmNQmMcK5BugrVGmYzs29CFAD2W6l13HnSOFs1Qisk/SGGkaJfeqmP5w7c1DxzPbVGKL/PLc1PG40yel2tG3hukEEEp2FFGPD0bdp6s2wSsJCbmOToXNWUfwn38PiM7vt1Hd9svW4FJ5ykycNjA21kLCZ2VcEJyUj+I3Oi8HBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707711061; c=relaxed/simple;
	bh=AX+o0JnqtMI2XzlPE3EyRlmUfPtaB6Tip9MGV6o16pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W9Ykk5XuhC8U4LgJ4tkjwzQuBMBGGo34zqeV/Ny6Ab3iFtVquFCFdOwTvY1OVmbEFfzKZL94oMSnvDdvXoWMyT2PDU5L4JLFVO7r9okBVnGThR1GRTs5wdog/7jYsHDDNuKX+OjjUMVW8L3uDP9kkMj4QKVYrEMiXBh6snIhL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tY8/JvBP; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C4ANMn038175;
	Sun, 11 Feb 2024 22:10:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707711024;
	bh=xLHO//KwhnZEjV6AuR2VlOJ6LDEJagIspJgvME7YXEg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tY8/JvBP/9Jx9hhd/+MLEYB0yB+JTmvx1HqOJ91y1STI3/XN9reskNfvrnI/WYvqM
	 Q4+YsR16FBka8n+5ztLdIwTy7+GtO7Ib12QHlJhwXP6efYhAC5fQHI0g9n0FKerW+Y
	 yonkbWkf1XeGGQrhMRhtIrxWXvLTf/izlimZkdxc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C4ANED036766
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 11 Feb 2024 22:10:23 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 11
 Feb 2024 22:10:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 11 Feb 2024 22:10:23 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C4AI0F101679;
	Sun, 11 Feb 2024 22:10:18 -0600
Message-ID: <359993c5-3387-443c-8cef-30ee7ad1f521@ti.com>
Date: Mon, 12 Feb 2024 09:40:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar
	<danishanwar@ti.com>, Andrew Davis <afd@ti.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Josua,

On 11/02/24 20:37, Josua Mayer wrote:
> This series adds DT bindings and dts descriptions for SolidRun AM642
> based SoM and Hummingboard EVB.
> 
> Additionally a commit from downstream vendor kernel are included,
> enhancing support for pru based ethernet.
> I wasn't sure how to properly annotate it in commit description /
> signed-off area ...:
> 
> 1. add description for "Industrial Ethernet Peripherals" (IEP) to am64
>    https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/arch/arm64/boot/dts/ti/k3-am64-main.dtsi?h=ti-linux-6.1.y-cicd&id=5afb73d82a014b59462162d960b350b8c58e5ae6
>    IEP is already supported in-tree by a driver, and used in
>    k3-am65-main.dtsi.
> 
> Unfortunately dtbs_check reported many problems, I put some remarks:
> 
> - 'mux-controller' does not match any of the regexes
>   The expectation seems to be that a mux-controller at minimum has an
>   address, something to put behind an @. However this is a gpio mux, not
>   sure how to name it better.
> 

I don't see this warning locally. Are you using updated dt-schema? reg
is not necessary gpio-mux as per gpio-mux.yaml

> - unevaluated properties: interrupts, interrupt-parent
>   sensors and flash yaml are missing interrupt descriptions, but these
>   parts definitely have an interrupt signal in this solidrun board.
> 

Please add them to appropriate schema as necessary

> - wrong names for pinctrl nodes
>   Other TI DTSs consistently end with *-pins-default. Should a different
>   naming convention be used?
> 

No, pinctrl nodes need to end in -pins. All TI boards have been updated
to new schema [0] and sysconfig tool on dev.ti.com/sysconfig generates
appropriately. Please fix


> - cdns,phy-type required property
>   inherited from k3-am64-main.dtsi
>   there is a PHY_NONE value in dt-bindings/phy/phy.h,
>   but not allowed in phy-cadence-torrent.yaml
>

Sorry, I didnt get what's the issue wrt cdns,phy-type ?


Note, I really don't want to accept patches that add new dtbs_check
issues especially for nodes that already have YAML bindings. Please
update the .yaml files as necessary.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a49568115143435390f20965902809471b6f830c


-- 
Regards
Vignesh

