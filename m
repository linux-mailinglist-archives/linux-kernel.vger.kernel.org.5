Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41E7D9C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbjJ0PAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345833AbjJ0PAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:00:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510D128
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:00:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so66455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698418817; x=1699023617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=In2w2XAnYFFzI3oDxSHEa9Ny2CIQ+xaG4Im4ZzOyKqU=;
        b=FlEijcltFgz485hcnEWkN3Cg8cNf4sMAczZuzLyot9khuMVyNelf7XeAnvNGBQCrhu
         dbx4xpuXp84OlLwhlmtGbUo1p6qE6tReBVUAC7U0InY9AdqaLEH7BkQ3UAWgYmplZwzQ
         PTVj4jsv7vhqfSc2/lNF3111VaVkzjuJOdmSeX/c9ybCfV1XEKDD53lVRh7Lm9FadfuL
         7qjRFoMsCYIUOgfG+z1Pe1hR5rIgk2kGyFZ4jA1sZlQjjYp/XHv4MMTMB3G8ogXqcnRe
         UCHITDOq0QwNpz5iEyzmQZTGtEKMuma5+bdqL1OSEhZ3JeEtdYd1jMJIKofT0nWXCQMC
         tjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418817; x=1699023617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=In2w2XAnYFFzI3oDxSHEa9Ny2CIQ+xaG4Im4ZzOyKqU=;
        b=rnRpGYooSRuqlA0FgL7kkHX9m7SIp7TqtsZiWFAlms6ut+eND+d0E8yshLUcYG/3fu
         ScTbVUirZRFtyHvFjcS6cgzUYD4jmO/HIcdmvsZ5QHseD3Dt7EyeF2OBJkGCNZpMvetB
         /VzLBzqU1+HWRGIP2iVZvyFiJl1G4i2AbI4YXOVCgNvaDsYJZKUWOT6CvTubphUljtq5
         ZI69NzbuVpowi4nw/BFS6yhalyMMI5nU6pW+zjoQLuGPehdRs2PclDjdZFZi1MSBhc4D
         dojAYqaTGuL+z9k2AB4byc2eiOoNyYlREcWHwMV6i9b/qLpOoKVZ//P9zaJTME1wJFTQ
         L+vg==
X-Gm-Message-State: AOJu0Yy1ySkj+fITExNw15RvW3SOwcK2p6lYHc+puhcgEOE5Q8NqWGGt
        jAn+MCO/OzPH92eLVS5497CBwrke4rnqGAktvNzuLw==
X-Google-Smtp-Source: AGHT+IHONKENQ9qinfgNvj/OXRTa77knD7izur4HaKYaTZhE3a13eoK1E1qDQ2pNsmFOX61jgM8j4IU+OTbtHanhvbU=
X-Received: by 2002:a05:600c:1d95:b0:3fe:e9ea:9653 with SMTP id
 p21-20020a05600c1d9500b003fee9ea9653mr114964wms.4.1698418816657; Fri, 27 Oct
 2023 08:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZTvGx/Ou6BVnYBqi@kernel.org>
In-Reply-To: <ZTvGx/Ou6BVnYBqi@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 27 Oct 2023 08:00:05 -0700
Message-ID: <CAP-5=fUv2=hKHPEYsx9kmni=fsLu6-g5qjJgSCFxPnTqHVY4LQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Disable BPF skeletons if clang version is
 < 12.0.1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 7:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> While building on a wide range of distros and clang versions it was
> noticed that at least version 12.0.1 (noticed on Alpine 3.15 with
> "Alpine clang version 12.0.1") is needed to not fail with BTF generation
> errors such as:
>
> Debian:10
>
>   Debian clang version 11.0.1-2~deb10u1:
>
>     CLANG   /tmp/build/perf/util/bpf_skel/.tmp/sample_filter.bpf.o
>   <SNIP>
>     GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
>   libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] secti=
on: -2
>   Error: failed to open BPF object file: No such file or directory
>   make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/sample_=
filter.skel.h] Error 254
>   make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/sample_filter=
.skel.h'
>
> Amazon Linux 2:
>
>   clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
>
>     GENSKEL /tmp/build/perf/util/bpf_skel/sample_filter.skel.h
>   libbpf: elf: skipping unrecognized data section(18) .eh_frame
>   libbpf: elf: skipping relo section(19) .rel.eh_frame for section(18) .e=
h_frame
>   libbpf: failed to find BTF for extern 'bpf_cast_to_kern_ctx' [21] secti=
on: -2
>   Error: failed to open BPF object file: No such file or directory
>   make[2]: *** [/tmp/build/perf/util/bpf_skel/sample_filter.skel.h] Error=
 254
>   make[2]: *** Deleting file `/tmp/build/perf/util/bpf_skel/sample_filter=
.skel.h'
>
> Ubuntu 20.04:
>
>   clang version 10.0.0-4ubuntu1
>
>     CLANG   /tmp/build/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf=
.o
>     GENSKEL /tmp/build/perf/util/bpf_skel/bench_uprobe.skel.h
>     GENSKEL /tmp/build/perf/util/bpf_skel/bperf_leader.skel.h
>   libbpf: sec '.reluprobe': corrupted symbol #27 pointing to invalid sect=
ion #65522 for relo #0
>     GENSKEL /tmp/build/perf/util/bpf_skel/bperf_follower.skel.h
>   Error: failed to open BPF object file: BPF object format invalid
>   make[2]: *** [Makefile.perf:1121: /tmp/build/perf/util/bpf_skel/bench_u=
probe.skel.h] Error 95
>   make[2]: *** Deleting file '/tmp/build/perf/util/bpf_skel/bench_uprobe.=
skel.h'
>
> So check if the version is at least 12.0.1 otherwise disable building
> BPF skels and provide a message about it, continuing the build.
>
> The message, when running on amazonlinux:2:
>
>   Makefile.config:698: Warning: Disabled BPF skeletons as reliable BTF ge=
neration needs at least clang version 12.0.1
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/Makefile.config | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 4300a9e4253a0c87..8b6cffbc485834c8 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -693,6 +693,13 @@ ifeq ($(BUILD_BPF_SKEL),1)
>      dummy :=3D $(warning Warning: Disabled BPF skeletons as clang ($(CLA=
NG)) is missing)
>      BUILD_BPF_SKEL :=3D 0
>    else
> +    CLANG_VERSION :=3D $(shell $(CLANG) --version | head -1 | sed 's/.*c=
lang version \([[:digit:]]\+.[[:digit:]]\+.[[:digit:]]\+\).*/\1/g')
> +    ifeq ($(call version-lt3,$(CLANG_VERSION),12.0.1),1)
> +      dummy :=3D $(warning Warning: Disabled BPF skeletons as reliable B=
TF generation needs at least $(CLANG) version 12.0.1)
> +      BUILD_BPF_SKEL :=3D 0
> +    endif
> +  endif
> +  ifeq ($(BUILD_BPF_SKEL),1)
>      $(call feature_check,clang-bpf-co-re)
>      ifeq ($(feature-clang-bpf-co-re), 0)
>        dummy :=3D $(warning Warning: Disabled BPF skeletons as clang is t=
oo old)
> --
> 2.41.0
>
