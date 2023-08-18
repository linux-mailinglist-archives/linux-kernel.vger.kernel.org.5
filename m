Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6478156F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbjHRWaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241621AbjHRW3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:29:43 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147104212
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:29:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so7870246d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692397780; x=1693002580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pipybyI4Zl/qm+a0HT858CPv8BhOzDnsExnqkOzO/gk=;
        b=YgxOJn4tDaIe+ZIwJmNbfCjJP5TjGukdN9kULy8C6IcFAsM9jMYXZGhBmc1dxEzIq8
         +FwDPvEMP4UHiXXjz0ghsz9AS+XMYT5ygAIkg7Qi7vS3WTUm1csMYEdh278hbAU5ogRd
         V3tKWIhZgoE5acXLGrSOsuIKkXX6n6q+r8uro/hfndX7Z7yoGVSeO+hQCfWOILpqwTOk
         gwuEAll4j3kqw3ai55IxnrBRWew4NM2+4aasrQexekIkklpYVb3C7fS6Jjuo3RfNheW+
         QWMFOLap7/Ltnd/lL0V5s/tG4ue96cdce4bQuWLZKPq4mfAfHC/DTi2TdlvEGNQC5y0B
         fhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692397780; x=1693002580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pipybyI4Zl/qm+a0HT858CPv8BhOzDnsExnqkOzO/gk=;
        b=b2ElJfJFsnGasvd47J/FyNZ25v2Q1ogInWAH4Mg/Pub7+SJ0wkuZ5vB436S5LUynL1
         d1McZCFMiPgm2Xo/v/IpiH8+tSgtmHi/5BHcV7mKMWFG+A+oYyDdDNcJ6B10wqMmrS53
         lkOu5/Hh04r2jX6FIFa3oboGnZ9jculxa0Xp9zy/6FTaySL5z4nLuU+KN6hvin9DBE3v
         dkXofDJoCuvBByFWqqfN/GEhWOFEf98v4UDpN2KrTs4CFToH8yOIp8r/EQvuuXGQ6eMe
         IQGngw2N8D3stber1pvD2vfJCGbeWjOZcaEeJf+lzCvLs3HZU9aHjMrhTeESb8ShZxzG
         rAwg==
X-Gm-Message-State: AOJu0YyRzrBiUVH7whY7YEAFN6mtCQEueG0Q6rbwuuZ0XGs0QlTAiKkR
        0+3vT0D3PlF+n9fTHXX3u5deRQ==
X-Google-Smtp-Source: AGHT+IGEoPlFBG46/AHW+D4TFUfO/XXeH18yydYqG3xx9oQZQ0v2qm4+SfT0BiR6232XwUKvBa9w0Q==
X-Received: by 2002:a0c:c991:0:b0:63d:70f6:8f6f with SMTP id b17-20020a0cc991000000b0063d70f68f6fmr631138qvk.43.1692397780218;
        Fri, 18 Aug 2023 15:29:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:75e0])
        by smtp.gmail.com with ESMTPSA id e16-20020a05620a12d000b00767ceac979asm821111qkl.42.2023.08.18.15.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 15:29:39 -0700 (PDT)
Date:   Fri, 18 Aug 2023 18:29:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <20230818222939.GB144640@cmpxchg.org>
References: <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org>
 <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org>
 <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
 <20230818183538.GA142974@cmpxchg.org>
 <CAJD7tkYjyqhjv7q-VCSPViFGqdYWGpsyftR6L=D_M8QuMsQQ5Q@mail.gmail.com>
 <20230818213502.nsur4qbs7t7nxg54@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230818213502.nsur4qbs7t7nxg54@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:35:02PM +0000, Shakeel Butt wrote:
> On Fri, Aug 18, 2023 at 11:44:45AM -0700, Yosry Ahmed wrote:
> > On Fri, Aug 18, 2023 at 11:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> > > > On Fri, Aug 18, 2023 at 10:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > > > > If this happens it seems possible for this to happen:
> > > > > >
> > > > > > cpu #1                                  cpu#2
> > > > > >                                              css_put()
> > > > > >                                              /* css_free_rwork_fn is queued */
> > > > > > rcu_read_lock()
> > > > > > mem_cgroup_from_id()
> > > > > >                                              mem_cgroup_id_remove()
> > > > > > /* access memcg */
> > > > >
> > > > > I don't quite see how that'd possible. IDR uses rcu_assign_pointer()
> > > > > during deletion, which inserts the necessary barriering. My
> > > > > understanding is that this should always be safe:
> > > > >
> > > > >   rcu_read_lock()                 (writer serialization, in this case ref count == 0)
> > > > >   foo = idr_find(x)               idr_remove(x)
> > > > >   if (foo)                        kfree_rcu(foo)
> > > > >     LOAD(foo->bar)
> > > > >   rcu_read_unlock()
> > > >
> > > > How does a barrier inside IDR removal protect against the memcg being
> > > > freed here though?
> > > >
> > > > If css_put() is executed out-of-order before mem_cgroup_id_remove(),
> > > > the memcg can be freed even before mem_cgroup_id_remove() is called,
> > > > right?
> > >
> > > css_put() can start earlier, but it's not allowed to reorder the rcu
> > > callback that frees past the rcu_assign_pointer() in idr_remove().
> > >
> > > This is what RCU and its access primitives guarantees. It ensures that
> > > after "unpublishing" the pointer, all concurrent RCU-protected
> > > accesses to the object have finished, and the memory can be freed.
> > 
> > I am not sure I understand, this is the scenario I mean:
> > 
> > cpu#1                      cpu#2                             cpu#3
> > css_put()
> > /* schedule free */
> >                                 rcu_read_lock()
> > idr_remove()
> >                                mem_cgroup_from_id()
> > 
> > /* free memcg */
> >                                /* use memcg */
> > 
> > If I understand correctly you are saying that the scheduled free
> > callback cannot run before idr_remove() due to the barrier in there,
> > but it can run after the rcu_read_lock() in cpu #2 because it was
> > scheduled before that RCU critical section started, right?
> 
> Isn't there a simpler explanation. The memcg whose id is stored in the
> shadow entry has been freed and there is an ongoing new memcg allocation
> which by chance has acquired the same id and has not yet initialized
> completely. More specifically the new memcg creation is between
> css_alloc() and init_and_link_css() and there is a refault for the
> shadow entry holding that id.

Good catch.

It's late on a Friday, but I'm thinking we can just move that
idr_replace() from css_alloc to first thing in css_online(). Make sure
the css is fully initialized before it's published.
