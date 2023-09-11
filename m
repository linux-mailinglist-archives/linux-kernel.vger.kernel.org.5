Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390679B1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354774AbjIKVzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjIKN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F76B12A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694438747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWAqz+TSHcXXWRExk4GJdL39eZS3mXtkMY/iF+0aEtI=;
        b=V+Ve/+YM4dt1w6eRt4clDvCUl2RCboXz0N36Gj8zedm4WMDzybaoVP3o1qAKpza74SXxzR
        DS15L06w62RTVrt5R9ApgGMYGQTnJp4lz1GF42PjJhvZ1CyY3mbGdrwyV65PRvQGb/bp8S
        ojPFbEQJ0/+uLh11yjDp0gN2hst/mBU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-Vf3Fhd4BMrKrF1Oc_npyog-1; Mon, 11 Sep 2023 09:25:44 -0400
X-MC-Unique: Vf3Fhd4BMrKrF1Oc_npyog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B64693C0C4A2;
        Mon, 11 Sep 2023 13:25:43 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.192.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6829B40C2064;
        Mon, 11 Sep 2023 13:25:39 +0000 (UTC)
Date:   Mon, 11 Sep 2023 09:25:35 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 0/2] Fix nohz_full vs rt bandwidth
Message-ID: <20230911132535.GA24480@lorien.usersys.redhat.com>
References: <20230821094927.51079-1-jiahao.os@bytedance.com>
 <1823b6fd-037f-38dc-2d33-0879d77768c3@bytedance.com>
 <20230907141703.GA441901@lorien.usersys.redhat.com>
 <bd786914-4718-7a35-fcc1-9cdee58d2f06@bytedance.com>
 <20230908124501.GA471894@lorien.usersys.redhat.com>
 <a353150b-1382-9e76-e14f-4170c956b8ce@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a353150b-1382-9e76-e14f-4170c956b8ce@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URI_HEX autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Hao,

On Mon, Sep 11, 2023 at 11:39:02AM +0800 Hao Jia wrote:
> On 2023/9/8 Phil Auld wrote:
> > On Fri, Sep 08, 2023 at 10:57:26AM +0800 Hao Jia wrote:
> > > On 2023/9/7 Phil Auld wrote:
> > > > Hi Hao,

...

> > > > 
> > > > Are you actually hitting this in the real world?
> > > > 
> > > > We, for example, no longer enable RT_GROUP_SCHED so this is a non-issue
> > > > for our use cases.  I'd recommend considering that. (Does it even
> > > > work with cgroup2?)
> > > > 
> > > 
> > > Yes, it has always been there. Regardless of whether RT_GROUP_SCHED is
> > > enabled or not, rt bandwidth is always enabled. If RT_GROUP_SCHED is not
> > > enabled, all rt tasks in the system are a group, and rt_runtime is 950000,
> > > and rt_period is 1000000.So rt bandwidth is always enabled by default.
> > 
> > Sure, there is that. But I think Daniel is actively trying to remove it.
> > 
> 
> Thank you for your reply. Maybe I'm missing something. Can you give me some
> links to discussions about it?
>

Sure, try this one:
      https://lore.kernel.org/lkml/cover.1693510979.git.bristot@kernel.org/


> > Also I'm not sure you answered my question. Are you actually hitting this
> > in the real world?  I'd be tempted to think this is a mis-configuration or
> > mis-use of RT.  Plus you can disable that throttling and use stalld to catch
> > cases where the rt task goes out of control.
> > 
> 
> > Are you actually hitting this in the real world?
> 
> I tested on my machine using default settings (rt_runtime is 950000, and
> rt_period is 1000000.). The rt task is supposed to be throttled after
> running for 0.95 seconds, but due to the influence of NO_HZ_FULL, it may be
> throttled after running for about 1.4 seconds. This will only cause the
> rt_bandwidth throttle to be delayed, but no warning will be triggered.

Yes, you can hit this in testing.  I'm asking if it's causing your real-world
applicaton issues or is this just a theoretical problem you can contrive a
test for?  Are you actually hitting this when running your workload?
From what you are showing (a test setup) I'm guessing no.

> 
> 
> > Plus you can disable that throttling and use stalld to catch cases where
> the rt task goes out of control.
> 
> IIRC, if we disable rt_bandwidth. The rt task is always running, which may
> cause cfs task starvation and hung_task warnning. This may be the reason why
> rt_bandwidth is enabled by default (rt_runtime is 950000, and rt_period is
> 1000000).

That's what stalld is for.  Some rt applications don't like giving up 5% of
the cpu time when they don't really need to.


Cheers,
Phil


-- 

