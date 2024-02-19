Return-Path: <linux-kernel+bounces-71502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECD85A646
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B09A28383E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEB02EB10;
	Mon, 19 Feb 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tAevtZO+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929C1DDD5;
	Mon, 19 Feb 2024 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353990; cv=none; b=O+TG7oWNe4WQzLp4kS9qCBcLbgKe4zU8pATpO2LZoFCrEehDHHKmEekoxVYYg9jJmrnGjbsc7IbRjyU/v2fJR72cATZqaBuj9se/sLlRbSHbn/Q/0rgqyyjHgJ0JFrvkqkaOXkvn1GE/udDGREyLxYYIQ8RPtLaty6dAq4owa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353990; c=relaxed/simple;
	bh=YIqvmNc3o3Upt/WX98hfSyCNITS3wfAVQH75uWmAsS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b1B1pphcwB+E491Qi2uW8pdmrfbC9FbXD36CXJEYPaNKAd4E+FQU9u3U0NI5oY2Ij+bCIUpt0mXTuQQZ4I011fiO9wzgm/1zRkqnLof1inquX18EAUlRuxo1NlKV7DsCVv4XLFHdlBH/hYURt4D9j1EMxzgzaCOf678RQaBlLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tAevtZO+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41JEkLop029033;
	Mon, 19 Feb 2024 08:46:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708353981;
	bh=IfkOakzQQy4AWxHgusHLHI+edDwwtB95rghAc1wFV50=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=tAevtZO+Nql9zUEsfW3XUqi7zznxX+tumQXxYV/RbWOr4ev6CwGd8yZXTFmxJmzhW
	 7NUc6/QHRct+WWuDAvpHXhjNKM4Uo5fXNaZKSFsnVFx7URuT7Aqg0HV+L1bNr+PT/H
	 G00iVoZPzX/xe0P5mToqp5ewSHXQoyJiUSoFtPOI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41JEkLc7088817
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Feb 2024 08:46:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Feb 2024 08:46:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Feb 2024 08:46:20 -0600
Received: from [10.250.151.109] ([10.250.151.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41JEkEXR096528;
	Mon, 19 Feb 2024 08:46:15 -0600
Message-ID: <be8be773-7ba0-4a08-af87-20ff9a830b27@ti.com>
Date: Mon, 19 Feb 2024 20:16:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add OSPI and Ethernet support on J722S EVM
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>
References: <20240219090435.934383-1-vaishnav.a@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240219090435.934383-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Vaishnav

On 2/19/2024 2:34 PM, Vaishnav Achath wrote:
> Hi,
>
> This series adds support for Ethernet and OSPI NOR flash on J722S EVM.
>
> V1: https://lore.kernel.org/all/20240216135533.904130-1-vaishnav.a@ti.com/
>
> Changelog:
> V1->V2:
>    * Update comments indicating PAD numbers.
>
> EVM Schematics are available at:
> 	https://www.ti.com/lit/zip/sprr495
>
> Test log (6.8.0-rc4-next-20240216):
>    https://gist.github.com/vaishnavachath/b04e3be90af4cdec59fb0d9cc72441b9
>
> For those interested, more details about this SoC can be found in the
> Technical Reference Manual here:
>              https://www.ti.com/lit/zip/sprujb3
>
> Thanks and Regards,
> Vaishnav
>
> Siddharth Vadapalli (1):
>    arm64: dts: ti: k3-j722s-evm: Enable CPSW3G RGMII1

Series Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> Vaishnav Achath (1):
>    arm64: dts: ti: k3-j722s-evm: Enable OSPI NOR support
>
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 132 ++++++++++++++++++++++++
>   1 file changed, 132 insertions(+)
>

