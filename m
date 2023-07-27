Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7046B764691
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjG0GQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjG0GQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:16:39 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890E319B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:16:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id A71446015F;
        Thu, 27 Jul 2023 08:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690438584; bh=v8tjT8YDeqCYzHJA6CKxcqAvKzkCNd4Kl/SePIkOylc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H+NP3Y+HWY+q+l1bRE/5U2gN9HpNKI944o/j/Su+y8uFOvnwfMs7X8/UhbM/UYyFs
         bNnVu+ACWxZAbt439AvuX4oB12KlR8jCiQzkPdyevmO+zaYd3aLjDKG/hi5tjZe2YF
         euZb9/h+df7cAPnO373+xU5KlZY3Lpgl5+YKrz58MGjehzNerCSvuBZSUgvvAppqd3
         hRAuWtGfTHISXKTc0mHt/hiH73YDHQntjXJSomfw0y/WEH8inn4H97H6+Gz2+Ch9nk
         m+W3xoL1mlMLnHC8mbre9oUPG3B+kSR6H0iytAqm0/RsrLve7q0iJU9WbPqpeyQwmy
         H2m10ECK8kaVQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RXM8HHwO1p07; Thu, 27 Jul 2023 08:16:21 +0200 (CEST)
Received: from [10.0.2.76] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 1C6A660155;
        Thu, 27 Jul 2023 08:16:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690438581; bh=v8tjT8YDeqCYzHJA6CKxcqAvKzkCNd4Kl/SePIkOylc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=APPA7pEwPF3Q21pW6oqSL+o2fxHn9vv8ZXYHb/lsSupLopCjXxTkivrrSoVF8wXC2
         DYzmmv1RDiE4krpWmkHSkjPclHYHPF/tIaUz3CQbJkPguKd/fynwxawUb5/iezdWNF
         4KAZUBy+hvVbmYSMcTpnBDtr/rsbG/d49BKHFd0SJHlPj9UOBtyG8FBuLJzuNKmZWe
         zqR/uCq0cjzwiPfMm2v6dlChf3yWkHDa/h5XarD0sQe/HzJqylTSdYHzgxHhgqgG9o
         C5XnheUNSHuyeIYJXfmdDtCf7MiSHiFch66DtUsTxARElpfFGjKRw8YcqxnVXj5vr9
         jopI2tdXt7lig==
Message-ID: <e9af482f-5b8a-70c0-d767-e98703cd1b03@alu.unizg.hr>
Date:   Thu, 27 Jul 2023 08:16:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
Content-Language: en-US, hr
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <error27@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
References: <20230421185205.28743-1-mirsad.todorovac@alu.unizg.hr>
 <ZEgbkoSjHcVLcCcp@bombadil.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZEgbkoSjHcVLcCcp@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.4.2023. 20:27, Luis Chamberlain wrote:
> On Fri, Apr 21, 2023 at 08:52:06PM +0200, Mirsad Goran Todorovac wrote:
>> Some functions were called both from locked and unlocked context, so
>> the lock was dropped prematurely, introducing a race condition when
>> deadlock was avoided.
>>
>> Having two locks wouldn't assure a race-proof mutual exclusion.
>>
>> __test_dev_config_update_bool(), __test_dev_config_update_u8() and
>> __test_dev_config_update_size_t() unlocked versions of the functions
>> were introduced to be called from the locked contexts as a workaround
>> without releasing the main driver's lock and causing a race condition.
>>
>> This should guarantee mutual exclusion and prevent any race conditions.
>>
>> Locked versions simply allow for mutual exclusion and call the unlocked
>> counterparts, to avoid duplication of code.
>>
>> trigger_batched_requests_store() and trigger_batched_requests_async_store()
>> now return -EBUSY if called with test_fw_config->reqs already allocated,
>> so the memory leak is prevented.
>>
>> The same functions now keep track of the allocated buf for firmware in
>> req->fw_buf as release_firmware() will not deallocate this storage for us.
>>
>> Additionally, in __test_release_all_firmware(), req->fw_buf is released
>> before calling release_firmware(req->fw),
>> foreach test_fw_config->reqs[i], i = 0 .. test_fw_config->num_requests-1
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Russ Weight <russell.h.weight@intel.com>
>> Cc: Tianfei zhang <tianfei.zhang@intel.com>
>> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> Cc: Zhengchao Shao <shaozhengchao@huawei.com>
>> Cc: Colin Ian King <colin.i.king@gmail.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>> Suggested-by: Dan Carpenter <error27@gmail.com>
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> Mirad, thanks for this work, good stuff! So the patch just needs to be
> adjust with:
> 
> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf"
> Cc: stable@vger.kernel.org # v5.4
> 
> Then, can you split the patch in two, one which fixes the memory leaks
> and another that deals with the mutexes. The second patch might be a fix
> for the original code but I can't tell until I see the changes split out.
> 
> The commit log should account for the memory leak and be clear how it
> happens. The other commit log for the second patch should clarify what
> it fixes and why as well.

It seems to me that there is something wrong with the patchwork, as this commit
had not yet appeared in 5.4 LTS stable tree?

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/?qt=grep&q=Mirsad&h=linux-5.4.y

I was accidentally looking whether it passed, and it seems like more than a month
since the other commits propagated :-/

Thanks,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

