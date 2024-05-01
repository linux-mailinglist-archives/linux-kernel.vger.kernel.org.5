Return-Path: <linux-kernel+bounces-165266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14718B8A3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774C91F2355E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9552F74;
	Wed,  1 May 2024 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fiJTEeXP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109A1DFF0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714567608; cv=none; b=ScdKovbtRl1cHNxMoA906rULHvPTq/gwXa+fBjxPGiMI/mkHaCu0BstQBr3xgLrxW1UnmmKlPqTTHxadrOqI+AKIehF28AX4mSfzIs/KI7Wm7cqh6i87V/He8Q2ySIxj8QhL3cgd3bT+Vts/0SOwhdEjNsS9EexiPKPwbKgxoOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714567608; c=relaxed/simple;
	bh=+MubC/KGi3R5Z/KvIdjNuyey5DrtTZwgztb8yzdUoxc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaauelg/01ixzCUHreqmXYa00ORxJ11sUJo/LpPZd37L1GoQ+dTM7ypBD2IlM0yTcuLlcleZchb3lNdI1X5yWbZAN4L14tQQfZ5LZRq3+/ths29uEg/T7TzuyeF1xN3dhdveNHVaxASbQTEYOml+Qw9UGKZHaQVvqPzxBRg+fkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fiJTEeXP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 441CkaMI075050;
	Wed, 1 May 2024 07:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714567596;
	bh=KUVfbo0nuQr8dsfxZADNos1NSoNYG5x48bUxkFbrq4Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fiJTEeXPiB76ZqWofRRoDWlbzr/BAq6pnh1gI1Nig18XFOzD4yAL6td9nDC4UwTQ9
	 AcIFFstB67BHI/IhBOPxIf+BrL0hFexT2Mnxky1ZvjgIUzZAKTKSHxX2HP3rwDJNmb
	 POqBt5RfGR9UfJiKuXo2HqhKuzoqZSZ/A7cJbKxs=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 441CkaSj035444
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 May 2024 07:46:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 May 2024 07:46:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 May 2024 07:46:36 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 441CkZ0M028184;
	Wed, 1 May 2024 07:46:35 -0500
Date: Wed, 1 May 2024 07:46:35 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/3] soc: ti: Driver updates for v6.7
Message-ID: <20240501124635.ufcuolkw4dzybhco@parcel>
References: <20240501124300.i5jzeugdlrlnfg22@undrafted>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501124300.i5jzeugdlrlnfg22@undrafted>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Sigh.. The $subject should have stated v6.10 instead of v6.7 :(

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
>   https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driver-soc-for-v6.10
> 
> for you to fetch changes up to ddbf3204f600a4d1f153498f618369fca352ae00:
> 
>   soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message (2024-04-09 11:11:59 -0500)
> 
> ----------------------------------------------------------------
> TI SoC driver updates for v6.10
> 
> Generic Cleanups/Fixes:
> - wkup_m3_ipc: Minor optimization to send NULL dummy message instead of empty pointer message
> - ti_sci: Register restart handler unconditionally
> 
> ----------------------------------------------------------------
> Andrew Davis (3):
>       firmware: ti_sci: Use devm_register_restart_handler()
>       firmware: ti_sci: Unconditionally register reset handler
>       soc: ti: wkup_m3_ipc: Send NULL dummy message instead of pointer message
> 
>  drivers/firmware/ti_sci.c    | 24 ++++++------------------
>  drivers/soc/ti/wkup_m3_ipc.c |  7 ++-----
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

