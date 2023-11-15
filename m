Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1817E2DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjKFUIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjKFUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:08:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D09D45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:08:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-543923af573so8421047a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699301286; x=1699906086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Ycq6QceCfDIGqp40OHeAUWRg3JtEhQcvVgFOP1Ygw=;
        b=SvbvWSwPzec733l8eG9hUxfEJnsN6JQQSZrWJCYlcpLW82FcJIc3CvHAT6nIMiyENu
         t6I5EKI7beLOZamWvnGl2ziaC/F0j+rMq4WX6FHPPUP+wTurPe1xWDhGWU9DAii+XdSX
         xuav4iZG9vWonAB3mokqXGXnqXgcyp66/pugcOpWM18YV0FPTbn489BpXLM85PJN9VjR
         tgtfOv1D3m2BYDgM1LpNv52iiZHx9arp0TAeBAiiIQx0J/+6LH+u6y+eAA6/HKAb4r5F
         er98Nf+G+zf5X1z/pYA8UhDwAvuZnTyQ3GZx3+2BoyWXG/pQBjPsGThgoSfEda/rTVwp
         YuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699301286; x=1699906086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09Ycq6QceCfDIGqp40OHeAUWRg3JtEhQcvVgFOP1Ygw=;
        b=WJzW0eZm2Hx0e9XV6B/vElmctzuZ40lOLpdopLJOUURJP6pgbbu/vHkI2Bsvv+olqz
         +4NvLB6dd4EIWh8mZZnxssImbc+aWQCUC27pKqRuKQUaHDMDMtEIfRrDuKpVlbx9ELj2
         szdfS1rcqr++0iSrDqVeaOn4jrByrWCo/ErrrCdZR4jeKBGhW/gerenJENyjb41o9Z8b
         SsY7qd1n73jQ3p0X5zjdS1q3T6HaNnYWlGevOVjtrsoV3QokvpNv3CJMHB2NejzffCwO
         liefjkgRLcl+YqvUYfqSPcIKTte1uiniwbWzd42hh+CWmB9kusDp7VV5Nyqe++tc3ANU
         yrPA==
X-Gm-Message-State: AOJu0Yw1wf19ShwLhcjx0fHzT3a6wDFvybBP92QSfWn0PO5LtW6daVnk
        +HV2xhVn5cEeQEzZFa89HXvF0rJg3ynMCJqzTV3b1g==
X-Google-Smtp-Source: AGHT+IFexG6Clo60Zn1DpTyGm9x80WuahtrZB3M10KOYvZroB4rjoIZncJjLNNDSmxdjjUmC0/ySdT6ZIb7KJLM1fc4=
X-Received: by 2002:a17:907:6016:b0:9df:3463:8ae with SMTP id
 fs22-20020a170907601600b009df346308aemr3740013ejc.40.1699301285900; Mon, 06
 Nov 2023 12:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20231104031303.592879-1-longman@redhat.com> <20231104031303.592879-3-longman@redhat.com>
In-Reply-To: <20231104031303.592879-3-longman@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Nov 2023 12:07:26 -0800
Message-ID: <CAJD7tkZirDce=Zq9bm_b_R=yXkj1OaqCe2ObRXzV-BtDc3X9VQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 8:13=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
> the updated tree in a way to pop out the leaf nodes first before
> their parents. This can cause traversal of multiple nodes before a
> leaf node can be found and popped out. IOW, a given node in the tree
> can be visited multiple times before the whole operation is done. So
> it is not very efficient and the code can be hard to read.
>
> With the introduction of cgroup_rstat_updated_list() to build a list
> of cgroups to be flushed first before any flushing operation is being
> done, we can optimize the way the updated tree nodes are being popped
> by pushing the parents first to the tail end of the list before their
> children. In this way, most updated tree nodes will be visited only
> once with the exception of the subtree root as we still need to go
> back to its parent and popped it out of its updated_children list.
> This also makes the code easier to read.
>
> A parallel kernel build on a 2-socket x86-64 server is used as the
> benchmarking tool for measuring the lock hold time. Below were the lock
> hold time frequency distribution before and after the patch:
>
>      Hold time        Before patch       After patch
>      ---------        ------------       -----------
>        0-01 us        13,738,708         14,594,545
>       01-05 us         1,177,194            439,926
>       05-10 us             4,984              5,960
>       10-15 us             3,562              3,543
>       15-20 us             1,314              1,397
>       20-25 us                18                 25
>       25-30 us                12                 12
>
> It can be seen that the patch pushes the lock hold time towards the
> lower end.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

I don't know why git decided to show this diff in the most confusing
way possible.

>  kernel/cgroup/rstat.c | 132 ++++++++++++++++++++++--------------------
>  1 file changed, 70 insertions(+), 62 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 1f300bf4dc40..d2b709cfeb2a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -74,64 +74,90 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *=
cgrp, int cpu)
>  }
>
>  /**
> - * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu update=
d tree
> - * @pos: current position
> - * @root: root of the tree to traversal
> + * cgroup_rstat_push_children - push children cgroups into the given lis=
t
> + * @head: current head of the list (=3D parent cgroup)
> + * @prstatc: cgroup_rstat_cpu of the parent cgroup
>   * @cpu: target cpu
> + * Return: A new singly linked list of cgroups to be flush
>   *
> - * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos star=
ts
> - * the traversal and %NULL return indicates the end.  During traversal,
> - * each returned cgroup is unlinked from the tree.  Must be called with =
the
> - * matching cgroup_rstat_cpu_lock held.
> + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
> + * parent first before its children. The parent is pushed by the caller.

I think it might be useful here (and elsewhere in the patch) where
"push" is being used to elaborate that we push to the beginning in a
stack-like fashion.

> + * The recursion depth is the depth of the current updated tree.
> + */
> +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
> +                               struct cgroup_rstat_cpu *prstatc, int cpu=
)
> +{
> +       struct cgroup *child, *parent;
> +       struct cgroup_rstat_cpu *crstatc;
> +
> +       parent =3D head;
> +       child =3D prstatc->updated_children;
> +       prstatc->updated_children =3D parent;
> +
> +       /* updated_next is parent cgroup terminated */
> +       while (child !=3D parent) {
> +               child->rstat_flush_next =3D head;
> +               head =3D child;
> +               crstatc =3D cgroup_rstat_cpu(child, cpu);
> +               if (crstatc->updated_children !=3D parent)

I think cgroup->updated_children is set to the cgroup itself if it's
empty, right? Shouldn't this be crstatc->updated_children !=3D child?

> +                       head =3D cgroup_rstat_push_children(head, crstatc=
, cpu);
> +               child =3D crstatc->updated_next;
> +               crstatc->updated_next =3D NULL;
> +       }
> +       return head;
> +}
> +
> +/**
> + * cgroup_rstat_updated_list - return a list of updated cgroups to be fl=
ushed
> + * @root: root of the cgroup subtree to traverse
> + * @cpu: target cpu
> + * Return: A singly linked list of cgroups to be flushed
> + *
> + * Walks the updated rstat_cpu tree on @cpu from @root.  During traversa=
l,
> + * each returned cgroup is unlinked from the updated tree.  Must be call=
ed
> + * with the matching cgroup_rstat_cpu_lock held.

This function takes care of holding the lock actually. I think that
sentence should be applied to cgroup_rstat_push_children() above?

>   *
>   * The only ordering guarantee is that, for a parent and a child pair
> - * covered by a given traversal, if a child is visited, its parent is
> - * guaranteed to be visited afterwards.
> + * covered by a given traversal, the child is before its parent in
> + * the list.
> + *
> + * Note that updated_children is self terminated while updated_next is
> + * parent cgroup terminated except the cgroup root which can be self
> + * terminated.

IIUC updated_children and updated_next is the same list.
updated_children is the head, and updated_next is how the list items
are linked. This comment makes it seem like they are two different
lists.

I am actually wondering if it's worth using the singly linked list
here. We are saving 8 bytes percpu, but the semantics are fairly
confusing. Wouldn't this be easier to reason about if you just use
list_head?

updated_children would be replaced with LIST_HEAD (or similar), and
the list would be NULL terminated instead of terminated by self/parent
cgroup. IIUC the reason it's not NULL-terminated now is because we use
cgroup->updated_next to check quickly if a cgroup is on the list or
not. If we use list_heads, we can just use list_emtpy() IIUC.

We can also simplify the semantics of unlinking @root from the updated
tree below, it would just be list_del() IIUC, which is actually more
performant as well. It seems like overall we would simplify a lot of
things. When forming the updated_list, we can just walk the tree and
splice the lists in the correct order.

It seems to me that saving 8 bytes percpu is not worth the complexity
of the custom list semantics here. Am I missing something here?
