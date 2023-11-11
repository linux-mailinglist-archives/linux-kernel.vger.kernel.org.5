Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809E7E883A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjKKC1u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 21:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:27:48 -0500
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BF44B3;
        Fri, 10 Nov 2023 18:27:45 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so2440833a91.3;
        Fri, 10 Nov 2023 18:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699669665; x=1700274465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g5Sg9zl2/Jzlb48PWJ9qHhhq1o2YXxnmZN1o79Ovm5g=;
        b=Ed5Ef8RJfghbbpMlLhLhpthRfFVSCrBWQkTSS23PjirESoFAgiMp/apPkG3R6A3Ek7
         BHS+y5xUm8aZ5dC9+R4zixEcYkcOgrF2LNEiG+bTV1iOES0WDOhCoXIJ9aNdeG9Yz45A
         txTNH+4mT09ckfXDsA8WZaXQQiyAQDP2pTDw9wc8sXQr0DcJ9hkXi0Rv+Wjom0LV3F1D
         v92QAJ5U5SgujX1kzxzcEx9BGvWL0WlwtgqdokwyToOL68+ndnZVHolCtgnGz7SNwVhX
         sVVal8wb9YXOL3omOb52HAwJriHopMdrewEBmsCP0MPbgxYX1ZO85U5rdJ2CgoVx6yDG
         CaTg==
X-Gm-Message-State: AOJu0Yxf2df4WDY9QBZrY1jVGVe+U4+Xs3MVdkDjKIEZZo2VTERqLLt5
        DgJ7XYQCIMCkXZKceaRG2Hq5of/yCl2r2yHZZZo=
X-Google-Smtp-Source: AGHT+IFJT/GE7XsIKWeegpPDXB2vEidUCs6t3J32mEXwB2x6MYR6YO1B05VwyOchlDPl21bc/r73Baf/pNfKM3XLF78=
X-Received: by 2002:a17:90b:4ad1:b0:27d:375a:e322 with SMTP id
 mh17-20020a17090b4ad100b0027d375ae322mr812696pjb.31.1699669664922; Fri, 10
 Nov 2023 18:27:44 -0800 (PST)
MIME-Version: 1.0
References: <20231110000012.3538610-1-namhyung@kernel.org> <ZU4cmwfQSK5wXbAD@kernel.org>
In-Reply-To: <ZU4cmwfQSK5wXbAD@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 10 Nov 2023 18:27:33 -0800
Message-ID: <CAM9d7ciqiKMXqah34vGL_qqwL8Pm8uaNTokYq+=VwbV5qdrBxQ@mail.gmail.com>
Subject: Re: [RFC 00/52] perf tools: Introduce data type profiling (v2)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, Ben Woodard <woodard@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        David Blaikie <blaikie@google.com>,
        Xu Liu <xliuprof@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Mark Wielaard <mark@klomp.org>,
        Jason Merrill <jason@redhat.com>
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

On Fri, Nov 10, 2023 at 4:05 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 09, 2023 at 03:59:19PM -0800, Namhyung Kim escreveu:
> > * Patch structure
> >
> > The patch 1-5 are cleanups and a fix that can be applied separately.
>
> Applied so far 1-9, will continue later.

Great, thanks a lot!
Namhyung
