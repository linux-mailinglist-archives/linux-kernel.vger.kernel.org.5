Return-Path: <linux-kernel+bounces-161760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA98B50D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5941C21672
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6210A3B;
	Mon, 29 Apr 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="izBL91tb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AFDF59;
	Mon, 29 Apr 2024 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370112; cv=none; b=b+5C93ZiAdFeVEPOuF5DbAfpg0iENle4LH90RjdsH68nJorUmz6bqyQADa7yjv8wLH4QIkkUUtvKIImPOKPBZ7JoejYNVAh/OsU71tHerYdBh5luP5JWT30QWL51EVyxjRFjYX/L5s7O7e+/+WMSgHi3lyPy5z7nCbajnkq0b3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370112; c=relaxed/simple;
	bh=eX3H8wIHM0FiZFB+0x0D89Bzoy/mfyWPnroB4QnwF4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DNPy06pBHtd/kW9heQvUH/2UTJSTm2s4OEAbayTnrWMbVlQLijLdl7HDbtRvPwrg9ZyeomKE3FCvXDHmy3fThYGsgBMm9LhuOUizyKpSYy2xwplnarPs5iU/ctcD2WYLRyctdPpFav34of1LcUvQFNS6iewA7TJA6qD7y1NrCx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=izBL91tb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43T5svHD072170;
	Mon, 29 Apr 2024 00:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714370097;
	bh=gLzy6b8OJzfnnQC7tsrjEadostV0B9ZF2+TL8e/KtDY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=izBL91tbOV2BdJNXdqzxBLj8xOluaLxal4ZexGf+deAsojZnQ9LqFekcG1WntIkCf
	 NxDj2Xc2rNzXVFKBBU53YfdgmoRY6YgSaFrngJfLdI0U4M1wuC/fmB6kCuUQZMd7Fx
	 1jeALg5N44kJ7kAOL3rVrM1XXPBoPwarYgscj5zg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43T5svsF071960
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Apr 2024 00:54:57 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Apr 2024 00:54:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Apr 2024 00:54:56 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43T5spBo097279;
	Mon, 29 Apr 2024 00:54:51 -0500
Message-ID: <f6ef8692-246e-49a5-952f-d371a87a70f4@ti.com>
Date: Mon, 29 Apr 2024 11:24:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX Coalescing
 based on hrtimers
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240424091823.1814136-1-danishanwar@ti.com>
 <98588a89-4970-4d75-be8a-ac410d77789f@lunn.ch>
 <1c5809f2-b69d-48d1-8c27-285f164ebeb8@ti.com>
 <2a4bea87-04bf-4373-8220-69650b435710@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <2a4bea87-04bf-4373-8220-69650b435710@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 25/04/24 6:19 pm, Andrew Lunn wrote:
>> I did some benchmarking today with,
>> 	1. Default driver (without any IRQ coalescing enabled)
>> 	2. IRQ Coalescing (With this patch)
>> 	3. Default IRQ Coalescing (Suggested by you in the above patch)
>>
>> I have pasted the full logs at [1].
>>
>> Below are the final numbers,
>>
>> ==============================================================
>> Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
>> ==============================================================
>> Default Driver           943 Mbps    31%      517 Mbps  38%   |
>> IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
>> Default IRQ Coalescing   942 Mbps    32%      521 Mbps  25%   |
>> ==============================================================
>>
>> I see that the performance number is more or less same for all three
>> methods only the CPU load seems to be varying. The IRQ coalescing patch
>> (using hrtimer) seems to improve the cpu load by 3-4% in TX and 13% in
>> RX. Whereas the default method that you have suggested doesn't give any
>> improvemnet in tx however cpu load improves in RX with the same amount
>> as method 2.
>>
>> Please let me know if this patch is OK to you based on the benchmarking?
> 
> It is good to include benchmark results in patches which claim to
> improve performance. Please add the default and the patch version
> results to the commit message.

Sure, I will add the benchmarking numbers in commit message and send v2.

> 
> The numbers show your more complex version does bring benefits, so it
> is O.K. to use it. I just wounder how many other drivers would benefit
> from a one line change.
> 
> 	Andrew

-- 
Thanks and Regards,
Danish

