Return-Path: <linux-kernel+bounces-52780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55304849C95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84171F21E65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3F249ED;
	Mon,  5 Feb 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wNzATdG3"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25142374C;
	Mon,  5 Feb 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141933; cv=none; b=YqSyKsMI6EzV5HHFP8nUx8GavVAxR6ExreZfHpJF3SjlqpWc4i78ZVZIL5fZldrEwt6wjm3SF0DwxcZYtumveLY5SMsrG6byk/gpfdvXtUs6L0Iph50Rdvfin2p0qZyGFOfgjJseiediv8mrnzcBgSplYzL5YN2O5fKZcY7H+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141933; c=relaxed/simple;
	bh=S+J22TKd61AMgNNTihfiv3o8sylxC4/vAIqdRq6ROtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q7Tq34qLpXh7ir7kiJxlzFuLYxaQgvpW3Jvfq7/JLQx+1etOnXFlLX4elvntS9mAntHIZUY5NBZft+EWccgjUxdiCjCjqvBKzemuV75w+rgcgqpuTF1IU8S0+fOqUcetWH6+QrCwHwGqpJgrQIP9FQVmJb2/yivxmkfDRANHMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wNzATdG3; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415E5Ooh023292;
	Mon, 5 Feb 2024 08:05:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707141924;
	bh=w1xj4NguHy2/0mX6AhYi+lji0W4HDt9Y+xGif/pdMR4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wNzATdG3E4xqSy2dKN/TjmL5Mc5qYc3f/jXtk9qTbmXg6A109yHUDVXe33GAVHuXC
	 MFaE9J6LrZNcFenoi3NuQ0OQDeYiJTTqsV1i+Nk2M+Z0vqIAKCspdQSo5xafzBeugd
	 0HNc8NijX2NNweENeAGBBns7YBnKU+JJOeTeuE8Y=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415E5OY4085400
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:05:24 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:05:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:05:24 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415E5LFe049488;
	Mon, 5 Feb 2024 08:05:21 -0600
Message-ID: <a50c5731-b328-4bf1-9449-ad15eb0f9ea6@ti.com>
Date: Mon, 5 Feb 2024 19:35:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: syscon: Add ti,am654-serdes-ctrl
 compatible
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240130195128.58748-1-afd@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240130195128.58748-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 31/01/24 01:21, Andrew Davis wrote:
> Add TI SERDES control registers compatible. This is a region found in the
> TI AM65 CTRL_MMR0 register space[0]. Each instance is used to control a
> SERDES clock and lane select mux.
> 
> [0] https://www.ti.com/lit/pdf/spruid7
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 084b5c2a2a3c2..d8679a2ad4b10 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -73,6 +73,7 @@ properties:
>                - rockchip,rv1126-qos
>                - starfive,jh7100-sysmain
>                - ti,am654-dss-oldi-io-ctrl
> +              - ti,am654-serdes-ctrl
>  
>            - const: syscon
>  

This needs to go via mfd tree (or at least need an ACK). Please cc
appropriate maintainer  (Lee Jones <lee@kernel.org>). So, I recommended
to split 2/2 out into separate series and post once this patch is merged.

-- 
Regards
Vignesh

