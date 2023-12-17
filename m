Return-Path: <linux-kernel+bounces-2422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65883815CEB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416FF1C21667
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E5A4E;
	Sun, 17 Dec 2023 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="W+0Whlom"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF881A2A;
	Sun, 17 Dec 2023 01:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C51D81000B2;
	Sun, 17 Dec 2023 04:05:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C51D81000B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1702775155;
	bh=WicLE+m2KjZ0UmGZ33Un03zmL1z8fwkULFl3o1Sphb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=W+0WhlomTM+JUUUkZ1gq/VVpGfyhap3Ye6TWBZLEfhpPnBEPBHh3fhua2HFk/p1k2
	 KFYCG88OVd9r3xIj1aUCzy6VJEPdIUFmm4NPO0PBHSAbT62xcZpgpHTKtJBr3+jDHv
	 S/E04O/2CndBgMd3Pr4M3D1MGnknhvHd534qIuDulKOL0MKz74Y0emh0Mqj8JcuLVe
	 ZwKOW1kJfITZZBsdegrE+4emxsmK34hUWrl64gIRPvXhvyXMnyPGCLPodD6zG1yeNN
	 G8cGD/vbH82Ln3a/+wIis19FxjuM5mvIHBzGGoFJrTzpR0ZMb0NZ6eylr6xf5Yae8/
	 LkM62LVkt+3yA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun, 17 Dec 2023 04:05:55 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 17 Dec 2023 04:05:55 +0300
Message-ID: <1e5907f2-c794-4ee2-8abc-b45831cca5bb@salutedevices.com>
Date: Sun, 17 Dec 2023 04:05:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] locking: introduce devm_mutex_init
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Waiman Long
	<longman@redhat.com>, "andy.shevchenko@gmail.com"
	<andy.shevchenko@gmail.com>, "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org"
	<lee@kernel.org>, "vadimp@nvidia.com" <vadimp@nvidia.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "npiggin@gmail.com"
	<npiggin@gmail.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>
CC: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20231214173614.2820929-1-gnstark@salutedevices.com>
 <20231214173614.2820929-3-gnstark@salutedevices.com>
 <5c10f66c-3fd8-4861-994b-13e71c24f10a@redhat.com>
 <b158ca2b-7300-4ad0-82b8-e1442d267734@csgroup.eu>
 <300d2131-87ef-48c1-b162-dcef0d8d5722@redhat.com>
 <5ef8a83a-5dfd-4038-851e-c730d5f1b6f3@csgroup.eu>
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <5ef8a83a-5dfd-4038-851e-c730d5f1b6f3@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182147 [Dec 16 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/16 23:36:00 #22664677
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Christophe

On 12/15/23 08:46, Christophe Leroy wrote:
> 
> 
> Le 14/12/2023 à 22:48, Waiman Long a écrit :
>> On 12/14/23 14:53, Christophe Leroy wrote:
>>>
>>> Le 14/12/2023 à 19:48, Waiman Long a écrit :
>>>> On 12/14/23 12:36, George Stark wrote:
>>>>> Using of devm API leads to a certain order of releasing resources.
>>>>> So all dependent resources which are not devm-wrapped should be deleted
>>>>> with respect to devm-release order. Mutex is one of such objects that
>>>>> often is bound to other resources and has no own devm wrapping.
>>>>> Since mutex_destroy() actually does nothing in non-debug builds
>>>>> frequently calling mutex_destroy() is just ignored which is safe for
>>>>> now
>>>>> but wrong formally and can lead to a problem if mutex_destroy() will be
>>>>> extended so introduce devm_mutex_init()
>>>>>
>>>>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>>>>> ---
>>>>>     include/linux/mutex.h        | 23 +++++++++++++++++++++++
>>>>>     kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
>>>>>     2 files changed, 45 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
>>>>> index a33aa9eb9fc3..ebd03ff1ef66 100644
>>>>> --- a/include/linux/mutex.h
>>>>> +++ b/include/linux/mutex.h
>>>>> @@ -21,6 +21,8 @@
>>>>>     #include <linux/debug_locks.h>
>>>>>     #include <linux/cleanup.h>
>>>>> +struct device;
>>>>> +
>>>>>     #ifdef CONFIG_DEBUG_LOCK_ALLOC
>>>>>     # define __DEP_MAP_MUTEX_INITIALIZER(lockname)            \
>>>>>             , .dep_map = {                    \
>>>>> @@ -127,6 +129,20 @@ extern void __mutex_init(struct mutex *lock,
>>>>> const char *name,
>>>>>      */
>>>>>     extern bool mutex_is_locked(struct mutex *lock);
>>>>> +#ifdef CONFIG_DEBUG_MUTEXES
>>>>> +
>>>>> +int devm_mutex_init(struct device *dev, struct mutex *lock);
>>>> Please add "extern" to the function declaration to be consistent with
>>>> other functional declarations in mutex.h.
>>> 'extern' is pointless and deprecated on function prototypes. Already
>>> having some is not a good reason to add new ones, errors from the past
>>> should be avoided nowadays. With time they should all disappear so don't
>>> add new ones.
>> Yes, "extern" is optional. It is just a suggestion and I am going to
>> argue about that.
> 
> FWIW, note that when you perform a strict check with checkpatch.pl, you
> get a warning for that:
> 
> $ ./scripts/checkpatch.pl --strict -g HEAD
> CHECK: extern prototypes should be avoided in .h files
> #56: FILE: include/linux/mutex.h:131:
> +extern int devm_mutex_init(struct device *dev, struct mutex *lock);
> 
> total: 0 errors, 0 warnings, 1 checks, 99 lines checked

This is ambiguous situation about extern. It's deprecated and useless on 
one hand but harmless. And those externs will not disappear by themself 
- it'll be one patch that clean them all at once (in one header at 
least) so one more extern will not alter the overall picture.

On the other hand if we manage to place devm_mutex_init near 
mutex_destroy then we'll have:

int devm_mutex_init(struct device *dev, struct mutex *lock);
extern void mutex_destroy(struct mutex *lock);

and it raises questions and does not look very nice.

>>>
>>>>> +
>>>>> +#else
>>>>> +
>>>>> +static inline int devm_mutex_init(struct device *dev, struct mutex
>>>>> *lock)
>>>>> +{
>>>>> +    mutex_init(lock);
>>>>> +    return 0;
>>>>> +}
>>>> I would prefer you to add a devm_mutex_init macro after the function
>>>> declaration and put this inline function at the end of header if the
>>>> devm_mutex_init macro isn't defined. In this way, you don't need to
>>>> repeat this inline function twice as it has no dependency on PREEMPT_RT.
>>> It is already done that way for other functions in that file. Should be
>>> kept consistant. I agree with you it is not ideal, maybe we should
>>> rework that file completely but I don't like the idea of a
>>> devm_mutex_init macro for that.
>>
>> devm_mutex_init() is not an API for the core mutex code. That is why I
>> want to minimize change to the existing code layout. Putting it at the
>> end will reduce confusion when developers look up mutex.h header file to
>> find out what mutex functions are available.
> 
> If I look at linux/gpio.h we are more or less in the same situation I think.
> 
> devm_mutex_init() is not an API for the core mutex code, but developers
> need to know the managed functions for mutex exist, and having them at
> the same place as non managed functions looks better to me. Now I agree
> with you that this duplication of functions is not the best, and it also
> applies to existing content of mutex.h so maybe we can do something
> about it later and improve the situation.
> 
> Christophe

-- 
Best regards
George

