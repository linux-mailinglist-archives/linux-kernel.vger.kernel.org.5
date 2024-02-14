Return-Path: <linux-kernel+bounces-65047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 377F585471F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB59228F00D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66CF1758B;
	Wed, 14 Feb 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xYbt46DM"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A9D17552;
	Wed, 14 Feb 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906424; cv=none; b=Ams0B8oBmPgO2rnvolk8waIu15R1WFWDYZSiZ9qaWO/8sZYKmy70AiI5n7d2JPW2gE2yoTsLmllAivivWLK2k1z8Aq1RNybOZTBrfHSFe6OoF69C0xu+4qKkfhB/AQiIGyyJE0oW58ZGdJ+BNT9UNFAeflSRbSZPFnY9dvuyDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906424; c=relaxed/simple;
	bh=teavYKWn7MDa4qq3Bv2CSJ8svQxWFPEc08FKfKtL2t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jyHL93BO+AiKVnZL7XBEa5UxUIzfpfQmdU4bg5GI/UG8/+88LJ4tugaf+UxXUtupYlzWjXUwwURLFU48OWFCtU17z99aqTCljtTFhyqvBt2FuD42T5Seig+uMZ6t1ttrMkGib3JwazyWFX+LZBZ1VgMqXOpcC9qgRdtguRjro+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xYbt46DM; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41EADKCM016860;
	Wed, 14 Feb 2024 04:13:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707905600;
	bh=bjdfTlC774uUXe81o8dxQeT0S9fWJO5KRJ77upIQLhw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xYbt46DMd6hV74O0FIblr0PzoNOwGjn7b02vohYGYnOBU1mhYG2GGZbuaEBBpHG/u
	 wiqWqKxINFFO09tnbKYECGksGXeECOctfnIXqJ6uT5cCUYxBsuUvyTaBeH+Lx6inHd
	 nzWU4l62KFwqxE2hh42ZsJqh462dZRbF7faY9API=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41EADJbK075785
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 04:13:19 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 04:13:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 04:13:19 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41EADFtd012758;
	Wed, 14 Feb 2024 04:13:16 -0600
Message-ID: <4f122f5d-e430-4299-b6c5-bbe778aad736@ti.com>
Date: Wed, 14 Feb 2024 15:43:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] arm64: dts: ti: iot2050: Factor out arduino
 connector bits
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>
References: <cover.1707463401.git.jan.kiszka@siemens.com>
 <3366367dc9f190c9e21027b9a810886791e99245.1707463401.git.jan.kiszka@siemens.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <3366367dc9f190c9e21027b9a810886791e99245.1707463401.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 09/02/24 12:53, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> A new variant is to be added which will not have a arduino connector
> like the existing ones. Factor out all bits that are specific to this
> connector.
> 
> The split is not perfect because wkup_gpio0 is defined based on what is
> common to all variants having the connector, thus containing also
> connector-unrelated information. But this is still cleaner than
> replicating this node into all 4 variants.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .../ti/k3-am65-iot2050-arduino-connector.dtsi | 768 ++++++++++++++++++
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 753 -----------------
>  .../ti/k3-am6528-iot2050-basic-common.dtsi    |   1 +
>  .../dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   1 +
>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts |   1 +
>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |   1 +
>  6 files changed, 772 insertions(+), 753 deletions(-)
>  create mode 100644 
> arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
> 
> diff --git 
> a/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi 
> b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
> new file mode 100644
> index 000000000000..cd86f412b837
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-arduino-connector.dtsi
> @@ -0,0 +1,768 @@
> +// SPDX-License-Identifier: GPL-2.0

This and elsewhere in the series should be

// SPDX-License-Identifier: GPL-2.0-only

as fixed up by Nishanth in [0]. I can fix that locally, let me know.

[0] https://lore.kernel.org/r/20240122145539.194512-16-nm@ti.com

-- 
Regards
Vignesh

