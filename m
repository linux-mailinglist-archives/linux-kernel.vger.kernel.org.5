Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B2D7EC6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbjKOPNH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 10:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbjKOPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:13:04 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6DC7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:13:00 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-282ff1a97dcso498829a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700061180; x=1700665980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXCJixjJgHg5fxVASLxV1bYeFt3XpDHx8wFlXRdXihw=;
        b=HOIbmgHoz2aCsNNubIYu1tw6SEm5DGuCi1C9ho0iJkeGf0OkbRhaeIAEe2MA035dcR
         iTqTjXdFYqk0M4eATNlny00sL9wDu1yJbpYmjRWxC7gKk78ZsrmFY49Ld1HtVe2yGf6O
         Y4XmwTnBqfZAamYPHvVvGjj2ZcXXKSRQ6s3vhxiZudhzKK5bRRCJ2O8E92myFZlmwKOM
         2kikABbkX7fsy65JftVwgRqcrSZENCkvw6VtS4jD6ZpR6zOE0F7g59l1EIvE4KQ20JNU
         90VI5cDBNtaNvzL5k6cMi/OLyk4zu6TAUFX2sh2I1r1fktGZB+j/zWmq2INkracmjgOR
         W7Gw==
X-Gm-Message-State: AOJu0Yx/0EGE0Lkdamu1AeiHfITTuXsgot2d0iGs9TcpIjljUD1JZ2AK
        K6sgM/RKuM8N6pK0h3BhuR73u/4MAFugJWAKF2c=
X-Google-Smtp-Source: AGHT+IFXlt9vMBSrAjbwFL+yhHWyFG2zg+6cbrMfogN3Od09w9GxjIFcawWuItk/eMXx73cr/19oKD0nypL17aa5fgo=
X-Received: by 2002:a17:90b:1d8e:b0:27d:3be:8e13 with SMTP id
 pf14-20020a17090b1d8e00b0027d03be8e13mr11015849pjb.12.1700061179919; Wed, 15
 Nov 2023 07:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20231102150919.719936610@infradead.org> <20231102152017.847792675@infradead.org>
 <ZUTprUojg7eHoxQI@krava> <CAM9d7cj-Y8BwxiqDcpJj0CoPAip3cc6mr+5WQcGYeFX7esw6sg@mail.gmail.com>
 <20231115095817.GB3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231115095817.GB3818@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Nov 2023 07:12:48 -0800
Message-ID: <CAM9d7chKHryDF45QUV+UtgZ+qiLsOsseXR5hXb=D8JS74HREDw@mail.gmail.com>
Subject: Re: [PATCH 01/13] perf: Simplify perf_event_alloc() error path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <olsajiri@gmail.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        irogers@google.com, adrian.hunter@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 1:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 03, 2023 at 12:50:19PM -0700, Namhyung Kim wrote:
>
> > > > -err_pmu:
> > > > -     if (is_cgroup_event(event))
> > > > -             perf_detach_cgroup(event);
> > > > -     if (event->destroy)
> > > > -             event->destroy(event);
> > > > -     module_put(pmu->module);
> >
> > I'm afraid of this part.  If it failed at perf_init_event(), it might
> > call event->destroy() already.  I saw you cleared event->pmu
> > in the failure path.  Maybe we need the same thing for the
> > event->destroy.
>
> In that case event->destroy will not yet have been set, no?

In perf_try_init_event(), it calls event->destroy() if set when it
has EXTENDED_REGS or NO_EXCLUDE capabilities and returns an error.

Thanks,
Namhyung
