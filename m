Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171B7542AF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjGNSk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjGNSky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:40:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013DA2680;
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2175371b3a.0;
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689360052; x=1691952052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaj9+8bPsLOlF6cZ7IxpC9i332ISYKV4tQnH1g2SIjg=;
        b=YirKGceAT6z8ET47AGt8osx9wUnEZwVRRCBQZHQSamFop77w665Ha9AxUvrF3adJNl
         xQDrI2u82R6zWttobX+tbyAdXsHdMLX6eNJ4KTduJ+wevcQIaKOv4AqOGQNZMvuTQJux
         /6BjrBZCVm1uoiFRKksuEyjWFoaBXNJ2xi/PMl6K36Gw8PnHSfVWeldzIE1FPyMAYd5x
         jB3vv3a7OCj/9U44WR8/sooNl71zazoxW4MafdLgPDwoCkoVGXeUg0FIlfvMj3ac8VPT
         ySq0CVxnDFoTS47wkOQlMmvZNnUmlMdvLoHv8/P3vg8VHbtrgFlCpXreed+usx5GL6JA
         C9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689360052; x=1691952052;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaj9+8bPsLOlF6cZ7IxpC9i332ISYKV4tQnH1g2SIjg=;
        b=GWNqsfquHBKVa5ykqk+qVVbyyqxqy5Puy4cuhnNilcrZZbZ0V7kJfnoTp+Nt1BMlq+
         9mX89RBH7GY09TxfeJ/DQJd6v2yaYtsNp+xa9pbVWJHM0AApOK9tOaVbO78fTVNxV0eh
         M2ndMffN9H8/TXbZ0pTKQbomoPQLiuxA3M2UwgYyb2klA1uVs84VdjFoCThQSRPJf6m+
         RCnNuGxBcW3hZgBJ765u90P3xIsQ1G2gpeNJQdXgoKIdY3uMWcZ0ySoj2+If+8Sg9KwA
         hq6/ahTpoIveDk397VU3m8kJo8rz9IAK5lsHLP2umBUcSyzTLfWyaAMsU0GlMRclEOh9
         Sh/Q==
X-Gm-Message-State: ABy/qLbL/aJE+HSNqBCazLdK4zfZxam23kXLZaORgcQi4RZym5xPXAmp
        Lq3E/hebmjY3KWayCcltJIk=
X-Google-Smtp-Source: APBJJlEFEoxnqbfk0Z7qSbw4sOXIFQIuh8c1Vjjrexw29TFUt/+RNDWEBlkXAmd14E+5d9isBY4EAQ==
X-Received: by 2002:a05:6a21:6da5:b0:133:1a76:6bab with SMTP id wl37-20020a056a216da500b001331a766babmr6838645pzb.47.1689360052379;
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id ey4-20020a056a0038c400b00672401787c6sm7455354pfb.109.2023.07.14.11.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 11:40:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when
 !CONFIG_DEBUG_LOCK_ALLOC
From:   Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
Date:   Sat, 15 Jul 2023 02:40:08 +0800
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D042B1CB-2ED4-4DF9-8CF5-5E455E7EAB73@gmail.com>
References: <f124e041-6a82-2069-975c-4f393e5c4137@linux.alibaba.com>
 <87292a44-cc02-4d95-940e-e4e31d0bc6f2@paulmck-laptop>
 <f1c60dcb-e32f-7b7e-bf0d-5dec999e9299@linux.alibaba.com>
 <CAEXW_YSODXRfgkR0D2G-x=0uZdsqvF3kZL+LL3DcRX-5CULJ1Q@mail.gmail.com>
 <894a3b64-a369-7bc6-c8a8-0910843cc587@linux.alibaba.com>
 <CAEXW_YSM1yik4yWTgZoxCS9RM6TbsL26VCVCH=41+uMA8chfAQ@mail.gmail.com>
 <58b661d0-0ebb-4b45-a10d-c5927fb791cd@paulmck-laptop>
 <7d433fac-a62d-4e81-b8e5-57cf5f2d1d55@paulmck-laptop>
 <F160D7F8-57DC-4986-90A9-EB50F7C89891@gmail.com>
 <6E5326AD-9A5D-4570-906A-BDE8257B6F0C@gmail.com>
 <e8ee7006-c1d0-4c04-bd25-0f518fb6534b@paulmck-laptop>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 2023=E5=B9=B47=E6=9C=8815=E6=97=A5 01:02=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 14, 2023 at 11:54:47PM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 23:35=EF=BC=8CAlan Huang =
<mmpgouride@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>>=20
>>>> 2023=E5=B9=B47=E6=9C=8814=E6=97=A5 10:16=EF=BC=8CPaul E. McKenney =
<paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> On Thu, Jul 13, 2023 at 09:33:35AM -0700, Paul E. McKenney wrote:
>>>>> On Thu, Jul 13, 2023 at 11:33:24AM -0400, Joel Fernandes wrote:
>>>>>> On Thu, Jul 13, 2023 at 10:34=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>>>> On 2023/7/13 22:07, Joel Fernandes wrote:
>>>>>>>> On Thu, Jul 13, 2023 at 12:59=E2=80=AFAM Gao Xiang =
<hsiangkao@linux.alibaba.com> wrote:
>>>>>>>>> On 2023/7/13 12:52, Paul E. McKenney wrote:
>>>>>>>>>> On Thu, Jul 13, 2023 at 12:41:09PM +0800, Gao Xiang wrote:
>>>>>>>>>=20
>>>>>>>>> ...
>>>>>>>>>=20
>>>>>>>>>>>=20
>>>>>>>>>>> There are lots of performance issues here and even a plumber
>>>>>>>>>>> topic last year to show that, see:
>>>>>>>>>>>=20
>>>>>>>>>>> [1] =
https://lore.kernel.org/r/20230519001709.2563-1-tj@kernel.org
>>>>>>>>>>> [2] =
https://lore.kernel.org/r/CAHk-=3DwgE9kORADrDJ4nEsHHLirqPCZ1tGaEPAZejHdZ03=
qCOGg@mail.gmail.com
>>>>>>>>>>> [3] =
https://lore.kernel.org/r/CAB=3DBE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyU=
qFneQ@mail.gmail.com
>>>>>>>>>>> [4] https://lpc.events/event/16/contributions/1338/
>>>>>>>>>>> and more.
>>>>>>>>>>>=20
>>>>>>>>>>> I'm not sure if it's necessary to look info all of that,
>>>>>>>>>>> andSandeep knows more than I am (the scheduling issue
>>>>>>>>>>> becomes vital on some aarch64 platform.)
>>>>>>>>>>=20
>>>>>>>>>> Hmmm...  Please let me try again.
>>>>>>>>>>=20
>>>>>>>>>> Assuming that this approach turns out to make sense, the =
resulting
>>>>>>>>>> patch will need to clearly state the performance benefits =
directly in
>>>>>>>>>> the commit log.
>>>>>>>>>>=20
>>>>>>>>>> And of course, for the approach to make sense, it must avoid =
breaking
>>>>>>>>>> the existing lockdep-RCU debugging code.
>>>>>>>>>>=20
>>>>>>>>>> Is that more clear?
>>>>>>>>>=20
>>>>>>>>> Personally I'm not working on Android platform any more so I =
don't
>>>>>>>>> have a way to reproduce, hopefully Sandeep could give actually
>>>>>>>>> number _again_ if dm-verity is enabled and trigger another
>>>>>>>>> workqueue here and make a comparsion why the scheduling =
latency of
>>>>>>>>> the extra work becomes unacceptable.
>>>>>>>>>=20
>>>>>>>>=20
>>>>>>>> Question from my side, are we talking about only performance =
issues or
>>>>>>>> also a crash? It appears z_erofs_decompress_pcluster() takes
>>>>>>>> mutex_lock(&pcl->lock);
>>>>>>>>=20
>>>>>>>> So if it is either in an RCU read-side critical section or in =
an
>>>>>>>> atomic section, like the softirq path, then it may
>>>>>>>> schedule-while-atomic or trigger RCU warnings.
>>>>>>>>=20
>>>>>>>> z_erofs_decompressqueue_endio
>>>>>>>> -> z_erofs_decompress_kickoff
>>>>>>>> ->z_erofs_decompressqueue_work
>>>>>>>> ->z_erofs_decompress_queue
>>>>>>>>  -> z_erofs_decompress_pcluster
>>>>>>>>   -> mutex_lock
>>>>>>>>=20
>>>>>>>=20
>>>>>>> Why does the softirq path not trigger a workqueue instead?
>>>>>>=20
>>>>>> I said "if it is". I was giving a scenario. mutex_lock() is not
>>>>>> allowed in softirq context or in an RCU-reader.
>>>>>>=20
>>>>>>>> Per Sandeep in [1], this stack happens under RCU read-lock in:
>>>>>>>>=20
>>>>>>>> #define __blk_mq_run_dispatch_ops(q, check_sleep, dispatch_ops) =
\
>>>>>>>> [...]
>>>>>>>>               rcu_read_lock();
>>>>>>>>               (dispatch_ops);
>>>>>>>>               rcu_read_unlock();
>>>>>>>> [...]
>>>>>>>>=20
>>>>>>>> Coming from:
>>>>>>>> blk_mq_flush_plug_list ->
>>>>>>>>                          blk_mq_run_dispatch_ops(q,
>>>>>>>>                               __blk_mq_flush_plug_list(q, =
plug));
>>>>>>>>=20
>>>>>>>> and __blk_mq_flush_plug_list does this:
>>>>>>>>         q->mq_ops->queue_rqs(&plug->mq_list);
>>>>>>>>=20
>>>>>>>> This somehow ends up calling the bio_endio and the
>>>>>>>> z_erofs_decompressqueue_endio which grabs the mutex.
>>>>>>>>=20
>>>>>>>> So... I have a question, it looks like one of the paths in
>>>>>>>> __blk_mq_run_dispatch_ops() uses SRCU.  Where are as the =
alternate
>>>>>>>> path uses RCU. Why does this alternate want to block even if it =
is not
>>>>>>>> supposed to? Is the real issue here that the BLK_MQ_F_BLOCKING =
should
>>>>>>>> be set? It sounds like you want to block in the "else" path =
even
>>>>>>>> though BLK_MQ_F_BLOCKING is not set:
>>>>>>>=20
>>>>>>> BLK_MQ_F_BLOCKING is not a flag that a filesystem can do =
anything with.
>>>>>>> That is block layer and mq device driver stuffs. filesystems =
cannot set
>>>>>>> this value.
>>>>>>>=20
>>>>>>> As I said, as far as I understand, previously,
>>>>>>> .end_io() can only be called without RCU context, so it will be =
fine,
>>>>>>> but I don't know when .end_io() can be called under some RCU =
context
>>>>>>> now.
>>>>>>=20
>>>>>>> =46rom what Sandeep described, the code path is in an RCU =
reader. My
>>>>>> question is more, why doesn't it use SRCU instead since it =
clearly
>>>>>> does so if BLK_MQ_F_BLOCKING. What are the tradeoffs? IMHO, a =
deeper
>>>>>> dive needs to be made into that before concluding that the fix is =
to
>>>>>> use rcu_read_lock_any_held().
>>>>>=20
>>>>> How can this be solved?
>>>>>=20
>>>>> 1. Always use a workqueue.  Simple, but is said to have =
performance
>>>>> issues.
>>>>>=20
>>>>> 2. Pass a flag in that indicates whether or not the caller is in =
an
>>>>> RCU read-side critical section.  Conceptually simple, but might
>>>>> or might not be reasonable to actually implement in the code as
>>>>> it exists now. (You tell me!)
>>>>>=20
>>>>> 3. Create a function in z_erofs that gives you a decent
>>>>> approximation, maybe something like the following.
>>>>>=20
>>>>> 4. Other ideas here.
>>>>=20
>>>> 5. #3 plus make the corresponding Kconfig option select
>>>> PREEMPT_COUNT, assuming that any users needing compression in
>>>> non-preemptible kernels are OK with PREEMPT_COUNT being set.
>>>> (Some users of non-preemptible kernels object strenuously
>>>> to the added overhead from CONFIG_PREEMPT_COUNT=3Dy.)
>>>=20
>>> 6. Set one bit in bio->bi_private, check the bit and flip it in =
rcu_read_lock() path,
>>> then in z_erofs_decompressqueue_endio, check if the bit has changed.
>>=20
>> Seems bad, read and modify bi_private is a bad idea.
>=20
> Is there some other field that would work?

Maybe bio->bi_opf, btrfs uses some bits of it.

>=20
> Thanx, Paul
>=20
>>> Not sure if this is feasible or acceptable. :)
>>>=20
>>>>=20
>>>> Thanx, Paul
>>>>=20
>>>>> The following is untested, and is probably quite buggy, but it =
should
>>>>> provide you with a starting point.
>>>>>=20
>>>>> static bool z_erofs_wq_needed(void)
>>>>> {
>>>>> if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
>>>>> return true;  // RCU reader
>>>>> if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preemptible())
>>>>> return true;  // non-preemptible
>>>>> if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
>>>>> return true;  // non-preeemptible kernel, so play it safe
>>>>> return false;
>>>>> }
>>>>>=20
>>>>> You break it, you buy it!  ;-)
>>>>>=20
>>>>> Thanx, Paul


