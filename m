Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0002E79A139
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjIKCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjIKCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:23:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6348B133;
        Sun, 10 Sep 2023 19:23:03 -0700 (PDT)
X-QQ-mid: bizesmtp76t1694398978t70gnb5o
Received: from [10.4.6.71] ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 11 Sep 2023 10:22:57 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: CR3LFp2JE4nXd/yItDfKehEUWKLbEtk1+3/pUXE5dfEQDDgB+X7s0IufsD/Fl
        dsLeLCPyiDx9YRBvW9jJMqrZlhvIFOKJNl9aTyeiQl5Mr0yHyNEQcbH0XaSv9YIl5yh+jK+
        J6PyISGNN6f5bj3WRHz+c1WN4lCufPcwjsVyuBXwmzkU393GmhBEpAksVrCzqAhvlbDAo6q
        kN1HYL5FwCjNxFI5L6R6RNMNyEq1U+c2uGl3w6dfDDZ9IOBh76BB97opYnTFDMNnOkxYJ5z
        dl6oTOtXhObc34fsk37vZAgekbKyYvci6QHAEYMGQCu5MgwVnPyg+qu13ai9gK/ELV+no2Y
        BvEntfv5YEMOx+rKLs7+oeV372zu+lQ9PZbOxlx
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1468014412657663109
Message-ID: <AF273646FB631DCF+2379e6e1-f44f-39b5-a367-8866077d85c0@tinylab.org>
Date:   Mon, 11 Sep 2023 10:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] of/kexec: Omit kaslr-seed when kexecing with nokaslr
To:     Rob Herring <robh+dt@kernel.org>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230908104458.775740-1-songshuaishuai@tinylab.org>
 <CAL_JsqJFWTWg9gmO7P8d5-W9VeMtmazhCsQW121LDAWLMAHEnQ@mail.gmail.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAL_JsqJFWTWg9gmO7P8d5-W9VeMtmazhCsQW121LDAWLMAHEnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/9/8 22:58, Rob Herring 写道:
> On Fri, Sep 8, 2023 at 5:45 AM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>
>> The chosen node always adds the kaslr-seed property which is needless
>> for the kernels kexeced with the cmdline contained "nokaslr".
>>
>> So omit the kaslr-seed when kexecing with nokaslr.
> 
> The kexec'ed kernel can ignore bootargs with CONFIG_CMDLINE_FORCE. So
> you don't know if kaslr-seed will be used or not.
> 
You are correct. In addition, unlike the EFI Stub, Kexec is unable to
determine whether the kexec'ed kernel supports RANDOMIZE_BASE,
hence it is appropriate to emit the kaslr-seed unconditionally like
those out-of-linux bootloaders.

Apologies for bothering you with this incorrect patch.

>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   drivers/of/kexec.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
>> index f26d2ba8a371..c0d53b10cb70 100644
>> --- a/drivers/of/kexec.c
>> +++ b/drivers/of/kexec.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/random.h>
>>   #include <linux/slab.h>
>>   #include <linux/types.h>
>> +#include <linux/string.h>
>>
>>   #define RNG_SEED_SIZE          128
>>
>> @@ -263,6 +264,14 @@ static inline int setup_ima_buffer(const struct kimage *image, void *fdt,
>>   }
>>   #endif /* CONFIG_IMA_KEXEC */
>>
>> +static bool is_nokaslr_cmdline(const char *cmdline)
>> +{
>> +       char *str;
>> +
>> +       str = strstr(cmdline, "nokaslr");
>> +       return str == cmdline || (str > cmdline && *(str - 1) == ' ');
> 
> Yet another copy of the same code. That's a clue to refactor into a
> common function.
> 
> Rob
> 

-- 
Thanks
Song Shuai

