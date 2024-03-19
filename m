Return-Path: <linux-kernel+bounces-107186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BA87F8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58AA6B21D51
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3767C0A7;
	Tue, 19 Mar 2024 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aEEyo48g"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEB54775;
	Tue, 19 Mar 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835245; cv=none; b=Y2NmLeC1JfhsCeM8OdEoBFK/0yauVX8nAGpWg2+fyfaUl4O9XQPZs9lpGPQA8IEcLwpmcEXXYpGp459pOzGgWhj/JbXII/T+cTJLzx8LGkqMX1MjO+3xWwh8H/ALRwYTTUnRz6vvugAJvRK0FPSPo+uAW9Lfx1H8Rz8TotSjjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835245; c=relaxed/simple;
	bh=DFm94adZYPQ2FWCpzK3RGccm1VoFml8OfF+X802TMVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pxgehc+eb0SUloSyT+IE/5wGYvtwaaxSamnsylvykTb8lxcSttYbx/JcONh+a+eF/S8uG301P1tAQl9CX9p55PRBLeNsKW2AER0qrYzIYDkLL5vPjDIWxeOxQmz+L3v4YvE9uJP5WgDaMe7tilbYfGm+yw7a/Vh52rWiqwIaE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aEEyo48g; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42J80FWC092170;
	Tue, 19 Mar 2024 03:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710835215;
	bh=9BEueWubpZ1GK0+Nc3P+zNaaOc+f91SzBDXWy6ZORfg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aEEyo48gxaSAQ2pAb8GWa2VA6aCfE6m6OgzgjUPXkWe7xEziOpPImJPnyGCOBtakI
	 hymW6eXeFf969H04TD5o7sJ7fbjmiyl5vic+JCdD0uQ3IGjzZqr66PUxkDpmMgZKak
	 A/Dr8kgkBSQEtWUdxQpkzY02rB1qv5qpeMdiewI0=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42J80FAf003342
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 03:00:15 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 03:00:15 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 03:00:15 -0500
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42J8084O124565;
	Tue, 19 Mar 2024 03:00:08 -0500
Message-ID: <c2579b14-eb2a-4479-b5c4-86f74a4349b1@ti.com>
Date: Tue, 19 Mar 2024 13:30:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
CC: <jkridner@beagleboard.org>, <robertcnelson@beagleboard.org>,
        <lorforlinux@beagleboard.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Derek Kiernan
	<derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann
	<arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/TEXAS INSTRUMENTS
 K3 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
        "open list:SPI
 SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM"
	<greybus-dev@lists.linaro.org>,
        Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-5-ayushdevel1325@gmail.com>
 <06009676-6189-40b9-a6d6-66a112e4f387@linaro.org>
 <89ec1649-5231-422e-9760-6e04b2a514fd@gmail.com>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <89ec1649-5231-422e-9760-6e04b2a514fd@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Ayush,

On 19/03/24 12:17, Ayush Singh wrote:
> On 3/19/24 11:34, Krzysztof Kozlowski wrote:
> 
>> On 17/03/2024 20:37, Ayush Singh wrote:
>>> DONOTMERGE
>>>
>>> this patch depends on Patch 1, 2, 3
>> So none of your work should be reviewed? I don't understand this, but in
>> such case I am not going to review it.
>>
>> Best regards,
>> Krzysztof
>>
> I am a bit lost here. It was mentioned in the patch v3 that I should 
> specify the interdependence of patches in v3. And now you are saying I 
> should not?
> 

It was mentioned in v3 that patches that are independent should be sent 
separately to the particular subsytem list and the dependencies should 
be mentioned in this series, still in this series you have combined SPI 
patches/platform DT changes along with the mikroBUS driver patches which 
creates confusion.

This is what I mentioned as a response to your v3 series regarding 
adding the patches

"The reasoning behind this is that these patches go in to separate 
maintainer trees and without the bindings merged first the device tree 
changes cannot be validated, thus it is a usual practice to get the 
bindings and driver merged first and the device tree changes to go in 
the next cycle. Another alternative is you can point to your fork with 
all the changes together."

My suggestion was to get your series with the bindings and the base 
driver support accepted/ready first and the send the platform specific 
DT changes later. The rationale behind pointing to your fork with all 
changes is to have all the changes (w1 EEPROM, instantiating remote 
mikrobus ports over greybus .etc) together and ensure there are no 
conflicts with the base series.

It looks like you have put DONOTMERGE on random patches (why is patch 3 
and 4 marked as do not merge?)

Thanks and Regards,
Vaishnav

> Here is the rationale for the dependence:
> 
> 1. Any changes to the property names in dt-bindings patch 1 will need an 
> appropriate change here.
> 
> 2. This patch will fail to build without patch 2.
> 
> 3. This patch will fail to build without patch 3.
> 
> 
> Ayush Singh
> 

