Return-Path: <linux-kernel+bounces-55057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EA84B6FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB991C23973
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53313174B;
	Tue,  6 Feb 2024 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XH4nP5lp"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF7E130ADC;
	Tue,  6 Feb 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227689; cv=none; b=ATqJsqeCrRlONJSmb8lBnM4uIEQVXv4hugb2MZhNSDT6iLxgusWV2rop40xCT79cATkKpgiGSmqd7tqPHR32im3zLkAVCynlnY6Nd+u9VCa9keFKqSkHfK27PTqrvdwJdK3JgGdJRKMAmTgHC7Nw2qQ3PKfBBfxtsqOQFY6ktY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227689; c=relaxed/simple;
	bh=cwspKAO4eH9fkWeK1iEeEtmuWAC1bYLef73pUkhyd8g=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWrMiN8uGi62R5tJ+Y5xR5VmQ8IsWtK4M1EoMQmzjZ3KA3zofOPlh5TDYAlzFIo+s+2g0gEw3uxg6mPg3Iy8nLaW2lWrChr0sVoA3d799C1nAJ7y0DAUrNfIURBLJW8AV8QC+ecLx7h1Pnev+jCKr44LNuIs8EgEJz4NrVklBI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XH4nP5lp; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416Dsdp3038974;
	Tue, 6 Feb 2024 07:54:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707227679;
	bh=xOSIvjGwIY11NMwwDwXSjuNlpUjjApvswY4dPoY0ms4=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=XH4nP5lpRQJ9jO9HHICkgfzNzoavmxgCQMHlXZmWi9xJiD06bumBJyfYRJ4Oybru6
	 CcewA/YO4IoPGwkgLXPOM/sPCjpcJRO2vih3PRYthQqOkvVZbEX5wEeTMJXJ73IHYl
	 P2Dh7tRGUYduXSHJoUQOc7FLCRGuONcTAi4948sM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416Dsdu6059864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 07:54:39 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 07:54:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 07:54:39 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Dscua073398;
	Tue, 6 Feb 2024 07:54:38 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <chandru@ti.com>,
        <rishabh@ti.com>, <vigneshr@ti.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
In-Reply-To: <20240206131420.wtitflgav23jto2q@verbally>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
Date: Tue, 6 Feb 2024 19:24:37 +0530
Message-ID: <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Nishanth Menon <nm@ti.com> writes:

> On 16:13-20240206, Udit Kumar wrote:
>> Most of clocks and their parents are defined in contiguous range,
>> But in few cases, there is gap in clock numbers[0].
>> Driver assumes clocks to be in contiguous range, and add their clock
>> ids incrementally.
>> 
>> New firmware started returning error while calling get_freq and is_on
>> API for non-available clock ids.
>> 
>> In this fix, driver checks and adds only valid clock ids.
>> 
>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
>> 
>> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>> Section Clocks for NAVSS0_CPTS_0 Device,
>> clock id 12-15 not present.
>> 
>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>  				while (num_parents--) {
>> +					/* Check if this clock id is valid */
>> +					ret = provider->ops->get_freq(provider->sci,
>> +						sci_clk->dev_id, clk_id, &freq);
>
> get_freq is a bit expensive as it has to walk the clock tree to find
> the clock frequency (at least the first time?). just wondering if
> there is lighter alternative here?
>
How about get_clock? Doesn't read the registers at least.

Regards,
Kamlesh

