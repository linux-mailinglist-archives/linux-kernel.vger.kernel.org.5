Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD66376D572
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjHBRep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjHBRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:34:26 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8742D7E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:32:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-407db3e9669so17531cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690997494; x=1691602294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMQekTCnCdL8XjbcnAHNf222IURbZFEXZaxJuKixKNk=;
        b=KG6K01hymSNMaPGmZAzouE3A51p2BpDPAfILMOzs4XwhiouffJplitKWL2w5cdhHLJ
         gaCT2djqK6oU3Z8s4Bm+G2n1eymaY5aXCV66bpZKL7HnU0gGJlA0/KMhvjPi7Vn72wKD
         eQMpxZxIu82IW/BcyKyeRoAHBTaA2usE5UAQKj2ERmcg4M8nH1e2mKXbrmQ+dFk+YkB5
         7SdGA/L25z4KHRxxbjc/SgZ49J8VFRIXIh3ZO1VBHAjrQwpi+3JtYS8KWbpnK6aUo9yr
         0laF+63mhvVy0BKfZYUyMCKJwTHUT1R5xY+KisJbrIbMmsalWuUHfmcJH8trmMsXWwHZ
         Byyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997494; x=1691602294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMQekTCnCdL8XjbcnAHNf222IURbZFEXZaxJuKixKNk=;
        b=JKfvBSzmkmmEd/vp9gONYMW+qH7WGgBN1pOpQTKVmo0MhdKdYQYJJUgaGtbOyNjKld
         ubyzGWCKMPEL2pWxYmkTMVq39j6Slmh1qsJd5CL3wz4GDh8yfSHvFNqs1WTF3K8RvLgr
         EpDpUY6AuNdD6asbX+0H8Ya+JL/4flYOOrBPLV7gdivl1OUOiGKiDCpT0UP+A4JLAeBc
         qho5EHetgRrhTCZOJv2OJsRxE1tIfZTKIHQpODrQ9ofjqK2n/5tWVz/wtwTCjO3QGJpU
         OUpg7vjtB/A2habDA+DSmARDSxSJt8CV4EKY4c/tjyCDnP2WDtRX1VMKXtvwyxP+E1FG
         CKEw==
X-Gm-Message-State: ABy/qLYJIxnhGIn/k4EcpE+XwvE17Cjb3yeTcIydti6MfjBaFi2HJgnD
        VlKb+JAx3Vrc5erNkFsyeCs6Mib459XYdHW4CIfgyA==
X-Google-Smtp-Source: APBJJlFKYJKSV3ehUY7fm4hlH9gWmIX+PDLT2OVwsFvzxFnUYZ/EzGlBqaYaYOyT+IaXs0P2jQVLt5fQvl2chbi/TyY=
X-Received: by 2002:a05:622a:1b8b:b0:3ef:302c:319e with SMTP id
 bp11-20020a05622a1b8b00b003ef302c319emr1165875qtb.8.1690997494037; Wed, 02
 Aug 2023 10:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <ZMpdKeO8gU/cWDqH@kernel.org>
In-Reply-To: <ZMpdKeO8gU/cWDqH@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Aug 2023 10:31:21 -0700
Message-ID: <CAP-5=fXOi9-GznqdzsQDsdje7+nL0v57GOPBW24yWD5yX3JDCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf script python: Cope with declarations after
 statements found in Python.h
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 6:42=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> With -Werror the build was failing on fedora rawhide:
>
>   [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$ gcc -v
>   Using built-in specs.
>   COLLECT_GCC=3Dgcc
>   COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/13/lto-wrapp=
er
>   OFFLOAD_TARGET_NAMES=3Dnvptx-none
>   OFFLOAD_TARGET_DEFAULT=3D1
>   Target: x86_64-redhat-linux
>   Configured with: ../configure --enable-bootstrap --enable-languages=3Dc=
,c++,fortran,objc,obj-c++,ada,go,d,m2,lto --prefix=3D/usr --mandir=3D/usr/s=
hare/man --infodir=3D/usr/share/info --with-bugurl=3Dhttp://bugzilla.redhat=
.com/bugzilla --enable-shared --enable-threads=3Dposix --enable-checking=3D=
release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disabl=
e-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id =
--with-gcc-major-version-only --enable-libstdcxx-backtrace --with-libstdcxx=
-zoneinfo=3D/usr/share/zoneinfo --with-linker-hash-style=3Dgnu --enable-plu=
gin --enable-initfini-array --with-isl=3D/builddir/build/BUILD/gcc-13.2.1-2=
0230728/obj-x86_64-redhat-linux/isl-install --enable-offload-targets=3Dnvpt=
x-none --without-cuda-driver --enable-offload-defaulted --enable-gnu-indire=
ct-function --enable-cet --with-tune=3Dgeneric --with-arch_32=3Di686 --buil=
d=3Dx86_64-redhat-linux --with-build-config=3Dbootstrap-lto --enable-link-s=
erialization=3D1
>   Thread model: posix
>   Supported LTO compression algorithms: zlib zstd
>   gcc version 13.2.1 20230728 (Red Hat 13.2.1-1) (GCC)
>   [perfbuilder@27cfe44d67ed perf-6.5.0-rc2]$
>
>   In file included from /usr/include/python3.12/Python.h:44,
>                    from scripts/python/Perf-Trace-Util/Context.c:14:
>   /usr/include/python3.12/object.h: In function 'Py_SIZE':
>   /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed de=
clarations and code [-Werror=3Ddeclaration-after-statement]
>     217 |     PyVarObject *var_ob =3D _PyVarObject_CAST(ob);
>         |     ^~~~~~~~~~~
>   In file included from /usr/include/python3.12/Python.h:53:
>   /usr/include/python3.12/cpython/longintrepr.h: In function '_PyLong_Com=
pactValue':
>   /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 for=
bids mixed declarations and code [-Werror=3Ddeclaration-after-statement]
>     121 |     Py_ssize_t sign =3D 1 - (op->long_value.lv_tag & _PyLong_SI=
GN_MASK);
>         |     ^~~~~~~~~~
>   <SNIP>
>   In file included from /usr/include/python3.12/Python.h:44,
>                    from util/scripting-engines/trace-event-python.c:22:
>   /usr/include/python3.12/object.h: In function 'Py_SIZE':
>   /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed de=
clarations and code [-Werror=3Ddeclaration-after-statement]
>     217 |     PyVarObject *var_ob =3D _PyVarObject_CAST(ob);
>         |     ^~~~~~~~~~~
>     CC      /tmp/build/perf/util/units.o
>     CC      /tmp/build/perf/util/time-utils.o
>   In file included from /usr/include/python3.12/Python.h:53:
>   /usr/include/python3.12/cpython/longintrepr.h: In function '_PyLong_Com=
pactValue':
>   /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 for=
bids mixed declarations and code [-Werror=3Ddeclaration-after-statement]
>     121 |     Py_ssize_t sign =3D 1 - (op->long_value.lv_tag & _PyLong_SI=
GN_MASK);
>         |     ^~~~~~~~~~
>
> So add -Wno-declaration-after-statement to the python scripting CFLAGS.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/scripts/python/Perf-Trace-Util/Build | 3 ++-
>  tools/perf/util/scripting-engines/Build         | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf=
/scripts/python/Perf-Trace-Util/Build
> index 7d0e33ce6aba44f4..5b0b5ff7e14afc50 100644
> --- a/tools/perf/scripts/python/Perf-Trace-Util/Build
> +++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
> @@ -1,3 +1,4 @@
>  perf-y +=3D Context.o
>
> -CFLAGS_Context.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-s=
trict-prototypes -Wno-unused-parameter -Wno-nested-externs
> +# -Wno-declaration-after-statement: The python headers have mixed code w=
ith declarations (decls after asserts, for instance)
> +CFLAGS_Context.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-s=
trict-prototypes -Wno-unused-parameter -Wno-nested-externs -Wno-declaration=
-after-statement
> diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/sc=
ripting-engines/Build
> index c220fec970324d85..586b94e90f4eb3b8 100644
> --- a/tools/perf/util/scripting-engines/Build
> +++ b/tools/perf/util/scripting-engines/Build
> @@ -5,4 +5,5 @@ perf-$(CONFIG_LIBPYTHON) +=3D trace-event-python.o
>
>  CFLAGS_trace-event-perl.o +=3D $(PERL_EMBED_CCOPTS) -Wno-redundant-decls=
 -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-exter=
ns -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-a=
fter-statement -Wno-switch-enum
>
> -CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-d=
ecls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecat=
ed-declarations -Wno-switch-enum
> +# -Wno-declaration-after-statement: The python headers have mixed code w=
ith declarations (decls after asserts, for instance)
> +CFLAGS_trace-event-python.o +=3D $(PYTHON_EMBED_CCOPTS) -Wno-redundant-d=
ecls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecat=
ed-declarations -Wno-switch-enum -Wno-declaration-after-statement
> --
> 2.37.1
>
