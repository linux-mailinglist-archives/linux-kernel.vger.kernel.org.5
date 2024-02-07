Return-Path: <linux-kernel+bounces-56615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF484CC9D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42CE01F26AF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E07C6EE;
	Wed,  7 Feb 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RRxvGBaY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0077A727;
	Wed,  7 Feb 2024 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315920; cv=none; b=IWJvLmpI4squOZOJjpHET2bf5L0XCbMf4EdBpOYLyTwjebUoi0YF1H9E8/CPjSs0SxhwoDz/dV03vdKIa8xNGZ1x3bGjh8pbuqDtgjOOLDGqw4Xcz2hF9BTRctEa0olD8bA81K7l5VeIbmLgDQjABK95AEpbjiiowH1h+g2PBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315920; c=relaxed/simple;
	bh=goer9JW5LQVNm42ou1bYbGgI7bBWhVy7CrVfB19USoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RYKUtXc2WLEqYqso+aRk58TUkcFlhWRwgajHyDh+00AciuWUOMzofLtYdSeOcLmkECYmzvxK2CpacSedqmSao3Mc36WjKClgJuRkkF0v0sMKBptGw1Q9HyqxJEqHjoji7ujWBt1408eLHwuCFMYy5FJggNlXF4adizQFZUQ5ehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RRxvGBaY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417EP8wD021937;
	Wed, 7 Feb 2024 08:25:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707315908;
	bh=FzuzGJ8GsxhI1TBl02HGU19mwn0nxJbHBIPkm1no2Og=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RRxvGBaYBXMwn7fqssRZuaRVFDgQGs2eV14ztIOVNRMM5bgFQ+LZqVZbOY5ZFQBSb
	 F9Cwqy9fcCyMDiGOxtlR1ZIhaJ96ucusc//3fnU/p6dZbxWqsoL37AGny8pm6LNYbG
	 0Gx3MbFTzvCq8ozqp0pmAxXkJw104xtmX/oWDGzk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417EP8cv046099
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 08:25:08 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 08:25:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 08:25:08 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417EP4FF087603;
	Wed, 7 Feb 2024 08:25:05 -0600
Message-ID: <1d5c0570-fa10-4b87-9833-1710f33db01f@ti.com>
Date: Wed, 7 Feb 2024 19:55:04 +0530
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
 Sabiya <sabiya.d@ti.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
References: <20240205200744.216572-1-sabiya.d@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240205200744.216572-1-sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


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


For Series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 162 ++++++++++++++++++++++++++
>   1 file changed, 162 insertions(+)
>

