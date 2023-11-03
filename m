Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE37E04B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 15:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377867AbjKCOaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 10:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377809AbjKCOaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 10:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6AD47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699021759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TFrz1T06ZV9wRLR/AaSeQ5njOC3A6YG14M3hWOUp/Z8=;
        b=PI8g1NoO7oBqanPAtr7FbGRl94EhKb241AR3qXem348/pCLWdnMKDntwG9ciwv0JKXrzDD
        dZV2Lt/15SDc+WLQLG4PepXH5UdCiWMdr4FjuwSiEVIad0i+IWyots1yyFE8k6jiAH1b0c
        z11+eDwFWECDw0DwptG2uMjssB58YhE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-7wfN8l6gP6aaWWEhvau41g-1; Fri, 03 Nov 2023 10:29:17 -0400
X-MC-Unique: 7wfN8l6gP6aaWWEhvau41g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-670b675b2c5so23907396d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021757; x=1699626557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFrz1T06ZV9wRLR/AaSeQ5njOC3A6YG14M3hWOUp/Z8=;
        b=JacWpelkGqsJhq4u6K6CfPUkpuVWKrSGBcXvgZfd/cqswpUfYOZio59WNeSv8CswPB
         VIRaVkaesqO35tYt5YaH1rx+b+BMg+XRRfD++Lbb/xe/0kmAWVGL8WTk7+hjtD2EZzLZ
         Kb6rlC0EGn+FDo2QLMPAZ2RrJfejfs5HZYSq/6OrUvPW1EyCdw8n6yI3DJInRA5PsCK6
         Uh68OM0DzlRymWHsfSutcYlgMOlUGtaC67sWZFokYVnhVVw+JCh4FLwxh+zjwkWIRtDl
         a/3uCzDirwrNvMyICvjWF7saaWbQwlGscCmnp1BkFLiVCBFARI82FYN1dGdNdvfVUGAO
         1jeQ==
X-Gm-Message-State: AOJu0YzN0yG3NLugN2LEq24ASPiXX6y76nJ9OL0eAkwBkNP1RP4CfGfs
        bgWudxZCBkd8MT1DsAWrFdAzc/k5jvF9NAI8vjBU+3OSlI4Q2FVjMCXV7o/X4Ii/xz2OragFKsJ
        4Rhk+ZdIzttX1QRjB8gm+rlTy
X-Received: by 2002:ad4:5c62:0:b0:66d:8184:dd8c with SMTP id i2-20020ad45c62000000b0066d8184dd8cmr26898766qvh.54.1699021757280;
        Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnf6nWK8JYc1GZzpLOlS0paMCKupoCJR7jKRm8P63Ly0yon6nTC76VZNwvH/JsM2gH3J4Sxg==
X-Received: by 2002:ad4:5c62:0:b0:66d:8184:dd8c with SMTP id i2-20020ad45c62000000b0066d8184dd8cmr26898743qvh.54.1699021757003;
        Fri, 03 Nov 2023 07:29:17 -0700 (PDT)
Received: from localhost.localdomain ([151.29.128.41])
        by smtp.gmail.com with ESMTPSA id ne18-20020a056214425200b0066cf4fa7b47sm792703qvb.4.2023.11.03.07.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:29:16 -0700 (PDT)
Date:   Fri, 3 Nov 2023 15:29:10 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an
 atomic_t value
Message-ID: <ZUUDtm4+OO+DQHX5@localhost.localdomain>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
 <ZUN5XyOs3pWcJBo2@localhost.localdomain>
 <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63726aac-2a9b-11f2-6c24-9f33ced68706@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/23 09:01, Waiman Long wrote:
> 
> On 11/2/23 06:26, Juri Lelli wrote:
> > Hi Waiman,
> > 
> > On 01/11/23 13:59, Waiman Long wrote:
> > > On 11/1/23 12:34, Michal Koutný wrote:
> > > > On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> wrote:
> > > > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > > > cpuset_mutex, nr_deadline_tasks can be updated under two different
> > > > > locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
> > > > > a result, data races can happen leading to incorrect nr_deadline_tasks
> > > > > value.
> > > > The effect is that dl_update_tasks_root_domain() processes tasks
> > > > unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
> > > The effect is that dl_update_tasks_root_domain() may return incorrectly or
> > > it is doing unnecessary work. Will update the commit log to reflect that.
> > > > > Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
> > > > > the easy way out to avoid this possible race condition is by making
> > > > > nr_deadline_tasks an atomic_t value.
> > > > If css_set_lock is useless for this fields and it's going to be atomic,
> > > > could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
> > > > from under css_set_lock in cgroup_exit() to a (new but specific)
> > > > cpuset_cgrp_subsys.exit() handler?
> > > But css_set_lock is needed for updating other css data. It is true that we
> > > can move dec_dl_tasks_cs() outside of the lock. I can do that in the next
> > > version.
> > Not sure if you had a chance to check my last question/comment on your
> > previous posting?
> > 
> > https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/
> 
> Thanks for the reminder. I look at your comment again. Even though
> dl_rebuild_rd_accounting() operates on css(es) via css_task_iter_start() and
> css_task_iter_next(), the css_set_lock is released at the end of it. So it
> is still possible that a task can call cgroup_exit() after
> css_task_iter_next() and is being processed by dl_add_task_root_domain(). Is
> there a helper in the do_exit() path to nullify the dl_task() check. Or
> maybe we can also check for PF_EXITING in dl_add_task_root_domain() under
> the pi_lock and do the dl_task() check the under pi_lock to synchronize with
> dl_add_task_root_domain(). What do you think?
> 
> I still believe that it doesn't really matter if we call dec_dl_tasks_cs()
> inside or outside the css_set_lock.

Hummm, what if we move dec_dl_tasks_cs outside css_set_lock guard in
cgroup_exit and we grab cpuset_mutex (for dl_tasks) before doing the
decrement in there?

