Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB297C58ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjJKQO5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjJKQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:14:55 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF63B0;
        Wed, 11 Oct 2023 09:14:54 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so5642600a91.1;
        Wed, 11 Oct 2023 09:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697040894; x=1697645694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6Rqn3iDNwBIeSwR0FMBrCcNoeILKrR52Gk76BQ01wg=;
        b=WXC0vHJyO+VSup/29i9CdcFvYLb+JRELOswFj/ppx3r6poImLnA9zgK4i9Hxolao3u
         ty0r9UP/1MBtbpJQSbNfVa8rUBny95nDTBBZJlRWtS3iigYHzQ6OE7G1Y7v5p+7wEIo6
         9c7myybAlGx7YWZx+WquCOgaCwma6BZlzKl3r7oLoQWJOhGxykM8AZkCJpQaB18IrPBd
         I7qwzn9vEHIBkbQ1SXnYxJ748xYgAFOLqfhUh/AykyB8vHyfqM29XZZBPMQ8MAEqOy2H
         qS2zAe1Q/694DvZwyudshz0QLiZju5hmGYF1VuW7aGZaCQLMAn3ibR2EIHE+K0PTrJ1N
         BGuA==
X-Gm-Message-State: AOJu0Yyngg/OzAvIAr8NCBOHtfmGOcx+hWATs7Vb7dfwvlE2fzCnFu42
        CF0sEXeLXppV/1+1emWc7LxQTHlU8ARk9A7txf4=
X-Google-Smtp-Source: AGHT+IGfQs48C/AEj++/bEHKnuG9iGQnpGYIfydmJxnJBE2zO40oA/uEGx9dJJsNe2wFj0ybJJPszVC4kbOOuZH/Ras=
X-Received: by 2002:a17:90a:f317:b0:27c:f8f4:fedb with SMTP id
 ca23-20020a17090af31700b0027cf8f4fedbmr3993191pjb.21.1697040893737; Wed, 11
 Oct 2023 09:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230916040915.1075620-1-irogers@google.com> <CAL715WJxmMbXkZSE3p_+ODGxabgrXREsBo9aFu9G9=qkYZeH9A@mail.gmail.com>
 <CAP-5=fUjNiDv=KQ7t8jqfOfOt5i8HGvt8Vv1hn2-hLxX_Kqucg@mail.gmail.com>
 <CAL715W+GQuCJm-1SEsNN2qnHghNL1SrzwH9Km5K8UxubEFfYVw@mail.gmail.com>
 <CAM9d7cgKWi0fafwTxSrKLrVZxcwnhwMGz=oNkAsNdOjDwF6pEA@mail.gmail.com>
 <CAP-5=fWXXi7Y=6Q0k8oLOZmYon+vvg-k4dNUSex_ijcL8ti9sQ@mail.gmail.com> <CAM9d7cjJxR5bvx5UvywEkwazkzpRZiKo8s7GLWutNiBKYa1J7g@mail.gmail.com>
In-Reply-To: <CAM9d7cjJxR5bvx5UvywEkwazkzpRZiKo8s7GLWutNiBKYa1J7g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 11 Oct 2023 09:14:42 -0700
Message-ID: <CAM9d7ch9cFpe3YzDhKhK0sRMn9pZ3RL+_ONCVB52s+EJgcRdqw@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Avoid frequency mode for the dummy event
To:     Ian Rogers <irogers@google.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Jihong <yangjihong1@huawei.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 4:02 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Tue, Oct 3, 2023 at 3:36 PM Ian Rogers <irogers@google.com> wrote:
> > With the PMU disabled, isn't there still a risk of an interrupt still
> > being in flight? In other words the disable doesn't prevent a race and
> > we'll catch this on the next timer call to
> > perf_adjust_freq_unthr_context. I think we can also improve the code
> > by just disabling a PMU once, we can take advantage of the
> > perf_event_pmu_context and disable that PMU, iterate its events and
> > then re-enable the PMU - i.e. no need for an enable and disable per
> > event. I'll put a patch together.
>
> Thanks, I was thinking about that too.  It's also a side effect of
> the context rewrite.  Maybe we could iterate pmu_ctx's active lists
> and skip pmus with PERF_PMU_CAP_NO_INTERRUPT and
> individual non-sampling events.

Or we can add pmu_ctx->nr_freq and check it before accessing
pmu MSRs.

Thanks,
Namhyung
