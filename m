Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE07F525B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjKVVOR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 16:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjKVVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:14:05 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAAB1FED;
        Wed, 22 Nov 2023 13:13:15 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2851a2b30a2so183105a91.3;
        Wed, 22 Nov 2023 13:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687595; x=1701292395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LQ1j4kWb3+CnF/kdYlkLVQpqjsriFv4ZkgAtmmsJSU=;
        b=EBuJaj53NzLsRiXGHZO4xRl7z6vLTzAjAjBIFAoETsRq6tCscqpVU8lSq24EgqglCw
         pUEQEWUtNAlxcJkKMmjIN73tVgo2GdGY70wu3qkae5bvd+iu+6Z7L1Q/ciLSS2oaHd1J
         9ony1xahTOKFq/HrJGrq7YrkjfLIHkc+6eG5y+ascC9ADcYqgcsQSQkwwyUdxY1nrCvf
         38I69vnOoLcfCaE/ky8kfsH1C6PptN+KxiiDWgGujR03dH0geE11hJZXByes6yR+K8j3
         7ncSOdSnun+9bV4nWZM46tNsnAFs80Hy5oOJerYKQoiv9SYReaF6hwoVFT+wt8OklQbp
         PS3Q==
X-Gm-Message-State: AOJu0YzANPug7OTFoQ1a8O+qUADvePBtjy9b8oq79A1tSQcLGf+pyXPu
        mwEuWoDRhpal2U9ICVTQhGQhhY/byZrv8sjhL328Epphbx8=
X-Google-Smtp-Source: AGHT+IGsqgHyKb5+Ji33Jh+aGa7/oAUcUoQFDx4KNZetbww0bQufT3EkE4vpwwSTnGmsDw77Wec77EzQdR13VlR/B70=
X-Received: by 2002:a17:90b:4f82:b0:274:4e9b:7a1a with SMTP id
 qe2-20020a17090b4f8200b002744e9b7a1amr3914762pjb.44.1700687595354; Wed, 22
 Nov 2023 13:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20231110000012.3538610-1-namhyung@kernel.org> <20231110000012.3538610-19-namhyung@kernel.org>
 <ZVzvFen/214ylf32@kernel.org> <CAM9d7cijprv2fOM_jwYbrV0jbhno2ZQDCT3SExG=Ot=b2mANmw@mail.gmail.com>
 <ZV5cZe8dxv/GzdGa@kernel.org>
In-Reply-To: <ZV5cZe8dxv/GzdGa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 13:13:04 -0800
Message-ID: <CAM9d7ci+rgyGmLmosNpA4Bk1u8sfwYCLVwN4grky5y4g2Weu3g@mail.gmail.com>
Subject: Re: [PATCH 18/52] perf report: Add 'type' sort key
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
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
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

On Wed, Nov 22, 2023 at 11:54 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 22, 2023 at 10:49:13AM -0800, Namhyung Kim escreveu:
> > On Tue, Nov 21, 2023 at 9:55 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > ⬢[acme@toolbox perf-tools-next]$ perf report -s type
> > > perf: Segmentation fault
> > > -------- backtrace --------
> > > perf[0x69f743]
> > > /lib64/libc.so.6(+0x3dbb0)[0x7f89b4778bb0]
> > > perf[0x505af6]
> <SNIP>
> > > perf[0x504f01]
> > > /lib64/libc.so.6(+0x27b8a)[0x7f89b4762b8a]
> > > /lib64/libc.so.6(__libc_start_main+0x8b)[0x7f89b4762c4b]
> > > perf[0x40ed65]
> > > ⬢[acme@toolbox perf-tools-next]$
> >
> > Right, the 'type' sort key was added here but unfortunately
> > it's not ready for prime time yet.  It also needs the next patch
> > 19/52 ("perf report: Support data type profiling") to fully enable
> > the feature.  Do you think it's better to squash into here?
>
> I haven't checked if squashing would be a good idea, but if you think
> its the right granularity, then do it, as long as we can test features
> in various ways as they are getting added, as I did, using a random
> perf.data file.

I still think it's better to split the change as it's logically separate.
But it's prematurely exposed then maybe needs some protection.

Thanks,
Namhyung
