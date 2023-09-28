Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEC7B1162
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjI1EBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 00:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjI1EBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:01:00 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FD7BF;
        Wed, 27 Sep 2023 21:00:58 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-79545e141c7so345911739f.0;
        Wed, 27 Sep 2023 21:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695873657; x=1696478457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQaJt77QAADp5dQVtAfvK8U5FuFyoZY42Sn71faXauA=;
        b=mWa3psEUxTdn207GyD8H6Og0WEFO7BF5RWn7kWO5I7hw1uh8Ul/gnWYSlGKVCjrEfl
         WppKUI4zHeyakX5CI1md53kjaHC0UhAsnUrjDCKkfCt43G/Vy5GRR/Hh1cUNefxRQmvR
         PFKywhEXug2eJnyr+ZFyL7tnV5f9zEpoMk9KuQn77QAC89pbU3GmrR74affIu0d6wbzc
         tQjIl/Jh8rTHBJSEUoJlLy6FEgs88zw4/g7rXND1oY5Stltwthr7LtmqWQYjKZqK8tgd
         WTsM240h4GWQW8WUkI5UUNnjmP7OtbuaZ4lrjX/XPCVXUoaSmJdzW7s8U6HkL00z9y6I
         mApQ==
X-Gm-Message-State: AOJu0YxaAeJyUcrv7G/lBhA6yQNBT8U9FMqsQbAyAIChQGfypSbKCCzg
        flZ01IWRwJ7J+msuGuLub6O/ZpKg5vDWsVHVEYg=
X-Google-Smtp-Source: AGHT+IFQLclcMSCsqGSZHGFx75bmoyRnGsY+U0uITLMPXBXsHFwS64TQ4gJWotRnkNwF/ncF19Y7h8sPhs30A83qsjU=
X-Received: by 2002:a5d:9c81:0:b0:785:d5d4:9f26 with SMTP id
 p1-20020a5d9c81000000b00785d5d49f26mr41560iop.9.1695873657615; Wed, 27 Sep
 2023 21:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fWuaii1rOOvN7rJDo3UoQvkEtiJv3QiBhLRhYk1_Se7ew@mail.gmail.com>
 <f4812cce-14d2-9771-233f-b0db5af449be@linux.alibaba.com> <CAM9d7cjjSJybJEbSdBkVH3qx7RDqriv4tqBCNw1Yi9bAeUf3Yw@mail.gmail.com>
 <3ce74666-7db9-f043-8004-b1cec050188a@linux.alibaba.com>
In-Reply-To: <3ce74666-7db9-f043-8004-b1cec050188a@linux.alibaba.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 27 Sep 2023 21:00:46 -0700
Message-ID: <CAM9d7ch1YPTsmuXyaWiu-p-9B34tQC2sveQUbTPrtbpFVv5TUg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] Add metrics for Arm CMN
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:06 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
>
>
> 在 2023/9/27 上午9:00, Namhyung Kim 写道:
> > Hello,
> >
> > On Mon, Sep 25, 2023 at 8:15 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> 在 2023/9/26 上午12:37, Ian Rogers 写道:
> >>> On Sun, Sep 24, 2023 at 10:58 PM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
> >>>>
> >>>> Changes since v8:
> >>>> - Add fully match identifier check as suggested by Ian.
> >>>> - Link: https://lore.kernel.org/lkml/1695037955-107983-1-git-send-email-renyu.zj@linux.alibaba.com/
> >>>>
> >>>> Jing Zhang (7):
> >>>>   perf pmu: "Compat" supports regular expression matching identifiers
> >>>>   perf metric: "Compat" supports regular expression matching identifiers
> >>>>   perf jevents: Support EventidCode and NodeType
> >>>>   perf test: Make matching_pmu effective
> >>>>   perf test: Add pmu-event test for "Compat" and new event_field.
> >>>>   perf jevents: Add support for Arm CMN PMU aliasing
> >>>>   perf vendor events: Add JSON metrics for Arm CMN
> >>>
> >>> Thanks for the patience with all the to and fro. I was able to test
> >>> the series with "git am -3" to get around a merge issue on
> >>> perf-tools-next.
> >>>
> >>> Reviewed-by: Ian Rogers <irogers@google.com>
> >>> Tested-by: Ian Rogers <irogers@google.com>
> >>>
> >>
> >> Thank you for following this series and providing many valuable suggestions.
> >
> > It's not applied cleanly.  Can you please rebase onto the current
> > tmp.perf-tools-next branch in the following tree?
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> >
>
> Hi Namhyung,
>
> I have sent v11[1] which rebase onto latest tmp.perf-tools-next branch. Please help to apply it, thanks.
>
> [1] https://lore.kernel.org/all/1695794391-34817-1-git-send-email-renyu.zj@linux.alibaba.com/

Yep, it looks good... testing now.

Thanks,
Namhyung
