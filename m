Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33F77EEF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjHQCH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjHQCHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:07:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715E1FD0;
        Wed, 16 Aug 2023 19:07:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b962535808so109687771fa.0;
        Wed, 16 Aug 2023 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692238042; x=1692842842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FC4zpF/OT6YA+2CRoUOjQ7kJNEGnjM2sXNFacPRsJjo=;
        b=RjDAp0jjwaeqwaS0ynQwfGNgpDZ4cpHxok4189aXBo2FNtLvkGDMNwUhoFbyaX0dhF
         k520Gcwq1gCWh12TzTkDC1GtrczUDrkdKdPsC0HGzsFDFTbZqzKTZJtis8CfoYuJ0y8+
         7leVCV1IX8wrVQkJsbOpkj9HjE7gmSI26mLYDaQ4/0bR/NjxX9ISHcFcBX9X0wf0Q7o4
         Kw+5RGlnc5FgXpt08Ia+L6jG+q/ZaskC13h85NFErG0S+mg3KZJ1gbwLZeLv2PWI2uLh
         usAotWV2FRLxHoRhn5JMyi5Zh7gtnILj/NEcGw5m6pvyMOvm0Oa1bfZBldSjoYo6Iryi
         rJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692238042; x=1692842842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FC4zpF/OT6YA+2CRoUOjQ7kJNEGnjM2sXNFacPRsJjo=;
        b=Vx1duBABoIiQtp+hb0csRgcdyYEKtHLGblGmnpQsLKgbubKA+qbohegX/7qE9Gr5IP
         pxkRKurS2XaE97xLEZbQ6WoejMP7rmkGdi28nQcsxKNtJWzivN6Am3y9z5S9g4TS7not
         cfMkRgW5m16pJxS4KZvblPEyIbkPYYq49VLYwCIRT6PmvZIpDBQY94ADeK3Qq/HDAucu
         YF92ZHWzRZ4Yp3hC42wt+2t2QTI5bwnRApIyt9iqlLZSeXn1wv/pkEeb7NrC8aUvPOL0
         axMwjxICnM83Y60WkgXcBs3oPgyU0VqZEUeYLmrhqN7ie6kQVPVpzFqRBfFrgpNlVdrY
         PDEw==
X-Gm-Message-State: AOJu0YyS4SusDC6ZQiN7Jh/VTo+OmCZF0ar64LdGjI+FTu8YSywtFDXs
        zdqG6guMVjS93aVLqI8pYNLjAiKiFoLdz7e0M1A=
X-Google-Smtp-Source: AGHT+IGW5RhuFYtHcZkxTxlq/sRXrRrlPib3VJn6Oxqk9mxkuGyxY6lpDkIka01jVQffH+IxGkIVUUsZ2stZ8oXf+Kk=
X-Received: by 2002:a2e:b78e:0:b0:2b5:89a6:c12b with SMTP id
 n14-20020a2eb78e000000b002b589a6c12bmr2799704ljo.10.1692238041905; Wed, 16
 Aug 2023 19:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230810081319.65668-1-zhouchuyi@bytedance.com> <20230810081319.65668-2-zhouchuyi@bytedance.com>
In-Reply-To: <20230810081319.65668-2-zhouchuyi@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Aug 2023 19:07:10 -0700
Message-ID: <CAADnVQK=7NWbRtJyRJAqy5JwZHRB7s7hCNeGqixjLa4vB609XQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, muchun.song@linux.dev,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 1:13=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>  static int oom_evaluate_task(struct task_struct *task, void *arg)
>  {
>         struct oom_control *oc =3D arg;
> @@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *tas=
k, void *arg)
>         if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
>                 goto next;
>
> +       /*
> +        * If task is allocating a lot of memory and has been marked to b=
e
> +        * killed first if it triggers an oom, then select it.
> +        */
> +       if (oom_task_origin(task)) {
> +               points =3D LONG_MAX;
> +               goto select;
> +       }
> +
> +       switch (bpf_oom_evaluate_task(task, oc)) {
> +       case BPF_EVAL_ABORT:
> +               goto abort; /* abort search process */
> +       case BPF_EVAL_NEXT:
> +               goto next; /* ignore the task */
> +       case BPF_EVAL_SELECT:
> +               goto select; /* select the task */
> +       default:
> +               break; /* No BPF policy */
> +       }
> +

I think forcing bpf prog to look at every task is going to be limiting
long term.
It's more flexible to invoke bpf prog from out_of_memory()
and if it doesn't choose a task then fallback to select_bad_process().
I believe that's what Roman was proposing.
bpf can choose to iterate memcg or it might have some side knowledge
that there are processes that can be set as oc->chosen right away,
so it can skip the iteration.
