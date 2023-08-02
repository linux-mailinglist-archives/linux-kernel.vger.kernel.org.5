Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D874976D568
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHBRds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjHBRdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:33:23 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DC49DA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:31:47 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4036bd4fff1so21541cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690997442; x=1691602242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9PIydnqQ3dEyq5utYkLvUYqJvKMSGVMEHB6crTMgkM=;
        b=wmnjSqR3AEvLOWI2K6c7yK9kn7fO5Pat99S0Bwsp0PE+T/O9vWdpbvSNknU4tUUGkn
         ca1jFG/o6OZRPOYrIXK5ktFKEkfvXjkyHxiHhOA5bpKtpY3AkRbncUkx0RhnbY1LQG82
         zNpUMw99ibeIKrEdaaNl226aP4G6mvh65veu+exS44GbVaWmGs9OSAiEivUegBo0AuUG
         X4+S92GD0p8Xpt42xJT8lOpauoFaUQcvRY3Gu9VwTjs5xpyoABn3qQo2HEanuvVrK6cb
         9D7jsDgLS7lvLeDPCHsTcGSOcKrOiiPVBpZunRUdc6FXrkmEiy9aKC5ylm5IcoRE1A4c
         bpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997442; x=1691602242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9PIydnqQ3dEyq5utYkLvUYqJvKMSGVMEHB6crTMgkM=;
        b=dvAAZ5l7emdk01wpQaN/OfRzI/hpqrs2+mNVIlQZSyGqQsdBo/M/VOHjOAeEEGIZXU
         lbQgKOCG0+T7ScSBmEt/qum7TyDBhiARqLgKVX5S6L0cnpyyp5Jkqf+YDybWEf9cTe6J
         6Uo6wGR1BMLmSyig2ldRQWPFWnNCv84+wxqF7P4F7UOSWyQboNJIa1tG7LacA0/jY8WV
         E96XmL9N8esThbrwsehod/4reAbMjmr55ej2IxRiC7trxeIKyVhuREzu573/6WwojU7i
         491qKn2xXaJH/TNSwkcHWaKTJlralDCUxBAbhrMmchYuz3oOz3WTV1vqFy4kKOoeJn6V
         GWRw==
X-Gm-Message-State: ABy/qLYrE7p0DaH970DHwmvD/FCf6WWdXU7dVCTFQD08NGEqScU1BAgz
        NBORrfy6qrz5e/tyM3KVqyYIIhV5DSSPAcNy0O2fDA==
X-Google-Smtp-Source: APBJJlFI3O33fIDrmQb3T3R+vWt/XUl3W+c523Scknw1Xsezrj9gRXfsmnqvFKS3yUUTAr4rSh9UVAefcI3sHWOzxbY=
X-Received: by 2002:ac8:5c05:0:b0:3f8:e0a:3e66 with SMTP id
 i5-20020ac85c05000000b003f80e0a3e66mr1367955qti.3.1690997442291; Wed, 02 Aug
 2023 10:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <ZMpcTMvnQns81YWA@kernel.org>
In-Reply-To: <ZMpcTMvnQns81YWA@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Aug 2023 10:30:30 -0700
Message-ID: <CAP-5=fW_3vu-XBe2OC07rkwcvQVKEeiLncVRO1CxGEBNa0tvGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf python: Cope with declarations after statements
 found in Python.h
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 6:38=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
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
>                    from /git/perf-6.5.0-rc2/tools/perf/util/python.c:2:
>   /usr/include/python3.12/object.h: In function =E2=80=98Py_SIZE=E2=80=99=
:
>   /usr/include/python3.12/object.h:217:5: error: ISO C90 forbids mixed de=
clarations and code [-Werror=3Ddeclaration-after-statement]
>     217 |     PyVarObject *var_ob =3D _PyVarObject_CAST(ob);
>         |     ^~~~~~~~~~~
>     LD      /tmp/build/perf/arch/perf-in.o
>   In file included from /usr/include/python3.12/Python.h:53:
>   /usr/include/python3.12/cpython/longintrepr.h: In function =E2=80=98_Py=
Long_CompactValue=E2=80=99:
>   /usr/include/python3.12/cpython/longintrepr.h:121:5: error: ISO C90 for=
bids mixed declarations and code [-Werror=3Ddeclaration-after-statement]
>     121 |     Py_ssize_t sign =3D 1 - (op->long_value.lv_tag & _PyLong_SI=
GN_MASK);
>         |     ^~~~~~~~~~
>
> So add -Wno-declaration-after-statement to the python binding CFLAGS.
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
>  tools/perf/util/setup.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index 869738fc06c38a4b..79d5e2955f85d8f6 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -66,6 +66,9 @@ if cc_is_clang:
>  else:
>      cflags +=3D ['-Wno-cast-function-type' ]
>
> +# The python headers have mixed code with declarations (decls after asse=
rts, for instance)
> +cflags +=3D [ "-Wno-declaration-after-statement" ]
> +
>  src_perf  =3D getenv('srctree') + '/tools/perf'
>  build_lib =3D getenv('PYTHON_EXTBUILD_LIB')
>  build_tmp =3D getenv('PYTHON_EXTBUILD_TMP')
> --
> 2.37.1
>
