Return-Path: <linux-kernel+bounces-122823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868F688FDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC8D1C23CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8747D41D;
	Thu, 28 Mar 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LBTiN42C"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0451C5F;
	Thu, 28 Mar 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624755; cv=none; b=DLocvNnPLcuOirKUK43eUheFVSQ9PM8pOch4TsoYfawpgiGamBnG+2gcStkv0GvlKbKwSEArKy8FJvvB+bI6oUlIGrKjxxVJoOKBB97+xbP3/Xhbv5PWAWTACXfvxxVIb+R2a1zePmj7woEO/s8pVWueWIRgKAl1aA88pxryCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624755; c=relaxed/simple;
	bh=j139NcbyoT6+stNc55OnWsyX0oek8QNy4nAdYuoTMj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAB0/UPySRl1EEinAQeUosPR7SvYjInAz8qzpqOwxAdbKedGdr88sOI7YN9WOl8bxYT8BNNR7QbRMJH2YrTyqstGeNAIqB0I+V7WjRtlCHn3HhgWTQ4dTeqPoWUPEBHYtWZ5Hhmyuw/MyH6rAj8tLFqUwlpCcSeqfW0Ln6HGqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LBTiN42C; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBJ9kh126347;
	Thu, 28 Mar 2024 06:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711624749;
	bh=1nLFAzopFcMqODaauIPuknNgvuL6g7M6Vfn48OndlN0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=LBTiN42CsPV0n0hqPvBU0+y71o9CCl0IJf+Wfd3qiDhYKG7u9H2Au4N6najDFUPzN
	 mdA0fzyt1YLq3cEdRm96ufsnk8KXe3d2lIygW6Hf966+v/5RkqCg0DT2IraZTSNKjq
	 hnc7yMVbyEmoybEOd1PxTWr6GtyL9xJgeg8DPU3c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBJ9ha097918
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 06:19:09 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:19:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:19:09 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBJ8Cp086654;
	Thu, 28 Mar 2024 06:19:08 -0500
Date: Thu, 28 Mar 2024 16:49:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
Subject: Re: [PATCH 2/5] bus: ti-sysc: Add a description and copyrights
Message-ID: <20240328111907.cknfqe3qpiyeipsp@dhruva>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-3-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327081508.36747-3-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 27, 2024 at 10:15:05 +0200, Tony Lindgren wrote:
> The ti-sysc driver is missing coprights and description, let's add
> those.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
> --- a/drivers/bus/ti-sysc.c
> +++ b/drivers/bus/ti-sysc.c
> @@ -1,6 +1,17 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * ti-sysc.c - Texas Instruments sysc interconnect target driver
> + *
> + * TI SoCs have an interconnect target wrapper IP for many devices. The wrapper
> + * IP manages clock gating, resets, and PM capabilities for the connected devices.
> + *
> + * Copyright (C) 2017-2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Many features are based on the earlier omap_hwmod arch code with thanks to all
> + * the people who developed and debugged the code over the years:
> + *
> + * Copyright (C) 2009-2011 Nokia Corporation
> + * Copyright (C) 2011-2012 Texas Instruments, Inc.

+Nishant

I am no expert on the copyrights part of it, but who gets copyright from
2012 - 2017?

Also, for TI should we stick to this format as you did above?
Copyright (C) 2011-2024 Texas Instruments Incorporated
perhaps?

But otherwise,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

