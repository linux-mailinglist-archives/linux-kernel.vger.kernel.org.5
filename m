Return-Path: <linux-kernel+bounces-151055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECD8AA869
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAB8281A54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E06219E2;
	Fri, 19 Apr 2024 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VfFrDAQc"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0A18AE4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507949; cv=none; b=hKfpucZ8uhdy5vh6rfXIoxRYVC2NtROi0WN9p7EIiQuk5Y+Opp3tbJwLhyuIHiTBM3/uB4ANwE8jRNdXtaVwXWw85LOjWxDvOkvTC5h2YTcW4BYazvv/2obhX7V9MHDgeDhqcUKwY0BPpOgCcd5teQqYFTVEf9D5fSmBxqbt5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507949; c=relaxed/simple;
	bh=PEmen8KQ1DIBf9Otagg92aPpYkHTn+urBtIzAd8eVIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sb7qrcuKnZS9w5JtSseLE1JLPPeyRUwnBp3AkYxV9K/nYcJN/dhPRHjeGduK80chDRlopWGOOMHwuaPvOj1pN0mqUUa/+gNB2fYwuZ9ho2f42YnpbqTQi5jpJs5r8zzEQl33ps5UddPlh6vX4rnEmsJ3mFHWQXhlBbz+drMc4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VfFrDAQc; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J6PTXG000382;
	Fri, 19 Apr 2024 01:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713507929;
	bh=XqF2DKZahdNVlibUU1nTRWzVc/LqYgGWka7+4CPt6TY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VfFrDAQck8kFYKkFO39agfltdC0hNM0YBIZBs5pwKIzbeBofv2+GOhMDVRiD3/+6O
	 M/02Hu2mPabF1WkNN6o6L6/ApwqgA5tL6HIziGPfeQVfE2vrSSr4kehkECGihhYdwC
	 iTXKmBVhx/7kgDUG1kMF+unkFrh1bGq5xDOhGXuY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J6PT0T026176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 01:25:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 01:25:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 01:25:29 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J6POJC078295;
	Fri, 19 Apr 2024 01:25:25 -0500
Message-ID: <2bcdf17c-c640-7c87-88eb-f465f8c78263@ti.com>
Date: Fri, 19 Apr 2024 11:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC: Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Ravi Gunasekaran
	<r-gunasekaran@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
 <4d63cbaa-63d9-49fa-bbf0-b3bc62ebfb36@app.fastmail.com>
Content-Language: en-US
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <4d63cbaa-63d9-49fa-bbf0-b3bc62ebfb36@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Arnd,

On 4/19/24 11:32 AM, Arnd Bergmann wrote:
> On Fri, Apr 19, 2024, at 08:00, Ravi Gunasekaran wrote:
>> HSR is a redundancy protocol that can be realized with any
>> two port ethernet controller.
>>
>> Many of TI's K3 SoCs support multi port ethernet controller.
>> So enable HSR driver inorder to support this protocol on
>> such SoCs.
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> The normal way this gets picked up into mainline is that you
> send it to the K3 platform maintainers (added to Cc) and they
> send me a pull request or forward the patch to soc@kernel.org.
> 

I usually do that for TI specific patches. This one seemed like a
generic one as HSR protocol can be run on any multi port ethernet
controller. So I wasn't sure about including TI maintainers. 

But no harm in Cc'ing them. I will follow this advice for future
patches.

>     Arnd

-- 
Regards,
Ravi

