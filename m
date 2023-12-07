Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D2807FD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 05:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjLGEw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 23:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjLGEwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 23:52:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1D10C0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 20:52:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c77e0832cso633565a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 20:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701924745; x=1702529545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+W1jLERIf0/mZcB/EwuwKYXs+J1GUC7lw1ozHshVhi8=;
        b=LmmyYr5FfhKtpMih88oqNC7r4uk1FsJuf40yQpeDkpL5BqCQMh+x+R13Y+I2OUadbU
         2fXh2iHSDMJrveSJtiknK74OX/5uzGyYU1fvu4pQbVysrkIKdmX+Bxw1qbgTQEIBQgU0
         OnYIb7F6dgbBnhNvSTMMjRTRrv8bsnLWSxTh0/Od1AMHynHbQtTo1RBjrxgc9+pczAmR
         MHySSdGG6OjvoOUwiVKGrQlCydV+YgoOX5sM9LiBuL6izR1G+bNi9E9d6UYXR56pN1/g
         POESlfc6bd5LVoeRKxNEYdtHJdwPQnWQodiGIypHVq9t25zDKxEWrh/B0/Go0ZWBxOgP
         kmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701924745; x=1702529545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+W1jLERIf0/mZcB/EwuwKYXs+J1GUC7lw1ozHshVhi8=;
        b=kZyA0UC9zugBqKrAUG1toShw1pltzlgNXrfocdWsgJWKc4pb/okyHg6Ql97OTqpy47
         cuosMk/l2qCMg8QhTBYaeT6m5zNoxv2rkYpy50Ys73pYWZH0QP5F57pxc2OZmWyHMjt+
         pURG3ehXj/HeEfFOZVGI1ULGecB3HlbB4LrLMNSInn/sGjNJEkKr6vflgPV/UYXWroDI
         uCjNfY7dea+rUB3CrQFbUDXSlKn8PjRnqKV14whhZvGEUOYku8UrvXjrRbbHvzjPp+0E
         QubYhVNLBkq6BKX0Sc+Av6JSrG0uOvnbnBadgU5DheUptwPi35ML3kl77cyaYGu2ILjJ
         HFeg==
X-Gm-Message-State: AOJu0YyTjeDCnGJDYuXTyFwkqN39UXC45RQKZ9G2DkkwtQ0Zfc5laEX8
        fu/0UaWA1sEKXWWXVhdhN4XmgR5q+pUK56p8E8dVkw==
X-Google-Smtp-Source: AGHT+IEcq53OQy6kNgV3fdJ1HSf9E4kSUOmMcn5pXK0gqIExUqSsAN2/a27fT4ucmtcYxNfnFnFYH8BU2l9MNoGZbOs=
X-Received: by 2002:a17:906:ca50:b0:a02:ad84:3ab3 with SMTP id
 jx16-20020a170906ca5000b00a02ad843ab3mr1044738ejb.44.1701924745165; Wed, 06
 Dec 2023 20:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20231207043753.876437-1-longman@redhat.com>
In-Reply-To: <20231207043753.876437-1-longman@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 6 Dec 2023 20:51:46 -0800
Message-ID: <CAJD7tkZtt8xedBJyRns+6HpdXoBxadLUGuGNG5s1trEbRgb9hA@mail.gmail.com>
Subject: Re: [PATCH-cgroup] cgroup: Move rcu_head up near the top of cgroup_root
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 8:38=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
>
> The use of kvfree_rcu(), however, has the limitation that the offset of
> the rcu_head structure within the larger data structure cannot exceed
> 4096 or the compilation will fail. By putting rcu_head below the cgroup
> structure, any change to the cgroup structure that makes it larger has
> the risk of build failure. Commit 77070eeb8821 ("cgroup: Avoid false
> cacheline sharing of read mostly rstat_cpu") happens to be the commit
> that breaks it even though it is not its fault. Fix it by moving the
> rcu_head structure up before the cgroup structure.
>
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU=
 safe")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/cgroup-defs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 5a97ea95b564..45359969d8cf 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -562,6 +562,10 @@ struct cgroup_root {
>         /* Unique id for this hierarchy. */
>         int hierarchy_id;
>
> +       /* A list running through the active hierarchies */
> +       struct list_head root_list;
> +       struct rcu_head rcu;
> +

Perhaps the comment should mention the placement requirements, and
maybe a pointer to wherever it is specified that the offset of struct
rcu_head should not exceed 4096?
