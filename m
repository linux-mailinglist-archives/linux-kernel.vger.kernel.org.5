Return-Path: <linux-kernel+bounces-49197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2932D846713
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3376B2269A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3BAF50E;
	Fri,  2 Feb 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g6KMnx3r"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4E3F9C2;
	Fri,  2 Feb 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706849228; cv=none; b=Pk6dqa0o3FMWkBTZR6kPE09S8RVHpj+68kkycU99PJL0glw/MCPJAbEVO3Dv8AGulyhR9AoAr9eIwC0wke1GJGZwWANl7NbsDK5PebrZddyIPitqDoRVPwnYXH/OZQGtM+amQBjA1I375hydWnmD5DO397yBfaGyEcRZ4z0kF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706849228; c=relaxed/simple;
	bh=dei4K8k4kNfv576PhUhrj/GhXC6CUdHZN4Fh4jZHoJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nobNXRVr3JZhHAz6V7TqIcTZhs2LvomHx4GaYOzAFl36pKlS1IIPeYKLsW+KXFsWnGi3f3BeebVoPviN462T3Bntog5kQQ4qjEJMLAnjxnkg+ZLVgwRatItkfvtQiKptqIQXp/ZU4UiWAyPe++daKOpFuenDFcx9qdKXc3fLp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g6KMnx3r; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4124krXj031984;
	Thu, 1 Feb 2024 22:46:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706849213;
	bh=jMtRVbuJJdTxBL8yEu4xKG6l6qNorypjS6u56YNKPZI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=g6KMnx3rdpT2Oy5KK4Krp5jwovZo5fDOXGD6weeCy/dOrJG3ySm0PTtN7CHpbzJ2F
	 CZYgCKsY04ODFcoEMRDkt7dxSkUC0IJ34a3kiCG1cDbWoRmX/DxvJQzk3Fb3XZD/4T
	 yluOa4llYPQKlXyUDSC1yfQgB4YGpobUDNoo/FB8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4124krnK055687
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 22:46:53 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 22:46:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 22:46:53 -0600
Received: from [10.249.129.226] ([10.249.129.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4124kmXa054104;
	Thu, 1 Feb 2024 22:46:49 -0600
Message-ID: <d40671cc-6e5d-461c-a1cf-3482a545042c@ti.com>
Date: Fri, 2 Feb 2024 10:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add AM64x ICSSG Ethernet support
To: MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero
 Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240122113045.1711818-1-danishanwar@ti.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240122113045.1711818-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 1/22/2024 5:00 PM, MD Danish Anwar wrote:
> Hi All,
>
> This series adds support for ICSSG ethernet on AM64x. 
> This series is based on the latest next-20231211 linux-next.
>
> AM64x EVM has three ethernet ports. One is dedicated to CPSW and one is
> dedicated to ICSSG1. The remaining port is muxed between CPSW and ICSSG1
> ICSSG1 ports. The ICSSG1 node is added in the k3-am642-evm.dts. By default
> the muxed port is used by CPSW so 2nd ICSSG1 port is disabled in the
> k3-am642-evm.dts. But overlay k3-am642-evm-icssg1-dualemac.dtso can be
> applied to use muxed port as ICSSG1.
>
> This is the v3 of the series [v1].
>
> Changes from v2 to v3:
> *) No functional changes.
> *) Rebased on latest linux-next (next-20240122) after 6.8-rc1.
>
> Changes from v1 to v2:
> *) Fixed aliases section in k3-am642-evm.dts
> *) Fixed firmware-names in k3-am642-evm.dts
> *) Changed icssg1_phy1 to ethernet-phy@f from ethernet-phy@0 as suggested
>    by Andrew L.
> *) Changed makefile to handle overlays using CONFIG_OF_ALL_DTBS as
>    suggested by Nishant and Andrew Davis.
> *) Fixed aliases section in k3-am642-evm-icssg1-dualemac.dtso
> *) Fixed pinctrl in k3-am642-evm-icssg1-dualemac.dtso
> *) Updated commit message of patch 3/3 of the series to warn about adding
>    label name to 'mdio-mux-1' node.
>
> [v1] https://lore.kernel.org/all/20231207081917.340167-1-danishanwar@ti.com/
> [v2] https://lore.kernel.org/all/20231212165832.3933335-1-danishanwar@ti.com/
>

For the series,
Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

