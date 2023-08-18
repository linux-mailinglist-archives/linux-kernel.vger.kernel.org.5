Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4168078155D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbjHRWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbjHRWTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:19:17 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FE30E9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:19:15 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a7f4f7a8easo629830b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692397155; x=1693001955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hmpKIyAQ8RsIyIEMOMC7QqMJtydQ9V1xA5lN6gQxjZI=;
        b=rDWfS1qgctml/CnDjcIdruBH+DHUCGbl85DmFlXB/3Rb4TZalsuBMBkcKe5rwOG/2d
         q11J5RVL2Nh/T5ca7d+YfO44YpB/y6Vj8RCzA7MmGI3ebcpF2CNKRcBf1WF3YSRTHN9t
         XRjr3lPJrmP0vBGvYrVC+KBesQD9ApDl2o1zdU5SL10jW3rWfTd8YVAbF86EpTusstrw
         6gxji2eNBUIE9sigybwMoCwnpzMhHZKp12BG7G2ouWBobL+2wNU7U87YLpeMHLQyGnSG
         qzX3XHyI1s1Ux7P7jE2aqRsSHBafKPpXmfcASYxce8+0kpUiNyZoIbwshrygCQxg43Zr
         coNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692397155; x=1693001955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmpKIyAQ8RsIyIEMOMC7QqMJtydQ9V1xA5lN6gQxjZI=;
        b=kJ8/uFsGpXCTIsFw0KNBN5Fy2npheUVs4rdmI/smz4yfFHitgHK4Nzr/YKvjX3GgAX
         urB6tS5XjYjxVsBvz8hzx1J0puBvKIsc1rVM4YE6JHMODMVvig5P2da9uEtbdmxJtYUO
         annMVhsstQOurM2Nz4j7BZtuUidzuctRDUjbN0KaR+gdKJmcN+bdAiBwOWVxVaQhc3ux
         Z2ytCynfz4FgRoRnGUCLGlJaexV7lA3IEMRmUqbnxRFmF2f4pZbrAc6yhckQqc6yIVBq
         LncOUc5d4vgl4qit9h6hIRJ3ETxBaLO1393SOyf83f2aOrnpLHBUzqv1TBxMxIznWTsq
         EAgA==
X-Gm-Message-State: AOJu0Yw0l2Dxpf2h6oY9cVTDmJmCqSECLgX44lUV3vporZi7L32qyNVt
        FjA+VkRR8mCpXg3hG2Yj+AAgew==
X-Google-Smtp-Source: AGHT+IGlY5jBVyHy6id4d2YSavOSbKGRT+TFNUDhCFs+bK5aqxjjPqXsb43+1mr0FR6EuLyJsll8cA==
X-Received: by 2002:a05:6359:1b85:b0:139:e3a4:70a1 with SMTP id ur5-20020a0563591b8500b00139e3a470a1mr420297rwb.28.1692397154786;
        Fri, 18 Aug 2023 15:19:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:75e0])
        by smtp.gmail.com with ESMTPSA id g22-20020a0caad6000000b006262de12a8csm981855qvb.65.2023.08.18.15.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 15:19:14 -0700 (PDT)
Date:   Fri, 18 Aug 2023 18:19:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <20230818221913.GA144640@cmpxchg.org>
References: <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org>
 <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org>
 <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org>
 <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:44:45AM -0700, Yosry Ahmed wrote:
> On Fri, Aug 18, 2023 at 11:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > > On Fri, Aug 18, 2023 at 10:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > > If this happens it seems possible for this to happen:
> > > > >
> > > > > cpu #1                                  cpu#2
> > > > >                                              css_put()
> > > > >                                              /* css_free_rwork_fn is queued */
> > > > > rcu_read_lock()
> > > > > mem_cgroup_from_id()
> > > > >                                              mem_cgroup_id_remove()
> > > > > /* access memcg */
> > > >
> > > > I don't quite see how that'd possible. IDR uses rcu_assign_pointer()
> > > > during deletion, which inserts the necessary barriering. My
> > > > understanding is that this should always be safe:
> > > >
> > > >   rcu_read_lock()                 (writer serialization, in this case ref count == 0)
> > > >   foo = idr_find(x)               idr_remove(x)
> > > >   if (foo)                        kfree_rcu(foo)
> > > >     LOAD(foo->bar)
> > > >   rcu_read_unlock()
> > >
> > > How does a barrier inside IDR removal protect against the memcg being
> > > freed here though?
> > >
> > > If css_put() is executed out-of-order before mem_cgroup_id_remove(),
> > > the memcg can be freed even before mem_cgroup_id_remove() is called,
> > > right?
> >
> > css_put() can start earlier, but it's not allowed to reorder the rcu
> > callback that frees past the rcu_assign_pointer() in idr_remove().
> >
> > This is what RCU and its access primitives guarantees. It ensures that
> > after "unpublishing" the pointer, all concurrent RCU-protected
> > accesses to the object have finished, and the memory can be freed.
> 
> I am not sure I understand, this is the scenario I mean:
> 
> cpu#1                      cpu#2                             cpu#3
> css_put()
> /* schedule free */
>                                 rcu_read_lock()
> idr_remove()
>                                mem_cgroup_from_id()
> 
> /* free memcg */
>                                /* use memcg */

idr_remove() cannot be re-ordered after scheduling the free. Think
about it, this is the common rcu-freeing pattern:

	rcu_assign_pointer(p, NULL);
	call_rcu(rh, free_pointee);

on the write side, and:

	rcu_read_lock();
	pointee = rcu_dereference(p);
	if (pointee)
		do_stuff(pointee);
	rcu_read_unlock();

on the read side.

In our case, the rcu_assign_pointer() is in idr_remove(). And the
rcu_dereference() is in mem_cgroup_from_id() -> idr_find() ->
radix_tree_lookup() -> radix_tree_descend().

So if we find the memcg in the idr under rcu lock, the cgroup rcu work
is guaranteed to not run until the lock is dropped. If we don't find
it, it may or may not have already run.
