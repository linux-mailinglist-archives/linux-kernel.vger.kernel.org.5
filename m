Return-Path: <linux-kernel+bounces-74948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBD985E05C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A59B27B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25E7FBBC;
	Wed, 21 Feb 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LhqVrL7d"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820D7FBA9;
	Wed, 21 Feb 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527334; cv=none; b=g5cTcaBq9mWpdGmL5yVJxbqn7hzwOkVjt7vTri64OJhHN743IUSl3OAQElBaswGuIPaQgq0Vk5CBK1dG8Dz0XJK3thZ6TauiH8kdjMXUYke1jIQzD/U6rihp6yxIpQNwB3bQfOoi3u8daDwMHojxO1YRktM3nqiD56z7EiwxAzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527334; c=relaxed/simple;
	bh=rT9e0xR3/zf9fYz4q5UoZyzl1p9/q6xVVkH3VlQhn6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KmmMRNDX1GRbvjQQNyQ0C3qzbiaa8aUQm/QlmHOBWomDmJX6Bn0RXXR6OsqfFwHUKYsRr1fzjn3igKJWdLMMFURhmeCO3H+Ek2gcWzKPhLCSsBaU0CF71gm4zkpEd3WhfFpsIw5FDu1hzpC9YaEN0PjXpyk9aC1Bz3SRzcoi8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LhqVrL7d; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41LEtFba066348;
	Wed, 21 Feb 2024 08:55:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708527315;
	bh=4EpSx7TG90PV+Ig74g5C3cPghx9YNnQ6JyQb5mCzoTM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LhqVrL7dmwFpOBmD39pWTeWv0zunVEW6gWGQ71l951Xc1XOhSP3OjSwNNmD5UsH+q
	 UsN5W12gJrDvvp7Sxcr0NoNL8brx3vaupCrqMKTiait6UnaBvW2YKFl4b/uW9QbWEc
	 nWNzPDuZyGVrHGwci24TbARJy/Zrc7IUBdSSSwX0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41LEtFoe057387
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Feb 2024 08:55:15 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Feb 2024 08:55:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Feb 2024 08:55:14 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41LEtAus108137;
	Wed, 21 Feb 2024 08:55:11 -0600
Message-ID: <0801de56-f3f0-4564-9677-345eca5fef6e@ti.com>
Date: Wed, 21 Feb 2024 20:25:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/2] Add CAN and OSPI support for AM69-SK platform
To: <sabiya.d@mistralsolutions.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linus.walleij@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20240220162527.663394-1-sabiya.d@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240220162527.663394-1-sabiya.d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/20/2024 9:55 PM, sabiya.d@mistralsolutions.com wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
>
> Hi All,
>
> This series adds support for the below interfaces on AM69-SK platform:
> -  CAN support on both MCU and MAIN domains
> -  OSPI NOR flash support
>
> v3: Changelog:
> 1) Updated OSPI partition table to increase the tiboot3 partition to 1MB.
> 2) Rebase the sources to accommodate the latest merge.
>
> v2: Changelog:
> 1) Removed CAN interface aliasing.
> 2) Updated bootph property on the leaf nodes.
>
> Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/
> Link to v2: https://lore.kernel.org/linux-arm-kernel/20240219111422.171315-1-sabiya.d@ti.com/
>
> Dasnavis Sabiya (2):
>    arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
>    arm64: dts: ti: k3-am69-sk: Add support for OSPI flash


For Series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 163 ++++++++++++++++++++++++++
>   1 file changed, 163 insertions(+)
>

