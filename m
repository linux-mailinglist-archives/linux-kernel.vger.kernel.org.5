Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395F8046F7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344196AbjLEDd0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 22:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjLEDdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:33:24 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB7BB4;
        Mon,  4 Dec 2023 19:33:31 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-286d8dae2dbso380468a91.1;
        Mon, 04 Dec 2023 19:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701747211; x=1702352011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMw9Nvv8QLfxV8cCUDbNc+UabXDMv0YVSrH/IrafvLo=;
        b=tD676X0MztpgP2n4kIQ3RrK7VWabXgvrewrGP5MRb11tOR8ulgcGL2wTaGxZZ6SbsM
         mn46HkrV1rboXGrwNqehmcUaLXH0P5XHTAatZd1u+nCJjZq0Ompu4bKTkgbQQTBJvy1X
         QyxrrbaIH+83vh2rIfQ1kAL0JcwF3PU1Cu8tDQZnQKoA5Loxr4yq3WVjYXYhS8IvQnwC
         DsCYuNLQl6j1uExXubL9sUdYaxskXpJT/vmmiAyiD/eBH8M8uTZTk/Uv3PTq75qt0mnu
         c+TwC9gSSgTkG/9kYQxxg6LUGF0y7szmoUlCESpd7PczwXa87IiS6iekdOLy08gDlGqV
         Lr0Q==
X-Gm-Message-State: AOJu0YzLo2+ZYJwmMmjV7GZnrimfDhicIRqKDEYvKCM09IlISwMeE7BR
        9nfS8w6XokyOz9kaTqGx+8GNkFxUi3ojn2zLfZs=
X-Google-Smtp-Source: AGHT+IF0FTyYf3LDF6VI38nVTZYSMM5HcQIp90bTAAgmPWxbi4G0S4OHra3Cy6H94F5jgxVkWxFl3zLpr1hFuZZr2PQ=
X-Received: by 2002:a17:90a:d801:b0:286:79b7:e86b with SMTP id
 a1-20020a17090ad80100b0028679b7e86bmr661326pjv.14.1701747210743; Mon, 04 Dec
 2023 19:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
In-Reply-To: <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 19:33:18 -0800
Message-ID: <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello,

On Mon, Dec 4, 2023 at 2:45 PM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
>
>
> On Mon, 4 Dec 2023, Ian Rogers wrote:
> > A metric is default by having "Default" within its groups. The default
> > metricgroup name needn't be set and this can result in segv in
> > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > that assume it has a value when there is a Default metric group. To
> > avoid the segv initialize the value to "".
> >
> > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Thanks! I was going to look for the bug but got pulled to other
> tasks. The patch looks good to me and I tested it successfully on
> AmpereOne.
>
>    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Looks like it needs to go through perf-tools for v6.7.
Ian, do you think this one is enough?

Thanks,
Namhyung
