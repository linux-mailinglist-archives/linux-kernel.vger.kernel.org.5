Return-Path: <linux-kernel+bounces-128342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA50895986
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D3E281B05
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D414AD2B;
	Tue,  2 Apr 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dIVWhDWj"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FD14AD25;
	Tue,  2 Apr 2024 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074785; cv=none; b=DDTbnJhV1hJ+NYExC73CwTRdTG8yKJ+xzlV8wl2p8W9yCnIkp16P0g+m2FjT1ZuPbSiGJ9BMEfbTzFONUchOa4E1Tze6d8DDuyLA11ftVtr8Gl2srhd0PpASGbG5axcQEdfWWOgTzmQzDG+FyFyVba5hMlyxa2KDThbE3LHG8EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074785; c=relaxed/simple;
	bh=X9540VTay3zPpd4CPsgRiEW9bGd7VHUS+RXehncyU9g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0lU4vxg8dmacla0jBrEEiiT9ri9wkA2/OgK2pBFRm7HSirZWNW5KG/fsruCSelTMLV9DQSHM6MqYiVl4CTnWHGDS5Mcu97CjLYfo8La6M4yJjtJ7CjOIkM8DEIRsTlS2nfpV+Q5vbWyDa87uK3r4p3hjCAGF72mR4lxKCDh3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dIVWhDWj; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432GJcgd110508;
	Tue, 2 Apr 2024 11:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712074778;
	bh=3bPzPP4K+H+1BMu8dI3Eb36lsIJOQUgjHONZTtR7D0c=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=dIVWhDWjYPzsX1dessVLw7SJEWObLdDRlrlCX4BDCuihLjOLkHB+BFZBqU29TGjFV
	 3kcGJIdo3dVAjowsUx3nup3UUwukdx/kmG4gBBk8XP7u7CH+77idHPkuijdMr8Sooj
	 rqe/FU08Lp/8qTcLPw2opeEEzI2W5T9XYPNK1O0Y=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432GJcal039517
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 11:19:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 11:19:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 11:19:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432GJbDw093535;
	Tue, 2 Apr 2024 11:19:37 -0500
Date: Tue, 2 Apr 2024 11:19:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Michael Walle <mwalle@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s: Disable ethernet ports by
 default
Message-ID: <20240402161937.dbfpyfmirs4cjytp@amendment>
References: <20240402151802.3803708-1-mwalle@kernel.org>
 <20240402161306.tkg35heqlwqxoaua@another>
 <D09RSRPKV9L9.2TS01DA84TEKK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D09RSRPKV9L9.2TS01DA84TEKK@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 18:16-20240402, Michael Walle wrote:
> Hi,
> 
> > This is better at arch/arm64/boot/dts/ti/k3-am62p-main.dtsi.
> 
> I'm fine with that, but be aware that we'll also change the am62p
> SoC dtsi in that case.

This change is valid to me (sigh.. it's been a whack-a-mole as you can expect).
62p and j722s/am67 are too closely related anyways.. but, this will need
to percolate consistently to all k3 SoCs.. (different problem).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

