Return-Path: <linux-kernel+bounces-156431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351718B02B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8011C2112C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7031598F1;
	Wed, 24 Apr 2024 06:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l4mL2YDt"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BCF158A07;
	Wed, 24 Apr 2024 06:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941743; cv=none; b=r6ULZj0C7wTeDNWQbYMlFmtCE4hNMQvq49DQKaEwWsjKDHuM8SlcGdYUykz5R+ECmvz7xOmoP10aF5gL8lZMD3t10BD4H0Q08zzpBkWunRQu0+pGaDiQOAeTA8LMUM7ZpUpJCz6/8vjcjuNgzu6WVDlKNxOJDCYtQTlKoBd6D0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941743; c=relaxed/simple;
	bh=JR54dDDk83m+e40bWsv9fRryEEDgFCZqtKo9xVfWVH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U8O+wB0ijezX3ABLWL1bwt4H3sGujhGy8EVrwcZOXNIkmcfE+0ehABKSe6Hk8HXy9QgWaAkI7K613L3PdjqQwRc3QUC8Pt7/DJth3tqeGdTmL73O9bIXSmYeMCH+4lqHEIIrWa3w3TxN4gmNWmJS4zJkigOibXf+ojk6OACEM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=l4mL2YDt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O6tTPI057180;
	Wed, 24 Apr 2024 01:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713941729;
	bh=PD6Eu9MZaXRIiE89W5PX2nUwC/2H67X4j2pdVBXYi38=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=l4mL2YDtc2pKDQhQEf/rDCxz61onJfP2u38L6PV2ZEYC72Usnr8W2H2NsoBNxjAtQ
	 ysDJsmfm1vQgppZteHmSqAAVnTFkqCmabCvpUY/JuUicvOOVdreMsAX5anPvO8Tttc
	 tDYsSJwUY/XQPETf35NNdIeWoMoixY+6LEg+u9Qw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O6tT7E075317
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Apr 2024 01:55:29 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 01:55:29 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 01:55:29 -0500
Received: from [10.250.149.192] ([10.250.149.192])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O6tPGn047033;
	Wed, 24 Apr 2024 01:55:25 -0500
Message-ID: <3f00114c-7185-4a50-9d6a-b3e31d7d3eb5@ti.com>
Date: Wed, 24 Apr 2024 12:25:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am64-main: Add PRU system events for
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
        Roger Quadros <rogerq@kernel.org>
References: <20240423100608.1421652-1-danishanwar@ti.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240423100608.1421652-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/23/2024 3:36 PM, MD Danish Anwar wrote:
> From: Suman Anna <s-anna@ti.com>
>
> PRU system events "vring" have been added to each PRU and RTU node
> in each of the ICSSG0 and ICSSG1 remote processor subsystems to
> enable the virtio/rpmsg communication between MPU and that PRU/RTU core.
> No events have been added to the Tx_PRU cores at present. The
> additions are done in the base k3-am64main.dtsi, and so are inherited
> by all the K3 AM64x boards.
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
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
>

Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Regards,
Ravi

