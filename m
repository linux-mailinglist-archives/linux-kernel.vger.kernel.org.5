Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6E68082DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378215AbjLGIWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:22:17 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD1121;
        Thu,  7 Dec 2023 00:22:23 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a338dfca7so3919296d6.2;
        Thu, 07 Dec 2023 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701937342; x=1702542142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egv6dYd8ESPNnSbaz+0Kszznpa5K+OI/xeewlObj9YM=;
        b=AKchBofsXZ2u8xbnnDlij3wORpGQA4iMQHmru4SlzB6sew+25aYkqfNcHxnz0Iwv8M
         SdHbHnWiuiXEiCW4nimf0fn/llUseBWNuwBwiFZJtATuUEq6/WbwI9ydktN5FN76T61Z
         7RUERAfky8f76Xsk/pTUF69qtTeS3KntTkufzEPJjP4q8Lzzyw/Kxx8jrZqT9szhjv7T
         xNoTQuMLeMEutJuQFyQP2syU+jbOb5VRrajI962V1CdEiyW8oIOJN6hlL4w5F8rvqs59
         GgElBe3U3uME/NzO5ePp9aSMeJw1xfkL/fs4OK3n/loeAvHNB5r40XCmsJ1MACotbqJL
         BbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937342; x=1702542142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egv6dYd8ESPNnSbaz+0Kszznpa5K+OI/xeewlObj9YM=;
        b=wVTsR93FWtNcldaqn/C0/sgaKrnzOiw16L8Tb9r7fjDFxKTVAWBdBrDpdv6/4bq2r5
         V0mJnJIHxlhGrcT/uJHX06ulk59B0qtNhOqEUOERIij+r4UPo+u4opmzABlbnvVhx2GR
         JhL8PgR91a1+woIc3fM7QqDfuCJIGwPylgUPLLFHbiYG1nZK51tG+xYdVHWWA4gmqovy
         L0PMxND3e0OejFq3zG9Lc65ReIZBOzXKmu+XZDEEfqVmfzV0NPs6Wh6HHzwNMfofu9hQ
         gzSZvcDRZ6tohJfhVHPZpjtynuJ24sk0rq1wY6Y6rslG8VHvf2lrRsson9Xa4jh2iO2B
         rJJA==
X-Gm-Message-State: AOJu0YyJEFiV9lfS60NZn0aOSlZV8Qx+rIt5q6QYAhERmH2GdTP9oo92
        eDZ6LRcQUNNjGKlQkjB3rQoxcxTRuYhFctwaBqQ=
X-Google-Smtp-Source: AGHT+IGb78uQtvQjOtkF5UieuAgn8fipBbuzXR6STd1V7pkRouaiMB4eNwuv9naPB4lCKqfx5wxl4pb6GfuadpgKBvA=
X-Received: by 2002:a05:6214:43c2:b0:67a:b72c:3ab5 with SMTP id
 oi2-20020a05621443c200b0067ab72c3ab5mr2965357qvb.62.1701937342424; Thu, 07
 Dec 2023 00:22:22 -0800 (PST)
MIME-Version: 1.0
References: <20231207043753.876437-1-longman@redhat.com>
In-Reply-To: <20231207043753.876437-1-longman@redhat.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 7 Dec 2023 16:21:46 +0800
Message-ID: <CALOAHbBrj5CTOeYwHJ4q_f092z+1BNAo9kHFfRbRFTCF=_hQfA@mail.gmail.com>
Subject: Re: [PATCH-cgroup] cgroup: Move rcu_head up near the top of cgroup_root
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 12:38=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>

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
>         /*
>          * The root cgroup. The containing cgroup_root will be destroyed =
on its
>          * release. cgrp->ancestors[0] will be used overflowing into the
> @@ -575,10 +579,6 @@ struct cgroup_root {
>         /* Number of cgroups in the hierarchy, used only for /proc/cgroup=
s */
>         atomic_t nr_cgrps;
>
> -       /* A list running through the active hierarchies */
> -       struct list_head root_list;
> -       struct rcu_head rcu;
> -
>         /* Hierarchy-specific flags */
>         unsigned int flags;
>
> --
> 2.39.3
>


--=20
Regards
Yafang
