Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8FC785FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 20:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjHWSeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjHWSeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 14:34:04 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C9ECC7;
        Wed, 23 Aug 2023 11:34:00 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E0BC683277;
        Wed, 23 Aug 2023 15:33:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4C44983293;
        Wed, 23 Aug 2023 15:33:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692804816; a=rsa-sha256;
        cv=none;
        b=xNdbrZxhXLUh3CpUrT6BQljaGRzW4shif7DoYGgSLBEs8KtTaYbc47xPJLXlP9f2BRo1Qr
        MZUyppjjThficAzi8+b5oC1uGZRsicqbwI2S7YG7MZFTqDT2uwAzeNGGwUmGNjOIq72YWr
        UxiALRZsQOK4TIR9Qwq/7vs0YvkLInG/r17cB1Kx32PCFLGqmnDVW8K6bAqqNYxM8X06zX
        CfF9TnIuTzB9/DE4FStBaH7CsrBezA8K2/iitjWqf8n1ozdeFJnga8FZfilv4pRE77FVD4
        M1yyLtyVHXRV9JTv25rd0h8uSJ1UljN3WAy9cUesoUSlhvBSspAaBm8RsCOznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692804816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=kQf0zTJgH0pEKRLTOV3m6gcA7NcnmvTfWQ4RbjMAWsA=;
        b=yWq1DkkNz2+DAVFwzqK9yvrSYT4BzfoZT8EtZuMZRR/FLnwMA59W8Dk+Ap3WTp5bor81jt
        HqI3398q+Qc0YZkg8no8+MD6A7j94UfUsnkXUeYlPnv87BUggYsG/093mfqXYZMzR7IP88
        Q9We9PRzvcGf3lCGBquzTqXnTGYGpqaVZWIDsbvOTGEwd1g47OUze2y/VJfYO0PJFS5QeB
        g8SzhJS2qgSNEJaQ2pirEaerI6H/Dg4ahSqey5M5YDzSJf9lDSA3qMqgoPZBo8ZuafxxYU
        m8WgcBoKkXweZO1cQM4z5/uDoxgbyLmQ/N0e4MhNt9UquurFwgUhQAtcVYDGWg==
ARC-Authentication-Results: i=1;
        rspamd-5c4f45d774-t6qr4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dragan@stancevic.com
X-Sender-Id: dreamhost|x-authsender|dragan@stancevic.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dragan@stancevic.com
X-MailChannels-Auth-Id: dreamhost
X-Grain-Blushing: 11a7a59a711d7a14_1692804816633_1050059864
X-MC-Loop-Signature: 1692804816633:1516637827
X-MC-Ingress-Time: 1692804816633
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.240.35 (trex/6.9.1);
        Wed, 23 Aug 2023 15:33:36 +0000
Received: from [192.168.1.36] (99-160-136-52.lightspeed.nsvltn.sbcglobal.net [99.160.136.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dragan@stancevic.com)
        by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4RW9Gl21BQzCw;
        Wed, 23 Aug 2023 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stancevic.com;
        s=dreamhost; t=1692804816;
        bh=kQf0zTJgH0pEKRLTOV3m6gcA7NcnmvTfWQ4RbjMAWsA=;
        h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
        b=x+GSN6++X/LgwwjnTI8kMzW71VuXY9/IrmMJUiZwlgHdsmEnEy9fhnWWKoNbXRTeB
         qBmhyP/TScWBixiHszcEeCfq+R4Oyr9VsmxcP3Od3Lk7sYVa1kfTA3Du1OTADGulsg
         wu/vZfLkZmbs/Qth7rl6yr7xpRmQJaxM9zPZmJixWsA52jTeWUEl8K+j7C2Ha/bOlm
         70ZG1acVAxfwf0V19Maoj5gWMXXP0i+2ErF+qGnR71ARIwWzLLPvuyvNx/g4YtBXNX
         TVmXTsRb3D9A7IHUPkcWc+WnwUFRnob3TItRGlG7bTNHCF3FH4HLm0XrluO6tnq2kZ
         j2wzpQsxzpfRA==
Message-ID: <2061b123-6332-1456-e7c3-b713752527fb@stancevic.com>
Date:   Wed, 23 Aug 2023 10:33:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: md_raid: mdX_raid6 looping after sync_action "check" to "idle"
 transition
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, song@kernel.org
Cc:     buczek@molgen.mpg.de, guoqing.jiang@linux.dev,
        it+raid@molgen.mpg.de, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, msmith626@gmail.com,
        "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
References: <CAPhsuW6R11y6vETeZ4vmFGmV6DRrj2gwhp1-Nm+csvtHb2nQYg@mail.gmail.com>
 <20230822211627.1389410-1-dragan@stancevic.com>
 <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
From:   Dragan Stancevic <dragan@stancevic.com>
In-Reply-To: <ab757e2b-3ff0-33d9-d30c-61669b738664@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuai-

On 8/22/23 20:22, Yu Kuai wrote:
> Hi,
> 
> 在 2023/08/23 5:16, Dragan Stancevic 写道:
>> On Tue, 3/28/23 17:01 Song Liu wrote:
>>> On Thu, Mar 16, 2023 at 8:25=E2=80=AFAM Marc Smith <msmith626@gmail.com>
>>> wr=
>>> ote:
>>>   >
>>>   > On Tue, Mar 14, 2023 at 10:45=E2=80=AFAM Marc Smith
>>> <msmith626@gmail.com>=
>>>    wrote:
>>>   > >
>>>   > > On Tue, Mar 14, 2023 at 9:55=E2=80=AFAM Guoqing Jiang
>>> <guoqing.jiang@li=
>>> nux.dev> wrote:
>>>   > > >
>>>   > > >
>>>   > > >
>>>   > > > On 3/14/23 21:25, Marc Smith wrote:
>>>   > > > > On Mon, Feb 8, 2021 at 7:49=E2=80=AFPM Guoqing Jiang
>>>   > > > > <guoqing.jiang@cloud.ionos.com> wrote:
>>>   > > > >> Hi Donald,
>>>   > > > >>
>>>   > > > >> On 2/8/21 19:41, Donald Buczek wrote:
>>>   > > > >>> Dear Guoqing,
>>>   > > > >>>
>>>   > > > >>> On 08.02.21 15:53, Guoqing Jiang wrote:
>>>   > > > >>>>
>>>   > > > >>>> On 2/8/21 12:38, Donald Buczek wrote:
>>>   > > > >>>>>> 5. maybe don't hold reconfig_mutex when try to unregister
>>>   > > > >>>>>> sync_thread, like this.
>>>   > > > >>>>>>
>>>   > > > >>>>>>           /* resync has finished, collect result */
>>>   > > > >>>>>>           mddev_unlock(mddev);
>>>   > > > >>>>>>           md_unregister_thread(&mddev->sync_thread);
>>>   > > > >>>>>>           mddev_lock(mddev);
>>>   > > > >>>>> As above: While we wait for the sync thread to terminate,
>>> would=
>>> n't it
>>>   > > > >>>>> be a problem, if another user space operation takes the 
>>> mutex?
>>>   > > > >>>> I don't think other places can be blocked while hold mutex,
>>> othe=
>>> rwise
>>>   > > > >>>> these places can cause potential deadlock. Please try above
>>> two =
>>> lines
>>>   > > > >>>> change. And perhaps others have better idea.
>>>   > > > >>> Yes, this works. No deadlock after >11000 seconds,
>>>   > > > >>>
>>>   > > > >>> (Time till deadlock from previous runs/seconds: 1723, 37,
>>> 434, 12=
>>> 65,
>>>   > > > >>> 3500, 1136, 109, 1892, 1060, 664, 84, 315, 12, 820 )
>>>   > > > >> Great. I will send a formal patch with your reported-by and
>>> tested=
>>> -by.
>>>   > > > >>
>>>   > > > >> Thanks,
>>>   > > > >> Guoqing
>>>   > > > > I'm still hitting this issue with Linux 5.4.229 -- it looks
>>> like 1/=
>>> 2
>>>   > > > > of the patches that supposedly resolve this were applied to 
>>> the
>>> sta=
>>> ble
>>>   > > > > kernels, however, one was omitted due to a regression:
>>>   > > > > md: don't unregister sync_thread with reconfig_mutex held
>>> (upstream
>>>   > > > > commit 8b48ec23cc51a4e7c8dbaef5f34ebe67e1a80934)
>>>   > > > >
>>>   > > > > I don't see any follow-up on the thread from June 8th 2022
>>> asking f=
>>> or
>>>   > > > > this patch to be dropped from all stable kernels since it 
>>> caused a
>>>   > > > > regression.
>>>   > > > >
>>>   > > > > The patch doesn't appear to be present in the current mainline
>>> kern=
>>> el
>>>   > > > > (6.3-rc2) either. So I assume this issue is still present
>>> there, or=
>>>    it
>>>   > > > > was resolved differently and I just can't find the 
>>> commit/patch.
>>>   > > >
>>>   > > > It should be fixed by commit 9dfbdafda3b3"md: unlock mddev 
>>> before
>>> rea=
>>> p
>>>   > > > sync_thread in action_store".
>>>   > >
>>>   > > Okay, let me try applying that patch... it does not appear to be
>>>   > > present in my 5.4.229 kernel source. Thanks.
>>>   >
>>>   > Yes, applying this '9dfbdafda3b3 "md: unlock mddev before reap
>>>   > sync_thread in action_store"' patch on top of vanilla 5.4.229 source
>>>   > appears to fix the problem for me -- I can't reproduce the issue 
>>> with
>>>   > the script, and it's been running for >24 hours now. (Previously 
>>> I was
>>>   > able to induce the issue within a matter of minutes.)
>>>
>>> Hi Marc,
>>>
>>> Could you please run your reproducer on the md-tmp branch?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp
>>>
>>> This contains a different version of the fix by Yu Kuai.
>>>
>>> Thanks,
>>> Song
>>>
>>
>> Hi Song, I can easily reproduce this issue on 5.10.133 and 5.10.53. 
>> The change
>> "9dfbdafda3b3 "md: unlock mddev before reap" does not fix the issue 
>> for me.
>>
>> But I did pull the changes from the md-tmp branch you are refering:
>> https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/log/?h=3Dmd-tmp
>>
>> I was not totally clear on which change exactly to pull, but I pulled
>> the following changes:
>> 2023-03-28 md: enhance checking in md_check_recovery()md-tmp    Yu 
>> Kuai    1 -7/+15
>> 2023-03-28 md: wake up 'resync_wait' at last in 
>> md_reap_sync_thread()    Yu Kuai    1 -1/+1
>> 2023-03-28 md: refactor idle/frozen_sync_thread()    Yu Kuai    2 -4/+22
>> 2023-03-28 md: add a mutex to synchronize idle and frozen in 
>> action_store()    Yu Kuai    2 -0/+8
>> 2023-03-28 md: refactor action_store() for 'idle' and 'frozen'    Yu 
>> Kuai    1 -16/+45
>>
>> I used to be able to reproduce the lockup within minutes, but with those
>> changes the test system has been running for more than 120 hours.
>>
>> When you said a "different fix", can you confirm that I grabbed the right
>> changes and that I need all 5 of them.
> 
> Yes, you grabbed the right changes, and these patches is merged to
> linux-next as well.
>>
>> And second question was, has this fix been submitted upstream yet?
>> If so which kernel version?
> 
> This fix is currently in linux-next, and will be applied to v6.6-rc1
> soon.

Thank you, that is great news. I'd like to see this change backported to 
5.10 and 6.1, do you have any plans of backporting to any of the 
previous kernels?

If not, I would like to try to get your changes into 5.10 and 6.1 if 
Greg will accept them.


Four out of five of your changes were a straight cherry-pick into 5.10, 
one needed a minor conflict resolution. But I can definitely confirm 
that your changes fix the lockup issue on 5.10

I am now switching to 6.1 and will test the changes there too.


Thanks


--
Peace can only come as a natural consequence
of universal enlightenment -Dr. Nikola Tesla

