Return-Path: <linux-kernel+bounces-143247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A3D8A3647
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC85F1F23A66
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAD14F9F5;
	Fri, 12 Apr 2024 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TJnc/P2O"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459314F9E9;
	Fri, 12 Apr 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949770; cv=none; b=nlQPdDXYY6hX7SKF17X8WhkqBowuk44Bqy52pGBzEn39jq5xBAy4cVDXJ+MFeLVqseLv02KBhXmtiLxwgMaxLFyIwZbu7iWOAQwDhcZ1kFbMpRD+4HQZyge4NLSEtZLn+N0g5c3ubzB5Cl10A52D9Tst8KrHlUHLwUuGmmhooTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949770; c=relaxed/simple;
	bh=cEMBjTLa4oS4FBEB1yZpiPv5fR5E5M4Ev/SdQfLIw7g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=QF570NvNJvtAYa5EIOP2pv4Krr9hqmGijuoNM1wpFnuKlJxW0sxjuJYaixPWcmfeeAm43Zx9DGhUwbTnHraBSfzX9bIhXW7CxOocZ8W9FoXU9LXohNcC8N0MeaPESFWepWS+pmkH9WMg+Gip79DQQR8j5RFbt4NzBXf8411Q/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TJnc/P2O; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43CJMc4U036042;
	Fri, 12 Apr 2024 14:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712949758;
	bh=XeqOGbTe45VWGL5WaglS7Qq+r/222UczPd4uE4qFAsQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=TJnc/P2OgPHKQLnWDrVxJCv1Lf91hb9JEHUOPOlvLw09gAJR1aDiVjPvrccJkDwJM
	 8iSqmuPTEZ5OzJ6YoHtaSXkUp8idKZqWqVf3gvIfBvu6EW+aHTFw/qdJ4SNW6MYLH6
	 IbW3QE4MAhT2lNF1NX9Rl97o8sIa+0Bih/PRdW7Y=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43CJMcNQ072499
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 14:22:38 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 14:22:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 14:22:38 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43CJMcHH116901;
	Fri, 12 Apr 2024 14:22:38 -0500
Message-ID: <11c6b895-0f6c-4a39-9df2-d51f1ee208fd@ti.com>
Date: Fri, 12 Apr 2024 14:22:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: am335x-evmsk: add alias node for uarts
From: Judith Mendez <jm@ti.com>
To: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240411231130.386222-1-jm@ti.com>
Content-Language: en-US
In-Reply-To: <20240411231130.386222-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi all,

On 4/11/24 6:11 PM, Judith Mendez wrote:
> The AM335x SK routes the PRUSS UART pins to the Zigbee header.
> PRUSS UART is enabled and can be tested using the Zigbee header.
> Since there are two UARTS, add alias node to be able to test PRUSS
> UART reliably from userspace.
> 

Please ignore this patch, do not merge! Thanks!

~ Judith


