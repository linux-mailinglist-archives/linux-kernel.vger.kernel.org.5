Return-Path: <linux-kernel+bounces-135211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C789BCC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE8A1C223C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3BB52F8E;
	Mon,  8 Apr 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pPtrOaEd"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B74452F72;
	Mon,  8 Apr 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571282; cv=none; b=ASvtmJ1FfKObJH7XT5YEJsSD1mmf0kN5ok947Tljqz76P8FAYZaL34uql1aT+JbAILjuN3YNrlPrRlVqQkUtrbGL9jbjbYaMaQyeo0zMUhk4jtffRoS3BbxdJ/8lmlyYIKhFPy3Bw9U0CjGXKoR5mbXwf1pooI4iGvWR6nw9J9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571282; c=relaxed/simple;
	bh=qVKOQI0HIIEZelwEJzSL9i8iJaDoCWVw7LBCGPtaPJA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+RymS/rObISR+ymwVIHIrn8M36yJxVkvwT3WH3wPNxahYYdOpPkZW/n9Q8pVA0cbjykTmpk8H71Wd3/OksX9L86AS9BIJXt17n2uCAjfHRKGqD649c5zHjuItIWtfcZLKonUGkechDtjOpEUWTZwa8TWJNxslVM3H50OodJ16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=pPtrOaEd; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438AEMg8102770;
	Mon, 8 Apr 2024 05:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712571262;
	bh=hHpDuMK/UeyJqzTu7xY4aY9f5r4P20RSqR//AoV2ics=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=pPtrOaEd8NaND1dzTO0hrh9146Q15vo7w94X2Eodk8dl+EFiKVMSJKYHP7/ebIsk5
	 CrW7/1e8IrYA1+k9TXFCfbY7pl7KZv8ZJYyjrAmUjUXzslttJ/PAMsETWTdfdVTy1o
	 woXSEevpJ0E3cYvgvWoecEqalFdDugRJZF7ncrag=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438AEMHN016329
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Apr 2024 05:14:22 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 05:14:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 05:14:22 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438AELBL081316;
	Mon, 8 Apr 2024 05:14:22 -0500
Date: Mon, 8 Apr 2024 15:44:21 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Andy Shevchenko
	<andy.shevchenko@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Message-ID: <20240408101421.53c3cpv4udo247q7@dhruva>
References: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
 <20240405-pinctrl-scmi-v8-2-5fc8e33871bf@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405-pinctrl-scmi-v8-2-5fc8e33871bf@nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 05, 2024 at 09:59:33 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI v3.2 pinctrl protocol bindings and example.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 4591523b51a0..e9d3f043c4ed 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -247,6 +247,37 @@ properties:
>        reg:
[...]

-- 
Best regards,
Dhruva

