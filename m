Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD17378E0C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbjH3Uek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjH3Uej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:34:39 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B15B81
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:09 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34df9c2748eso26665ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693427578; x=1694032378; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neliSw7qoh+YUhiPFUyH0EEqS3rYdeTkzSKzjqUjw8A=;
        b=Z65u+YRz1l6pJzF1+RoWCPc18jdeArFYsEpVczIgPMjManxRd5GvjJ9Nv6HRhJSAm1
         1CA/3bB4lk+NOmjjBfJM8jfrMzDFoiB29/QRMAd3URa8TqmQIpRM8XsNj8GFjBjHGjUR
         G6NmxZy2vc08/b5ctfpirZBnj4GyAar7F9vxO8MZK4SaoXIys610Eod+/GReq51TFiYq
         /CdUNtSD5lS1hgVupLT03fPj17lVr1GAFyMLAZlk80REqw4auj0d65Q08UPO8dMbsTik
         7+I1Z+bPuF/X3yIkM9j8C8S+Sd37GCHHl3j3tAOfOrZcAd1Tcq15AR2EnLIofOsGOkqD
         sOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427578; x=1694032378;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neliSw7qoh+YUhiPFUyH0EEqS3rYdeTkzSKzjqUjw8A=;
        b=XpZeAVh535gskDtAvRgQOW0aaMufhNPrjMITytt7VKC/OS3sN7aRWrpa4YHilrXe77
         UgnUif73y6COZwp6dvnYZwVQfVquMmbsTUx1qUz4J5rQvFXQ7lKgC0yc1cnCYHg8TWZy
         vFp4Gq/eY1L9MK1Q1qfqTDwqkT3SScIJdJTBhqqravPVjhTpaJ5D5m5fPxcKWN4ZcUj8
         3ckatnQ4lPkheRlATlbE8zijtMEoqZod6gexQ/2QkNyDEQFl+bHHr+08bASgfPjrdpGq
         F/rW6ahnGSpPnIgo9B4diZjF11nhprz5y4tuONuY+FjrQCfD8D32M+lOldAWAamCMLzf
         Lr5g==
X-Gm-Message-State: AOJu0Yy/BrkpOFOjkqI98i0Yp+VO7D+YKNsbQJpXY8D75edG2stKJhag
        NYNzXEmdzlS8LgUxMqKgj2oC40nXp+95Zbau04DVWA==
X-Google-Smtp-Source: AGHT+IEtPBJyW+fxDSwfhZLVKMbrw+fx+hC8DUP+9B7LnqUilulxgXIOq0VIs7hNfhDbzxT0E54wrg==
X-Received: by 2002:a17:902:e551:b0:1c1:efe5:cce5 with SMTP id n17-20020a170902e55100b001c1efe5cce5mr28280plf.3.1693422989246;
        Wed, 30 Aug 2023 12:16:29 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id f4-20020aa782c4000000b0068a0922b1f0sm10343368pfn.137.2023.08.30.12.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:16:28 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Igor Raits <igor.raits@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Stable <stable@vger.kernel.org>
Subject: Re: Fwd: WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561
 __cfsb_csd_unthrottle+0x149/0x160
References: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com>
Date:   Wed, 30 Aug 2023 12:16:24 -0700
In-Reply-To: <a5dd536d-041a-2ce9-f4b7-64d8d85c86dc@gmail.com> (Bagas Sanjaya's
        message of "Wed, 30 Aug 2023 07:37:49 +0700")
Message-ID: <xm26cyz4ibnb.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> I notice a regression report on Bugzilla [1]. Quoting from it:
>
>> Hello, we recently got a few kernel crashes with following backtrace. Happened on 6.4.12 (and 6.4.11 I think) but did not happen (I think) on 6.4.4.
>> 
>> [293790.928007] ------------[ cut here ]------------
>> [293790.929905] rq->clock_update_flags & RQCF_ACT_SKIP
>> [293790.929919] WARNING: CPU: 13 PID: 3837105 at kernel/sched/sched.h:1561 __cfsb_csd_unthrottle+0x149/0x160
>> [293790.933694] Modules linked in: [...]
>> [293790.946262] Unloaded tainted modules: edac_mce_amd(E):1
>> [293790.956625] CPU: 13 PID: 3837105 Comm: QueryWorker-30f Tainted: G        W   E      6.4.12-1.gdc.el9.x86_64 #1
>> [293790.957963] Hardware name: RDO OpenStack Compute/RHEL, BIOS edk2-20230301gitf80f052277c8-2.el9 03/01/2023
>> [293790.959681] RIP: 0010:__cfsb_csd_unthrottle+0x149/0x160
>
> See Bugzilla for the full thread.
>
> Anyway, I'm adding this regression to regzbot:
>
> #regzbot introduced: ebb83d84e49b54 https://bugzilla.kernel.org/show_bug.cgi?id=217843
>
> Thanks.
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217843

The code in question is literally "rq_lock; update_rq_clock;
rq_clock_start_loop_update (the warning)", which suggests to me that
RQCF_ACT_SKIP is somehow leaking from somewhere else?
