Return-Path: <linux-kernel+bounces-68415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74828579EF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A7B22255
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6580E1C282;
	Fri, 16 Feb 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H1B0V7in"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B01C2BC;
	Fri, 16 Feb 2024 10:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078091; cv=none; b=YcbsSkX7RNFmHdRSB8BNXCn2mEwAAGIzhjB+6WGbg+omR2dbxQcbmrqVzNC6eqe0KI27OUN0TPWr7n6J3NKCa+yyDCzVZRIg1OmBmCysMQcLNeqS0gJq6xcm1grC+EFxQVZSg4tl6lv1jeSqC2JKo5ynBPKTPOdcegS2UpFiSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078091; c=relaxed/simple;
	bh=70iIBpN9KLV3WoyUf70P1Lk2UtHP5UcWF5M97QWARoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EYmHafuK4MIJdJi3/pYshjvtbC5vYrYleU5JRBgsktLTQetS6aerTTfBn2EJTwOkkAz9g73m3j+Ut/9VGUCRBzyvAAGULZXMq5REy2L6e/XjUZq6vxiUqfMRUO3r4Zu/Z4Vn4lqicoXZ9qkOChzTcmDfwH52bYuy7tUAhpmaTdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H1B0V7in; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GA7cWK042769;
	Fri, 16 Feb 2024 04:07:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708078058;
	bh=dLTLIlAYxcZ5PaqaE2ofqGOyAZiVCTA/khFLfSDc5Uk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H1B0V7inKaD6BhKKMurdxr7YCdPnGyb+4K75vF5C8W77fbEfM9rYpxFqj+Y+rFuYk
	 FI7oV+vHtQ/zDgVf2bI3CGbL7x2tlQJJsLlhf4/oEjLcPOikDMoLQwOPrREJd2zcEn
	 RdcL23YUhHzJUrJvo7aCgpe7KcFP+qBjcPjyRDP0=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GA7c0B053980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 04:07:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 04:07:38 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 04:07:37 -0600
Received: from [10.249.128.244] ([10.249.128.244])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GA7UrK096668;
	Fri, 16 Feb 2024 04:07:31 -0600
Message-ID: <8a481b57-d55a-44e3-a38e-8dbad3cc79a8@ti.com>
Date: Fri, 16 Feb 2024 15:37:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add common1 region for AM62, AM62A & AM65x
To: Devarsh Thakkar <devarsht@ti.com>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <j-luthra@ti.com>
References: <20240216062426.4170528-1-devarsht@ti.com>
Content-Language: en-US
From: Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20240216062426.4170528-1-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 16-Feb-24 11:54, Devarsh Thakkar wrote:
> This adds DSS common1 region for respective SoCs supporting it.
> 
> Changelog:
> V2 : Remove do-not-merge tag and add am62a dss common1 reion
> V3 : Add Fixes tag to each commit
> V4 : Add Reviewed-by tag and AM62A SoC TRM Link
> V5 : Split dts patch to separate patches for each SoC
> 
> Devarsh Thakkar (4):
>   dt-bindings: display: ti,am65x-dss: Add support for common1 region
>   arm64: dts: ti: Add common1 register space for AM65x SoC
>   arm64: dts: ti: Add common1 register space for AM62x SoC
>   arm64: dts: ti: Add common1 register space for AM62A SoC

For the series,

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya


> 
>  .../devicetree/bindings/display/ti/ti,am65x-dss.yaml       | 7 +++++--
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi                   | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                  | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi                   | 5 +++--
>  4 files changed, 14 insertions(+), 8 deletions(-)
> 

