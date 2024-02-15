Return-Path: <linux-kernel+bounces-67353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E74856A55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DE91F21D42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758B136676;
	Thu, 15 Feb 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MofzPKt0"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBD135A70;
	Thu, 15 Feb 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016237; cv=none; b=ElpKeiNLjH1N2czjp+Rt86L+CbjSzdEPXjwZU2jWNyNYI6yLF6/7wvnFcPxcBMqVCB7zBprYs1spkRb8CZAIjuGVfvInMK/JVPwlvcBr7/oJkKlG8GOfJSjb2lO5dsqlKtAOCRtg2uQ7yG04jq/9AuNjWHNCaX5kAo/2EdaHdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016237; c=relaxed/simple;
	bh=Teovor+0cNBgqv0pxvlZZTXnZq+NJs8jQr9ByH5s71c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XQzlZQBE1HzHurjTPDWfQu7DLqbIpgIuCcvjEOPwebxZPXXseNDWv5Bdxy21eKyPiiUBYCOHTDPGVXkdt3Jh/rQDEBz6MdtCaWD6NzST5Zz+CTQ4ptiT0sIXxOJ9S8BvOXtmj7fX/J9ms1cOycvkvWHCz9rFHecGQmgxi6/hetU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MofzPKt0; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FGv4Df063872;
	Thu, 15 Feb 2024 10:57:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708016224;
	bh=Z4RnqGGznCJSeFLUCS/wbnFfpLvync7aTHoThMZ9qH0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MofzPKt0R/Z7VHhjt58hopkb1FITPJbseGGzei/F6gfjbEsn2D0dNokIi8ADOD8hl
	 ITpiHJcL9aB6xugaxTFoKG2SFUozVM1uQGhJlamBrN7F3ft8MrSqFO9JbYp4o7wmI9
	 z9+jk4DnwVRyu+iw3wcKTEUTDP2QQfVvjKYbdndU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FGv48Z057710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 10:57:04 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 10:57:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 10:57:04 -0600
Received: from [10.249.135.225] ([10.249.135.225])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FGux4V066060;
	Thu, 15 Feb 2024 10:57:00 -0600
Message-ID: <4ef87f6c-caa8-45a8-8649-422806ec6eb2@ti.com>
Date: Thu, 15 Feb 2024 22:26:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am654: Drop ti,syscon-rgmii-delay from
 ICSSG nodes
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20240215105407.2868266-1-danishanwar@ti.com>
 <71adaabd-bb24-4181-9fdf-f7191e93edb5@kernel.org>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <71adaabd-bb24-4181-9fdf-f7191e93edb5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 2/15/2024 9:27 PM, Roger Quadros wrote:
> 
> 
> On 15/02/2024 12:54, MD Danish Anwar wrote:
>> Drop ti,syscon-rgmii-delay from ICSSG0, ICSSG1 and ICSSG2 node as this
>> property is no longer used by ICSSG driver.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am654-icssg2.dtso | 2 --
>>  arch/arm64/boot/dts/ti/k3-am654-idk.dtso    | 4 ----
>>  2 files changed, 6 deletions(-)
> 
> What about the DT binding document?
> 

Now I am only removing the property from device tree. Once this proprty
is removed from all DTs, in the 6.9-rc-1 I will remove the binding as
well so that net people can merge that without getting any errors /
warnings.

-- 
Thanks and Regards,
Md Danish Anwar

