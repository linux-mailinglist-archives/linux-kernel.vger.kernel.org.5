Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F97EE52E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjKPQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:30:08 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B6E189
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:30:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so71565e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700152203; x=1700757003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F38ipVUNvi48KLUDF7UtMFc73Zu13fPzsb7BsE5kJSc=;
        b=e//oMVnhugdxZVRTiLqPYA3eLopxTxbjUr9MetKr0aqj4vesYAxgpODZf5PWm/2gtl
         eb0ZN1YTDM1/2/DnwYayPSn+qiLJTSAB+JYEGBy5IZ67940Ohb+lG1bkusSs+SzUi826
         jbZFxK/atYbzkLP4yAsHUUJB1fBoLIyxYD4urkUbZt8X4my6ZE72b9qCQEqwVZUhe+h7
         Afx0zlQcAoWwvHpcvXtIOld/nuEJySji/8oUBE3k5mpEWfymBT3eIByofGgddzXJ/xz8
         Nd9MGpP4p5T+0cbwXQ/DPIslB1obr7TeRd9ehk+g062m9jVlwUfWe79u6i9CIpp4EZt5
         jNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700152203; x=1700757003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F38ipVUNvi48KLUDF7UtMFc73Zu13fPzsb7BsE5kJSc=;
        b=Fq6C6HgozfiE6Pg6FDngVUbdAR3fRm1RfZS+n/dOeB6c76dbnTiOmm79yXJasf3fkY
         WWOLaNqMi//xBDT4jzniX2MXam2231fIp7pEDhRouwNSh+pP9ndNzNtQqv40izc79nj9
         YnBbDpXdW4aHT5/dKXVunzFgh7tQL9eoR5Y0oR8Zj26E45PilSQ9Xpl4gJLGOaIQHJTs
         Me57vWaykvDpl/IEIErL7LX6xOjNEGuLr6zvH1gzVNpewKx+HxQg4uuApCvqnm09R+xU
         W+1eJFqsOtHJPTK339D9vhT/vzgiS9D6xE5nDlxwvHfmwa3xxWOzl222Eakw3mAcKUwb
         eqaw==
X-Gm-Message-State: AOJu0YyAh29+mrhSUGPBRENgcVT4nGjo/JfPxRxZM2/RXEusf6XxMwy5
        XPtZU+1MwI+7Joj/u5wLx+kMSQHTmudgyjEgTt72nA==
X-Google-Smtp-Source: AGHT+IHTSAO3ZZWQEDfwlIxcr2RQHkWHxU1lY0UMFAqrwEicgTwTY4mkmAJXdjESEXa6UsOxY2NYQCZ4aKF8v3hJKeM=
X-Received: by 2002:a05:600c:3f8b:b0:3f4:fb7:48d4 with SMTP id
 fs11-20020a05600c3f8b00b003f40fb748d4mr142802wmb.3.1700152203066; Thu, 16 Nov
 2023 08:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org>
In-Reply-To: <20231115162054.2896748-1-timvp@chromium.org>
From:   Mark Hasemeyer <markhas@google.com>
Date:   Thu, 16 Nov 2023 09:29:51 -0700
Message-ID: <CAP0ea-s2QwQhKpu81b+n5Fcq7dscbwTxoFf2tpV926RXw3ca1g@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To:     Tim Van Patten <timvp@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

>
> From: Tim Van Patten <timvp@google.com>
>
> __thaw_task() was recently updated to warn if the task being thawed was
> part of a freezer cgroup that is still currently freezing:
>
>         void __thaw_task(struct task_struct *p)
>         {
>         ...
>                 if (WARN_ON_ONCE(freezing(p)))
>                         goto unlock;
>
> This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
> asserted, the CGROUP_FREEZING bits are not also cleared at the same
> time. Meaning, when a cgroup is marked FROZEN it continues to be marked
> FREEZING as well. This causes the WARNING to trigger, because
> cgroup_freezing() thinks the cgroup is still freezing.
>
> There are two ways to fix this:
>
> 1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
> children cgroups.
> 2. Update cgroup_freezing() to also verify that FROZEN is not set.
>
> This patch implements option (2), since it's smaller and more
> straightforward.
>
> Signed-off-by: Tim Van Patten <timvp@google.com>
> ---
>
>  kernel/cgroup/legacy_freezer.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
> index 122dacb3a443..66d1708042a7 100644
> --- a/kernel/cgroup/legacy_freezer.c
> +++ b/kernel/cgroup/legacy_freezer.c
> @@ -66,9 +66,15 @@ static struct freezer *parent_freezer(struct freezer *freezer)
>  bool cgroup_freezing(struct task_struct *task)
>  {
>         bool ret;
> +       unsigned int state;
>
>         rcu_read_lock();
> -       ret = task_freezer(task)->state & CGROUP_FREEZING;
> +       /* Check if the cgroup is still FREEZING, but not FROZEN. The extra
> +        * !FROZEN check is required, because the FREEZING bit is not cleared
> +        * when the state FROZEN is reached.
> +        */
> +       state = task_freezer(task)->state;
> +       ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
>         rcu_read_unlock();
>
>         return ret;
> --
Tested-by: Mark Hasemeyer <markhas@chromium.org>
