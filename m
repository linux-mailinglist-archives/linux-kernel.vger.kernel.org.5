Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E37DECC2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjKBGFC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Nov 2023 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjKBGFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:05:00 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6037EA6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 23:04:58 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-280260db156so590281a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 23:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698905098; x=1699509898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQqLDfCUNhZOdjIXAMjs/nSqV0LAthk72rfDvChjyOs=;
        b=f6YdYdRRoiIp/wbVa2XKqzAfyDsMWFn1xiQJPQzrMV3DEQk+f6kWH8ffieWxt2U2aQ
         UMcy2JS6xWH2HxRfBAzXj3fGBtrE4gSNBUbUeV80QlQaChPTNLORy0+iuXveX68GxLPm
         mBdw+Hb63unjSnlkLoGzzk5Dr5oiAQFtZ2mVLB8UqXh2soywHmyupRmJdCQY7zfS2ixy
         8DIm64ZV8Kx29hlD2fmMKm0MeYBdVJuhgxWp0MPRdvB2N9MgTlfBKiUakf3RJcea7pfe
         FrIKpoALVNXt5F6R+G4xl+ndl+nqnk5bQGBkoyOSr1d+d+6hax4MxzlvTELUog/A7zxj
         H2Cw==
X-Gm-Message-State: AOJu0Yz39yAeO3RpPIm4bDvljmf+wC1BxM2aS3blAl7guu1ilL66wNZf
        MiGmBxrHdcapv/tZvfm+6SDP4wL5yvLBrymqGYxSR3X+hHU=
X-Google-Smtp-Source: AGHT+IF3ZrmIivZ+xS9ued53+mLO4o8+bdImPumo8rTqwa246M/H8qZ/KHZSju8YMX1RBZeA7HmnnniZpr2FxDCxxpE=
X-Received: by 2002:a17:90b:3654:b0:280:125:e52e with SMTP id
 nh20-20020a17090b365400b002800125e52emr15176002pjb.35.1698905097710; Wed, 01
 Nov 2023 23:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZUEehyDk0FkPnvMR@kernel.org>
In-Reply-To: <ZUEehyDk0FkPnvMR@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 1 Nov 2023 23:04:46 -0700
Message-ID: <CAM9d7ciFJGWF1y0h+ZFNNhaVCLb4AUqdv+8FFQE0xZX7rfF_ag@mail.gmail.com>
Subject: Re: [PATCH next 1/1] perf build: Warn about missing libelf before
 warning about missing libbpf
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Tue, Oct 31, 2023 at 8:34 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> As libelf is a requirement for libbpf if it is not available, as in some
> container build tests where NO_LIBELF=1 is used, then better warn about
> the most basic library first.
>
> Ditto for libz, check its availability before libbpf too.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.config | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b3e6ed10f40c6f6c..8b6cffbc485834c8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -680,15 +680,15 @@ ifndef BUILD_BPF_SKEL
>  endif
>
>  ifeq ($(BUILD_BPF_SKEL),1)
> -  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
> -    dummy := $(warning Warning: Disabled BPF skeletons as libbpf is required)
> -    BUILD_BPF_SKEL := 0
> -  else ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
> +  ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
>      dummy := $(warning Warning: Disabled BPF skeletons as libelf is required by bpftool)
>      BUILD_BPF_SKEL := 0
>    else ifeq ($(filter -DHAVE_ZLIB_SUPPORT, $(CFLAGS)),)
>      dummy := $(warning Warning: Disabled BPF skeletons as zlib is required by bpftool)
>      BUILD_BPF_SKEL := 0
> +  else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
> +    dummy := $(warning Warning: Disabled BPF skeletons as libbpf is required)
> +    BUILD_BPF_SKEL := 0
>    else ifeq ($(call get-executable,$(CLANG)),)
>      dummy := $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
>      BUILD_BPF_SKEL := 0
> --
> 2.41.0
>
