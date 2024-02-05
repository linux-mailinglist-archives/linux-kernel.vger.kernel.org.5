Return-Path: <linux-kernel+bounces-52844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19278849D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C0287E88
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2C12C688;
	Mon,  5 Feb 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bFFWQzef"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39252C1A3;
	Mon,  5 Feb 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144616; cv=none; b=kTJPJNSJCzItAS5VkxxPAMJGRsuNKfukWr4L4UX+3RHLrYpcbG2PJBVuZ2Kvm4rn31IIQqdqefzm2l5giv+IcPWCpR/7Z2kiblAj89fosk4ed8SeGdi8aqoYAJYIhK01/+QY18MYMnxsrmGwmny9NCth9KVeQlDJRRSSCl7jWxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144616; c=relaxed/simple;
	bh=5WTRDT0iWZcYT9Equ2fzP9IJqfiG/l7YotgxFwbMsy0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgQ+RsRA2qLsi7kuX7nvmfHdQOqNNqVRfxHbQXfQ8EmwJSObHgDsFj87rMjWsLqRpekzaDS0v/fatmbxHOoCkx0HXWT2RD98Z/1ZTGFFA+pFOzHc/Pz+Sa1W9r41++CVN6cGzCSUKRZKZYsktwm1xFiJAsNZTwe6VQMWV80aDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bFFWQzef; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Eo5IN038916;
	Mon, 5 Feb 2024 08:50:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707144605;
	bh=rFao23tD1GaHNE3daEZ6EYR019Z9WK7PSs9NxgAa+J0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=bFFWQzefS4IqvBNZBS5G8GazN4qn2Ep54v7g+LW5wwEI4TuAhVtI1Y5TzEqGUAKrj
	 hbyAPAu99ALU4lkOPM9D6WPWM/8gr3feFLT24jrc4FKQSsghSJKytB7zG+NLmzR5aQ
	 pRMz1fjc8n/63twaLIlBc3fJ0sQJ2cSIUtWoz738=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415Eo5p9027004
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:50:05 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:50:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:50:05 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415Eo5u2117959;
	Mon, 5 Feb 2024 08:50:05 -0600
Date: Mon, 5 Feb 2024 08:50:05 -0600
From: Nishanth Menon <nm@ti.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH] clk: keystone: sci-clk: match func name comment to actual
Message-ID: <20240205145005.6yauznc7qbfbrs4l@banana>
References: <20240115001255.4124-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240115001255.4124-1-rdunlap@infradead.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:12-20240114, Randy Dunlap wrote:
> Correct the function name in the kernel-doc comment to match the
> actual function name to avoid a kernel-doc warning:
> 
> drivers/clk/keystone/sci-clk.c:287: warning: expecting prototype for _sci_clk_get(). Prototype was for _sci_clk_build() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

