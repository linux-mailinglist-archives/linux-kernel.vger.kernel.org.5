Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99187812EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379458AbjHRSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359123AbjHRSfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:35:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7B3C3F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:35:41 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6424c61c80eso5784606d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692383740; x=1692988540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oz06k/Wemi6J/ldyB6c9tZm1247DSyEcuvZiFNgbP/o=;
        b=DtsMQQNk4Bw3nnmKshQ+7c4Rh2kpkW0GfXbaMoNvPPCBSotCAKqyKPqUpE7cnqxQDg
         3NVgdQWv50gPB+xZd95+0eKBdY/vozuftwC8s7uE4FW8nb5nIjP2X9OQ749EhQ4ZI9FN
         NIJnAzSOhJDd5OAuAAu6GF85ydfquuGL4aReaWtesi88GnMSRQxlDOBlhfSCpVTL3/jl
         xsMqtR+H10NCVwftvFu8Xtm0Rd/Y7TOZ9ozwxiiqbPuqEKx4TcTwjwQFDmpTbykwjI+8
         H7qYx8Rob30SfV3A+Xm4ONoW3BneudCzjgkK9VYwDGry+J30qPVuPQ/bNAmmAGSswHLE
         rUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692383740; x=1692988540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz06k/Wemi6J/ldyB6c9tZm1247DSyEcuvZiFNgbP/o=;
        b=AxIZcQNzhR265mLkIv5jfu8zpgsYJLYcHOI8nvh1ZKLrG1pTUawoESO6yojcLq9+CU
         8zfXMs1+MEZp8cEtd8STv8//IhFFfa4BupUA/hFLFRL3bdrfvT2ZThv7FUGveb04de9J
         EXKXXUqmpKIn0uKG6Q9gWFGfhZW/zQeEs4NPqKJeEU3eFN4JIVAda3gEGwCKIGs6AjL3
         IQBzuElHLkmHIgmgt5IaO6u/3BVsImVZFAKb3sIb2p0DAaKOeB+/jIjQY/umiVTZMZEq
         ubZD9mW73PO4WVVzIT/5FfxxArsumj12Y25V07fgIjfNxS56/iXfEN8cSbVVHOWcBv7H
         IEnA==
X-Gm-Message-State: AOJu0YwMHEZSMuLTawAEh3cuqax444QSrLzNNNmVZR3wMi+hcOR1l1Vq
        cmlYS2bNnaeq6pAX0TFzEg407g==
X-Google-Smtp-Source: AGHT+IF7YzSibPnzgxPoJYofHLjKfxo+upoXyv0TzXTpF3VWJPmLvlah9US/Du/r9oTY1p/0jpOSwQ==
X-Received: by 2002:a0c:cb0b:0:b0:64b:51d4:6696 with SMTP id o11-20020a0ccb0b000000b0064b51d46696mr28432qvk.5.1692383740251;
        Fri, 18 Aug 2023 11:35:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:75e0])
        by smtp.gmail.com with ESMTPSA id o6-20020a0ccb06000000b0063d252a141dsm853148qvk.116.2023.08.18.11.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:35:39 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:35:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Yu Zhao <yuzhao@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <20230818183538.GA142974@cmpxchg.org>
References: <20230817164733.2475092-1-nphamcs@gmail.com>
 <20230817190126.3155299-1-nphamcs@gmail.com>
 <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
 <20230818134906.GA138967@cmpxchg.org>
 <CAJD7tkZY3kQPO2dn2NX0WODwwRifhH4R=pSZnFZYxh23Eszb-g@mail.gmail.com>
 <20230818173544.GA142196@cmpxchg.org>
 <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZ3i-NoqSi+BkCY7nR-2z==243F1FKrh42toQwsgv5eKQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:45:56AM -0700, Yosry Ahmed wrote:
> On Fri, Aug 18, 2023 at 10:35 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Fri, Aug 18, 2023 at 07:56:37AM -0700, Yosry Ahmed wrote:
> > > If this happens it seems possible for this to happen:
> > >
> > > cpu #1                                  cpu#2
> > >                                              css_put()
> > >                                              /* css_free_rwork_fn is queued */
> > > rcu_read_lock()
> > > mem_cgroup_from_id()
> > >                                              mem_cgroup_id_remove()
> > > /* access memcg */
> >
> > I don't quite see how that'd possible. IDR uses rcu_assign_pointer()
> > during deletion, which inserts the necessary barriering. My
> > understanding is that this should always be safe:
> >
> >   rcu_read_lock()                 (writer serialization, in this case ref count == 0)
> >   foo = idr_find(x)               idr_remove(x)
> >   if (foo)                        kfree_rcu(foo)
> >     LOAD(foo->bar)
> >   rcu_read_unlock()
> 
> How does a barrier inside IDR removal protect against the memcg being
> freed here though?
> 
> If css_put() is executed out-of-order before mem_cgroup_id_remove(),
> the memcg can be freed even before mem_cgroup_id_remove() is called,
> right?

css_put() can start earlier, but it's not allowed to reorder the rcu
callback that frees past the rcu_assign_pointer() in idr_remove().

This is what RCU and its access primitives guarantees. It ensures that
after "unpublishing" the pointer, all concurrent RCU-protected
accesses to the object have finished, and the memory can be freed.
