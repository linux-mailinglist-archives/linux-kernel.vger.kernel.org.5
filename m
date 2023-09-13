Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15679E2FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbjIMJJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjIMJJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:09:04 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED641993;
        Wed, 13 Sep 2023 02:09:00 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BC06861E5FE03;
        Wed, 13 Sep 2023 11:08:12 +0200 (CEST)
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
To:     Dragan Stancevic <dragan@stancevic.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     guoqing.jiang@linux.dev, it+raid@molgen.mpg.de,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        msmith626@gmail.com, "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
 <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
 <07d5c7c2-c444-8747-ed6d-ca24231decd8@huaweicloud.com>
 <cf765117-7270-1b98-7e82-82a1ca1daa2a@stancevic.com>
 <0d79d1f9-00e8-93be-3c7c-244030521cd7@huaweicloud.com>
 <ff996ffb-cba5-cc9b-2740-49ba4a1869b5@huaweicloud.com>
 <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
Date:   Wed, 13 Sep 2023 11:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <07ef7b78-66d4-d3de-4e25-8a889b902e14@stancevic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 3:54 PM, Dragan Stancevic wrote:
> On 9/4/23 22:50, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/08/30 9:36, Yu Kuai 写道:
>>> Hi,
>>>
>>> 在 2023/08/29 4:32, Dragan Stancevic 写道:
>>>
>>>> Just a followup on 6.1 testing. I tried reproducing this problem for 5 days with 6.1.42 kernel without your patches and I was not able to reproduce it.
>>
>> oops, I forgot that you need to backport this patch first to reporduce
>> this problem:
>>
>> https://lore.kernel.org/all/20230529132037.2124527-2-yukuai1@huaweicloud.com/
>>
>> The patch fix the deadlock as well, but it introduce some regressions.

We've just got an unplanned lock up on "check" to "idle" transition with 6.1.52 after a few hours on a backup server. For the last 2 1/2 years we used the patch I originally proposed with multiple kernel versions [1]. But this no longer seems to be valid or maybe its even destructive in combination with the other changes.

But I totally lost track of the further development. As I understood, there are patches queue up in mainline, which might go into 6.1, too, but have not landed there which should fix the problem?

Can anyone give me exact references to the patches I'd need to apply to 6.1.52, so that I could probably fix my problem and also test the patches for you those on production systems with a load which tends to run into that problem easily?

Thanks

  Donald

[1]: https://lore.kernel.org/linux-raid/bc342de0-98d2-1733-39cd-cc1999777ff3@molgen.mpg.de/

> Ha, jinx :) I was about to email you that I isolated that change with the testing over the weekend that made it more difficult to reproduce in 6.1 and that the original change must be reverted :)
> 
> 
> 
>>
>> Thanks,
>> Kuai
>>
>>>>
>>>> It seems that 6.1 has some other code that prevents this from happening.
>>>>
>>>
>>> I see that there are lots of patches for raid456 between 5.10 and 6.1,
>>> however, I remember that I used to reporduce the deadlock after 6.1, and
>>> it's true it's not easy to reporduce, see below:
>>>
>>> https://lore.kernel.org/linux-raid/e9067438-d713-f5f3-0d3d-9e6b0e9efa0e@huaweicloud.com/
>>>
>>> My guess is that 6.1 is harder to reporduce than 5.10 due to some
>>> changes inside raid456.
>>>
>>> By the way, raid10 had a similiar deadlock, and can be fixed the same
>>> way, so it make sense to backport these patches.
>>>
>>> https://lore.kernel.org/r/20230529132037.2124527-5-yukuai1@huaweicloud.com
>>>
>>> Thanks,
>>> Kuai
>>>
>>>
>>>> On 5.10 I can reproduce it within minutes to an hour.
>>>>
>>>
>>> .
>>>
>>
> 


-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
