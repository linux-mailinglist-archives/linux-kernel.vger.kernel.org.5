Return-Path: <linux-kernel+bounces-146349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A3A8A63D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FFF1C20BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91006D1A3;
	Tue, 16 Apr 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NrYXPnCS"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185CA38;
	Tue, 16 Apr 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713249263; cv=none; b=APXRXCXwc0CZPDwDCqM15tBTnnuVT42H92mtYvflaZKnkO+C7PNEP1X2mVxVT55XYGpNaAki3xaRheZPnEZ5aUAU15MtQLJKrIzHxTD3CfKNq1+8vdqw+Wbj313sOk6MBeo5EdpwATx3APyKaPy62ffMcmAtR0MgbyXFuWzvguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713249263; c=relaxed/simple;
	bh=aUB2sz5q+pwDDgokv+BkgppIYgiz6sSwYxbo6bVyyPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QPe2eQQKjRhLPhwXTaNGiwolELC5rAZ+qtmmds9S9D0UQpJdkvoNRsggRu2NG+91lDziJHwpRqfGoAOXoIUIN6dLvXffxogQXM/F6EvPWEJuszrZz4hneZTt1vJ79MD6ipIR3QwT7dK9CVib1LgJvNo3Q0bYX5zSpW8G8XhuMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NrYXPnCS; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43G6Y18b054914;
	Tue, 16 Apr 2024 01:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713249241;
	bh=aUB2sz5q+pwDDgokv+BkgppIYgiz6sSwYxbo6bVyyPk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NrYXPnCSaCc6HHmFgI38YHbIaOtJ5hW8rPs3CMxbDMNn2N8TtRhDylLSA7VunCVAx
	 Snvu0NFMQ+t4PN++JoEZFZjqDfjrmrsgLE03JxB32wjbkYERLdKAhVKB4KWfjGTS4m
	 rABNwLmLcX4artr7On8yfqcs6DxQeYFLDo7QMENI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43G6Y12l005530
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Apr 2024 01:34:01 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 Apr 2024 01:34:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 Apr 2024 01:34:01 -0500
Received: from [10.249.132.198] ([10.249.132.198])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43G6Xubk035621;
	Tue, 16 Apr 2024 01:33:57 -0500
Message-ID: <d79cfcb1-5883-4596-a601-040769a16182@ti.com>
Date: Tue, 16 Apr 2024 12:03:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] arm64: dts: ti: k3-am62a: Disable USB LPM
To: Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Andrew Davis <afd@ti.com>, <b-liu@ti.com>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240412-for-v6-10-am62-usb-typec-dt-v7-0-93b827adf97e@kernel.org>
 <20240412-for-v6-10-am62-usb-typec-dt-v7-3-93b827adf97e@kernel.org>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240412-for-v6-10-am62-usb-typec-dt-v7-3-93b827adf97e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/12/2024 5:32 PM, Roger Quadros wrote:
> As per AM62A TRM [1] USB Link Power Management (LPM)
> feature is not supported. Disable it else it may
> cause enumeration failure on some devices.
>
>> 4.9.2.1 USB2SS Unsupported Features
>> The following features are not supported on this family of devices:
>> ...
>> - USB 2.0 ECN: Link Power Management (LPM)
>> ...
> [1] - https://www.ti.com/lit/pdf/spruj16
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> Changelog:
> v7 - Rebased to v6.9-rc1
> v6 - Rebased on next-20240226
> v5 - new patch
> ---

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

>


