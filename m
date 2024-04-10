Return-Path: <linux-kernel+bounces-137776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122489E6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168931F22525
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87885818;
	Wed, 10 Apr 2024 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UfxFwwmB"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0407387;
	Wed, 10 Apr 2024 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709606; cv=none; b=AzqwtIn+gEZwkQTSLSjoQZaLusMNs3Trt7MM5aqbS/bukDDiLM+0IETxRm/vBGyvGwDk2Z8ZJ5d9zEQZe4DN6Rg+ebt0DOXigLBEqgxVdeTzo2e22YTgzvhvYArjsBGQYbOsqpzXRlguAb42eknxDvW/igxHW7EgqQTruI3VglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709606; c=relaxed/simple;
	bh=DFJlsyWtNR4AILqPAwwwDiwJLsYOsOgSTRpDX2EDGcU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnX4UXOUB25wZ8GpUS+5m/BBc3rKsUcUeJHq0MMJbhYFpgFtHJckswMWTsX9qmXzo8u7J9RxocbMQW7TxK61BFYZuLzgby+3lVFSFMvuaaeVqOLyd3yycVS9kvSjQmXRXbLGh/wg92L+OHv9VKkVoVywWdDCFJqxop1O8x8P9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UfxFwwmB; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43A0dq7K041056;
	Tue, 9 Apr 2024 19:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712709592;
	bh=cmZSSvfxWpFvGOfbBlYMoBX5v+AChVyAxZqkm1pY0HU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=UfxFwwmB/sQfjtdjat+TPCwB//zI8o0CaKPlUMNH3g0S6HxOhW+HTbpOlYhQq/vN+
	 7L2oiZIiqY0p35cRLQLFgW1jdhXGOCHkOWqgMLzh98Ah7N5/e4DCrEvWavvhhu7Gjs
	 hG+ORkD6AKUKqckEyuMRTyMtcS3gxZgV8vEnCzhU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43A0dqLa130837
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 19:39:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 19:39:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 19:39:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43A0dqud128754;
	Tue, 9 Apr 2024 19:39:52 -0500
Date: Tue, 9 Apr 2024 19:39:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: minor
 whitespace cleanup
Message-ID: <20240410003952.wnxayyiyqxkgj7we@supplier>
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
 <171269138685.642844.11136653326464585397.b4-ty@ti.com>
 <63fc911e-8906-43d0-a4bf-80ceac83d178@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63fc911e-8906-43d0-a4bf-80ceac83d178@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 22:04-20240409, Krzysztof Kozlowski wrote:
> On 09/04/2024 21:36, Nishanth Menon wrote:
> > Hi Krzysztof Kozlowski,
> > 
> > On Thu, 08 Feb 2024 11:51:45 +0100, Krzysztof Kozlowski wrote:
> >> The DTS code coding style expects exactly one space before '{'
> >> character.
> >>
> >>
> > As discussed offline, I am picking this patch up.
> > 
> > I have applied the following to branch ti-k3-dts-next on [1].
> > Thank you!
> > 
> > [1/2] arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
> >       commit: 45ab8daed512258c07fd14536a3633440dabfe84
> 
> What about the omap one (second in the series)? Shall I take it?

I had poked Tony about it (he is the maintainer for OMAP). Tony: could
you comment?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

