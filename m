Return-Path: <linux-kernel+bounces-156436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88898B02C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4251C22695
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D401586FB;
	Wed, 24 Apr 2024 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M2gxhANI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C74A157491;
	Wed, 24 Apr 2024 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941927; cv=none; b=hSKcFOJj4ZYbtzsnfV/Y4qZKzC1ZvO8fOrr/YgX2fJ/jqhof9qm+KVVckWgtybQ9RgE8X/YO7uabcixO6lEj2VQOlIBBL3mRrI5TFNoRS+63gfBmAVc0J+FeBndnwSXyAmP9ChkZ2r7Q6AEZ+iXa37ec4ZKYyG8gmxdkOaX2PO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941927; c=relaxed/simple;
	bh=P1t0REWUuQLsDRjagkYz1+vlorbhLbaVGuGqkr3Yluo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UEi6xCNNVJcyiLMsoRnQHmKjtmA8t/ClyaeepnpdOLIzGKFbMZMtQJ0lMueOaSXKDpxUfPpWqwMEFl/GxstTUMRmEIVNBQM7WYLB60wnPEC24ARvwwoq+tKCjNLWdCLh1CbXT7HlSIryNq7sl3PfG32///CADABrGM0nAhtVCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M2gxhANI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O6waBC064296;
	Wed, 24 Apr 2024 01:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713941916;
	bh=nK4OyElnhUKU5PaeG4vEL+OZvrtvfGDKXHMETnf8p4k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=M2gxhANIi1ydmEQj31DX0dDNysx65SQKGb39A/p33VlHwIFT6EQCrOYYrfh+5Km1d
	 WFibkIeKLWsiLQ0bT9Cnghchm77x19YmRL3gg4O4ofSgb7fQCZ0RkUjUB5fyJn2LLR
	 cUOHa9TxEF1nUoGR/7GVOYISFccQVnjNWZStRiwE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O6waUC010974
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 01:58:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 01:58:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 01:58:36 -0500
Received: from [10.250.149.192] ([10.250.149.192])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O6wVpu107489;
	Wed, 24 Apr 2024 01:58:32 -0500
Message-ID: <0b572ad3-800b-4d62-8ddc-2207a82a2f41@ti.com>
Date: Wed, 24 Apr 2024 12:28:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-main: Add PRU system events for
 virtio
To: MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <srk@ti.com>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240423100838.1421845-1-danishanwar@ti.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240423100838.1421845-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/23/2024 3:38 PM, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
>
> A PRU system event "vring" has been added to each PRU and RTU
> node in each of the ICSSG0, ICSSG1 and ICSSG2 remote processor
> subsystems to enable the virtio/rpmsg communication between MPU
> and that PRU/RTU core. The additions are done in the base
> k3-am65-main.dtsi, and so are inherited by all the K3 AM65x
> boards.
>
> The PRU system events is the preferred approach over using TI
> mailboxes, as it eliminates an external peripheral access from
> the PRU/RTU-side, and keeps the interrupt generation internal to
> the ICSSG. The difference from MPU would be minimal in using one
> versus the other.
>
> Mailboxes can still be used if desired, but currently there is
> no support on firmware-side for K3 SoCs to use mailboxes. Either
> approach would require that an appropriate firmware image is
> loaded/booted on the PRU.
>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> This patch is based on linux-next tag next-20240423
>
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 0d68aa8e946f..72aa3b9aacce 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>

Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Regards,
Ravi

