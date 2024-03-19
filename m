Return-Path: <linux-kernel+bounces-107512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5F987FD80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1EBB2242A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AC7F7D3;
	Tue, 19 Mar 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YMFkbvab"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC77F492;
	Tue, 19 Mar 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710851031; cv=none; b=KKzkQ8wRpIKoY4hiYZJEbKsk6shE/Xlup3LDw8pMSu9W3CI2wsofwB4lEO3f1N51qq4qii23Z3FPQRsYg0y0BEQGhPgQUKo77HTpM/8OBzpDSujiUkKHd0K/KPUxPftPa8iPpW6cOQb7rS76ODEBkF+z8iUSiVabD/h3Nf1dayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710851031; c=relaxed/simple;
	bh=SlOln8xPDywR1tWfylM5enltr6blU9v4YSUA3SB4mlo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cotijXgmq9DVmu8z7zYvxw8RBUSxJln2LNqnkaGnPEnA78KoDVAtslFqCUqX3O7dzbmFfPUWjsH7xl6RyW49zSAYay6IBXh8T3CVuEOrUvQIvX4VKf7CP8OWI9jFRu+CfeTjiMe6OCHkcvyMZVq9tjOdVGTxw9cS5KsptngkhHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YMFkbvab; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42JCNgu9004971;
	Tue, 19 Mar 2024 07:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710851022;
	bh=LOb4gIwJ/2H59TvQtXjMoCLrpCHsTI10TG1FqHqP4YU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YMFkbvabu0ATouR0mxLV8Llj5bEpGudOBC7UmxADxCUlgT2O+S713JTQfqI9vmqku
	 RCiE43YOCgd/U+kR1BmTbDvPr6/SnHMAqG8zvnR22GMzJVC0rkph3YPdBrlJmqiO9y
	 qK2haIrmAr7vbGAAn/qX8Pp6zHy3A3RHmn8/GXm8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42JCNgpG021186
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 Mar 2024 07:23:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Mar 2024 07:23:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Mar 2024 07:23:41 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42JCNfrU113825;
	Tue, 19 Mar 2024 07:23:41 -0500
Date: Tue, 19 Mar 2024 07:23:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <s-vadapalli@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <danishanwar@ti.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: ti: k3-j784s4: Add overlay to enable
 QSGMII mode with CPSW9G
Message-ID: <20240319122341.g6v6rjb3snru6223@flavored>
References: <20240314072129.1520475-1-c-vankar@ti.com>
 <20240314072129.1520475-5-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240314072129.1520475-5-c-vankar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:51-20240314, Chintan Vankar wrote:
> +&serdes2 {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;

Here and elsewhere
Please follow https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-properties-in-device-node

> +	serdes2_qsgmii_link: phy@0 {
> +		reg = <2>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_QSGMII>;
> +		resets = <&serdes_wiz2 3>;
> +	};
> +};

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

