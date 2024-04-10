Return-Path: <linux-kernel+bounces-138807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524A89FA97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C181F30BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575F178CC7;
	Wed, 10 Apr 2024 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k1LB4Rrm"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432D174ED5;
	Wed, 10 Apr 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760475; cv=none; b=tJiXP7DS9ORqJ1KC8J8hRwtAlgPKERI79xrJHfzRA24vTv+rYa6M9mSBoVwrGyfRu+9VtYwsIi/uJ8zdAjQykDyOJTVpy6wazDyeKZPy3Q+j+X1pJluTUx92Okji5TruZXtmTpDTLklyglOft7rstG3fSgg81gqd2TxNQBt3T48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760475; c=relaxed/simple;
	bh=Ba8Muqof+9JBG9pxYvD1gIhVwXrgPfJ0OrHRZY+g3dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LteO501oSr/DbG6yZzcgRW4/jCX9fyEv9NaTREG6rEeT0f5QM/N99gBzFIz/vOzQV5OSOQwQOChtiRY5BsvBCiG0bbZwiU/IHlJ0kqLAZYXuEpAqW/0TSTJLsVCLeuZCCOUIhwHVa6uwYvVh/l8lxcTCQzOah+DCmTmHld66Hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k1LB4Rrm; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AElkqK083175;
	Wed, 10 Apr 2024 09:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712760467;
	bh=S3ifYyhWzJGFkrlNiF/gne+4NFe8fCiiNgj29hFN1Ew=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=k1LB4RrmGnZ0IPOFec3L/bEt5pgAycihKKCIBfswywYeMvY1f/6oTQZ85vl4bm8TM
	 7RsDQ8Xchwzxw5uPI2HAjFnOcUJzorXajUj6kvQPRK7oBGhou4xslltVTMuLPAI+Pu
	 xF1skHJqasoaBz92DPjj1SS7OaalE7bjpsyxa8KQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AElk0i073289
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 09:47:46 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 09:47:46 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 09:47:46 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AElkhG039070;
	Wed, 10 Apr 2024 09:47:46 -0500
Message-ID: <75bb4c75-fa76-49b0-a969-88dca12fb1bf@ti.com>
Date: Wed, 10 Apr 2024 09:47:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
To: Robert Nelson <robertcnelson@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Kridner
	<jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>, Tony
 Lindgren <tony@atomide.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <ZgME0qSL3KXCD07I@chinchilla> <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
 <CAOCHtYhODiMHWA17EQD7YsZ08Uocy5A=kbjH5vjUUaXAopnxeA@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAOCHtYhODiMHWA17EQD7YsZ08Uocy5A=kbjH5vjUUaXAopnxeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/5/24 10:39 AM, Robert Nelson wrote:
> On Tue, Mar 26, 2024 at 12:36 PM Andrew Davis <afd@ti.com> wrote:
>>
>> On 3/26/24 12:24 PM, Matthijs van Duin wrote:
>>> I'll write a more in-depth reply when I have a moment, but right now I'd
>>> like to point out that the uio-pruss driver in mainline linux is for the
>>> pru subsystem on the freon/primus family of ARM9-based SoCs (OMAP-L1xx /
>>> AM17xx / AM18xx / TMS320C674x / DA8xx), which is not currently supported
>>> by remoteproc-pru.
>>>
>>
>> I'll wait for your full reply, but a quick note, for those devices listed
>> this driver isn't usable either after they all moved to DT. As this driver
>> never got a DT port and relies on platform data (which is gone for those
>> couple devices).
>>
>> Andrew
> 
> Andrew, I think we are okay with nuking the whole uio driver in
> mainline, I'll ack it..
> 

Okay, will send that patch.

>   I figured we'd have more community response..  We gave them a chance..
> 
> The only issue I personally have with supporting remoteproc-pruss
> 
> We have a few users on 4.19.x-ti, 5.10.x-ti (remoteproc_pruss) can we
> please make sure this project:
> 
> https://git.ti.com/gitweb?p=pru-software-support-package/pru-software-support-package.git;a=summary
> 
> actually works on mainline remoteproc_pruss ?
> 
> Watching the shortlog, it must break on every single TI LTS release:
> 

Yeah, before we got the remoteproc driver upstream we managed
to break it just about every LTS, it *should* be a bit more
stable now that it is upstream..

> https://git.ti.com/gitweb?p=pru-software-support-package/pru-software-support-package.git;a=shortlog
> 
> Whereas uio... well same firmware from 3.8.x ;)
> 

That is one benefit of the microkernel style "just expose raw memory
to userspace as a driver", it sure looks simple :)

Andrew

> (i will keep our uio fork alive, but we just use an overlay to switch
> to between remoteproc_pruss and uio)
> 
> Regards,
> 

