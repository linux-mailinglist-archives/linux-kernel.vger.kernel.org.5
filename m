Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CF88119B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjLMQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjLMQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:41:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F61F98;
        Wed, 13 Dec 2023 08:41:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5be30d543c4so4014821a12.2;
        Wed, 13 Dec 2023 08:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702485707; x=1703090507; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gr+U3ThNAiG15ak/Lw3/3fJKchrsxVjpre1fxBodeHk=;
        b=i5fNo+ZRR2bjx4Ux+fmAKRYYZYjY6ihAzf3O46GVHgCHMjl8I5YuNa0CzUfxwpstVK
         x6OWaFD8K8FUa0l6T4DEjQNt+R8ULgcLggNArT1fp1EIVTPx5p2wR2ISpiNIBkITQqPw
         IoXncIfo3zNax4jjaMWaeTJBcZRseOHkAdUqbGYeY+jx+joj8T++/czndYrSi0CPJfcL
         qGcUqmF52KKTqtu0lGcKDshlNolfyAm9zDDdFgPoysAG72ldkGfrnAt+fqBW5I3+v+R8
         WweJREcSLmZlsmoOm6xtDQSGvl6K8l1nyz3XkwOvMVXC3j0ph9qWu0h3rULn0w7P0EBm
         hs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702485707; x=1703090507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gr+U3ThNAiG15ak/Lw3/3fJKchrsxVjpre1fxBodeHk=;
        b=WeBAZIqm5iLMq/5aaCLUROiqINqQe5KltwmErd6dIsMN3GiIClHYgfxrO4FKI0TAyK
         Pwn2aVUgZRLPU3mLl8YY7L+x43WHkPHWF+tav5J350Rho8zjM/Df/9PkemQn/fwwl+qu
         9lJo6aJFmZM/MzUP5opzr2J7NlrwrOjb7Y9kpalbUb7tgY6n4PqP6ojhzPgywuHxT4oh
         YYgh9Pb7kfGNk/VDc4YVLM4xOPmKwgjGmzWkbFtZmxVh4WmQO1qBTcqQOT8hfocVFKhm
         uOMsPm6w8xHwuJBF7rTFRX13lp/gMKE4DhohRZMCTAtyFAEatoSIbMkq4nu2reoZ+yS/
         h0fA==
X-Gm-Message-State: AOJu0Yy0YdSKQJHEo5ZqoZIypnNFnrbIXBpoivb6qNcM/LdFKry2RPmK
        DP/H+AFDCXQUK+NdMUoLep0=
X-Google-Smtp-Source: AGHT+IEd/aXZEAYYeKeL+Fq0SwOq+XspHrL1Lt7AF+acnSZ5Z0izCV8j8aJOzdEXlyG9NrNmjmtL5w==
X-Received: by 2002:a05:6a21:7802:b0:191:e72c:24cf with SMTP id be2-20020a056a21780200b00191e72c24cfmr422281pzc.31.1702485706573;
        Wed, 13 Dec 2023 08:41:46 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c090:500::5:4500])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a0017a300b006d0bff2cc81sm2027359pfg.123.2023.12.13.08.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:41:44 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:41:41 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Huan Yang <11133793@vivo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chris Li <chrisl@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 1/2] mm: add defines for min/max swappiness
Message-ID: <ZXnexTxt3JE8mEMV@dschatzberg-fedora-PF3DHTBV>
References: <20231213013807.897742-1-schatzberg.dan@gmail.com>
 <20231213013807.897742-2-schatzberg.dan@gmail.com>
 <86984d9b-c955-4b06-9097-2a757b1bacfe@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86984d9b-c955-4b06-9097-2a757b1bacfe@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:58:26AM +0800, Huan Yang wrote:
> 
> 在 2023/12/13 9:38, Dan Schatzberg 写道:
> > [????????? schatzberg.dan@gmail.com ????????? https://aka.ms/LearnAboutSenderIdentification,????????????]
> > 
> > We use the constants 0 and 200 in a few places in the mm code when
> > referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
> > and MAX_SWAPPINESS #defines to improve clarity. There are no functional
> > changes.
> > 
> > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> > ---
> >   include/linux/swap.h |  2 ++
> >   mm/memcontrol.c      |  2 +-
> >   mm/vmscan.c          | 10 +++++-----
> >   3 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index f6dd6575b905..e2ab76c25b4a 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> > 
> >   #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
> >   #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> > +#define MIN_SWAPPINESS 0
> > +#define MAX_SWAPPINESS 200
> 
> Do MAX_SWAPPINESS apply for all swapppiness? If so, maybe better change
> swappiness sysctl define:
> ```
> sysctl.c:
> 
> {
>         .procname    = "swappiness",
>         .data        = &vm_swappiness,
>         .maxlen        = sizeof(vm_swappiness),
>         .mode        = 0644,
>         .proc_handler    = proc_dointvec_minmax,
>         .extra1        = SYSCTL_ZERO,
>         .extra2        = SYSCTL_TWO_HUNDRED,
>     },
> 
> ```
> 
> Here hard code swappiness in [0, 200], and now add a new define.

Yes, MAX_SWAPPINESS is a hard limit. I'm not sure what you're
proposing here - the SYSCTL_ZERO and SYSCTL_TWO_HUNDRED values are a
little different than the defines I added. I think most of the value
is just consistently using the defines in the core mm code.

> 
> And many other code hard reference 200 into max value of swappiness, like:
> 
> ```
> memcontrol.c:
> static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>                        struct cftype *cft, u64 val)
> {
>     struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> 
>     if (val > 200)
>         return -EINVAL;
> 
>     if (!mem_cgroup_is_root(memcg))
>         memcg->swappiness = val;
>     else
>         vm_swappiness = val;
> 
>     return 0;
> }

This one is already fixed in my patch.
