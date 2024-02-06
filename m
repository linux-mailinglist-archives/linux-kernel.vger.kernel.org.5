Return-Path: <linux-kernel+bounces-55092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A757384B796
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B737287EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449D131E43;
	Tue,  6 Feb 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YbhDIhlY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA0130E4F;
	Tue,  6 Feb 2024 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707228962; cv=none; b=kTJemrD9bnulabFScVnWKrpG/VVAPuBLo3yyz5fantNKrey9nR3qWuAyPWYT4mUyYbYirs+7EGjneMi6FDjQbEubWQs3AewwH89lN30JBLedBfqS0fPJDr4QSIKKqQKXLl1NHyrdsJL88f3QaMkHj2cyJn/tuArl1Qc39uBJH4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707228962; c=relaxed/simple;
	bh=7tlTMuFjAjMwNCwiRRG5+QXtQ/MwY5GdCZoCBOZRQ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=reTxWfGDdrig30C9w1H6retudWqgDi5hjEEbZb36TUCj8O7DyjVoH+MVxEw6ZJH0iguC3BJfbE0ZttIzUuH99+yt0DvkZx1YK1XkjKjF2VNnylMmLr4tfuboJx1BOWoUWd3R5L+6VLAogFN5tBSPvActHjHXuisWacYmsuQHxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YbhDIhlY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416EFqxS034992;
	Tue, 6 Feb 2024 08:15:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707228952;
	bh=5nhVmZo58knSfgmGXShQ9V9c5OqXdispK8mj8/jUycU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YbhDIhlYxuExrVyCDQ6BPS5QMnHgtsssuDl7F1yQWn8/SpowBxrY/Xp80bvoqBehh
	 J3xwCNaF8+pPkRqI6PSQcT1geK7Se87IvDExEa6V+uEAA1hp3wkgRVYl5TG88wX9Ri
	 yfrBUmPYDQgx28Vt8C4sYMRzvr+zoZuk+e60tFSo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416EFqu2070971
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:15:52 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:15:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:15:52 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416EFlZI104081;
	Tue, 6 Feb 2024 08:15:48 -0600
Message-ID: <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
Date: Tue, 6 Feb 2024 19:45:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Content-Language: en-US
To: Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>,
        <chandru@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
 <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/6/2024 7:24 PM, Kamlesh Gurudasani wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On 16:13-20240206, Udit Kumar wrote:
>>> Most of clocks and their parents are defined in contiguous range,
>>> But in few cases, there is gap in clock numbers[0].
>>> Driver assumes clocks to be in contiguous range, and add their clock
>>> ids incrementally.
>>>
>>> New firmware started returning error while calling get_freq and is_on
>>> API for non-available clock ids.
>>>
>>> In this fix, driver checks and adds only valid clock ids.
>>>
>>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
>>>
>>> [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
>>> Section Clocks for NAVSS0_CPTS_0 Device,
>>> clock id 12-15 not present.
>>>
>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>>   				while (num_parents--) {
>>> +					/* Check if this clock id is valid */
>>> +					ret = provider->ops->get_freq(provider->sci,
>>> +						sci_clk->dev_id, clk_id, &freq);
>> get_freq is a bit expensive as it has to walk the clock tree to find
>> the clock frequency (at least the first time?). just wondering if
>> there is lighter alternative here?
>>
> How about get_clock? Doesn't read the registers at least.

Said API needs, some flags to be passed,

Can those flag be set to zero, Chandru ?


> Regards,
> Kamlesh

