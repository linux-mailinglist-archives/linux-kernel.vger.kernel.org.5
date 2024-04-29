Return-Path: <linux-kernel+bounces-162073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82898B5586
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7897B1F220D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339B3524BD;
	Mon, 29 Apr 2024 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h8YKeSKo"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28E4F1E0;
	Mon, 29 Apr 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386971; cv=none; b=UqVt8uta9slqH2OYdFPgmL68X5htNzCc9WSJmBySvHRJ0PXJXKkI3rMq2s1EZBpg608xfsAPnC+ChopIU9Cy9irygnFH1Q7t+XUdDt3WLr8pXIRpn2RU8NQ+hnu8aMNYTer2ulw585V27nugqvUamKJOBvruaQrymX1Elfir4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386971; c=relaxed/simple;
	bh=xJgozEc9bvRSml/VE5BORhP5iBvQAIxM4K9jCU3zMvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B71HaYHZutatRvZWNgz1eqGaFYmHcBCGfKLchAAGv4+k1UIYvOwNepYmGBc3F8rlVBORwkcg4IFP+kCMcLVtq2JGQkNL1MlvGG7CRQBsxry+BpnUI0ISVbe/OYk+N5LaQPgIXMuwtBk4m94dU8dCQNBHjygMPmYp3lFx1PQdqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h8YKeSKo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAZokD062642;
	Mon, 29 Apr 2024 05:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714386950;
	bh=VlOmsa4jHj0oxLSa8GgFslPkSe4QTnCL8SwfmLq2ews=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=h8YKeSKoLrOIJKzItVGjngyM6djvljrwYPKjkp37E0frKqaIo1ZfBLnlwTvpsgCWd
	 G+LyITC8dg0imuSRB0iOEm58dorhDlbeW8i3LnL+1GI+G3SG6tG08petSUnBEFHPwq
	 /Ao9PdGBgjvJUFhNBTFB1SBxZ/QjacO0VFxkaBzk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAZoTB074068
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:35:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:35:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:35:50 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAZklk008401;
	Mon, 29 Apr 2024 05:35:46 -0500
Message-ID: <a0ae09ae-664f-263f-e08e-ab6638a632ef@ti.com>
Date: Mon, 29 Apr 2024 16:05:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] arm64: dts: ti: k3-am62a7: Add overlay for second
 CPSW3G Port
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240429101739.2770090-1-c-vankar@ti.com>
 <20240429101739.2770090-3-c-vankar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240429101739.2770090-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/29/24 3:47 PM, Chintan Vankar wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> The SK-Ethernet-DC01 Add-On Ethernet Card for AM62A7-SK board supports
> RGMII mode.
> 
> Add overlay to enable the second CPSW3G port in RGMII-RXID mode with the
> Add-On Ethernet Card.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v2:
> https://lore.kernel.org/r/20240425102038.1995252-3-c-vankar@ti.com/
> 
> Changes from v2 to v3:
> - Updated SPDX-License-Identifier and "pinctrl-0" property in "cpsw3g"
>   node in "k3-am62a7-sk-ethernet-dc01.dtso" as suggested by Ravi.
> 
>  arch/arm64/boot/dts/ti/Makefile               |  3 +
>  .../dts/ti/k3-am62a7-sk-ethernet-dc01.dtso    | 62 +++++++++++++++++++
>  2 files changed, 65 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62a7-sk-ethernet-dc01.dtso


Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi

