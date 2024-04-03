Return-Path: <linux-kernel+bounces-130665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970E897B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A79F1C21903
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1409156968;
	Wed,  3 Apr 2024 22:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QEKv7A2d"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B44F138494;
	Wed,  3 Apr 2024 22:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182036; cv=none; b=CDHo65GzZX76Pw4ucHZ5Ys35h2/tF/d9cz73ywphDP5PpkbO4MqzGUUTdp3K1nusaNqZa3xhQUWEpEpJpDXatwkWzeE0chasqbShnHpIF3uH85J5ITZLZEKBL+z34B7tVvI4z3jNri7QsX1dD5ftqKLtrA4FOFb3qspkNp2SqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182036; c=relaxed/simple;
	bh=Ae1w3hEtb7CWAG+5BUypFnAMi/JIXf3SjPGUhME24yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=chf8oF1mJyUn+LiHuEzMmeUHUhK+V7VL0Z2ajaFcCGFCFtfPx5VFgVjKEXbRYvbpVQPk0+6clBOvJPamrqbOJCKbX+0RtcdoR6gps9w1roNaVynk37ch1mKW4TQwko2ugOD3wcd0ORlD6V0lBBVcrINraGM4uU7YtBTPVH+stHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QEKv7A2d; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433M6ixH101777;
	Wed, 3 Apr 2024 17:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712182004;
	bh=x6ejS97vXDQKhsgPPO5shtQltx8KlNYRI8+o0+w2Zlk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QEKv7A2dYjzLLUka71IEf3IdXv05l3KCmvoRxO9MN2D85tzIVW2CWlh2xomFh1QZb
	 o2z3TL+LsCRuhlyqRwsJwksxYWpLi9eu2lWfhpHGUPUWKD4wscV0voH6nZPQ4/zj75
	 1e6GT0Pfl2wsTqcBrcygsQMLACvTL0b9pbltGJik=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433M6iaW066939
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 17:06:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 17:06:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 17:06:44 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433M6hHS116423;
	Wed, 3 Apr 2024 17:06:44 -0500
Message-ID: <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
Date: Wed, 3 Apr 2024 17:06:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
To: Guenter Roeck <linux@roeck-us.net>
CC: Jean Delvare <jdelvare@suse.com>, Juerg Haefliger <juergh@proton.me>,
        Riku
 Voipio <riku.voipio@iki.fi>, <linux-hwmon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/3/24 4:30 PM, Guenter Roeck wrote:
> On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
>> Hello all,
>>
>> Goal here is to remove the i2c_match_id() function from all drivers.
>> Using i2c_get_match_data() can simplify code and has some other
>> benefits described in the patches.
>>
> 
> The return value from i2c_match_id() is typically an integer (chip ID)
> starting with 0. Previously it has been claimed that this would be
> unacceptable for i2c_get_match_data(), and chip IDs were changed to start
> with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
> is an example. Either this series is wrong, or the previous claim that
> chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
> wrong. Which one is it ? I find it very confusing that the chip type for
> some drivers now starts with 1 and for others with 0. Given that, I am not
> inclined to accept this series unless it is explained in detail why the
> chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
> with one but is ok to start with 0 for all drivers affected by this
> series. Quite frankly, even if there is some kind of explanation, I am not
> sure if I am going to accept it because future driver developers won't
> know if they have to start chip types with 0 or 1.
> 

i2c_get_match_data() has no issue with returning 0 when the driver_data
for the match is also 0 (as it will be when the chip type is 0 here).

The confusion might be that returning 0 is also considered a failure code.
This is a problem in general with returning errors in-band with data, and
that is nothing new as i2c_match_id() does the same thing.

Actually, i2c_match_id() is worse as most of these drivers take the result
from that and immediately dereference it. Meaning if i2c_match_id() ever did
failed to find a match, they would crash before this series. Luckily i2c_match_id()
can't fail to find a match as far as I can tell, and so for the same reason
neither can i2c_get_match_data(), which means if 0 is returned it is always
because the chip ID was actually 0.

At some point we should switch all the *_get_match_data() functions to
return an error code and put the match if found as a argument pointer.
Forcing everyone to changing the chip type to avoid 0 as done in
ac0c26bae662 is the wrong way to fix an issue like that.

Andrew

