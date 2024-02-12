Return-Path: <linux-kernel+bounces-62103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F0851B86
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158A1287187
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93633F9D3;
	Mon, 12 Feb 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vY9es+EJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F003E47E;
	Mon, 12 Feb 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759117; cv=none; b=NdH1dYi8CZi45+Ivh4vszTLwhpsYNs1VUSl+OkLxI1wt4DPJFjnpXN8dt9zlHdiTZMPvYEbk5HaavLbddgjfBrXSzHt4mtJjcOfXeH74cgxpKgnmTo8z8RjQDhA2xPr2xiBsNGAG0neqeWGWGarjFvAjC0e8a4soZXUF4q8+skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759117; c=relaxed/simple;
	bh=sF6cd8C0cBwlhyJJQ2WkNoocSKv51Tl2cyBRWYinPoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mYXKXe4aNFOI5IXe+1+fLyvetb+44M/LTtVsi2V3kmJKJqwOtqnza07RlmJCmWKQS0AkNKRxq6dAbVL9SrzUGJsETu1XpT9hQzwGv4ljYarqbQp8OhbptPesnaP89b2fk0sDJVZ391GnFwJHeHoGR0FsrNiouAPGslhbqtukUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vY9es+EJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CHVb0B072153;
	Mon, 12 Feb 2024 11:31:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707759097;
	bh=qFz9E77b4ViF9Ae4NJ5AyukglGb22Hx5MYZrPMtvh8U=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vY9es+EJTElRhv974rrJFZCjZneMsLhdE0IM/fc1iNCLJG9qz97PTFf6R8EEQZsCB
	 hG5l1CtT1c8LQRGEgrCKKOiTW5yDKe/cL/dZxFAsaV+nJk0ik5hl2dFYcpfbX690W+
	 x+kxxMBJQLYJcp/VWNtkVZ8PYHZ86Vg8aQy4rA+4=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CHVb9r021585
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 11:31:37 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 11:31:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 11:31:36 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CHVagU066580;
	Mon, 12 Feb 2024 11:31:36 -0600
Message-ID: <22af7436-8833-4049-bdbb-f79bb3314ee8@ti.com>
Date: Mon, 12 Feb 2024 11:31:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fix MMC properties on Sitara devices
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207225526.3953230-1-jm@ti.com>
 <20240211154411.GA3360@francesco-nb>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240211154411.GA3360@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 2/11/24 9:44 AM, Francesco Dolcini wrote:
> Hello Judith and TI folks,
> 
> On Wed, Feb 07, 2024 at 04:55:17PM -0600, Judith Mendez wrote:
>> This patch series aims to add or fix MMC properties:
>> OTAPDLY/ITAPDLY.
>>
>> The DLL properties ti,trm-icp and ti,driver-strength-ohm
>> should also be updated since only AM64x and AM62p devices
>> have a DLL to enable, so remove these properties when not
>> applicable.
> 
> Do you have any reference regarding this change? TI reference manual or
> anything like that?

I believe there is no specific documentation that states outright that
these device tree properties are not applicable for devices like AM62x.

There are a few hints in the device datasheet and TRM, if the MMC PHY
has a DLL to enable, DLL properties should show in both docs.

Also, you can read the MMC bindings doc description:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree
/bindings/mmc/sdhci-am654.yaml#L179

> 
> No change needed in sdhci_am654.c? It seems that `drv_strength` is written
> to some register unconditionally, is it ok to do so?


Actually, we only write this value to the register if there is a DLL
to enable. If we have this property in device tree for devices like
AM62x and AM62ax, this property is ignored in the driver. So I am
removing this property from device tree as part of the effort to
clean up MMC nodes in device tree.

> 
> Do this change implies that there is no way to configure the drive
> strength on such SoCs and MMC/SD trace impedance must be the nominal
> 50ohm?

We do not support changing drive strength for these devices. My 
understanding is that the drive strength should default to about
40 ohms, which should be good enough for any eMMC operating mode.

~ Judith

> 
> Thanks,
> Francesco
> 


