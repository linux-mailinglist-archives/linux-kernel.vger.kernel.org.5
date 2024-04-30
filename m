Return-Path: <linux-kernel+bounces-164674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD88B80ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3431C25901
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62EA174EF1;
	Tue, 30 Apr 2024 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z8RSWnmg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E019DF51;
	Tue, 30 Apr 2024 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506900; cv=none; b=HHLjI5NI5FdQ1FmFisj6goRzWybHBSL4tV9TeBKuHn6C7Q63zspqDBJ4eM/onTNmsBtQFpgVMDh+67942Bs/rlI+kVzbdmlLtQsbgFoMxp7fXaGfLNlT/xp/YmG7+AUI+vFHF6AO5k2Tc5XQK7sSoNrbRpggblVb96VOVYppkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506900; c=relaxed/simple;
	bh=2LMenNk3zwF8jj5YX4CkqPj+ddO4mvVniF6SINTc7js=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAxgyyosiHwihquhwGgl1vWlDLkmyoEsgoK5xPLHhoLwfnaP6fDmRdKZlLxouu3H4Ckikv79wXfiqibOqBb3526JBTjWP4n01F/9I3Vu6BdJUSV0TJ4cAwsRjsF4zJME+lr8iRALY1HFZwKYO4X4bLjODpfsixOKZNdKALuDGOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z8RSWnmg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UJsmmj026593;
	Tue, 30 Apr 2024 14:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714506888;
	bh=F5F8GLBKKCa6qmNE+znNdTedPxtMFRI3BDE/b7iBunY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Z8RSWnmg/di072ujzDAFsIwSpEUgv0UudsBkL16M5a3oJxNIXN7+5pLiI8uGVV674
	 voHF6Ns38+TNxOonpqPtagZBQoSGw5UH44TewETtNo9UBoCWYPvch750cuEtezOMHJ
	 bbKGtBcgfNqAKEns7+wuJfYO8SE2bxd9Vpj1n65E=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UJsmBs057739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Apr 2024 14:54:48 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 14:54:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 14:54:48 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UJsltf040931;
	Tue, 30 Apr 2024 14:54:47 -0500
Date: Tue, 30 Apr 2024 14:54:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 0/5] MMC fixes for TI K3 platforms
Message-ID: <20240430195447.3kwslkiihfsqoo3u@shading>
References: <20240423151732.3541894-1-jm@ti.com>
 <fa07e1ad-8e86-4f19-878a-26a639b3a058@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa07e1ad-8e86-4f19-878a-26a639b3a058@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:26-20240430, Judith Mendez wrote:
> On 4/23/24 10:17 AM, Judith Mendez wrote:
> > This patch series includes MMC updates for various TI K3 platforms.
> > 
> > It includes support for enabling UHS/SDR104 bus modes.
> > 
> > For AM62ax, add missing UHS support.
> > 
> > For AM65x, fix ITAP delay and OTAP delay and clkbuf-sel properties
> > in SDHCI nodes.
> 
> Please do not merge this series, will send a update v4.

Judith: after discussing offline, I do not see a problem with the
series. The defconfig patch can be send separately (probably next
cycle) - you do not really need to resubmit the complete series again.
- for current users initrd isn't broken anyways.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

