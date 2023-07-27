Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CE7765F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjG0WOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjG0WOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:14:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9F187
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 15:14:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 270A16016E;
        Fri, 28 Jul 2023 00:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690496079; bh=GGrU1py5zBySjol9/sf+8EqAi+AHIoToMAFQhr4/TBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=14OIyMHaGDofQIH6MRLDh5gcK0BazSY6YhAdiqI7CrrsqLfr8V/g1WJKCfLnhsrd/
         rhvhziSECbjFKYhw9vjCAqYLILZX2nyXQA699+5WiwquxWjakplB+yaTVfTuHpOmif
         wFsHbVOIwK4VA+hCxTN5v+BB/YZQUhxLyP30kD+9cJi7pTQ1l6p8RP/uI8LF2oejpd
         Oz4k38YbY5o/OX54jvGsPL9D5yhaam1Gwi4q4KU0GBcQWs3G+wkiFnlIYRwm56sqo7
         y5Iff99YYllQwf0t36sl6AGdmd7HU1BCG58QACM7Kevlktk2r3KFQaBr7ecn94Shah
         QwyvYnZJywMaQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5pVsXPRFA-xD; Fri, 28 Jul 2023 00:14:36 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 63E566015E;
        Fri, 28 Jul 2023 00:14:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1690496076; bh=GGrU1py5zBySjol9/sf+8EqAi+AHIoToMAFQhr4/TBc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1SdeapKW/9ica7Axz4tDvx0pR7/kLklPF35BdGigQlU4EmtuWPhEXJlTZi6VpOnLC
         4k/Jum59J5Vv+H3t8rlxhPTBZiYDVZcYzgsEELtP4385Vz5uqwM4/JDM7CV23AQug4
         4XU/oVBVbgxIiBeGhRFYml5zOGdWcpHJkOHs3xGwHs1vextMo4R0be8JFpPPyEy4v1
         +V/zUF07jitYm7408vJlrhyvjDP33tji2mdkbsFizdCsZTcrKbZZsdPQ/dSkjliMTc
         lL6nLPBX53R6C3yE8WmFjSVE7A5yTuk9QR9/2dKiDggrh9FTLrDLBqowQgvyIrhz/4
         28Vz4zTw+4Aqw==
Message-ID: <8f6e7b28-e59d-96dd-1c46-bde3e3e56b54@alu.unizg.hr>
Date:   Fri, 28 Jul 2023 00:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <e9af482f-5b8a-70c0-d767-e98703cd1b03@alu.unizg.hr>
 <ZMKPCtftDQnfakId@bombadil.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZMKPCtftDQnfakId@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 17:36, Luis Chamberlain wrote:
> On Thu, Jul 27, 2023 at 08:16:17AM +0200, Mirsad Todorovac wrote:
>> On 25.4.2023. 20:27, Luis Chamberlain wrote:
>>> On Fri, Apr 21, 2023 at 08:52:06PM +0200, Mirsad Goran Todorovac wrote:
>>>> Some functions were called both from locked and unlocked context, so
>>>> the lock was dropped prematurely, introducing a race condition when
>>>> deadlock was avoided.
>>>>
>>>> Having two locks wouldn't assure a race-proof mutual exclusion.
>>>>
>>>> __test_dev_config_update_bool(), __test_dev_config_update_u8() and
>>>> __test_dev_config_update_size_t() unlocked versions of the functions
>>>> were introduced to be called from the locked contexts as a workaround
>>>> without releasing the main driver's lock and causing a race condition.
>>>>
>>>> This should guarantee mutual exclusion and prevent any race conditions.
>>>>
>>>> Locked versions simply allow for mutual exclusion and call the unlocked
>>>> counterparts, to avoid duplication of code.
>>>>
>>>> trigger_batched_requests_store() and trigger_batched_requests_async_store()
>>>> now return -EBUSY if called with test_fw_config->reqs already allocated,
>>>> so the memory leak is prevented.
>>>>
>>>> The same functions now keep track of the allocated buf for firmware in
>>>> req->fw_buf as release_firmware() will not deallocate this storage for us.
>>>>
>>>> Additionally, in __test_release_all_firmware(), req->fw_buf is released
>>>> before calling release_firmware(req->fw),
>>>> foreach test_fw_config->reqs[i], i = 0 .. test_fw_config->num_requests-1
>>>>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>>>> Cc: Russ Weight <russell.h.weight@intel.com>
>>>> Cc: Tianfei zhang <tianfei.zhang@intel.com>
>>>> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>>> Cc: Zhengchao Shao <shaozhengchao@huawei.com>
>>>> Cc: Colin Ian King <colin.i.king@gmail.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: Takashi Iwai <tiwai@suse.de>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Scott Branden <sbranden@broadcom.com>
>>>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>>>> Suggested-by: Dan Carpenter <error27@gmail.com>
>>>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>>>
>>> Mirad, thanks for this work, good stuff! So the patch just needs to be
>>> adjust with:
>>>
>>> Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf"
>>> Cc: stable@vger.kernel.org # v5.4
>>>
>>> Then, can you split the patch in two, one which fixes the memory leaks
>>> and another that deals with the mutexes. The second patch might be a fix
>>> for the original code but I can't tell until I see the changes split out.
>>>
>>> The commit log should account for the memory leak and be clear how it
>>> happens. The other commit log for the second patch should clarify what
>>> it fixes and why as well.
>>
>> It seems to me that there is something wrong with the patchwork, as this commit
>> had not yet appeared in 5.4 LTS stable tree?
> 
> Did you resend a new v5 with the requested changes?

Actually, I am not sure what is the procedure, for it is accepted and visible in 5.10+ trees?

Mirsad
