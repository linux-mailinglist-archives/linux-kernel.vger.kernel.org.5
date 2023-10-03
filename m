Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14C7B6B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbjJCOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjJCOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8372B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696342170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X44Tq6ZQyKHpf85+uPUYtu3C07cLcK5Yop9qoiVlU4Q=;
        b=KAmaQodv9KmEX/P3LMyXCbetHiw1zbAIc+K8/0pVJ05pVWWBlFOJBvjzsdqxYlOJ8rI8qw
        h+x1cKE2xjjaMb/+ct0+sfMHmID8u4/t0egh6vBOcht8QHpIo5IcMQoUU4a+X4ac49g5al
        cvfSpaWv96zRr9Qq2hO6mgaOlyZCG1E=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ZqeIPJzUN3eTzl5A7k7AhA-1; Tue, 03 Oct 2023 10:09:28 -0400
X-MC-Unique: ZqeIPJzUN3eTzl5A7k7AhA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4936b96d2f1so339890e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 07:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696342168; x=1696946968;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X44Tq6ZQyKHpf85+uPUYtu3C07cLcK5Yop9qoiVlU4Q=;
        b=h72+rS2JJ4Kwx2yuN+fpfxUnnNMJMNHPc3XpVwoctl6hm8au0YDsUIMOkzuzEd1Y8f
         X8lAvBAE8quYu15YETpI9TPBwtVCQRRDEcyuuvoyVOiYjiMAonxsSYGlyJ8rjoAbCtc5
         xBKKTe67d7u3UVkGhtBqXXCmZzLRGEz6fhKktCxuYph+Zlryvgv05shwELJXk5yR/34C
         vctLRpaIEPN23qdYKuuIPLsXoGOCnGsnJmXXCwUYJoBqPQnJcB/gI/z2oK9CUfUBFNm/
         Q9NGWajSLSNjx0nULZ1AjxKtwvJZOlfKQqOWdq/UgGYLuNINahIcT65SaR9mmcDCTvNV
         JDPA==
X-Gm-Message-State: AOJu0YxC/zVfPbo+rIo/LunS7DW5ZtcetNuazU1r2NP30ZjSVVzcp0BW
        IxCu3rBJ3X1t6CppMocCgNInk8ToOJh85md9FDz8vKEqdoG4V+DG7dzFE59AtnHSHH5QiqVtddL
        BEgKKl/i2YGPyhvIKwefuWxuIzGJcI42S
X-Received: by 2002:a1f:e203:0:b0:49d:3e4c:6168 with SMTP id z3-20020a1fe203000000b0049d3e4c6168mr5577718vkg.7.1696342167733;
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE51CWMMcL1xIGhPy1qwOpsEeNOmhrlSsl8Pun0ZXJxi4IsgC97mbRzcHjfWR+66hBRo6sgqQ==
X-Received: by 2002:a1f:e203:0:b0:49d:3e4c:6168 with SMTP id z3-20020a1fe203000000b0049d3e4c6168mr5577694vkg.7.1696342167414;
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a0c8c09000000b0065b11053445sm516960qvb.54.2023.10.03.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:09:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>
Subject: Re: Question on tw_timer TIMER_PINNED
In-Reply-To: <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
References: <ZPhpfMjSiHVjQkTk@localhost.localdomain>
 <CANn89iJFyqckr3x=nwbExs3B1u=MXv9izL=2ByxOf20su2fhhg@mail.gmail.com>
Date:   Tue, 03 Oct 2023 16:09:24 +0200
Message-ID: <xhsmhwmw3ol0r.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/09/23 14:10, Eric Dumazet wrote:
> On Wed, Sep 6, 2023 at 1:58=E2=80=AFPM Juri Lelli <juri.lelli@redhat.com>=
 wrote:
>>
>> Hi Eric,
>>
>> I'm bothering you with a question about timewait_sock tw_timer, as I
>> believe you are one of the last persons touching it sometime ago. Please
>> feel free to redirect if I failed to git blame it correctly.
>>
>> At my end, latency spikes (entering the kernel) have been reported when
>> running latency sensitive applications in the field (essentially a
>> polling userspace application that doesn't want any interruption at
>> all). I think I've been able to track down one of such interruptions to
>> the servicing of tw_timer_handler. This system isolates application CPUs
>> dynamically, so what I think it happens is that at some point tw_timer
>> is armed on a CPU, and it is PINNED to that CPU, meanwhile (before the
>> 60s timeout) such CPU is 'isolated' and the latency sensitive app
>> started on it. After 60s the timer fires and interrupts the app
>> generating a spike.
>>
>> I'm not very familiar with this part of the kernel and from staring
>> at code for a while I had mixed feeling about the need to keep tw_timer
>> as TIMER_PINNED. Could you please shed some light on it? Is it a strict
>> functional requirement or maybe a nice to have performance (locality I'd
>> guess) improvement? Could we in principle make it !PINNED (so that it
>> can be moved/queued away and prevent interruptions)?
>>
>
> It is a functional requirement in current implementation.
>
> cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
> changelog has some details about it.
>
> Can this be changed to non pinned ? Probably, but with some care.
>
> You could simply disable tw completely, it is a best effort mechanism.
>

So it's looking like doing that is not acceptable for our use-case, as
we still want timewait sockets for the traffic happening on the
housekepeing (non-isolated) CPUs.


I had a look at these commits to figure out what it would take to make it
not pinned:

  cfac7f836a71 ("tcp/dccp: block bh before arming time_wait timer")
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")

and I'm struggling to understand why we want the timer to be armed before
inet_twsk_hashdance(). I found this discussion on LKML:

  https://lore.kernel.org/all/56941035.9040000@fastly.com/

And I can see that __inet_lookup_established() and tw_timer_handler()
both operate on __tw_common.skc_nulls_node and __tw_common.skc_refcnt, but:
- the timer has its own count in the refcount
- sk_nulls_for_each_rcu() is (on paper) safe to run concurrently with
  tw_timer_handler
  `\
    inet_twsk_kill()
    `\
      sk_nulls_del_node_init_rcu()

So I'm thinking we could let the timer be armed after the *hashdance(), so
it wouldn't need to be pinned anymore, but that's pretty much a revert of
  ed2e92394589 ("tcp/dccp: fix timewait races in timer handling")
which fixed a race.

Now this is the first time I poke my nose into this area and I can't
properly reason how said race is laid out. I'm sorry for asking about such
an old commit, but would you have any pointers on that?

Thanks

