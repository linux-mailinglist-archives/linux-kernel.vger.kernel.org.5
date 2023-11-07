Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452EB7E472F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbjKGRij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKGRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:38:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B18120
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699378669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zm8Amys7QGjJOjN2CWnRiELnLonabUOLC+9I3mdxhrc=;
        b=H/QHXFrAt0nNQSzFYSLqgWrNNOW8QG+qbmWNVfTksaR+eFlag6I7VySs1LIGLJpuqycAWU
        FtbxiD3AsQijShfdtCn0krAO3YQCuNJBWcgK69fhrasRmZE3xIXScDkEP0idGDSDfK8v3x
        05QjpRbd3yXkFhUABC+AeDUa3KG/P0o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-BcVxSCqZO8izOQ7a6Yo_fQ-1; Tue, 07 Nov 2023 12:37:47 -0500
X-MC-Unique: BcVxSCqZO8izOQ7a6Yo_fQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9c75b999aaaso427893366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:37:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378666; x=1699983466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm8Amys7QGjJOjN2CWnRiELnLonabUOLC+9I3mdxhrc=;
        b=b5+NWnyK5zGL7axXLZZKc6yrxLtqmPyGGpJAMcRxVqwTi8hHhCyBSqY+Oq3p/9KWK+
         jLKOJMQ0gtYOpFooFz31Wp7Vca+OOArTW2RzuwWCfuE+Gnlk3mtHny8Sq5eZcA0ETlSy
         mEDZ7acmBmou8EWx05Jmqcih8ell45tCB9cv60hqsDxurbOi1uoShwtsn70idmLW+YMi
         gv9sTfnZBjbCzEn1klyss5ez55ansGGtavZzgelkY+U/gMrKHR/RGZLss8VUXR7ePZdV
         /AQ50iooYVshdTho9WG0nxeUeOyvUIw1wPEStYg4be/Bzh3++dMelb4huRhqSLQYKvFV
         /pIg==
X-Gm-Message-State: AOJu0Yx41h1k+Tn6Prt6PJBadTA9Du0tweMRpyqN3lvbPdKhu3Lc9Sg2
        HMxRqAveyq6GS3drEt6T4PWyv++HaEXylyoLhhljSJ8tNazP5kYw91PYGxXof/pQHi0u2IbfkwD
        CTch9T5ayu/DDQdeoqWKcQ7zk
X-Received: by 2002:a17:907:c003:b0:9df:867f:f74c with SMTP id ss3-20020a170907c00300b009df867ff74cmr8174892ejc.65.1699378666271;
        Tue, 07 Nov 2023 09:37:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh/gMLEZHMHGCh/pJHcMtqzdd7B/+yaNlwBMsqxyn+hUxrg4ZTCUCPYq3PJ6zllM44UhIBLQ==
X-Received: by 2002:a17:907:c003:b0:9df:867f:f74c with SMTP id ss3-20020a170907c00300b009df867ff74cmr8174873ejc.65.1699378665944;
        Tue, 07 Nov 2023 09:37:45 -0800 (PST)
Received: from [192.168.0.224] (host-95-250-205-146.retail.telecomitalia.it. [95.250.205.146])
        by smtp.gmail.com with ESMTPSA id a1-20020a170906190100b009b913aa7cdasm1276630eje.92.2023.11.07.09.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 09:37:45 -0800 (PST)
Message-ID: <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
Date:   Tue, 7 Nov 2023 18:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20231107114732.5dd350ec@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 17:47, Steven Rostedt wrote:
> On Mon, 6 Nov 2023 16:37:32 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
>> Say CFS-server runtime is 0.3s and period is 1s.
>>
>> At 0.7s, 0-laxity timer fires. CFS runs for 0.29s, then sleeps for
>> 0.005s and wakes up at 0.295s (its remaining runtime is 0.01s at this
>> point which is < the "time till deadline" of 0.005s)
>>
>> Now the runtime of the CFS-server will be replenished to the full 0.3s
>> (due to CBS) and the deadline
>> pushed out.
>>
>> The end result is, the total runtime that the CFS-server actually gets
>> is 0.595s (though yes it did sleep for 5ms in between, still that's
>> tiny -- say if it briefly blocked on a kernel mutex). That's almost
>> double the allocated runtime.
>>
>> This is just theoretical and I have yet to see if it is actually an
>> issue in practice.
> 
> Let me see if I understand what you are asking. By pushing the execution of
> the CFS-server to the end of its period, if it it was briefly blocked and
> was not able to consume all of its zerolax time, its bandwidth gets
> refreshed. Then it can run again, basically doubling its total time.
> 
> But this is basically saying that it ran for its runtime at the start of
> one period and at the beginning of another, right?
> 
> Is that an issue? The CFS-server is still just consuming it's time per
> period. That means that an RT tasks was starving the system that much to
> push it forward too much anyway. I wonder if we just document this
> behavior, if that would be enough?

The code is not doing what I intended because I thought it was doing overload
control on the replenishment, but it is not (my bad).

he is seeing this timeline:

- w=waiting
- r=running
- s=sleeping
- T=throttled
- 3/10 reservation (30%).

|wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww|rrrrrrrrrrrrrrrrrrrrrrrrrrr|s|rrrrrrrrr+rrrrrrrr+rrrrrrrrr|TTTTTTTTTT <CPU
|___________________________period 1_______________________________________________________________|________period 2_______________________ < internal-period
0---------1---------2---------3---------4---------5---------6--------7--------8---------9----------10.......11.......12.........13......... < Real-time

It is not actually that bad because the ~2x runtime is over 2 periods.

But it is not what I intended... I intended this:

|wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww|rrrrrrrrrrrrrrrrrrrrrrrrrrrrsr|TTTTTTTTTT[...]TTTTTTTTTTT|rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr|TTTTTTT
|___________________________period 1_________________________________|_________period 2________________________[...]___________|___period 3____________________|[.... internal-period
0---------1---------2---------3---------4---------5---------6--------7--------8---------9----------10.......11.[...]16.........17........18........19........20|[.... < Real-time
---------------------------------------------------------------------+---------------------------------------------------------|
                                                                     |                                                         +new period
                                                                     +30/30>30/100, thus new period.

At the replenishment time, if the runtime left/period left > dl_rutime/dl_period,
replenish with a new period to avoid adding to much pressure to CBS/EDF.

One might say: but then the task period is different... or out of sync...
but it is not a problem: look at the "real-time"... the task starts and
run at the "deadline - runtime...." emulating the "zerolax"
(note, I do not like the term zerolax here... but (thomas voice:) whatever :-)).

One could say: in presence of deadline, this timelime will be different...

But that is intentional, as we do not want the fair server to break DL. But more
than that, if one has DL tasks, FIFO latency "property" is broken, and they should
just disable the defer option....

that is what I mentioned at the log:

"If the fair server reaches the zerolax time without consuming
its runtime, the server will be boosted, following CBS rules
(thus without breaking SCHED_DEADLINE)."

by the rule I meant doing the overload check... I thought it was
there already... but it was not... there was no need for it.

I am working on it... it is a simple change (but I need to test).

-- Daniel

