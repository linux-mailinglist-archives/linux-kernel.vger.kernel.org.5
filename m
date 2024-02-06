Return-Path: <linux-kernel+bounces-54322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A63284ADA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2655E285CF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5E78695;
	Tue,  6 Feb 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aShxzpxi"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76677F12;
	Tue,  6 Feb 2024 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194545; cv=none; b=Te2OFHRa7Kdms5aBiDcjXj5FOg7cSqRUvhuzVUGtrUhN3+gKlRriL+tlqaIdh2ZByLc9SLt1LvUtJKZ8rdVtb9gVZoxd6TQa2PXD+bbRzL7GRX1iLldlN1UfEvuBvxBg98lj4W1ih7O+ugUuTt6DmusfgWAJQgAJzfjr4NehzWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194545; c=relaxed/simple;
	bh=fJefokdoxosbrsAG/SFfoJIcxTljV212fJf1SB1L6dM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=acbU34ASfDpEXfSu4rLokHV4ShJ9PLhZhdPP8zVktAd4EtxxUnbpowr7Lh4UpPw1XqV6VNjGwQL4xmTp+F0aObtmxKDTzkwCnAqjFQFgiwYS2AX4QKSq4AbAZGiuvHDC9MOM1SnMvdcZqbAg7kaHnqnaqKnpOf9Ksvo23IBqxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aShxzpxi; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4164gG0V018529;
	Mon, 5 Feb 2024 22:42:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707194536;
	bh=GhBSl6VGZebW2/O8K9Z7lTfCIghad3Q4DqkvUXm2Ckk=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=aShxzpxiDvcJQ4HWO6r1nL9pbqFFxoTHepkoxVphPGFbNolEUUsjjXWAEQFpa4ERd
	 4VVlkgt39IDb7zvmQnpKqho+SV9u3OGLy1cVe+5aQ5V9S8y1qKqOr6NSEEYWfzqClB
	 3X99N67paDWsqEFk70fF7noiSAbPUN48qfKZ1UU8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4164gGU0116573
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 22:42:16 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 22:42:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 22:42:16 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4164gCFO100557;
	Mon, 5 Feb 2024 22:42:13 -0600
Message-ID: <a1957347-7c23-42bb-9c62-e1276dd23c53@ti.com>
Date: Tue, 6 Feb 2024 10:12:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH 0/3] Add PCIe DT support for TI's J784S4 SoC
Content-Language: en-US
To: Vignesh Raghavendra <vigneshr@ti.com>
References: <20240129114749.1197579-1-s-vadapalli@ti.com>
 <ffeb1902-332c-445b-a16a-7fc293cad2eb@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <ffeb1902-332c-445b-a16a-7fc293cad2eb@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/02/24 20:05, Vignesh Raghavendra wrote:
> 
> 
> On 29/01/24 17:17, Siddharth Vadapalli wrote:
>> Hello,
>>
>> TI's J784S4 SoC has two Gen3 x4 Lane PCIe Controllers. This series adds
>> the necessary device-tree support to enable both PCIe instances in Root
>> Complex mode of operation by default. The device-tree overlay to enable
>> both instances in Endpoint mode of operation is also present in this
>> series.
>>
>> **NOTE**
>> This series depends on:
>> 1. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240124122936.816142-1-s-vadapalli@ti.com/
>>    for adding the Device ID in the bindings for J784S4 SoC.
>>
>> 2. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240129104958.1139787-1-s-vadapalli@ti.com/
>>    for enabling support for configuring the PCIe mode of operation,
>>    number of lanes and link speed when the System Controller node
>>    in the device-tree is modelled as a "simple-bus" which happens to
>>    be the case for J784S4 SoC:
>>    https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi#L45
>>
>> 3. https://patchwork.kernel.org/project/linux-arm-kernel/patch/20240125100501.4137977-2-c-vankar@ti.com/
>>    for fixing the "serdes_ln_ctrl" node in order to ensure that the PCIe
>>    lanes are mapped correctly to the corresponding Serdes Lanes.
> 
> Sorry, too many dependencies for me to keep track of. I am ignoring  the
>  series, please resubmit once dependencies are resolved.

Sure Vignesh. I will post the v2 series once the dependencies are met.

-- 
Regards,
Siddharth.

