Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC97BFEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjJJOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJJOTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:19:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E317CA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:19:22 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qqDZm-0005Ce-FV; Tue, 10 Oct 2023 16:19:10 +0200
Message-ID: <47e5f0a7-e3ee-79c8-7460-2c67cf9960cc@pengutronix.de>
Date:   Tue, 10 Oct 2023 16:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        David.Kaplan@amd.com, bp@alien8.de, mingo@kernel.org,
        x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20231006051801.423973-1-sumit.garg@linaro.org>
 <8eeac047a59667912a45b21050a6e4c57d7cccd5.camel@kernel.org>
 <CAFA6WYNamspdK=RakirdS3fiHrmmaPXcgEcZeNn5z2DRNdE3Rw@mail.gmail.com>
 <1de1ace90f1645fc629c075826aa67eda8dfd138.camel@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <1de1ace90f1645fc629c075826aa67eda8dfd138.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jarkko,

On 10.10.23 15:49, Jarkko Sakkinen wrote:
> On Tue, 2023-10-10 at 18:44 +0530, Sumit Garg wrote:
>> On Tue, 10 Oct 2023 at 18:03, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>
>>> On Fri, 2023-10-06 at 10:48 +0530, Sumit Garg wrote:
>>>> Static calls invocations aren't well supported from module __init and
>>>> __exit functions. Especially the static call from cleanup_trusted() led
>>>> to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.
>>>>
>>>> However, the usage of static call invocations for trusted_key_init()
>>>> and trusted_key_exit() don't add any value from either a performance or
>>>> security perspective. Hence switch to use indirect function calls instead.
>>>>
>>>> Note here that although it will fix the current crash report, ultimately
>>>> the static call infrastructure should be fixed to either support its
>>>> future usage from module __init and __exit functions or not.
>>>>
>>>> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>>>> Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
>>>> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Polish commit message as per comments from Mimi
>>>>
>>>>  security/keys/trusted-keys/trusted_core.c | 13 +++++--------
>>>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
>>>> index c6fc50d67214..85fb5c22529a 100644
>>>> --- a/security/keys/trusted-keys/trusted_core.c
>>>> +++ b/security/keys/trusted-keys/trusted_core.c
>>>> @@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
>>>>  #endif
>>>>  };
>>>>
>>>> -DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
>>>>  DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
>>>>  DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
>>>>                         *trusted_key_sources[0].ops->unseal);
>>>>  DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
>>>>                         *trusted_key_sources[0].ops->get_random);
>>>> -DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
>>>> +static void (*trusted_key_exit)(void);
>>>>  static unsigned char migratable;
>>>>
>>>>  enum {
>>>> @@ -359,19 +358,16 @@ static int __init init_trusted(void)
>>>>                 if (!get_random)
>>>>                         get_random = kernel_get_random;
>>>>
>>>> -               static_call_update(trusted_key_init,
>>>> -                                  trusted_key_sources[i].ops->init);
>>>>                 static_call_update(trusted_key_seal,
>>>>                                    trusted_key_sources[i].ops->seal);
>>>>                 static_call_update(trusted_key_unseal,
>>>>                                    trusted_key_sources[i].ops->unseal);
>>>>                 static_call_update(trusted_key_get_random,
>>>>                                    get_random);
>>>> -               static_call_update(trusted_key_exit,
>>>> -                                  trusted_key_sources[i].ops->exit);
>>>> +               trusted_key_exit = trusted_key_sources[i].ops->exit;
>>>>                 migratable = trusted_key_sources[i].ops->migratable;
>>>>
>>>> -               ret = static_call(trusted_key_init)();
>>>> +               ret = trusted_key_sources[i].ops->init();
>>>>                 if (!ret)
>>>>                         break;
>>>>         }
>>>> @@ -388,7 +384,8 @@ static int __init init_trusted(void)
>>>>
>>>>  static void __exit cleanup_trusted(void)
>>>>  {
>>>> -       static_call_cond(trusted_key_exit)();
>>>> +       if (trusted_key_exit)
>>>> +               (*trusted_key_exit)();
>>>>  }
>>>>
>>>>  late_initcall(init_trusted);
>>>
>>> Would it be less confusing to require trusted_key_exit from each?
>>>
>>
>> It is already required for each trust source to provide exit callback
>> but this NULL check was added via this fix [1] in case there isn't any
>> trust source present.
>>
>> [1] https://lkml.kernel.org/stable/20220126184155.220814-1-dave.kleikamp@oracle.com/
> 
> I'd considering creating a placeholder trusted_key_default_exit() with
> perhaps pr_debug() statement acknowledging it getting called.
> 
> Hmm.. if we had that I wonder if we could get away with __weak... Then
> you would not need to assign anything. This is not through-out analyzed.
> Tbh I'm not sure how module loader handles this type of scenario but
> at least the placeholder function would make sense in any case.

If you define a default exit function as __weak and expect trusted key sources
to override it, you can only have one trust source at most in the compiled
kernel and no boot-time selection would be possible.

Cheers,
Ahmad

> 
> If abusing weak symbols was in-fact possible probably then the whole
> idea of using static_call could be thrown to garbage bin but there's
> now a lot of context here related on how module loader works linux
> that I'm ignoring...
> 
> BR, Jarkko
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

