Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FE47C4759
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbjJKBgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbjJKBgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:36:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4E9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:36:12 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so3636a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 18:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696988170; x=1697592970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+sBQDLcPV7LRqiHSrWLqzfwU0UGHpGELoludilNh5I=;
        b=Jf2mLqqU72O1vvvClGVjxMHawpdpaZwSRoOw496k8k/cy6eDfK1chsWJFAtmg0/GcF
         mSsZQewS5nlna3MCskt5DV02ScrwtOBE0Hf4wmRp+Z6wfwq0wohRufg+ulIYYybtSlrI
         XyzbrxggwaOQqZOdSa87zKihi5ZmU+NQU6zeeeen4VKvlviepIX47+mAWIS8c9zOI8Ti
         eyFNrq74lKttt58BWHhqJ1tg/RMIZw9OcW4bnHYOYKnAfeCWUfZs0asPNQsoWKmdD56k
         Yi3sRcIdSkn1GhmRXBKI2wF0W4SA7u2b7Ww8u+64w1dh0GIV7b/p1wS/ww4/7OKnCSOd
         ENhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988170; x=1697592970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+sBQDLcPV7LRqiHSrWLqzfwU0UGHpGELoludilNh5I=;
        b=FBNpgTwLN/B74hWwlbV7el694oktiScOBuuSOio1ssfmeIsCZlX8IG/ZkA1x3A4qny
         jcxSsnAp/Oj54K5ydV0SwMIUMzaGMXJgqzfRIcS66xrZoiZgt5b1k9I/D2wkOUHyx0t3
         981Ms3pmaE8X5ate1U1CuLDWKAmuF1csCfQ5FOlOhCzSHHKfsyjnHQaXbz5HJkSJf3TG
         WPaina7qL7FnBeDKkR6A42KOqNYQEx4zxS+Inh9LenAqEVYohpY8m4oBI4cffE2B8vLa
         x8EiTlbdfqFuOyoQVyI7C5shCau7fUvclDibl3L/kEnSSa0zXMW+RcLXTIPa9MyHk0uR
         /qLQ==
X-Gm-Message-State: AOJu0YyQwD2ywcvbkriznqeYY/4JhxSYs4kNL5IHpNgWxxUtg85M6n5r
        oJKlI9vFWIsoGa5cDbyZmw0LIeDyEgDslRZPlLkyyw==
X-Google-Smtp-Source: AGHT+IGhrcHFTQwfrnQ+bzSFjLtyebXmHAy60HH5YGHyNv84o1BbsJb5OqxH0HX2LRtHoVupJ6g3TkOJx6G0TbGiScQ=
X-Received: by 2002:a50:d481:0:b0:53d:b53c:946b with SMTP id
 s1-20020a50d481000000b0053db53c946bmr52345edi.2.1696988170406; Tue, 10 Oct
 2023 18:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <202310110451.rvdUZJEY-lkp@intel.com> <20231010234247.71604-1-namhyung@kernel.org>
In-Reply-To: <20231010234247.71604-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Oct 2023 18:35:59 -0700
Message-ID: <CAP-5=fVpgYJMTgRjQc6zoMYjNkm7T0TSBPXLgz_VWuzwRo_ktg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Do not ignore the default vmlinux.h
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 4:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The recent change made it possible to generate vmlinux.h from BTF and
> to ignore the file.  But we also have a minimal vmlinux.h that will be
> used by default.  It should not be ignored by GIT.
>
> Fixes: b7a2d774c9c5 ("perf build: Add ability to build with a generated v=
mlinux.h")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@i=
ntel.com/
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/bpf_skel/vmlinux/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tools/perf/util/bpf_skel/vmlinux/.gitignore
>
> diff --git a/tools/perf/util/bpf_skel/vmlinux/.gitignore b/tools/perf/uti=
l/bpf_skel/vmlinux/.gitignore
> new file mode 100644
> index 000000000000..49502c04183a
> --- /dev/null
> +++ b/tools/perf/util/bpf_skel/vmlinux/.gitignore
> @@ -0,0 +1 @@
> +!vmlinux.h
> --
> 2.42.0.609.gbb76f46606-goog
>
