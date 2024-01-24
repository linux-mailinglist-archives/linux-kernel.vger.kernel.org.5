Return-Path: <linux-kernel+bounces-37343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8CC83AE87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3AD1F263F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5C7CF31;
	Wed, 24 Jan 2024 16:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kuZDZlNL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205A7691A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114491; cv=none; b=DW3Osr8XJdsBp5id3fyJ5vq7ICJaRO22pjyJKBRMTD2RApQqvpjwKPcrw677fT1gPK81FWwea2D1s2RW2K9pSZ5CnakHjAkTlpgVxgue+dq2gS08NGHb7RWwnnvqKzZwZdBfrJSg+k0IId7uK6KNpoLYtCKjujRdpUuM9WwtCMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114491; c=relaxed/simple;
	bh=EY5T98Ikwh/Cff/JRGa4DnYWeQbcAuML2xJiE1P4T6E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ32AEpBv90sZGvDVcZxbAVpzvkmMU2NXXs3zn7QTx971OcwQ6Cf30v70kKDCmwx2G2HNp/WInlJBmPMkiDHeBT1jALfsAxW679acPO4cor3Y5GSPkrjEKAydV+mFvwW6EKxtdahBofYl6TF0xbMLBP0+j4H9X3QfCuUNNmiNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kuZDZlNL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OGfGPV059857;
	Wed, 24 Jan 2024 10:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706114476;
	bh=p9pdHt4QofTqYFvzDomPY2bcOHYAht+kNqYp2CE1JcU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=kuZDZlNLtCWaF3DbfmgeUkXrWBCg7zS30vYJhBO6tSTEHSanYk5QcZQTAaRj8tgm+
	 EkcYDiHDyUyYmdl/bi6NHeDjU/JggCj2tCthqEz0/1SvgG99DA8g/LfW4i3yq1tVFa
	 18ns+3Z173DF6K74jUgiqwsC0FRcxOaUZ10GAt2w=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OGfGDg130719
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 10:41:16 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 10:41:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 10:41:16 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OGfGMo124796;
	Wed, 24 Jan 2024 10:41:16 -0600
Date: Wed, 24 Jan 2024 10:41:16 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Message-ID: <20240124164116.k5ah56xvuclfkxdr@despise>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124162857.111915-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124162857.111915-2-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:28-20240124, Andrew Davis wrote:
> TI Keystone devices can and should use the common multi-v7 defconfig.
> Currently it is not clear which defconfig should be used and so config
> options for Keystone boards are added to either both defconfigs, or only
> one or the other. As nice as it is to have a config just for this platform
> it is a maintenance burden. As it is not used by generic distros it is not
> very useful to continue to maintain. Remove this defconfig.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/configs/keystone_defconfig | 238 ----------------------------
>  1 file changed, 238 deletions(-)
>  delete mode 100644 arch/arm/configs/keystone_defconfig
> 

There are a bunch of downstream folks who will have recipe fails etc if
we do that. I am not sure we need to go down that route.

I know we had intent on multi_v7_defconfig -> but as far as I recollect,
at least during armv7 it did'nt exactly pan out as it did on armv8.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

