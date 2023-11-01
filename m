Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0617DE506
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjKARIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbjKARIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:08:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F67FD;
        Wed,  1 Nov 2023 10:08:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9d10f94f70bso2004366b.3;
        Wed, 01 Nov 2023 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698858526; x=1699463326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxqC4haUmO6O6zFKwa2JDemqA1Zr0ZXCW08zDQAdl+M=;
        b=YJ5cPBx7s/w1G3jpaDof0yohlE5FynVbV3+YjI+zgj0MXmKlMoAD+jkfqbaTAeOPNm
         9cyWveC/fAkIEgb1pkVzQ1b50m4Wt3COsnGbLNs4qxA7pQLNvcoFJx+tUs0QATiSBtYl
         jGw9SgJsSywkmYGss+fCiwRxX58woUCYQ4yyNXzxtURm4o9ppG/5GmRvJ0vK3O9RZ4ZM
         DJwM3uLypvp/LVUE+5FKCDWuBJt4KTdKHaQVrd99XEH/2c6pqHw5Dv4A0kBlwhUMSUhD
         h9TOkUA2vb9aDMeoNMqxEgv4LsGjAqASwUWIVYoXIPbDc/NteyDOiOCAc1XMMd5D/Wh0
         kaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698858526; x=1699463326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxqC4haUmO6O6zFKwa2JDemqA1Zr0ZXCW08zDQAdl+M=;
        b=pes6iMfFV7WDBKzkbQCfrMGdkDn0GV6iA56plmPu7o4OOZqHWg0u3DDv05PzhieodS
         PbZgwN4fLW0WmHsag/nWITHbyNwJugHukqhXnSgx2gCudulnHmsVrV7A47KwWCGQpNWf
         YfTSaaUNYTwKUHiAZ920YGhvvppCqTwGnowgU2qWjl6UQiDMe8nuthLxPvcCgQRc09xG
         NkAXaMxAHfgr/XppkICiIuqeRLmDQTBVrDc+bmF3ADuAcAy6vGKSb0BChfGRHKuVswvk
         Z0/0Mqu4pl5z6y2jJB45QRqjHiGkZAYgmpLz6xtFOux+eZxaZLUtqf5Iuojcx86jctKs
         TDHw==
X-Gm-Message-State: AOJu0YzACtJfTtig5jYbat5b4NkL+fimjBLUTI3ws+2f95yQKBv9GopP
        JviuOfUC52W+JhzeLk4G1bskY4fd3MCOa7Vy00A=
X-Google-Smtp-Source: AGHT+IHh/xoThtkS3jWPmHaVPIYaN0JAsAKsui3AVMwsCTMgS9HAdTpsiYFJj2naIUWjXdqCl0SM1zRBe0PN5df0Omk=
X-Received: by 2002:a17:906:dc93:b0:9c7:3611:9e7c with SMTP id
 cs19-20020a170906dc9300b009c736119e7cmr2502264ejc.61.1698858525799; Wed, 01
 Nov 2023 10:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231101102837.25205-1-ddrokosov@salutedevices.com> <20231101102837.25205-2-ddrokosov@salutedevices.com>
In-Reply-To: <20231101102837.25205-2-ddrokosov@salutedevices.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Nov 2023 10:08:34 -0700
Message-ID: <CAEf4BzZ0p-k15XLf2QdHNN6TodjRBtRKk2mvsttCj=GUi4Or3A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org,
        kernel@sberdevices.ru, rockosov@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 3:29=E2=80=AFAM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> Sometimes it is necessary to understand in which memcg tracepoint event
> occurred. The function cgroup_name() is a useful tool for this purpose.
> To integrate cgroup_name() into the existing memcg tracepoints, this
> patch introduces a new tracepoint template for the begin() and end()
> events, utilizing static __array() to store the cgroup name.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++------
>  mm/vmscan.c                   |  8 ++--
>  2 files changed, 69 insertions(+), 16 deletions(-)
>
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.=
h
> index d2123dd960d5..124bc22866c8 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -141,19 +141,47 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_templat=
e, mm_vmscan_direct_reclaim_b
>  );
>
>  #ifdef CONFIG_MEMCG
> -DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_re=
claim_begin,
>
> -       TP_PROTO(int order, gfp_t gfp_flags),
> +DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
>
> -       TP_ARGS(order, gfp_flags)
> +       TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_fla=
gs),
> +
> +       TP_ARGS(memcg, order, gfp_flags),

By adding memcg in front of existing tracepoint arguments, you
unnecessarily break everyone who currently has some scripts based on
this tracepoint. Given there is no reason why memcg has to be the very
first argument, it would be nice if you can just append it at the end
to make it nicely backwards compatible. Same for other tracepoints
below.

Tracepoints are not an ABI, but there is also no point in arbitrarily
breaking all current scripts for such a trivial reason.

> +
> +       TP_STRUCT__entry(
> +               __field(int, order)
> +               __field(unsigned long, gfp_flags)
> +               __array(char, name, NAME_MAX + 1)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->order =3D order;
> +               __entry->gfp_flags =3D (__force unsigned long)gfp_flags;
> +               cgroup_name(memcg->css.cgroup,
> +                       __entry->name,
> +                       sizeof(__entry->name));
> +       ),
> +
> +       TP_printk("memcg=3D%s order=3D%d gfp_flags=3D%s",
> +               __entry->name,
> +               __entry->order,
> +               show_gfp_flags(__entry->gfp_flags))
>  );

[...]
