Return-Path: <linux-kernel+bounces-70705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC3859B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFD0B21484
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD2BA4D;
	Mon, 19 Feb 2024 04:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cdf4Yrh2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A067FBFA;
	Mon, 19 Feb 2024 04:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708316586; cv=none; b=ZYpMcd4DY1K2Em84uvSpsUvZZKMwSy33Z8L6842fQv+dXEw1RAw9m2ZsTt2DqTqXx3Q1HUOZm9hbjB2q7DIYGJfo6H4S1vPdL5nCP9YzaTwg5UcOJMh4UzgoXencyITNDQAtqEYu1Y04Q3A2B76Kc7RStmX5nSR5Kpi5iK3ePVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708316586; c=relaxed/simple;
	bh=5DFmnihUuoK8BqdPhuRxH5vmbYynV/5WlY/vetuvZBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EtCxOmr2fyUhE8DHf9KLxyX0et5N0Q2l4mII4WaGfZsExShw8d/4rhvK6h+xyw4/X5VjdBSSr+69eqL24w0lxOmjqVkDx4dCYHhYEats78boU8UMhMj2vbBUUkQTF92iiEZ7NXGWQvFr5sVpRJXUSPunc5ljfT3QbaVyCuWwl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cdf4Yrh2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41J4MPrS026144;
	Sun, 18 Feb 2024 22:22:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708316545;
	bh=5DFmnihUuoK8BqdPhuRxH5vmbYynV/5WlY/vetuvZBI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cdf4Yrh2SGmdXF2pwv3rN2HwMG6RC96dR0f0Qp2ZIaYL8dlLBNXMoy/Mn5Qvhc4Bk
	 SiV54RxMI3B5ZpejAq3FGAzQHKdSv71QD7HTlHFknCAhoGoxdAjkQ77w3O0hwqwNMi
	 UP9bf2iy/bNIX4GE667hIXzALBFwyr1PGwohPkXc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41J4MPf4010989
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 18 Feb 2024 22:22:25 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 18
 Feb 2024 22:22:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 18 Feb 2024 22:22:25 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41J4MJvf018270;
	Sun, 18 Feb 2024 22:22:20 -0600
Message-ID: <bd93e51b-70ec-4cd4-88a3-1c79a0e3c75f@ti.com>
Date: Mon, 19 Feb 2024 09:52:18 +0530
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
 <8aa96c66-d054-4b33-8972-f9faf2e84482@ti.com>
 <c37af45e-def1-4a97-ae01-e00e5b22eb23@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <c37af45e-def1-4a97-ae01-e00e5b22eb23@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 18/02/24 19:48, Josua Mayer wrote:
> Am 13.02.24 um 07:12 schrieb Vignesh Raghavendra:
>> Hi
>>
>> [...]
>>
>> On 11/02/24 20:37, Josua Mayer wrote:
>>> ---
>>> Josua Mayer (4):
>>>        dt-bindings: arm: ti: Add bindings for SolidRun AM642
>>> HummingBoard-T

This goes via TI K3 arch tree

>>
>>>        dt-bindings: rtc: abx80x: convert to yaml
>>>        dt-bindings: iio: humidity: hdc20x0: add optional interrupts
>>> property
>>>        dt-bindings: mtd: spi-nor: add optional interrupts property
>> 2/5 needs to go via RTC subsystem tree. Could you split it out into its
>> own series when you respin
> Only rtc, or should I split out the other two as well?

Split others too. RTC, IIO and SPI-NOR related bindings should go via
respective trees. Please post them individually to appropriate lists.

Regards
Vignesh

