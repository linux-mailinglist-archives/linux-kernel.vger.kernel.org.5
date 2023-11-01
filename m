Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD217DDC2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346894AbjKAEv2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Nov 2023 00:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjKAEv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:51:26 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091E103;
        Tue, 31 Oct 2023 21:51:20 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso6414679b3a.2;
        Tue, 31 Oct 2023 21:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698814280; x=1699419080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TflHzLL9mwHfj7Sd/OTyc8fpg+bR2C6DIqUfv6/8H1g=;
        b=SBziHYS4TmgI0AWh+WxKmxF+NxYpnnGzYS8yaAVrM94GyrDXKO8fUVtDTQhYFe3xIj
         +qQuL/8O/uHwOpyOS53rQXVZ7ahmT9+KyATWVY/sdXvHM/WBXuMYar3ZLxB73WRt9phO
         F6TeGSIK206lV7y9yrMZEr1OUSxulzH1y8nFQnx4GgPgBHOdtPMvuRighr2G4ypKxLQJ
         TjOlzmx/FOwmp+sJ7rzamESrYDXJD7O72OkECpInSx/iWsCX4jaYyvrFpOR05cLREANp
         mGVdRx39APLIhwpxhPIx4ZuBcP1sXs3qaudfM/b3guHSe92SUZ8XOKTSVVHWL/C0XwEl
         PHFg==
X-Gm-Message-State: AOJu0YwUlWEcI37yNUVgvxTHWovsdt0JhgdN7YStR93nkEiHF5UEnXED
        BGGAhXRmRBk3MY97XYkeVjrKTmfAZLdmQQzlgLcwt7No
X-Google-Smtp-Source: AGHT+IFdsFFUN0KEmfwfH+o5Css7WEZJM3PT05GVXxMYAaSa5SNSIPjKrTtgQy8rYCc5/76mPbGAFpAgsQ18zPAMZq0=
X-Received: by 2002:a05:6a20:8c19:b0:161:2607:d815 with SMTP id
 j25-20020a056a208c1900b001612607d815mr12922828pzh.24.1698814279625; Tue, 31
 Oct 2023 21:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231030111438.1357962-1-yangjihong1@huawei.com>
In-Reply-To: <20231030111438.1357962-1-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 31 Oct 2023 21:51:07 -0700
Message-ID: <CAM9d7ciTwcj-yGAzH6SFFfSQwjnJpnNfs8HypKOaCTLKT6HoiA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf build: Add loading python binding check to
 python.so build
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 30, 2023 at 4:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> Add loading python binding check to python.so build so that problem can be
> detected in advance in the build phase instead of being left to `perf test`
> phase.
>
> In normal scenarios, the original build is not affected:
>
>   $ cd tools/perf
>   $ rm -rf /tmp/perf; mkdir /tmp/perf; make O=/tmp/perf
>   $ echo $?
>   0
>   $ cd /tmp/perf
>   $ ./perf test python
>    19: 'import perf' in python                    : Ok
>
> Create an error scenario, for example, delete util/rlimit.c from
> util/python-ext-sources:
>
>   $ cd tools/perf
>   $ sed -i 's@util/rlimit.c@#util/rlimit.c@g' util/python-ext-sources
>   $ grep rlimit util/python-ext-sources
>   #util/rlimit.c
>   $ rm -rf /tmp/perf; mkdir /tmp/perf; make JOBS=1 O=/tmp/perf
>   <SNIP>
>     GEN     /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so
>   Error: Load python binding failed. See /tmp/perf/python_ext_build/lib//build.log for more details
>   make[2]: *** [Makefile.perf:644: /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so] Error 1
>   make[1]: *** [Makefile.perf:242: sub-make] Error 2
>   make: *** [Makefile:70: all] Error 2
>   $ cat /tmp/perf/python_ext_build/lib//build.log
>   Traceback (most recent call last):
>     File "<string>", line 1, in <module>
>   ImportError: /tmp/perf/python_ext_build/lib/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

For both patches,
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Makefile.perf | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d80dcaa5a1e3..a2449c4890ad 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -645,7 +645,13 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_
>          CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
>           $(PYTHON_WORD) util/setup.py \
>           --quiet build_ext; \
> -       cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> +       $(PYTHON_WORD) -c 'import sys; sys.path.insert(0, "$(PYTHON_EXTBUILD_LIB)"); import perf' 2>$(PYTHON_EXTBUILD_LIB)/build.log; \
> +       if [ $$? -ne 0 ]; then \
> +               echo "Error: Load python binding failed. See $(PYTHON_EXTBUILD_LIB)/build.log for more details"; \
> +               exit 1; \
> +       else \
> +               cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
> +       fi
>
>  python_perf_target:
>         @echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
> --
> 2.34.1
>
