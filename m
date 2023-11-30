Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1E17FFE5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377131AbjK3WMQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 17:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjK3WMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:12:14 -0500
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B892B10DF;
        Thu, 30 Nov 2023 14:12:20 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c21e185df5so1162233a12.1;
        Thu, 30 Nov 2023 14:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701382340; x=1701987140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Z2BEAePLu01GRPlfECCRaK8cq/hBNpwuCocumn+ug4=;
        b=VjrD9LBGRx0AT73T4mgniuqfUKmBSH4mqWGmUblO+7mXJJ6OX1F/dLSo7++qotgAau
         KFoDVwPNDkVPPLiFqdPKcaF21ZPgK+zJDmL0LnvKOPEnbHicz2+/g8WKokZ3Tg+GLPz+
         9KJ0WJIAJb8MG8eWdi1tXu/iKHh9JyxVDKm4X7bZkKC/GCj4LZgBWZui5TGBzZoZo4Am
         E+GbwgvqcPZfhD1Q5F1FwksbVueQyEj6aGpESI81BQ6LTWb1/bnyBLlThwgW2zePfwat
         jiRr4uuitRSu3KWpmDoZw4K/fchPWBVrxNyKsgbKKC9C95JmqFHbgInicRqrbzfbYq48
         4NlA==
X-Gm-Message-State: AOJu0Yy7Q0mU1NhRmxBZCcKdCKAAQR3+tipeT9eQeUk8HKU0uFoStifZ
        EzQ93GKJKP2g+rwlb0BtAf4avqiSxxutbjqaFFY=
X-Google-Smtp-Source: AGHT+IHUrfUhc1KjoJM0sgOBbQJ/V0+8OJ0d1ll3lqAXcHNTp5BImJQJGhsViHMJJr60vBWw6pSedfARAoFCeE4+AQ8=
X-Received: by 2002:a17:90a:f3cc:b0:280:25e8:f7b4 with SMTP id
 ha12-20020a17090af3cc00b0028025e8f7b4mr24694263pjb.15.1701382340064; Thu, 30
 Nov 2023 14:12:20 -0800 (PST)
MIME-Version: 1.0
References: <ZWkEeqdmCHMLhLr2@kernel.org>
In-Reply-To: <ZWkEeqdmCHMLhLr2@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 30 Nov 2023 14:12:08 -0800
Message-ID: <CAM9d7chi4OQRZRpbNnHFwJ6Esfr+P3b6FQBmHiqU9HXcp8+HLw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Nov 30, 2023 at 1:54 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Namhyung reported:
>
>   I'm seeing a build error on my Alpine linux image which uses busybox +
>   musl libc:
>
>     In file included from trace/beauty/arch_errno_names.c:1,
>                      from builtin-trace.c:899:
>     /build/trace/beauty/generated/arch_errno_name_array.c: In function 'arch_syscalls__strerrno':
>     /build/trace/beauty/generated/arch_errno_name_array.c:142:49: error: unused parameter 'arch' [-Werror=unused-parameter]
>       142 | const char *arch_syscalls__strerrno(const char *arch, int err)
>
>   It looks like busybox find command doesn't have -printf option
>
>     find: unrecognized: -printf
>     , Yesterday 9:16 PM
>     ,
>     BusyBox v1.36.1 (2023-07-27 17:12:24 UTC) multi-call binary.
>
>     Usage: find [-HL] [PATH]... [OPTIONS] [ACTIONS]
>
>     Search for files and perform actions on them.
>     First failed action stops processing of current file.
>     Defaults: PATH is current directory, action is '-print'
>
> So just remove it and pipe find's entry to a basename loop to produce
> the same result.
>
> Fixes: 0337cf74ccf2a434 ("perf util: Introduce architecture specific errno/name mapping")
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for the fix!

Tested-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/trace/beauty/arch_errno_names.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
> index cc09dcaa891e04bb..3ec8781344db13ba 100755
> --- a/tools/perf/trace/beauty/arch_errno_names.sh
> +++ b/tools/perf/trace/beauty/arch_errno_names.sh
> @@ -76,7 +76,7 @@ EoHEADER
>
>  # Create list of architectures that have a specific errno.h.
>  archlist=""
> -for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort -r); do
> +for arch in $(find $toolsdir/arch -maxdepth 1 -mindepth 1 -type d | while read arch ; do basename $arch ; done | sort -r); do
>         test -f $toolsdir/arch/$arch/include/uapi/asm/errno.h && archlist="$archlist $arch"
>  done
>
> --
> 2.41.0
>
