Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA47E09A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377789AbjKCTue convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Nov 2023 15:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKCTud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:50:33 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A66D4E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:50:31 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-28023eadc70so2417197a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 12:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699041030; x=1699645830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+9uIel5PccOA8PHoSqpnvZ3HoedGl5aV/O8FGCyQEc=;
        b=CaVK3fkTfezTltzrlQmVvjxhH+ikXRpPnjMaxn0bbA5+8Z2kVxA1CUZ0rNl85mJfEQ
         44MOfb1I50tt0AIUtqPhNROPq9MmxCqHDM7FZWFkuyjPwO9c/HIAMKyT9F2GIZ2CXR8o
         1CHxsOpC+ZZnw/UOHmYw+E4C1D8bgQrQ/aivA5y0bzQlBwLUY0tZK5V11M+OKEKLLQLx
         HEufwecgbVBXqKczjBfMMmOsn65Z1MPgN6YCjVInPUlR2UW+9Dz6AAuHDFflyGYY4x/x
         DXJ5Z8l+hVTtUDSz5Qxov3VxSsfcxurPZBcQ86YAf4UGewEonmOgP1a7PxwkTos45h/8
         k+nw==
X-Gm-Message-State: AOJu0YwlbRbN5yfUu5ApoLdTdTRX8DhjjvGoN92m6lg1ntSX7I6/ywl3
        Bj4Hk0hGnR9AOSpDtpSgggP+SR0mvbin5tDYNrk=
X-Google-Smtp-Source: AGHT+IHdP4uyNBCo/u7nBWMxlHJICUgi/9O4YiyImzYhHVpIWSc8log9MYdQhtI0pbMzGCC2/Qdoz7FAchXna9f3h8g=
X-Received: by 2002:a17:90a:49ca:b0:27c:f1f8:261f with SMTP id
 l10-20020a17090a49ca00b0027cf1f8261fmr18389928pjm.20.1699041030547; Fri, 03
 Nov 2023 12:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231102150919.719936610@infradead.org> <20231102152017.847792675@infradead.org>
 <ZUTprUojg7eHoxQI@krava>
In-Reply-To: <ZUTprUojg7eHoxQI@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Nov 2023 12:50:19 -0700
Message-ID: <CAM9d7cj-Y8BwxiqDcpJj0CoPAip3cc6mr+5WQcGYeFX7esw6sg@mail.gmail.com>
Subject: Re: [PATCH 01/13] perf: Simplify perf_event_alloc() error path
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        irogers@google.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri and Peter,

On Fri, Nov 3, 2023 at 5:38 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Nov 02, 2023 at 04:09:20PM +0100, Peter Zijlstra wrote:
>
> SNIP
>
> > @@ -11936,24 +11957,24 @@ perf_event_alloc(struct perf_event_attr
> >        */
> >       if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
> >               err = -EINVAL;
> > -             goto err_pmu;
> > +             goto err;
> >       }
> >
> >       if (event->attr.aux_output &&
> >           !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
> >               err = -EOPNOTSUPP;
> > -             goto err_pmu;
> > +             goto err;
> >       }
> >
> >       if (cgroup_fd != -1) {
> >               err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
> >               if (err)
> > -                     goto err_pmu;
> > +                     goto err;
> >       }
> >
> >       err = exclusive_event_init(event);
> >       if (err)
> > -             goto err_pmu;
> > +             goto err;
> >
> >       if (has_addr_filter(event)) {
> >               event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
> > @@ -11961,7 +11982,7 @@ perf_event_alloc(struct perf_event_attr
> >                                                   GFP_KERNEL);
> >               if (!event->addr_filter_ranges) {
> >                       err = -ENOMEM;
> > -                     goto err_per_task;
> > +                     goto err;
> >               }
> >
> >               /*
> > @@ -11986,41 +12007,21 @@ perf_event_alloc(struct perf_event_attr
> >               if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
> >                       err = get_callchain_buffers(attr->sample_max_stack);
> >                       if (err)
> > -                             goto err_addr_filters;
> > +                             goto err;
> >               }
> >       }
> >
> >       err = security_perf_event_alloc(event);
> >       if (err)
> > -             goto err_callchain_buffer;
> > +             goto err;
> >
> >       /* symmetric to unaccount_event() in _free_event() */
> >       account_event(event);
> >
> >       return event;
> >
> > -err_callchain_buffer:
> > -     if (!event->parent) {
> > -             if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
> > -                     put_callchain_buffers();
> > -     }
>
> hum, so this is now called all the time via __free_event, but it should
> be called only if we passed get_callchain_buffers call.. this could screw
> up nr_callchain_events number eventually no?

Looks like so.

>
> jirka
>
> > -err_addr_filters:
> > -     kfree(event->addr_filter_ranges);
> > -
> > -err_per_task:
> > -     exclusive_event_destroy(event);
> > -
> > -err_pmu:
> > -     if (is_cgroup_event(event))
> > -             perf_detach_cgroup(event);
> > -     if (event->destroy)
> > -             event->destroy(event);
> > -     module_put(pmu->module);

I'm afraid of this part.  If it failed at perf_init_event(), it might
call event->destroy() already.  I saw you cleared event->pmu
in the failure path.  Maybe we need the same thing for the
event->destroy.

Thanks,
Namhyung


> > -err_ns:
> > -     if (event->hw.target)
> > -             put_task_struct(event->hw.target);
> > -     call_rcu(&event->rcu_head, free_event_rcu);
> > -
> > +err:
> > +     __free_event(event);
> >       return ERR_PTR(err);
> >  }
> >
> >
> >
