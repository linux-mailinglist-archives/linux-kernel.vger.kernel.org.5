Return-Path: <linux-kernel+bounces-62993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98085289C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476A1B222D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7B134A7;
	Tue, 13 Feb 2024 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bCilPB5n"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8D12E48;
	Tue, 13 Feb 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804794; cv=none; b=XoRlB0takfs7thBjQiY9AYMcpdEUqa0zJ+b0ujxnqbvryItWfca2YrcBF/EM6/x5eXKbFXQmu99rKNUMER7IZ1fSVtc+qvs7TcrsVMgT0nImZzzcL9nqV7zMDpKnnAZLf2Nx9TFJXltXNi8W+cZzB8DpMgmC1AHA8uJfr02RxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804794; c=relaxed/simple;
	bh=01O6va/IhWdV2WPIij2S2wkwp/nopmx39uYTcW8swao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WKDBFkspn+JZC2EmEfEd5Vwnd2zzSszWtL3bX1d+AxQib5FLEIRrOcMk28zm5z4UrsU3gEdunGJDa+cg0ooryUG6hlo43Cfq1CWcVqh3LSmvKH/WEVyIEdBjJqkmJCpgFGtR8c94r6KFuVx/Gf/fBOYljAngLjxfDP+wrRr1Hy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bCilPB5n; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41D6CbwF023894;
	Tue, 13 Feb 2024 00:12:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707804757;
	bh=dxRhWa+Vi5AUowqvCvK+WY/xzf1fihE7v0jwRRrlRrM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bCilPB5nlv6hi+wJbbJvhgbgmmo/hLRYbkOj/9cIhQiJmg5u9yNC9tVrcjA5pukBi
	 7+RDi/SoT6xyeuctdGahvk8444zZQu/yifwmC9U5lIIKHSDm0yLQ0Bpqsk0rVtUXdg
	 dR+SYMX66ZoMpGobpP1b0NFaJyogr9l2hqNLyjH8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41D6Cb8I012775
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Feb 2024 00:12:37 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Feb 2024 00:12:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Feb 2024 00:12:37 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41D6CVPo050043;
	Tue, 13 Feb 2024 00:12:32 -0600
Message-ID: <8aa96c66-d054-4b33-8972-f9faf2e84482@ti.com>
Date: Tue, 13 Feb 2024 11:42:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] arm64: dts: add description for solidrun am642 som
 and hummingboard evb
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar
	<danishanwar@ti.com>, Andrew Davis <afd@ti.com>
References: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240211-add-am64-som-v5-0-790ed7121249@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi

[...]

On 11/02/24 20:37, Josua Mayer wrote:
> ---
> Josua Mayer (4):
>       dt-bindings: arm: ti: Add bindings for SolidRun AM642 HummingBoard-T


>       dt-bindings: rtc: abx80x: convert to yaml

2/5 needs to go via RTC subsystem tree. Could you split it out into its
own series when you respin

Rest will go via TI K3 arch tree.


>       arm64: dts: add description for solidrun am642 som and evaluation board
>       arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3
> 
> Suman Anna (1):
>       arm64: dts: ti: k3-am64-main: Add ICSSG IEP nodes
> 
>  Documentation/devicetree/bindings/arm/ti/k3.yaml   |   7 +
>  .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  79 +++
>  arch/arm64/boot/dts/ti/Makefile                    |   7 +
>  arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  24 +
>  .../boot/dts/ti/k3-am642-hummingboard-t-pcie.dtso  |  45 ++
>  .../boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso  |  44 ++
>  arch/arm64/boot/dts/ti/k3-am642-hummingboard-t.dts | 292 ++++++++++
>  arch/arm64/boot/dts/ti/k3-am642-sr-som.dtsi        | 594 +++++++++++++++++++++
>  9 files changed, 1092 insertions(+), 31 deletions(-)
> ---
> base-commit: 798d1ee1675be84d5c7eb639480aab33f2c8791e
> change-id: 20240101-add-am64-som-51a1ca47edf3
> 
> Sincerely,

-- 
Regards
Vignesh

