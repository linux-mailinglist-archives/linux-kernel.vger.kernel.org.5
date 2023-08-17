Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE0477FCFF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353986AbjHQR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353994AbjHQR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:26:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AEBF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:26:27 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bf095e1becso50335ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692293187; x=1692897987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CDRl1/FFXQzt1PG5UM+41faxkoiYDoNvq2d7j+I4d6M=;
        b=2mwQCh5jd41H1BJAU+hEBa8u1PRPFONFNvdXcHOgRsWX1CPT2Nb/5RhD0DZWCc8Clu
         2v+sEIidduxj/LXVHU6xGOVzR5jJwANuymgND905u8yG6UZ2Cbeg0/vFpr1qPwM+hSFT
         Q0g1tOgsrAkOPGbb8l/Ow3pE/5Upg4r89MKU5Oelsd/GRTJdCFkqnNe1VsFEl4ADmQHw
         jhIJ8oStYVaCu7uHY0MCIf+GWRur98K/WOuqrlWp0nOrz5WO94OjPQrm85pvFL0O99zg
         duJEtpObhhWxHie0ZcbAm9LwauPIVnYiWLLarm2htg9VSOXS1iTKq2SJSpGR/e322zmn
         D/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692293187; x=1692897987;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CDRl1/FFXQzt1PG5UM+41faxkoiYDoNvq2d7j+I4d6M=;
        b=UCKZgcY6MEboyjzLV1wtPM7niwWVL9CqlDWguCQQbwGNsFI3+s96roFaIq5eGDW+39
         KUpAVaCt2nsHgj5vvyFdCIyn36LZckMHzWaaHt0URQc6XiuI2dDJRuA3OlTad+yNKLQq
         9hulqOVvn03nQ+bUjpOoJmHiLYMsRPAOkN+5ep5XKb8hfguUaCMWTXR7h18C7ozzfyYV
         0CyATXExn9G0fWBEZGR994eJrz9n62uDYizt0aO+lX2iaUr0oQRSLxPZDX/OqKgkM72P
         wwnxxYlwjfuP01PvoCO+2mzTdiZDQ3loBKxOxagrZoWYdVeqf8XsbDhzkc4XfczQlTrP
         2P1Q==
X-Gm-Message-State: AOJu0YyZw3VX/XpexZ2T0seVWzkDTE8RMS1L/2FlujAS/TpYNQIj77LH
        cumjPXPGj46b8D99+uDxnAs89g==
X-Google-Smtp-Source: AGHT+IHNnMqBatXZYdvKTkOvYxFNJ7DOcCguixrdqDz0LK7VurLGe3CXxam/YuJMZnTSzK3oRdJRiA==
X-Received: by 2002:a17:903:22cd:b0:1b8:50a9:6874 with SMTP id y13-20020a17090322cd00b001b850a96874mr19735plg.5.1692293186761;
        Thu, 17 Aug 2023 10:26:26 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902d3c600b001bdf45eb5b6sm12246plb.284.2023.08.17.10.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 10:26:26 -0700 (PDT)
Message-ID: <8a33da7a-425b-4fb5-9bf0-9a34ff01d80f@kernel.dk>
Date:   Thu, 17 Aug 2023 11:26:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     Chengming Zhou <chengming.zhou@linux.dev>,
        Bart Van Assche <bvanassche@acm.org>, hch@lst.de
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, cel@kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <202308172100.8ce4b853-oliver.sang@intel.com>
 <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
 <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
 <d16edaf8-1eef-f099-eb15-7599906d1492@linux.dev>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d16edaf8-1eef-f099-eb15-7599906d1492@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/23 11:17 AM, Chengming Zhou wrote:
> On 2023/8/17 23:29, Chengming Zhou wrote:
>> On 2023/8/17 22:50, Bart Van Assche wrote:
>>> On 8/17/23 07:41, kernel test robot wrote:
>>>> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
>>>> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))
>>>
>>> The above information shows that dd_inserted_request() has been called
>>> 276 times and also that dd_finish_request() has been called 278 times.
>>
>> Thanks much for your help.
>>
>> This patch indeed introduced a regression, postflush requests will be completed
>> twice, so here dd_finish_request() is more than dd_inserted_request().
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index a8c63bef8ff1..7cd47ffc04ce 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -686,8 +686,10 @@ static void blk_mq_finish_request(struct request *rq)
>>  {
>>         struct request_queue *q = rq->q;
>>
>> -       if (rq->rq_flags & RQF_USE_SCHED)
>> +       if (rq->rq_flags & RQF_USE_SCHED) {
>>                 q->elevator->type->ops.finish_request(rq);
>> +               rq->rq_flags &= ~RQF_USE_SCHED;
>> +       }
>>  }
>>
> 
> I just tried to run LKP and xfstests, firstly failed to run LKP on my server
> which seems to miss some dependencies. Then I ran xfstests successfully.
> 
> But xfstests generic/704 always pass and no WARN in dmesg. (I don't know why,
> maybe my server settings are some different from the test robot.)
> 
> So I try to reproduce it manually. Steps:
> 
> ```
> echo mq-deadline > /sys/block/sdb/queue/scheduler
> 
> mkfs.ext4 /dev/sdb
> mount /dev/sdb /fs/sdb
> cd /fs/sdb
> stress-ng --symlink 4 --timeout 60
> 
> echo none > /sys/block/sdb/queue/scheduler
> ```
> 
> This way the WARNING in mq-deadline can be reproduced easily.
> 
> Then retest with the diff, mq-deadline WARNING still happened... So there
> are still other requests which have RQF_USE_SCHED flag completed without
> being inserted into elevator.
> 
> Will use some tracing and look again.

Ah missed this, thanks for doing this testing. I'll wait for an update
version. We can just fold in whatever change we need, and most likely
just push the patch to next week rather than send off a pull request for
this week. It's the only important thing pending on the block side.

-- 
Jens Axboe

