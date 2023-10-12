Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06737C7807
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442682AbjJLUpS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 16:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJLUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:45:17 -0400
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA39C0;
        Thu, 12 Oct 2023 13:45:16 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-690d2441b95so1052526b3a.1;
        Thu, 12 Oct 2023 13:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697143516; x=1697748316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxBM1WL5YWehdPAMO4b4zshfBpUnsTGMOdYs0eBjj/w=;
        b=lLZEUKtqOpwzuxc9E4pKErfnIrhMUb4GXfRoUPSP2OpjCeet3XB/MxiwAvbZCJFxmz
         kMpcVuUeueQ2Y08tZ10xeIHwTgMWdOJOkDr5xzS+8QHbe7dhkaXIdr0Uzr4oZhDaZhXq
         BBxn1a2utTH0OYXl0MX3jWfrbqFM4h4PCxRf290SUAvdl7ZfxQDDp+JjhqdR8pntknFL
         TChy446uJ/+0xAl2Ldmctno7oECEj7wnkf9k1tbv3BL6tE79bGUaxWYtZfePoDwqau4Q
         7i8gDLA0OX5UJ7NoZg10+pWC6aEUlE9vqPKIz8WaCuu5KMszQKR2w2E6bPMjANfS7mli
         QPCA==
X-Gm-Message-State: AOJu0Yzn5KbrQdQTs9EX8XMieXJtUXDfnd9TW53mQqaK1CTIXPCG+tol
        vw67CXrY0Bb7vrtT3W/AcosJEF41NzzfNmhHo2zPiHlJ
X-Google-Smtp-Source: AGHT+IG70/F9hrde7bl7cPJIFM2rVadqEHlOfFeA+ynkkcPuBHcvxTD8ozOM+i26QK02Nds7OPOekjk0bS4K2rMBLiI=
X-Received: by 2002:a05:6a00:238d:b0:690:f877:aa1e with SMTP id
 f13-20020a056a00238d00b00690f877aa1emr38987459pfc.12.1697143515938; Thu, 12
 Oct 2023 13:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <ZSeMGPPfxkMvdaP3@gmail.com>
 <CAM9d7chzw4UeHHeXaMfPTiRdLbv7PbpK=xkgxMDojAxAc8y7Jg@mail.gmail.com> <ZSg73+7Ar/U2OWMO@gmail.com>
In-Reply-To: <ZSg73+7Ar/U2OWMO@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 13:45:04 -0700
Message-ID: <CAM9d7cgQXLt-UAfq=HhQ=ajeLXFfRHSfnYeWd-rX+2R7VwvOxQ@mail.gmail.com>
Subject: Re: [RFC 00/48] perf tools: Introduce data type profiling (v1)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
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

On Thu, Oct 12, 2023 at 11:33 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Namhyung Kim <namhyung@kernel.org> wrote:
>
> > > Could we perhaps add an IP filter to perf events to get this built-in?
> > > Perhaps attr->exclude_user would achieve something similar?
> >
> > Unfortunately IBS doesn't support privilege filters IIUC.  Maybe
> > we could add a general filtering logic in the NMI handler but I'm
> > afraid it can complicate the code and maybe slow it down a bit.
> > Probably it's ok to have only a simple privilege filter by IP range.
>
> It will still be so much faster than moving it through the BPF machinery,
> and bonus points if we merge this into the existing privilege-domain
> filtering ABI, so no magic 0x800000000000 constants are needed.
>
> 'Overhead' to other usecases shouldn't be much more than a single branch
> somewhere.

Ok, maybe overhead is not a concern.  But users need to pass the
filter expression to the kernel.

Thanks,
Namhyung
