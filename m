Return-Path: <linux-kernel+bounces-61215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB355850F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661061F214BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90DF9E4;
	Mon, 12 Feb 2024 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w2kUHL8O"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45968F50D;
	Mon, 12 Feb 2024 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707727487; cv=none; b=ot3Ok/tmcwg108lcQZ6e8b+fIuxU7By29EhICH0zn6i/AWOaf6dPRc+Ykz6GhqMqNIfKzwfEMZYtOQeWesSobiQ/G4Yt43LseonJb+QlCpKINFi/UTzHzF1+JBN/RZDJLzAUHOkNCXjYxgcOgW4LS7ihxWDQkj838oPCY+mFeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707727487; c=relaxed/simple;
	bh=WT9+34ZCmtcYGnQtWyy86rhkWukF1ByVZAwi6JWrDLU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJgCHwJ/FCMsPWEZxZaZw2yjD3Hh4A3G88EdyJ6s0gRPZTn0TkH1R73ic9SY2CUNEBs7ex98e9ZD9DPLFQ7+pM1lnPTU2LKprvpUB4tEsn9kpBKh1hHooPOgr7zy5mZV2CJAV8omWj1cV4NzYeiDlQ0hzTnXz1hCvLevsyXlni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w2kUHL8O; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41C8iatA093562;
	Mon, 12 Feb 2024 02:44:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707727476;
	bh=QRTuRIb8y6jqnVejiSnu7kSYQH3ynwOZQLaFbO94ibo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=w2kUHL8Owl6bUF7+gPuRu09QafmbShYqDgcwKLwidZeyYX6kpaGVICrOXM1mzUTKD
	 gxk89qq/rQwz8Fj7jM10Ch64qNEzWK1N3LI6AH9T2QzuQMRTIXD82Bch9jciktzhl1
	 G6ii2BrCZHbhgjsuWJDQHvuVVBjEZFT/2Cstt8V0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41C8ia8i068710
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 02:44:36 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 02:44:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 02:44:36 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41C8iZMj078613;
	Mon, 12 Feb 2024 02:44:35 -0600
Date: Mon, 12 Feb 2024 14:14:34 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Vaishnav Achath <vaishnav.a@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <j-choudhary@ti.com>
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce J722S SoC and EVM
Message-ID: <20240212084434.fygiqv2gtovjlq3d@uda0497581>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206100608.127702-1-vaishnav.a@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Vaishnav,

On 15:36-20240206, Vaishnav Achath wrote:
> This series adds basic support for J722S family of SoCs. Also add
> J722S EVM support with basic peripheral like MMC and UART.
> 
> TRM: https://www.ti.com/lit/zip/sprujb3
> EVM Schematics: https://www.ti.com/lit/zip/sprr495
> 
> Bootlog (6.8.0-rc3-next-20240206):
> https://gist.github.com/vaishnavachath/23d859925277df9ccd628190e7c23371
> 
> Changelog:
> V1->V2:
>   * Address feedback from Nishanth to reuse from AM62P5 dtsi.
>   * Remove bootph-all from root nodes.
>   * Change License to GPL-2.0-only OR MIT as followed for other
>     K3 files.
> 
> Vaishnav Achath (3):
>   dt-bindings: arm: ti: Add bindings for J722S SoCs
>   arm64: dts: ti: Introduce J722S family of SoCs
>   arm64: dts: ti: Add support for TI J722S Evaluation Module
> 

For the series, 

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>  .../devicetree/bindings/arm/ti/k3.yaml        |   6 +
>  arch/arm64/boot/dts/ti/Makefile               |   3 +
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts       | 251 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi          |  89 +++++++
>  arch/arm64/boot/dts/ti/k3-pinctrl.h           |   3 +
>  5 files changed, 352 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-j722s.dtsi
> 
> -- 
> 2.34.1
> 

