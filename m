Return-Path: <linux-kernel+bounces-59731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37B984FB02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C661C20F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542727E115;
	Fri,  9 Feb 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uWKlbt3e"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D153398;
	Fri,  9 Feb 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707499696; cv=none; b=Ovtg9g2npjAeytNxGYeXGhrrBlOAsOinKVgRL2dURZAcRUL85B+pMo/evQ+MFSjDD2t7RGfZe4GzTLS8AXAtesq5eMXW4qKig+aWUnUdao74s4QAxF85tRmbLHfxD4V5jjkM2RXCc7jJNk8xseyxo1ejGQWq1TwFhubT7h2x5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707499696; c=relaxed/simple;
	bh=gT2MMmQYb6BDxoKJ6012hLv8jiRgdYiZ/k0iLDkFY5I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j12QUvvG7RL/SWF+sPNAyERVFcezbdMUqo3Bb86N1I+LurP/uVjno2MyxBmDRcfRNdJ+i8uq8cyejmTjLgWm2N92YLZRdK5VWT+zDUDLjQM/W5sMqxs4DwbDQV+JcMPhQcXFAPdPG5a6UhQM5Qj4lbve9p/1Va25X8zPiMQRBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uWKlbt3e; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419HRjMN107124;
	Fri, 9 Feb 2024 11:27:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707499665;
	bh=ChMKvF2JsnRfO1wCJ3seSx1YCrX0MD0sAXNdfyh2XCo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uWKlbt3e0mr9rUSIGde9qmnmgxr75d3H3ENeOaNBiEOLNSja7TdeGcqLSHk8wBSYe
	 7PPvhHUoSVToNxUd8aMRbZNYe33Culu+Tvfn4WhG5LO/Lnyh7iUimAW+iKKU9bQJgy
	 8EXXSIHmoA+PrhQfybH6t4lo4Jiqrtb36Gq4AOY4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419HRjh2003793
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 11:27:45 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 11:27:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 11:27:45 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419HRj5N128855;
	Fri, 9 Feb 2024 11:27:45 -0600
Date: Fri, 9 Feb 2024 11:27:45 -0600
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 9/9] arm64: dts: ti: k3-am6*: Fix bootph-all property
 in MMC node
Message-ID: <20240209172745.dswt5q6xnulubrjp@bagpipe>
References: <20240207225526.3953230-1-jm@ti.com>
 <20240207225526.3953230-10-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240207225526.3953230-10-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:55-20240207, Judith Mendez wrote:
>  &sdhci1 {
>  	/* SD/MMC */
> +	bootph-all;
>  	status = "okay";
>  	vmmc-supply = <&vdd_mmc1>;
>  	vqmmc-supply = <&vddshv_sdio>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&main_mmc1_pins_default>;
>  	disable-wp;
> -	bootph-all;

NAK! Read [1]


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

