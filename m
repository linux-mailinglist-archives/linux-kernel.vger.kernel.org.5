Return-Path: <linux-kernel+bounces-26318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A42882DE73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A41283098
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA2182B5;
	Mon, 15 Jan 2024 17:25:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E39A182A1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F412F4;
	Mon, 15 Jan 2024 09:25:46 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE50F3F5A1;
	Mon, 15 Jan 2024 09:24:59 -0800 (PST)
Message-ID: <29a13c04-f669-a6c3-4693-af7e44469ad2@arm.com>
Date: Mon, 15 Jan 2024 17:24:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] firmware/arm_sdei: Fix invalid argument to unregister
 private events.
Content-Language: en-GB
To: Pierre Gondois <pierre.gondois@arm.com>, Levi Yun <ppbuk5246@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240110090107.26323-1-ppbuk5246@gmail.com>
 <21e77238-4884-40ca-bc01-b7e4774b9239@arm.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <21e77238-4884-40ca-bc01-b7e4774b9239@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Levi, Pierre,

On 15/01/2024 13:01, Pierre Gondois wrote:
> On 1/10/24 10:01, Levi Yun wrote:
>> To unregister private events in device freeze, it should call
>> cpuhp_remove_state with sdei_hp_state not sdei_entry_point.
>> otherwise, it seems to fail on cpuhp_cb_check.

Oops. Well caught!


> I think you can also add:
> Fixes: d2c48b2387eb ("firmware: arm_sdei: Fix sleep from invalid context BUG")


>> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
>> index 285fe7ad490d..3e8051fe8296 100644
>> --- a/drivers/firmware/arm_sdei.c
>> +++ b/drivers/firmware/arm_sdei.c
>> @@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
>>       int err;
>>         /* unregister private events */
>> -    cpuhp_remove_state(sdei_entry_point);
>> +    cpuhp_remove_state(sdei_hp_state);
> 
> Maybe it would also be worth resetting 'sdei_hp_state':
>   sdei_hp_state = 0;

The next call should always be 'thaw', which doesn't check this, but it's good to cleanup
stale values.

Regardless:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

