Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB9D7C58C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbjJKQDK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346959AbjJKQDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:03:05 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D00D9;
        Wed, 11 Oct 2023 09:03:04 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5789ffc8ae0so4701588a12.0;
        Wed, 11 Oct 2023 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040183; x=1697644983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iWpEjqXSGgVGGjwEGjS564d40stRH2TrVc0ZOoChC0=;
        b=Og3dJcMq4FeKSlG+kbe5ZfxCTM6XyumC5wTclpg69Vrdz9zGMa8ZOC6YddcVEoeqYa
         WkyA/H3ous0hU71u2Nv3tSDR6ku9JGGkjn2fJWxw9aMpAajgPPTqhc7gZMH58a7rinwT
         AdA8sbRPA6AGBXXXH6YADCmUq7HmWIj3GEFgy0bggd+EpQZc2RIw/iuwSZBezUHrh/B1
         IzGPOs7oEDAOCZbJUC8jX3CBmlNmpMc63pAS52/4UeKFWipI8p6RfFo5IejErCWsjt9C
         sWPqyztXjLmYAelLq9d5LKDzVlUh4g3MZJNLlAGqhHzDvv1SZ0IOM6g9YQgZl1TgEIwl
         3bYg==
X-Gm-Message-State: AOJu0YxS7GU87LdRFI02tV+cbfETIbmZEmE5nVrLFUHGDW8KvOl8HfQ+
        CPoLj3kXTC4Neg6mXR6Cyl1Wj/kvVFu2+qBerYU=
X-Google-Smtp-Source: AGHT+IFhXpVfK13xXF14nVLHcGscMHIBos0Pvg+4mfgk9pC3Cc0MCs29njbs8cFj2heJlBcnNAvupC06PbwNBFa2ky4=
X-Received: by 2002:a17:90a:e7c3:b0:279:57d:f6fc with SMTP id
 kb3-20020a17090ae7c300b00279057df6fcmr17976089pjb.44.1697040183152; Wed, 11
 Oct 2023 09:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231004040844.797044-1-namhyung@kernel.org> <20231004160224.GB6307@noisy.programming.kicks-ass.net>
 <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com>
 <20231009210425.GC6307@noisy.programming.kicks-ass.net> <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
 <CAM9d7cjxSd9QJzTs1_s6Nh7c38FZ7_2FGPoCunvnmjX_y-+Dyg@mail.gmail.com>
 <20231011075136.GM14330@noisy.programming.kicks-ass.net> <20231011095004.GD6337@noisy.programming.kicks-ass.net>
In-Reply-To: <20231011095004.GD6337@noisy.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Oct 2023 09:02:51 -0700
Message-ID: <CAM9d7cghWx+ds8rxFq7xrtoAc4wDrY=yyk=38v+xoY2SODUmtA@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 2:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 11, 2023 at 09:51:36AM +0200, Peter Zijlstra wrote:
>
> > I'll go write me a Changelog and apply the thing, then we can forget
> > about things.
>
> I pushed out:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/core&id=52ecef05348dc97e3a5121f7cc0dd08e340b870c
>
> for the robots to chew on, will push out to tip if nobody complains.

Thanks a lot!
Namhyung
