Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615917ACA0D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIXOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIXOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:37:10 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7514FA;
        Sun, 24 Sep 2023 07:37:02 -0700 (PDT)
Received: from [192.168.1.122] (ip5b41a963.dynamic.kabel-deutschland.de [91.65.169.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 64C5761E5FE03;
        Sun, 24 Sep 2023 16:36:00 +0200 (CEST)
Message-ID: <fb261b77-4859-07bb-e586-8589741e0c9e@molgen.mpg.de>
Date:   Sun, 24 Sep 2023 16:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Content-Language: en-US
From:   Donald Buczek <buczek@molgen.mpg.de>
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
 <63c63d93-30fc-0175-0033-846b93fe9eff@molgen.mpg.de>
 <de7f6fba-c6e0-7549-199e-36548b68a862@stancevic.com>
 <d48c6c4a-9b0e-20bc-7d40-2a88aa37524a@molgen.mpg.de>
 <f79867f5-befb-0d7d-0c01-a42caa5d1466@molgen.mpg.de>
In-Reply-To: <f79867f5-befb-0d7d-0c01-a42caa5d1466@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 10:55, Donald Buczek wrote:
> On 9/14/23 08:03, Donald Buczek wrote:
>> On 9/13/23 16:16, Dragan Stancevic wrote:
>>> Hi Donald-
>>> [...]
>>> Here is a list of changes for 6.1:
>>>
>>> e5e9b9cb71a0 md: factor out a helper to wake up md_thread directly
>>> f71209b1f21c md: enhance checking in md_check_recovery()
>>> 753260ed0b46 md: wake up 'resync_wait' at last in md_reap_sync_thread()
>>> 130443d60b1b md: refactor idle/frozen_sync_thread() to fix deadlock
>>> 6f56f0c4f124 md: add a mutex to synchronize idle and frozen in action_store()
>>> 64e5e09afc14 md: refactor action_store() for 'idle' and 'frozen'
>>> a865b96c513b Revert "md: unlock mddev before reap sync_thread in action_store"
>>
>> Thanks!
>>
>> I've put these patches on v6.1.52. I've started a script which transitions the three md-devices of a very active backup server through idle->check->idle every 6 minutes a few ours ago.  It went through ~400 iterations till now. No lock-ups so far.
> 
> Oh dear, looks like the deadlock problem is _not_fixed with these patches.

Some more info after another incident:

- We've hit the deadlock with 5.15.131 (so it is NOT introduced by any of the above patches)
- The symptoms are not exactly the same as with the original year-old problem. Differences:
- - mdX_raid6 is NOT busy looping
- - /sys/devices/virtual/block/mdX/md/array_state says "active" not "write pending"
- - `echo active > /sys/devices/virtual/block/mdX/md/array_state` does not resolve the deadlock
- - After hours in the deadlock state the system resumed operation when a script of mine read(!) lots of sysfs files.
- But in both cases, `echo idle > /sys/devices/virtual/block/mdX/md/sync_action` hangs as does all I/O operation on the raid.

The fact that we didn't hit the problem for many month on 5.15.94 might hint that it was introduced between 5.15.94 and 5.15.131

We'll try to reproduce the problem on a test machine for analysis, but this make take time (vacation imminent for one...).

But its not like these patches caused the problem. Any maybe they _did_ fix the original problem, as we didn't hit that one.

Best

   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
