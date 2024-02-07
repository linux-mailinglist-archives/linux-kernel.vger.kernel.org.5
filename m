Return-Path: <linux-kernel+bounces-56312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587084C897
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FE41F2421A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1025621;
	Wed,  7 Feb 2024 10:27:37 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469F25570
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301656; cv=none; b=iMxjNWxPsAPs236FKkYtfo+RVL3DneKu1fva+RcrWaOeyQhST5EcEtDWF3YqIJc94PL3v9i0fa+B3EBcBcGrgah7xkjBqbUfExAxZ4cDBhYSCHtn3I9nBqFGcm0U68UHZ+wFGr1kP89IRoFquRcbcq6g7+ZlJQ3MayQmNWxNPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301656; c=relaxed/simple;
	bh=QF6qPrFjdGL+9K36GBNdVQWXCpMVPlNweWk2SIEZG/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=INR96wmrjq57AkkBvbscTlUd/FJ4l+SIhvqR09qt5TPnaniTlZnZONUWL3VqFXoLno8S4r8yzBdNDKyCQu2Hy61++onf3vv8NNQTgI6K45xkSktoIhhacaRG//NCaoamq3HcF1PpK9HB6YePpVAeFGE1wnVL5vDNKabTd3lSApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 7 Feb
 2024 13:27:28 +0300
Received: from [192.168.211.130] (10.0.253.138) by Ex16-01.fintech.ru
 (10.0.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Feb 2024
 13:27:28 +0300
Message-ID: <6497acbb-7970-4fd5-bc47-f6896f22efc1@fintech.ru>
Date: Wed, 7 Feb 2024 02:27:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gt: Prevent possible NULL dereference in
 __caps_show()
Content-Language: en-US
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Jani Nikula
	<jani.nikula@linux.intel.com>
CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, <intel-gfx@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
References: <20240206164543.46834-1-n.zhandarovich@fintech.ru>
 <3c63aea1-1a04-45eb-9af1-02f52d4132e4@linux.intel.com>
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
In-Reply-To: <3c63aea1-1a04-45eb-9af1-02f52d4132e4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hello,

On 2/7/24 01:16, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> On 06/02/2024 16:45, Nikita Zhandarovich wrote:
>> After falling through the switch statement to default case 'repr' is
>> initialized with NULL, which will lead to incorrect dereference of
>> '!repr[n]' in the following loop.
>>
>> Fix it with the help of an additional check for NULL.
>>
>> Found by Linux Verification Center (linuxtesting.org) with static
>> analysis tool SVACE.
>>
>> Fixes: 4ec76dbeb62b ("drm/i915/gt: Expose engine properties via sysfs")
>> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>> ---
>> P.S. The NULL-deref problem might be dealt with this way but I am
>> not certain that the rest of the __caps_show() behaviour remains
>> correct if we end up in default case. For instance, as far as I
>> can tell, buf might turn out to be w/o '\0'. I could use some
>> direction if this has to be addressed as well.
>>
>>   drivers/gpu/drm/i915/gt/sysfs_engines.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> b/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> index 021f51d9b456..6b130b732867 100644
>> --- a/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> +++ b/drivers/gpu/drm/i915/gt/sysfs_engines.c
>> @@ -105,7 +105,7 @@ __caps_show(struct intel_engine_cs *engine,
>>         len = 0;
>>       for_each_set_bit(n, &caps, show_unknown ? BITS_PER_LONG : count) {
>> -        if (n >= count || !repr[n]) {
>> +        if (n >= count || !repr || !repr[n]) {
> 
> There are two input combinations to this function when repr is NULL.
> 
> First is show_unknown=true and caps=0, which means the for_each_set_bit
> will not execute its body. (No bits set.)
> 
> Second is show_unknown=false and caps=~0, which means count is zero so
> for_each_set_bit will again not run. (Bitfield size input param is zero.)
> 
> So unless I am missing something I do not see the null pointer dereference.
> 
> What could theoretically happen is that a third input combination
> appears, where caps is not zero in the show_unknown=true case, either
> via a fully un-handled engine->class (switch), or a new capability bit
> not added to the static array a bit above.
> 
> That would assert during driver development here:
> 
>             if (GEM_WARN_ON(show_unknown))
> 
> Granted that could be after the dereference in "if (n >= count ||
> !repr[n])", but would be caught in debug builds (CI) and therefore not
> be able to "ship" (get merge to the repo).
> 
> Your second question is about empty buffer returned i.e. len=0 at the
> end of the function? (Which is when the buffer will not be null
> terminated - or you see another option?)
> 
> That I think is safe too since it just results in a zero length read in
> sysfs.
> 
> Regards,
> 
> Tvrtko
> 
>>               if (GEM_WARN_ON(show_unknown))
>>                   len += sysfs_emit_at(buf, len, "[%x] ", n);
>>           } else {

Thank you for such a full response.

I think you are right. I was under the impression that either currently
or in the future there might be an input combination, as you mentioned,
that may trigger the NULL dereference. If you feel it will be caught
beforehand, I am satisfied as well. Same goes for the empty buffer stuff.

I think dropping the patch is the best option then. Apologies for any
inconvenience.

Nikita

