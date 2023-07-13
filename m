Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B54752426
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjGMNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGMNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:48:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640719B4;
        Thu, 13 Jul 2023 06:48:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qJwfi-0003Ca-Qb; Thu, 13 Jul 2023 15:47:54 +0200
Message-ID: <573023b6-4320-2c8d-b1ec-75d542590db0@leemhuis.info>
Date:   Thu, 13 Jul 2023 15:47:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH] sparc: mark __arch_xchg() as __always_inline
Content-Language: en-US, de-DE
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
References: <20230628094938.2318171-1-arnd@kernel.org>
 <20230628155103.GA214400@ravnborg.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230628155103.GA214400@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1689256090;9d0540f3;
X-HE-SMSGID: 1qJwfi-0003Ca-Qb
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.23 17:51, Sam Ravnborg wrote:
> On Wed, Jun 28, 2023 at 11:49:18AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> An otherwise correct change to the atomic operations uncovered an
>> existing bug in the sparc __arch_xchg() function, which is calls
>> __xchg_called_with_bad_pointer() when its arguments are unknown at
>> compile time:
>>
>> ERROR: modpost: "__xchg_called_with_bad_pointer" [lib/atomic64_test.ko] undefined!
>>
>> This now happens because gcc determines that it's better to not inline the
>> function. Avoid this by just marking the function as __always_inline
>> to force the compiler to do the right thing here.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Link: https://lore.kernel.org/all/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
>> Fixes: d12157efc8e08 ("locking/atomic: make atomic*_{cmp,}xchg optional")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I assume you will find a way to apply the patch.

Hmmm, looks to me like this patch is sitting here for two weeks now
without having made any progress. From a quick search on lore it also
looks like Dave is not very active currently. Hence:

Arnd, is that maybe something that is worth sending straight to Linus?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
