Return-Path: <linux-kernel+bounces-162061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A5A8B5568
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C816B227C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08A1EB2F;
	Mon, 29 Apr 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GXh2ZPU5"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F017BA2E;
	Mon, 29 Apr 2024 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714386879; cv=none; b=pDhW+zWBbDPiiE58If/JjDgI/dheepte58HB2xl8184PmDDuR/kdg77iPbCjGL30nNMApaVqRf2QLCAZUSuFESugfvwrrFvDP6lEBynID5E1VCjJVWJPNJh/nov/YVnxy++C8anNvuQAqyxgtLoXHP62sPAY8H/f+0vD1ZpbeVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714386879; c=relaxed/simple;
	bh=Kstemt5Z21Vosm5/6thPt/7hYzc7lcLYUCfUJsumT6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=usXhG6Oefu31BUSpNnnEgrB8Agl85QIGpXHdd4jRDUNzx0Gqb4EqOJXh1rk0+5fGxzo1Z3wZdC2lO/xkaregPj6F3FZq0lLAWuttUTmaaniyR7yY5m1ZiFM7qmZYytX03zesLj50Jo5O48jyz3b/nNIu5cZVOAyIpwFB0YsZskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GXh2ZPU5; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43TAYLGf005164;
	Mon, 29 Apr 2024 05:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714386861;
	bh=5ppUcfn4J8w9laTurDj/YW82wqBCBTbBVOmQQGnJTHg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GXh2ZPU5lmnqbagpXkLWU+3DeZQadjHfQyfZZ3ahYx1B/932AlFygG1cAg7qsHbmC
	 kIcgj3ahYVMZvSdpg0eR9vCeVbB6tcEIO3lBUQDKSn/pcfl/2rvazbZK0mBJVaIFbR
	 sFlCQ+MiH5N8JmOkQN26dGYA5NMoeZ/te6j91KI0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43TAYLZu068643
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 05:34:21 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 05:34:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 05:34:21 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43TAYG9S110863;
	Mon, 29 Apr 2024 05:34:17 -0500
Message-ID: <f37bf7e9-78c7-9382-01af-4d8f37ec2ba9@ti.com>
Date: Mon, 29 Apr 2024 16:04:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-evm-icssg1-dualemac: add
 overlay for mii mode
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240429092919.657629-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240429092919.657629-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 4/29/24 2:59 PM, MD Danish Anwar wrote:
> Add device tree overlay to enable both ICSSG1 ports available on AM64x-EVM
> in MII mode.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> This is v2 of the series v1 [1]
> Changes from v1 to v2:
> *) Rebased the patch on next-20240429 linux-next tag.
> *) Added "GPL-2.0-only OR MIT" in the license as pointed out by
>    Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> [1] https://lore.kernel.org/all/20240423090028.1311635-1-danishanwar@ti.com/
> 
>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>  .../ti/k3-am642-evm-icssg1-dualemac-mii.dtso  | 101 ++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-dualemac-mii.dtso
> 

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi

