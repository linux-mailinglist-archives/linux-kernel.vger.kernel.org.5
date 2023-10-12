Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125107C73F9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379562AbjJLRUx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbjJLRUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:20:51 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA0B8;
        Thu, 12 Oct 2023 10:20:48 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-27d1f57bda7so844389a91.0;
        Thu, 12 Oct 2023 10:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131248; x=1697736048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGM0orxolwQDYHlwlGGazTy0jcBbxhs1wdeAXhV7h3Y=;
        b=hhZ4zuysFFLsDu2d89pncICkGNOrYaWQzeNDazuRKYpcTLCfNPjZbpNoRvGyxZBSIu
         6y067hb1jW2mpkqUGH9KdG+mGQ9Qo1S7Fc+rJUjvEHp522xDzlyD8tnjTgMTBY9wy0eG
         E2xBt+i99IV2yvh0EnARQ2SZODT3+qV3YKamKZ2dcuNHRUyDC8LVv5rRBYtYO/Dped5x
         JMHXUDpMnnSyb90bHkhWpzbY9Qe7jAum1E/qDJk3m8X2MtbYWpa+mkLz7sVkQ2iKbcXo
         Xo+zKs1Ek0c73eKjPU3NvVAV/qHS3t/y/bKB37elh4i0ALtxM6/wgKYUVqGtOfT8O/Pn
         rWRA==
X-Gm-Message-State: AOJu0YztyToEeh6HW0PzpQ5TibA3Y3zJHeWs/6mrTV0ASFfrG8QSkodU
        hoYary1T179YxpMHGfLehSdLUIrGG2njxww4Wvq22oWo
X-Google-Smtp-Source: AGHT+IEPxre891+/R+saTBS32Agft7q5gaZKp4Bi09ZkOwD5fSlSHo3lCoxtne4U/s4K9msfTnOZiSnlm/h0dSuMtIo=
X-Received: by 2002:a17:90b:ecc:b0:27d:a59:ebae with SMTP id
 gz12-20020a17090b0ecc00b0027d0a59ebaemr4670194pjb.46.1697131248206; Thu, 12
 Oct 2023 10:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230907210533.3712979-1-irogers@google.com> <CAP-5=fVaK2hhBTX4=zKX5Dft36RurctYEtGzsdUp6XKsjHguMw@mail.gmail.com>
 <CAM9d7cjDmX=k1aEYGZAf5NJ-j6_q55BOOaMofABHE52KWD3jjA@mail.gmail.com>
In-Reply-To: <CAM9d7cjDmX=k1aEYGZAf5NJ-j6_q55BOOaMofABHE52KWD3jjA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 10:20:37 -0700
Message-ID: <CAM9d7cihoHMBet3jV43QkmnZfJ=veVuBkN4vQ-VRpWEQJX+htA@mail.gmail.com>
Subject: Re: [PATCH v1] perf parse-events: Avoid erange from hex numbers
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 6, 2023 at 12:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Fri, Oct 6, 2023 at 8:30 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Sep 7, 2023 at 2:05 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > We specify that a "num_hex" comprises 1 or more digits, however, that
> > > allows strtoull to fail with ERANGE. Limit the number of hex digits to
> > > being between 1 and 16.
> > >
> > > Before:
> > > ```
> > > $ perf stat -e 'cpu/rE7574c47490475745/' true
> > > perf: util/parse-events.c:215: fix_raw: Assertion `errno == 0' failed.
> > > Aborted (core dumped)
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf stat -e 'cpu/rE7574c47490475745/' true
> > > event syntax error: 'cpu/rE7574c47490475745/'
> > >                          \___ Bad event or PMU
> > >
> > > Unable to find PMU or event on a PMU of 'cpu'
> > >
> > > Initial error:
> > > event syntax error: 'cpu/rE7574c47490475745/'
> > >                          \___ unknown term 'rE7574c47490475745' for pmu 'cpu'
> > >
> > > valid terms: event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1,config2,config3,name,period,percore,metric-id
> > > Run 'perf list' for a list of valid events
> > >
> > >  Usage: perf stat [<options>] [<command>]
> > >
> > >     -e, --event <event>   event selector. use 'perf list' to list available events
> > > ```
> > >
> > > Issue found through fuzz testing.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
