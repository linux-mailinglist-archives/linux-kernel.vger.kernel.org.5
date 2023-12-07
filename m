Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E04808F1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443579AbjLGRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443447AbjLGRx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:53:26 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C410CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:53:32 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca0f21e48cso13953821fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701971611; x=1702576411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej8XOnCH2VsZ/qShm6gnD6DULhgsDhDu14Fz2jUUZmE=;
        b=ZPgQg+itvxzN5Vw5a/c662emHmOeBkmMXS1vW3e6UWjkrUKmHz1p8BtKukTJsUp+w3
         LNL+xUafOLP9JcDbxxbIwiVA+rYrtBNRPq2PjZQoDw5q45u2aa2f1e1XdI2O0FtzZr+w
         o9Htppcy1HzHCPs1x2+nsOzi6/p5fo3qJvgs6symtiueJ0qIFEoKgiOGScYmJqVjOI3h
         TVDEFDxv2Npm66IHUs/wAgkuizAEulmOQh8W+1YP0oDjuVKTWcCZiR6Nve9i+n5JN17p
         CVLlCn29aWm/5MtbD0H7gYpCk2we/FIjdEQtYP6e93fJ5QJupdZr9ieLs9MOCxklvajU
         8rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971611; x=1702576411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej8XOnCH2VsZ/qShm6gnD6DULhgsDhDu14Fz2jUUZmE=;
        b=BiHXfJOsg1DcKpxqa5lDBpE8n8K6kqpGLDC5kZZWTFP3t8FnIpjoPMerRo6yOc6a/p
         SP1Pge7gn37quSFyOo6YCtQFA567gWz+Pi2KD17FkhWVE8lRXW9unRF/BYIPW6ypBRue
         r8tCONmlM/5zcMiT+4MrFUA6TtZjlU3b1e4WCsm0E0lEM2ZU048XSFrgFGo1hUwQVbTc
         ode0vWNcKKvyrg4tB5DSQ4fvCZ3Gn8/n4izQ5lPFHzeTzXs31LMBLj9wE9aV2PyQmZ/i
         UKoQ1IHUKkeBnVxw/NxK5oToGQ809+q+BcSQv8JRkMhr6SniP5gY4qq0A2t0TWj4G+Ni
         xO3g==
X-Gm-Message-State: AOJu0YwgXrg7VO4EDnDXSOGV/MaeR+mLoXjgWriblp1oYQ7uCl5PYCKQ
        qQ164cBwGb1WUjvgIFq7tWl1hCXvsGRLC0JzH6s5x8faLMxCSSOqaA4=
X-Google-Smtp-Source: AGHT+IFSp7ZQgdeytewdjCrCAk/6O+2n4Z6XadRtIMNXGzlOiWvtudw1L7uZcT8Tl9dY9nr57EQaBQT3y1WABj45CSI=
X-Received: by 2002:a2e:98d7:0:b0:2ca:286:4b1c with SMTP id
 s23-20020a2e98d7000000b002ca02864b1cmr1948479ljj.91.1701971610472; Thu, 07
 Dec 2023 09:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20231207134614.882991-1-longman@redhat.com>
In-Reply-To: <20231207134614.882991-1-longman@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Dec 2023 09:52:54 -0800
Message-ID: <CAJD7tka2op5wfRKawumoGrScVRA3qD0c2N-WshcmMbPzFBe0wQ@mail.gmail.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of cgroup_root
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 5:46=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
>
> The current implementation of kvfree_rcu(), however, has the limitation
> that the offset of the rcu_head structure within the larger data
> structure must be less than 4096 or the compilation will fail. See the
> macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
> for more information.
>
> By putting rcu_head below the large cgroup structure, any change to the
> cgroup structure that makes it larger run the risk of causing build
> failure under certain configurations. Commit 77070eeb8821 ("cgroup:
> Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
> the last straw that breaks it. Fix this problem by moving the rcu_head
> structure up before the cgroup structure.
>
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU=
 safe")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.or=
g.au/
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

 Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
