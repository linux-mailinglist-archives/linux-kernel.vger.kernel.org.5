Return-Path: <linux-kernel+bounces-56179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2C084C70E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12AA1B21542
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A420DCD;
	Wed,  7 Feb 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EM1y0ICn"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CD208CB;
	Wed,  7 Feb 2024 09:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297334; cv=none; b=Mfn+qQY2+4kkDOUu7xLmW/G3+10Y+CjOL8EdHFJsmIyeG3UsrVsP9WxdHJ5Qbp/TU1MaRWsXCASQRXuHRteCxt94oIJEFa2OuPYxMZv3qXyu69eWVq5TzRhIYENZs9PKWGIfXIWKaqpmD/GLW74kzWYbgB11L8EPBl4PEnv03Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297334; c=relaxed/simple;
	bh=+721dfLmbIiV47gQXs5k0Bzo6o/Lr02F7RnJ3L1Awag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LFypdbaEsOrPxnMDgRDVqoN+MSAgJKEWmXHwcikke6yrkFfF3kfxpCx5iXh/pf8HY83z0m6TdHvlwLftXCdTjKY3ly+sKdgX/n8cuWvD9VvNmz5CLTIIDENLQrEHb1TkoLNcxX4i1IqzSrqPmtDxhLHp76lWWfrzHxYgxxVxg9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EM1y0ICn; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179FQNi071497;
	Wed, 7 Feb 2024 03:15:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707297326;
	bh=0lfHQJJv7IOlVNDpDB7SCczThCqAcdwzDRGQusp7u54=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EM1y0ICnuex2mTheTgnCv5kQWE2vvLXfNB/c48dEjOmBfURpyhNqAed/DfbzL6tSC
	 wpbosuRcNff/BeQeLq07/MdQyVUWUkUa3jIhkupTzAIl8CfUEN3pwLQ9B736P5FLvC
	 tcLhQmDxNos8FZgnnwyY5hDVivybkbbam6c0VMrM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179FQ9X105887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:15:26 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:15:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 03:15:26 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4179FMeu040993;
	Wed, 7 Feb 2024 03:15:23 -0600
Message-ID: <d490d4cb-fb42-4189-b992-ba46be404137@ti.com>
Date: Wed, 7 Feb 2024 14:45:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] Add CAN and OSPI support for AM69-SK platform
Content-Language: en-US
To: <sabiya.d@mistralsolutions.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
References: <20240205200744.216572-1-sabiya.d@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240205200744.216572-1-sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Sabiya

On 2/6/2024 1:37 AM, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
>
> Hi All,
>
> This series adds support for the below interfaces on AM69-SK platform:
> -  CAN support on both MCU and MAIN domains
> -  OSPI NOR flash support
>
> v2: Changelog:
> 1) Removed CAN interface aliasing.
> 2) Updated bootph property on the leaf nodes.
>
> Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/
>
> Dasnavis Sabiya (2):
>    arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
>    arm64: dts: ti: k3-am69-sk: Add support for OSPI flash

Series LTGM


>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 162 ++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
>

