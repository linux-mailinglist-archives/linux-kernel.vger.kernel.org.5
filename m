Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92C37C4CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjJKIPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJKIPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF4292
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697012099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9D1+Mg6WwE6XkiEh34ZneVi9fMIARLlEUsflqkgul4=;
        b=YhHhtFvJXZVAj8IPxKUn2XU3xS05kzsB9v/qelSNbJTWY8mwCVZFLLP6pjiAaatXWSA1R5
        v/a761EGGo1aPWDs9LfGlqVqApQIFfrDgW+AwHQqVvBb4G5ytHMfNnN5s4fGCzijLYgtP8
        i7fG9JjoP6FZvlR7dTQOnjPQWJyfTzk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-FZ44SCHOMmeh9QZmQPgOPQ-1; Wed, 11 Oct 2023 04:14:57 -0400
X-MC-Unique: FZ44SCHOMmeh9QZmQPgOPQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41981d2dc9aso76781511cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012097; x=1697616897;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9D1+Mg6WwE6XkiEh34ZneVi9fMIARLlEUsflqkgul4=;
        b=HV0u1WWbRaUzUwDuSZxAMDCszZP1YibmtXVDii9/WBE81iRywcEzfQI64eKbGtmYvP
         6EM0DW0g96vJffHtYDIcxlX+mHcjVi2jFFahjRUDhOBt2n7PY91W1mztRj/jLLcqqpAL
         G45jWdE4lvvEO1HgLr9CtJrRY0YLi9rWezCafiLq3MfNBtNX5s4d5DKjE1mKNowoWOjf
         lqz13RuBh8g6l2HJ8iphxNkLY8WuysFOxbQThcJ24lwlNiH4NBv+JJAnZkR48/ogI2si
         XF3cjGLZ68F8hT4kP0YDo+AD3mgECpLMOT7VRREijtu77r+4LNhS/B/kXgJNKFwa+LqO
         Or2w==
X-Gm-Message-State: AOJu0Yzy2yxKHLlc7UyQ4Ys0CQV+kgHmb5S8L6Qy0mIvcPg5OkP5ej9u
        1GthJp/iNtgnZoOWfPNmOp1Ip0XwL6AH3LnsBGqKrEJWUUtIfI5NTlH46FllyHBN5YoPzr/aZHK
        DBkum2jdkcDFsDixVdmoh4cBN
X-Received: by 2002:a05:622a:1d1:b0:417:b91b:e101 with SMTP id t17-20020a05622a01d100b00417b91be101mr25076627qtw.21.1697012097434;
        Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGul6z32HfOLFDPOSzU+YQXeKevNCxMXG7nQdRT9WC1cm2UXgJGAXlQqlesfJE6USlhuVfGSg==
X-Received: by 2002:a05:622a:1d1:b0:417:b91b:e101 with SMTP id t17-20020a05622a01d100b00417b91be101mr25076614qtw.21.1697012097133;
        Wed, 11 Oct 2023 01:14:57 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.163])
        by smtp.gmail.com with ESMTPSA id b21-20020ac84f15000000b004180fdcb482sm5193431qte.81.2023.10.11.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:14:56 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:14:52 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH] cgroup/cpuset: Change nr_deadline_tasks to an atomic_t
 value
Message-ID: <ZSZZfImXuCG4Xvaz@localhost.localdomain>
References: <20231009191515.3262292-1-longman@redhat.com>
 <ZSTiULEnD7SF9n7y@localhost.localdomain>
 <6b769316-6434-5054-43f5-7933fc2bee01@redhat.com>
 <31e06652-1dbd-e32f-3123-d17e178c5c27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31e06652-1dbd-e32f-3123-d17e178c5c27@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 16:03, Waiman Long wrote:
> 
> On 10/10/23 15:44, Waiman Long wrote:
> > 
> > On 10/10/23 01:34, Juri Lelli wrote:
> > > Hi,
> > > 
> > > On 09/10/23 15:15, Waiman Long wrote:
> > > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > > cpuset_mutex, nr_deadline_tasks can be updated in various contexts
> > > > under different locks. As a result, data races may happen that cause
> > > > incorrect value to be stored in nr_deadline_tasks leading to incorrect
> > > Could you please make an example of such data races?
> > 
> > Since update to cs->nr_deadline_tasks is not protected by a single lock,
> > it is possible that multiple CPUs may try to modify it at the same
> > time.� It is possible that nr_deadline_tasks++ and nr_deadline_tasks--
> > can be done in a single instruction like in x86 and hence atomic.
> > However, operation like "cs->nr_deadline_tasks +=
> > cs->nr_migrate_dl_tasks" is likely a RMW operation and so is subjected
> > to racing. It is mostly theoretical, but probably not impossible.
> 
> Sorry, even increment and decrement operators are not atomic.
> 
> inc_dl_tasks_cs() is only called from switched_to_dl() in deadline.c which
> is protected by the rq_lock, but there are multiple rq's. dec_dl_tasks_cs()
> is called from switched_from_dl() in deadline.c and cgroup_exit() in
> cgroup.c. The later one is protected by css_set_lock. The other place where
> nr_deadline_tasks can be changed is in cpuset_attach() protected by
> cpuset_mutex.

So, let's see. :)

switched_to_dl(), switched_from_dl() and cpuset_attach() should all be
protected (for DEADLINE tasks) by cpuset_mutex, see [1] for the former
two.

What leaves me perplexed is indeed cgroup_exit(), which seems to operate
under css_set_lock as you say. I however wonder why is that not racy
already wrt, say, cpuset_attach() which AFAIU uses css information w/o
holding css_set_lock?

Thanks,
Juri

1 - https://elixir.bootlin.com/linux/latest/source/kernel/sched/core.c#L7688

