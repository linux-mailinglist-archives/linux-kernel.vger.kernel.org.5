Return-Path: <linux-kernel+bounces-161746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FD88B509F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE831F22CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA32DDB2;
	Mon, 29 Apr 2024 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XouBsHLT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABF8D515;
	Mon, 29 Apr 2024 05:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367648; cv=none; b=kpQPIZQz6rGJ+R7nqEWloOKQvN+zGoHkxvDuU34ZCBvtgKyjTJMky+fDIMOOlXqG8lLOb8g20peZhp5HSTBDU5RcuZADYE2BuifS4Ianlk0R6wqFrTXjyTG1fETWSyG4aS2QBtQbxc7zS9egmvw2TD1LJ7IXuIwR8h0N7Xnx8vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367648; c=relaxed/simple;
	bh=LOB8StXyZXYH/XY9UsffloYZM/xf1QPKlDb/jL6XLMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxZtXK9zkeVrXWgXZ51vV2Zh9DY3omUB3f6dDps0rkdANjxFCabBz7T2ueq3TUytku+iJfwearWzBPTbdYgRV/79lLj/VEP7Wmkfs7z4uB4Ciyjv/iIaHlJ6wkR0OXFFVXwWcBg9dIx18eIlnz02168SKcrnLw2vP/K5HdPAUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XouBsHLT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T5DgeY098261;
	Mon, 29 Apr 2024 00:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714367623;
	bh=FHC8hHDhd2PbbJ5rnihDqnECh12r4f6wby1K3UtboNA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XouBsHLT/Pvp+wG3PNzf4uDD3ELE0YuhlIqZVk0+u04STXfCGPeAbhMb1bIpLALgn
	 h2sFgV6KBz3BT+sKqTlqQVHJ9PrsNzWVQg9gw7ANdgwICu7e15sUkQWDgbm5XDfMZs
	 WcZMZSRbIvU5gDXdorx+5tz5uik7+ulrfRU+Iexo=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T5DggU078548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 00:13:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 00:13:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 00:13:42 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T5DcIW017805;
	Mon, 29 Apr 2024 00:13:38 -0500
Message-ID: <3d547a28-5ead-3cee-204c-c212db9f3ecc@ti.com>
Date: Mon, 29 Apr 2024 10:43:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am62a7-sk: Add alias for CPSW3G
 MAC port 1
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <danishanwar@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240425102038.1995252-1-c-vankar@ti.com>
 <20240425102038.1995252-2-c-vankar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240425102038.1995252-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/25/24 3:50 PM, Chintan Vankar wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> Add alias for CPSW3G MAC port 1 to enable kernel to fetch MAC Address
> directly from U-Boot.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v1:
> https://lore.kernel.org/r/20230424111945.3865240-2-s-vadapalli@ti.com/
> 
> Changes from v1 to v2:
> - No changes.
> 
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index f241637a5642..7ac3049302ae 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -22,6 +22,7 @@ aliases {
>  		serial3 = &main_uart1;
>  		mmc0 = &sdhci0;
>  		mmc1 = &sdhci1;
> +		ethernet0 = &cpsw_port1;
>  	};
>  
>  	chosen {

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi

