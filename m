Return-Path: <linux-kernel+bounces-61322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764278510FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D34B25334
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E348208CB;
	Mon, 12 Feb 2024 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FGJOWhWS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D21BC44;
	Mon, 12 Feb 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734120; cv=none; b=nC7gjZy3Q6ZFKjB1mMJ5iu++ytp5OTQ5FtuUjdWVs6NJFkTXjC8jVMrNU3JNxAcbwhPhJMecgBlHaQeqpxH17Njg2HfJhn87lGaCEno7OA4pVG2d15ZS2HXquYdd9uFiZhHVa9XnsJMubBp81UvYo8lO7ynpXWYgjP91PlsvdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734120; c=relaxed/simple;
	bh=GtSA2uksSNi9NjNtGdRb198QphqBQo298wJEqml0ao0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZkWMu3EwEzf3taPU2BnZ5jWxrHQeovhv0mpNbrDwqXQxc8oUXrG7PYQS9Xww+bJjt9nFQGbYzaBEZBCxR0YSlYFZUXB/7YyK7jzya2GfB3CvoBtgBWG8FahAXm4NiBp3ldOcRRpgJg9lqT6gHoqxHo/eMxA1PTkxqvKcKHHsc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FGJOWhWS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CAZCcm047334;
	Mon, 12 Feb 2024 04:35:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707734112;
	bh=Xj9j2XfAcYdQJO4Bp6v+MxM9gh2G++BUQji8tP63c30=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=FGJOWhWSnry9bE2ph/1TDWzGLM8H38uGhmZ7HVtAqTE0A+vCurSNAXZSthuk2SLiq
	 s1QJsKW5CILLO2CFSSOzgXvOLcnVRVDhqgEenL8WXaYaLMUHxpFfdFFZ7fTKt/NxJk
	 OynRI4epJjjLXLCw5cgGWbnILEHpzWdp4fu6+1Wg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CAZC75067085
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 04:35:12 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 04:35:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 04:35:12 -0600
Received: from [10.24.68.216] (a0498981-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.68.216])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CAZ8Xx102619;
	Mon, 12 Feb 2024 04:35:09 -0600
Message-ID: <ab894372-8212-4a29-8167-b872105db81c@ti.com>
Date: Mon, 12 Feb 2024 16:05:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: dts: ti: Modify pinmux for wkup_uart0 and
 mcu_uart0
Content-Language: en-US
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240212095905.1057298-1-b-kapoor@ti.com>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20240212095905.1057298-1-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This should have been a v2, please ignore this . I will resend.

Thanks

On 12/02/24 3:29 pm, Bhavya Kapoor wrote:
> WKUP_PADCONFIG registers for wkup_uart0 and mcu_uart0 lies under
> wkup_pmx2 for J7200. Thus, modify pinmux for both of them. Also,
> remove the redundant clock-frequency property from mcu_uart0 node.
>
> Only Tx and Rx Signal lines for wkup_uart0 are brought out on
> J721S2 Common Proc Board and J784S4 EVM, but CTS and RTS signal lines
> are not brought out. Thus, remove pinmux for CTS and RTS signal lines
> for wkup_uart0 in J721S2 and J784S4.
>
> Bhavya Kapoor (4):
>    arm64: dts: ti: k3-j7200-common-proc-board: Modify Pinmux for
>      wkup_uart0 and mcu_uart0
>    arm64: dts: ti: k3-j7200-common-proc-board: Remove clock-frequency
>      from mcu_uart0
>    arm64: dts: ti: k3-j721s2-common-proc-board: Remove Pinmux for CTS and
>      RTS in wkup_uart0
>    arm64: dts: ti: k3-j784s4-evm: Remove Pinmux for CTS and RTS in
>      wkup_uart0
>
>   .../boot/dts/ti/k3-j7200-common-proc-board.dts | 18 +++++++++---------
>   .../dts/ti/k3-j721s2-common-proc-board.dts     |  2 --
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts       |  2 --
>   3 files changed, 9 insertions(+), 13 deletions(-)
>

