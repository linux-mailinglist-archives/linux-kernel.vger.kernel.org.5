Return-Path: <linux-kernel+bounces-165267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E78B8A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DA61F212C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA551C30;
	Wed,  1 May 2024 12:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NIM6nKvn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69063FB3B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567632; cv=none; b=legsIVib2C6xAtmGzRK/Aa8ncNdDv+wM7fFLoU08Yb1mD7qdkzyzQgQTZFpo0xFU7a7ZtQCOX9tj/2tmyZNx9VTbev8JMx+ZRuiZlUWTDXMdxGplx3kXvVD5tt53/89sYeN0wdZ2eOecurpaP3J4K4JZQ4/aW/8oj80kJdJ1Rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567632; c=relaxed/simple;
	bh=TW/ubFUtbqY2ySBG4W/Q4Xq02IsSZRBT1zPsyquEBV0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUAggA26iPWtq/wOF75ysK6bo33TcU8HLL8Sk0tPFPK2XY0eaLOeKoPtpHffgJH+7BfaO3FeRY3/i6ouL3hkHe/kTg+c9VBtqJiF8bJzm76Rk7LZvMiu6V9VaP1opqyfTiPrTwVqVHh3zZZefUUL1nmB2EHNRgpUKbdWVQxgY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NIM6nKvn; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441Ckxqp093699;
	Wed, 1 May 2024 07:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714567619;
	bh=sVQNjTB3YsNS9qiey7NxwbY5ofBo97tqC1wJrppDR4E=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=NIM6nKvnhHUtp2sWHMGEgbdIV7NroDKbqwAwC7FxdL2TNC4oMgbacdprW9P1wXsm3
	 HpNl/XsYzbyjf2+GDZyVUCyZuUx5Dx6SUDQjDThIleEPCYPBME29l5wS/lAslkH4W0
	 sHZo6NF2ml+uB4z9GQs3RLYV0a97PzjJ5mSP7Zl0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441Ckx7J028170
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 May 2024 07:46:59 -0500
Received: from lewvowa01.ent.ti.com (10.180.75.79) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 07:46:59 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by lewvowa01.ent.ti.com
 (10.180.75.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 1 May
 2024 07:46:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 07:46:59 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441Ckxsv028787;
	Wed, 1 May 2024 07:46:59 -0500
Date: Wed, 1 May 2024 07:46:59 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Tony Lindgren" <tony@atomide.com>
Subject: Re: [GIT PULL 2/3] ARM: dts: ti: keystone: Updates for v6.9
Message-ID: <20240501124659.vmvl2ahad4nrsbbc@sizable>
References: <20240501124309.3cj5b3gjf3cpimut@outsell>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501124309.3cj5b3gjf3cpimut@outsell>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Sigh.. The $subject should have stated v6.10 instead of v6.9 Here.
Apologies on the mixup.

On 07:43-20240501, Nishanth Menon wrote:
> Hi,
> 
> Please pull:
> 
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-keystone-dt-for-v6.10
> 
> for you to fetch changes up to 60242b20fe784ef9142050be8b68bd85e94be557:
> 
>   dt-bindings: arm: keystone: Remove ti,system-reboot-controller property (2024-04-09 11:05:19 -0500)
> 
> ----------------------------------------------------------------
> Keystone2 device tree updates for v6.10
> 
> Generic Cleanups/Fixes:
> -  Remove custom ti,system-reboot-controller property
> 
> ----------------------------------------------------------------
> Andrew Davis (2):
>       ARM: dts: ti: keystone: k2g: Remove ti,system-reboot-controller property
>       dt-bindings: arm: keystone: Remove ti,system-reboot-controller property
> 
>  Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 5 -----
>  arch/arm/boot/dts/ti/keystone/keystone-k2g.dtsi            | 5 -----
>  2 files changed, 10 deletions(-)
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

