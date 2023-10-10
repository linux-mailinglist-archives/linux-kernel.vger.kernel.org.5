Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B57C0062
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjJJP2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjJJP2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:28:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD34AF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:28:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5068b69f4aeso13701e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696951721; x=1697556521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekO9fiWw5dM/5weaz3ceIzr6MnGrpqT9loFE7MOGyrU=;
        b=FMzgRh7nFfJZT1vSt5yVw4JXV++TtBXraW2kKnZAKQ7lzX/0RSzo6PjXlAvg/n8n+4
         JsS8JEPnJItkFgjPIeodqbf+TOHgo5FLAlp54T1KEpiBcPLfNrF9vYeO+/wJpJbPwZma
         2NAgOhxBI09+7bCMnoMytBe0CXmhxYyC/72w4fH4Kqn+xmhfONU4qpIqzo2BulTy4onv
         Z98rXcpUIwxS2NPj/BQGTZki1iJ8XoUlbXcgtBnHoL5dv9NmzwbodCXBnPEx3xbe/4oL
         4qJpLaL9He7OdZQn7RoU3XQBdnmx1wqkMcYIMaE2F0pkG8zUnnWWpc+u7RqXHn0VFMu+
         03HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696951721; x=1697556521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekO9fiWw5dM/5weaz3ceIzr6MnGrpqT9loFE7MOGyrU=;
        b=W0pa1szbhjaA9Uppk+MXYeo2QnQmOEmSBobx/VqBd5u0K6TiYCC7DiH6wjFszJEf6r
         wwmLGjmMiGSPp3oex91bdHZf7+CBMhq/9R513BOLVNUaUBujp/62nXXucEExAPNi66Wa
         wGDobzamfqxrqt6NNTvjTCK/AmDFn/LHgrUa2zfkOaLRWsDW8kk3BhUGXQGxTJNeJAdv
         BxittWPnPDXJIUracLCp0cLsXBrJb75tk56ugXNxuJ9bGKep3YEgdHZBLxLQUz3Hx3XB
         02tdPyhfxpTiwu0PpwkGUeR0vEYC/4NhvMft04p6E+X6l+hw6V0L6cf1PwEIEkUDaSoU
         fQjQ==
X-Gm-Message-State: AOJu0Yyf+F1e0iLX3wH6ec1X03MteFFe+XAttFeLCj+EAY8ZXsKnth6t
        C+kaXCnT4cDWFfvpihl08FS8AW1N86xH5I0lsLqwieqEc+q0DGhnwLvmdA==
X-Google-Smtp-Source: AGHT+IFUfVTdI3DGmUSL2RAl8Kh9AQ/SR5mm4YaKckWRqnUiZrfDiBbiehIs91u221NVNLchLwUcJr+ww0Wg7om+KoE=
X-Received: by 2002:ac2:44a1:0:b0:501:3d3:cbc0 with SMTP id
 c1-20020ac244a1000000b0050103d3cbc0mr329938lfm.2.1696951721128; Tue, 10 Oct
 2023 08:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231005190451.175568-1-adrian.hunter@intel.com> <20231010142234.20061-1-adrian.hunter@intel.com>
In-Reply-To: <20231010142234.20061-1-adrian.hunter@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 10 Oct 2023 08:28:29 -0700
Message-ID: <CAP-5=fUcC32Qa8vdS5WEa0n-hX_9CeZvbraTJ5+6duQ+2hUJ0A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add unaligned.h to check-headers.sh
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:22=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> Add include/asm-generic/unaligned.h to check-headers.sh bringing
> tools/include/asm-generic/unaligned.h up to date so that the kernel and
> tools versions match.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
>
> Based on top of 5 patch set "perf intel-pt: Use of get_unaligned_le16() e=
tc"
>
>
>  tools/include/asm-generic/unaligned.h | 129 ++++++++++++++++++++++++--
>  tools/perf/check-headers.sh           |   1 +
>  2 files changed, 122 insertions(+), 8 deletions(-)
>
> diff --git a/tools/include/asm-generic/unaligned.h b/tools/include/asm-ge=
neric/unaligned.h
> index 9140bb4e16c6..156743d399ae 100644
> --- a/tools/include/asm-generic/unaligned.h
> +++ b/tools/include/asm-generic/unaligned.h
> @@ -1,11 +1,11 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_UNALIGNED_H
> +#define __ASM_GENERIC_UNALIGNED_H
> +
>  /*
> - * Copied from the kernel sources to tools/perf/:
> + * This is the most generic implementation of unaligned accesses
> + * and should work almost anywhere.
>   */
> -
> -#ifndef __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> -#define __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H
> -
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wpacked"
>
> @@ -37,7 +37,120 @@ static inline u64 get_unaligned_le64(const void *p)
>         return le64_to_cpu(__get_unaligned_t(__le64, p));
>  }
>
> -#pragma GCC diagnostic pop
> +static inline void put_unaligned_le16(u16 val, void *p)
> +{
> +       __put_unaligned_t(__le16, cpu_to_le16(val), p);
> +}
> +
> +static inline void put_unaligned_le32(u32 val, void *p)
> +{
> +       __put_unaligned_t(__le32, cpu_to_le32(val), p);
> +}
> +
> +static inline void put_unaligned_le64(u64 val, void *p)
> +{
> +       __put_unaligned_t(__le64, cpu_to_le64(val), p);
> +}
> +
> +static inline u16 get_unaligned_be16(const void *p)
> +{
> +       return be16_to_cpu(__get_unaligned_t(__be16, p));
> +}
> +
> +static inline u32 get_unaligned_be32(const void *p)
> +{
> +       return be32_to_cpu(__get_unaligned_t(__be32, p));
> +}
> +
> +static inline u64 get_unaligned_be64(const void *p)
> +{
> +       return be64_to_cpu(__get_unaligned_t(__be64, p));
> +}
> +
> +static inline void put_unaligned_be16(u16 val, void *p)
> +{
> +       __put_unaligned_t(__be16, cpu_to_be16(val), p);
> +}
> +
> +static inline void put_unaligned_be32(u32 val, void *p)
> +{
> +       __put_unaligned_t(__be32, cpu_to_be32(val), p);
> +}
> +
> +static inline void put_unaligned_be64(u64 val, void *p)
> +{
> +       __put_unaligned_t(__be64, cpu_to_be64(val), p);
> +}
> +
> +static inline u32 __get_unaligned_be24(const u8 *p)
> +{
> +       return p[0] << 16 | p[1] << 8 | p[2];
> +}
>
> -#endif /* __TOOLS_LINUX_ASM_GENERIC_UNALIGNED_H */
> +static inline u32 get_unaligned_be24(const void *p)
> +{
> +       return __get_unaligned_be24(p);
> +}
> +
> +static inline u32 __get_unaligned_le24(const u8 *p)
> +{
> +       return p[0] | p[1] << 8 | p[2] << 16;
> +}
> +
> +static inline u32 get_unaligned_le24(const void *p)
> +{
> +       return __get_unaligned_le24(p);
> +}
> +
> +static inline void __put_unaligned_be24(const u32 val, u8 *p)
> +{
> +       *p++ =3D val >> 16;
> +       *p++ =3D val >> 8;
> +       *p++ =3D val;
> +}
> +
> +static inline void put_unaligned_be24(const u32 val, void *p)
> +{
> +       __put_unaligned_be24(val, p);
> +}
> +
> +static inline void __put_unaligned_le24(const u32 val, u8 *p)
> +{
> +       *p++ =3D val;
> +       *p++ =3D val >> 8;
> +       *p++ =3D val >> 16;
> +}
> +
> +static inline void put_unaligned_le24(const u32 val, void *p)
> +{
> +       __put_unaligned_le24(val, p);
> +}
> +
> +static inline void __put_unaligned_be48(const u64 val, u8 *p)
> +{
> +       *p++ =3D val >> 40;
> +       *p++ =3D val >> 32;
> +       *p++ =3D val >> 24;
> +       *p++ =3D val >> 16;
> +       *p++ =3D val >> 8;
> +       *p++ =3D val;
> +}
> +
> +static inline void put_unaligned_be48(const u64 val, void *p)
> +{
> +       __put_unaligned_be48(val, p);
> +}
> +
> +static inline u64 __get_unaligned_be48(const u8 *p)
> +{
> +       return (u64)p[0] << 40 | (u64)p[1] << 32 | (u64)p[2] << 24 |
> +               p[3] << 16 | p[4] << 8 | p[5];
> +}
> +
> +static inline u64 get_unaligned_be48(const void *p)
> +{
> +       return __get_unaligned_be48(p);
> +}
> +#pragma GCC diagnostic pop
>
> +#endif /* __ASM_GENERIC_UNALIGNED_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 4314c9197850..d09c3d46f08f 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -161,6 +161,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SY=
MBOL" -I "^#include <asm/ex
>  check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include=
 <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
>  check arch/x86/include/asm/amd-ibs.h  '-I "^#include [<\"]\(asm/\)*msr-i=
ndex.h"'
>  check arch/arm64/include/asm/cputype.h '-I "^#include [<\"]\(asm/\)*sysr=
eg.h"'
> +check include/asm-generic/unaligned.h '-I "^#include <linux/unaligned/pa=
cked_struct.h>" -I "^#include <asm/byteorder.h>" -I "^#pragma GCC diagnosti=
c"'
>  check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-gene=
ric/mman-common\(-tools\)*.h>"'
>  check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman=
.h>"'
>  check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)*=
 static_assert$"'
> --
> 2.34.1
>
