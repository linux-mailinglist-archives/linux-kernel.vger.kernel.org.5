Return-Path: <linux-kernel+bounces-37346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E583AE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2577285C08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9C7E578;
	Wed, 24 Jan 2024 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uzTncL3b"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1BB7CF1C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114517; cv=none; b=sxB014HoDfonHcPv5vqg+N1Zh3Qumv1nDEgduuV2ld2Q3JrChw/PFfjjqRb1Qfa5ocU+ls6aX6Dy4DFVhsDiwPAOrWyeiTy84BfdWvj2EQSeVYIi/HUU8BInu3PHzvSIbPPHAtezUcpHQNN5ePQiQwzS7atqEe3J7XheW2VVMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114517; c=relaxed/simple;
	bh=IbvbHqtaj4yq7eFshfycgw/H9L8TR0XfzygGQXv5Uro=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTs9AZWmcX9OiaWD1GQLqU4nLpJs9sDsXWTDV8FtfijbrlKNL/XLy5wJ/iZ2XqEqCgknDMAIpwHeOV3cCSv8XdOT0BX0pc9+gkXpi8gFNAIuG3wj32Y2hEZGj8ZFJhNLIfLx+hwe/1T4ImCfoWeO/UUGWGYjZN/UFUCJmf9XnMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uzTncL3b; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OGffpA059352;
	Wed, 24 Jan 2024 10:41:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706114501;
	bh=LS+fFj/Dp1Hce0ugxwGmNteG7WakNOwL+qwveFyX3fk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uzTncL3bO+i+/7bkpueBsQKXZ8I/+R2IkDz78zseR2zplQSjwRD0IQuK9/H9Oo/UD
	 65LGwvPSK779MLcCXd6v4Ncwxuu1u7r4sfeGqj+8/eJ12x7xZsily5v8Lo+h+MNfG3
	 rUHADKova8NEiDZB+8SbREqYWLID7/kvhmH7eJJs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OGffTs020533
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 10:41:41 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 10:41:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 10:41:41 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OGffO3125175;
	Wed, 24 Jan 2024 10:41:41 -0600
Date: Wed, 24 Jan 2024 10:41:41 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Add more TI Keystone support
Message-ID: <20240124164141.e6sdftiqxoxr6k7t@ravage>
References: <20240124162857.111915-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124162857.111915-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:28-20240124, Andrew Davis wrote:
> The Keystone platforms used their own keystone_defconfig mostly to
> enable CONFIG_ARM_LPAE which could not be added to the multi_v7 config.
> Now that we have multi_v7_lpae_defconfig/lpae.config target we can and
> should use that defconfig for Keystone. Add the remaining must have
> options for Keystone support to multi_v7_defconfig.
> 

Please state bloat-o-meter impact on vmlinux.

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

