Return-Path: <linux-kernel+bounces-137653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720C89E522
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5661F23369
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D6158A35;
	Tue,  9 Apr 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VYsHSsqE"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D4158851;
	Tue,  9 Apr 2024 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699086; cv=none; b=I8V6ZkuKErYE4g+HnNYFfmDHaWiIFfxb9JNtg3k6SZzU38JAiLiIMxIEPjgcrX76up7VJNiGoijVN1mAvlOIgljobDKIErwgaQOybcJ7ip7Tg2OAQcO9HFKok5DWhijKDMJw1rC3WhO9e/Gj2bU45LW5qA8wmkx1P5/uoH2qAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699086; c=relaxed/simple;
	bh=9AniVrmVEwjQQ91ny9Uuu92Ev9GZHv7gYh3BV+EJVvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JZLuXUklFut1R3EJW4cZspCts5mJTZYLRmVbebbJlWiRaeRhCdCPkGxUnG2+2rUBV/JhpRx/GzWrU2soMzPjbHOa+7paQfYGamC2CAOb6kit8Yh0tby6HUrZgl/85CX1png7rXNogU/bY7gjOsRSwBDnmLAA4iteXlgvSBZIxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VYsHSsqE; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 439LiQRk004818;
	Tue, 9 Apr 2024 16:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712699066;
	bh=6jGZr9jb/pRBatR/Kljqu36LgjlgOFEHyb73BCXCNbM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VYsHSsqEPUobLUljx6cz4GA5FVFaZv87np0wQT9/atjtfegoPU3JIjK2n7H9nPSz3
	 tTydrdAOPmcyT67gtzLFgf43Mp6xZhjXm/YxHEnYNhNhXq0rZthdRuoFjdkEbZ1dOK
	 lnVd8CZYk0L1sJSYct9/Yr8zKio2x+BEON1M3p/M=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 439LiQaJ003856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Apr 2024 16:44:26 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Apr 2024 16:44:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Apr 2024 16:44:25 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 439LiPKr059974;
	Tue, 9 Apr 2024 16:44:25 -0500
Message-ID: <e1d1aad3-0635-45e1-9470-6398a04820d0@ti.com>
Date: Tue, 9 Apr 2024 16:44:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to
 accommodate 5% safety margin
To: Francesco Dolcini <francesco@dolcini.it>
CC: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck
	<wim@linux-watchdog.org>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240404153319.1088644-1-jm@ti.com>
 <a148e8ab-f502-45ec-b915-22fce751ad64@roeck-us.net>
 <a7b0baba-56bc-47ca-9494-0178f441ff8b@ti.com>
 <ZhWchn3qr_7Ocggm@gaggiata.pivistrello.it>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <ZhWchn3qr_7Ocggm@gaggiata.pivistrello.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 4/9/24 2:52 PM, Francesco Dolcini wrote:
> On Tue, Apr 09, 2024 at 02:37:15PM -0500, Judith Mendez wrote:
>> Hi all,
>>
>> On 4/6/24 8:01 AM, Guenter Roeck wrote:
>>> On Thu, Apr 04, 2024 at 10:33:19AM -0500, Judith Mendez wrote:
>>>> On AM62x, the watchdog is pet before the valid window
>>>> is open. Fix min_hw_heartbeat and accommodate a 5% safety
>>>> margin with the exception of open window size < 10%,
>>>> which shall use <5% due to the smaller open window size.
>>
>> Please do not merge this patch, I will add an additional
>> patch removing the hack in this driver.
> 
> Is the patch buggy, or you are just talking about an additional clean-up?
> If it is an additional patch and this code is fine, why holding it back?


1. If we leave the hack, the hack shifts the valid window. This
is not desirable behavior. It is better to add a safety margin
that works in all possible scenarios.

2. 5% safety margin works in almost all cases except when the
timeout is < 5s. This due to a requirement of a min of 0.25s for the
safety margin due max possible error. At < 5s timeout, 5% is not
enough.

I am not 100% sure if using < 5s timeout is a real use-case
but I would rather use a safety margin that works for all cases.

~ Judith



