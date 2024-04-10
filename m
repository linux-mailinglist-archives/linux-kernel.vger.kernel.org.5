Return-Path: <linux-kernel+bounces-138302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64489EF8C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE61F2377F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8B15921E;
	Wed, 10 Apr 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yhBtbwOw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA7156861;
	Wed, 10 Apr 2024 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743593; cv=none; b=GpYXMNDZD6xS4QtmunpDTtAVDSQXLy8t+sB74HuYg3cm+MUTqHxs6tI/CrhjXwaBigH30q7I+MifNCUsgGXDKTj3mngd9ghu/dyovIK+4qEQzoncDwDpRm5T+gDgTz51yjfjYdFVNqpuHhcbrNPIUlQiBe5Z5izDIQTw+DpLGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743593; c=relaxed/simple;
	bh=5Ce48EpIcKzodLFNGKTWP9aCBbROGQV/67j+aVRwLCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u6etOPDLyhIkFVjw1R1l7b7ZU2/sqEpbopQcT737anF1OFEITzsUukEYFYg/5BrGLlloY470LStC6oPD4iNpxFjPIV9ynNog5kgbKfIGDNCdGsfqXvZPpBbDXtCJ0lcSfjZqfkGMJNbUuHRpEpp4c2sM/2Vp6YTwtSiU4MQfgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yhBtbwOw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AA6NGG013595;
	Wed, 10 Apr 2024 05:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712743583;
	bh=R8Wo5XqToQPqhoN0MN5T+7qipwaxNJK0EROG9c6zWVA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yhBtbwOwzTY5kqKowAMbiIdfraXtYOfkuXhXF6fQuSW/Nf7p+UysknfCq6+ERVuKF
	 b7ssKkAEdTT9Z1ravnbqpmytFsBYPkeSMtgUVBd1RGV/52THH56falH6rj49DHp/KM
	 MV/y0hNiuXWPwTP/KYuMV02diIegd57HXL1o5VEE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AA6NtT006854
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 05:06:23 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 05:06:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 05:06:22 -0500
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AA6IdB041531;
	Wed, 10 Apr 2024 05:06:19 -0500
Message-ID: <b77128a1-8c61-49c2-81a4-c0811c5c8e3c@ti.com>
Date: Wed, 10 Apr 2024 15:36:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Fix the reg-range for
 dma-controller
To: Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <bb@ti.com>, <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240405085208.32227-1-j-choudhary@ti.com>
 <20240405085208.32227-2-j-choudhary@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240405085208.32227-2-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks for this fix Jayesh

On 4/5/2024 2:22 PM, Jayesh Choudhary wrote:
> The TX Channel Realtime Registers region 'tchanrt' is 128KB and Ring
> Realtime Registers region 'ringrt' is 2MB as shown in memory map in
> the TRM[0]. So fix ranges for those reg-regions.

Minor one, but it will be better to say that you are fixing these 
register ranges for  PKTDMA .

Something like that

For PKTDMA, The TX Channel Realtime Registers region 'tchanrt' ....

Also, it will help reviewer if you can mention which section in TRM[0], 
holding memory map .

If you are doing v2 then please take care of above in commit message.

rest for whole series

LGTM



> [0]: <https://www.ti.com/lit/pdf/spruiv7>
>
> Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index e9cffca073ef..e10cc9fc0b10 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -141,8 +141,8 @@ main_pktdma: dma-controller@485c0000 {
>   			compatible = "ti,am64-dmss-pktdma";
>   			reg = <0x00 0x485c0000 0x00 0x100>,
>   			      <0x00 0x4a800000 0x00 0x20000>,
> -			      <0x00 0x4aa00000 0x00 0x40000>,
> -			      <0x00 0x4b800000 0x00 0x400000>,
> +			      <0x00 0x4aa00000 0x00 0x20000>,
> +			      <0x00 0x4b800000 0x00 0x200000>,
>   			      <0x00 0x485e0000 0x00 0x10000>,
>   			      <0x00 0x484a0000 0x00 0x2000>,
>   			      <0x00 0x484c0000 0x00 0x2000>,

