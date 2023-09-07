Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F542797DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbjIGVbq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjIGVbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:31:45 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1F0B4;
        Thu,  7 Sep 2023 14:31:41 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-34f359949afso5625155ab.1;
        Thu, 07 Sep 2023 14:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122301; x=1694727101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Etes2f+NSQtz7X2glqyFp2vo1IYIDzTep95hy4IotI=;
        b=jMBZtfyJfHiF5/pu/QTgeFkzGKfKFhhBRa3qKa0G6460wlDZ55EwjqFWemarXYILs5
         j6BaY27spxzpGdaGne0wo5xUwwPQwmv/tdbQZEYFuBj1J8w3SylNz162IdeG6Rl7tJ3Q
         UP9Dc6Q11okMimpmJu2pP0sjEHyJGjFHoH+1UCErryBsEkPVrDXeKnGqhwzzFzOLhy9S
         acd+NoCcLq+rH28ialGlqPK59MXZeiUmXXwwRzuzjmKLrqKseMTymnhMdPna88y0Bfha
         87yPunxnJpXRBlSgTgpHcPqj5/a/uOc35wakOs3Cr3yNw60uhj/27D2qFzu4kyrxGyPf
         UO6A==
X-Gm-Message-State: AOJu0YwldZEggmRq11gyskMqYFmmwqI+F+iD29SFdcd7yhYEuBIIXWzj
        i/O3bmNwRBMIVOCy1Ppvj8f/jjmrrxyrePNe34SNV85t2A0=
X-Google-Smtp-Source: AGHT+IEDBvpyBqwXX6bed5rZF+6pKhjKWpPjO9Do/i7sGrDcjLcG7sA4kTJ+6+jtnH1IEwSgS7+H9sfOH0J5eT4fCSo=
X-Received: by 2002:a05:6e02:ca7:b0:349:3755:4d33 with SMTP id
 7-20020a056e020ca700b0034937554d33mr880977ilg.21.1694122300878; Thu, 07 Sep
 2023 14:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230903114721.190733-1-adityag@linux.ibm.com> <20230903114721.190733-2-adityag@linux.ibm.com>
In-Reply-To: <20230903114721.190733-2-adityag@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 7 Sep 2023 14:31:29 -0700
Message-ID: <CAM9d7cip5Sm9cJdJHN4gvC+9zBTDjywmdHLK2A457Z8K1Po0vg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf check: introduce check subcommand
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Sep 3, 2023 at 4:47 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
>
>     perf version --build-options | grep " on .* HAVE_FEATURE"
>
> Instead of this, introduce a subcommand "perf check --feature", with which
> scripts can test for presence of a feature, such as:
>
>     perf check --feature HAVE_FEATURE
>
> 'perf check --feature' command is expected to have exit status of 1 if feature is
> built-in, and 0 if not, -2 if feature is not known.
>
> A global array 'supported_features' has also been introduced that can be
> used by other commands like 'perf version --build-options', so that
> new features can be added in one place, with the array
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tools/perf/Build                        |  1 +
>  tools/perf/Documentation/perf-check.txt | 53 ++++++++++++++
>  tools/perf/builtin-check.c              | 95 +++++++++++++++++++++++++
>  tools/perf/builtin.h                    | 47 ++++++++++++
>  tools/perf/perf.c                       |  1 +
>  5 files changed, 197 insertions(+)
>  create mode 100644 tools/perf/Documentation/perf-check.txt
>  create mode 100644 tools/perf/builtin-check.c
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index aa7623622834..a55a797c1b5f 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -1,5 +1,6 @@
>  perf-y += builtin-bench.o
>  perf-y += builtin-annotate.o
> +perf-y += builtin-check.o
>  perf-y += builtin-config.o
>  perf-y += builtin-diff.o
>  perf-y += builtin-evlist.o
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> new file mode 100644
> index 000000000000..ee4331838be5
> --- /dev/null
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -0,0 +1,53 @@
> +perf-check(1)
> +===============
> +
> +NAME
> +----
> +perf-check - check features in perf
> +
> +SYNOPSIS
> +--------
> +'perf check' [--feature]
> +
> +DESCRIPTION
> +-----------
> +With no options given, the 'perf check' just prints the perf version
> +on the standard output.
> +
> +If the option '--feature' is given, then status of feature is printed
> +on the standard output, ie. whether it is compiled-in/built-in or not
> +
> +OPTIONS
> +-------
> +--feature::
> +        Print whether a feature is compiled-in or not. A feature name/macro is
> +        required to be passed after this flag
> +
> +        Example Usage:
> +                perf check --feature libtraceevent
> +                perf check --feature HAVE_LIBTRACEEVENT
> +
> +        Supported feature names/macro:
> +                dwarf      /  HAVE_DWARF_SUPPORT
> +                dwarf_getlocations  /  HAVE_DWARF_GETLOCATIONS_SUPPORT
> +                libaudit   /  HAVE_LIBAUDIT_SUPPORT
> +                syscall_table       /  HAVE_SYSCALL_TABLE_SUPPORT
> +                libbfd     /  HAVE_LIBBFD_SUPPORT
> +                debuginfod /  HAVE_DEBUGINFOD_SUPPORT
> +                libelf     /  HAVE_LIBELF_SUPPORT
> +                libnuma    /  HAVE_LIBNUMA_SUPPORT
> +                numa_num_possible_cpus  /  HAVE_LIBNUMA_SUPPORT
> +                libperl    /  HAVE_LIBPERL_SUPPORT
> +                libpython  /  HAVE_LIBPYTHON_SUPPORT
> +                libslang   /  HAVE_SLANG_SUPPORT
> +                libcrypto  /  HAVE_LIBCRYPTO_SUPPORT
> +                libunwind  /  HAVE_LIBUNWIND_SUPPORT
> +                libdw-dwarf-unwind  /  HAVE_DWARF_SUPPORT
> +                zlib       /  HAVE_ZLIB_SUPPORT
> +                lzma       /  HAVE_LZMA_SUPPORT
> +                get_cpuid  /  HAVE_AUXTRACE_SUPPORT
> +                bpf        /  HAVE_LIBBPF_SUPPORT
> +                aio        /  HAVE_AIO_SUPPORT
> +                zstd       /  HAVE_ZSTD_SUPPORT
> +                libpfm4    /  HAVE_LIBPFM
> +                libtraceevent      /  HAVE_LIBTRACEEVENT
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> new file mode 100644
> index 000000000000..3dee72426c30
> --- /dev/null
> +++ b/tools/perf/builtin-check.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "builtin.h"
> +#include "color.h"
> +#include "util/debug.h"
> +#include "util/header.h"
> +#include <tools/config.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <subcmd/parse-options.h>
> +
> +struct check {
> +       const char *feature;
> +};
> +
> +static struct check check;
> +
> +static struct option check_options[] = {
> +       OPT_STRING(0, "feature", &check.feature, NULL, "check if a feature is built in"),
> +       OPT_END(),
> +};
> +
> +static const char * const check_usage[] = {
> +       "perf check [<options>]",
> +       NULL
> +};
> +
> +static void on_off_print(const char *status)
> +{
> +       printf("[ ");
> +
> +       if (!strcmp(status, "OFF"))
> +               color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> +       else
> +               color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> +
> +       printf(" ]");
> +}
> +
> +static void status_print(const char *name, const char *macro,
> +                        const char *status)
> +{
> +       printf("%22s: ", name);
> +       on_off_print(status);
> +       printf("  # %s\n", macro);
> +}
> +
> +#define STATUS(feature)                                   \
> +do {                                                      \
> +       if (feature.is_builtin)                               \
> +               status_print(feature.name, feature.macro, "on");  \
> +       else                                                  \
> +               status_print(feature.name, feature.macro, "OFF"); \
> +} while (0)
> +
> +/**
> + * check whether "feature" is built-in with perf
> + * returns:./perf annotate --data-type --type-stat -k vmlinux -d '[kernel.kallsyms]' --objdump=llvm-objdump
> + *   -1: Feature not known
> + *    0: Built-in
> + *    1: NOT Built in
> + */
> +static int has_support(const char *feature)
> +{
> +       int res = -1;
> +
> +       for (int i = 0; supported_features[i].name; ++i) {
> +               if ((strcmp(feature, supported_features[i].name) == 0) ||
> +                       (strcmp(feature, supported_features[i].macro) == 0)) {
> +                       res = supported_features[i].is_builtin;
> +                       STATUS(supported_features[i]);
> +                       break;
> +               }
> +       }
> +
> +       if (res == -1) {
> +               color_fprintf(stdout, PERF_COLOR_RED, "Feature not known: %s", feature);
> +               return -2;

return -1 ??  It doesn't match with the comment.


> +       }
> +
> +       return !res;
> +}
> +
> +int cmd_check(int argc, const char **argv)
> +{
> +       argc = parse_options(argc, argv, check_options, check_usage,
> +                            PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +       printf("perf check %s\n", perf_version_string);
> +
> +       if (check.feature)
> +               return has_support(check.feature);
> +
> +       return 0;
> +}
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index f2ab5bae2150..6683ea6d3b60 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -2,6 +2,52 @@
>  #ifndef BUILTIN_H
>  #define BUILTIN_H
>
> +#include <stddef.h>
> +#include <linux/compiler.h>
> +#include <tools/config.h>
> +
> +struct feature_support {
> +       const char *name;
> +       const char *macro;
> +       int is_builtin;
> +};
> +
> +#define FEATURE_SUPPORT(name_, macro_) { \
> +       .name = name_,                       \
> +       .macro = #macro_,                    \
> +       .is_builtin = IS_BUILTIN(macro_) }
> +
> +static struct feature_support supported_features[] __maybe_unused = {

Hmm.. do you want it in a header file?
I'm afraid it'd duplicate the entire array for any .c files that
include this header.


> +       FEATURE_SUPPORT("dwarf", HAVE_DWARF_SUPPORT),
> +       FEATURE_SUPPORT("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> +#ifndef HAVE_SYSCALL_TABLE_SUPPORT

Do we really need this #ifndef?

Thanks,
Namhyung


> +       FEATURE_SUPPORT("libaudit", HAVE_LIBAUDIT_SUPPORT),
> +#endif
> +       FEATURE_SUPPORT("syscall_table", HAVE_SYSCALL_TABLE_SUPPORT),
> +       FEATURE_SUPPORT("libbfd", HAVE_LIBBFD_SUPPORT),
> +       FEATURE_SUPPORT("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
> +       FEATURE_SUPPORT("libelf", HAVE_LIBELF_SUPPORT),
> +       FEATURE_SUPPORT("libnuma", HAVE_LIBNUMA_SUPPORT),
> +       FEATURE_SUPPORT("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
> +       FEATURE_SUPPORT("libperl", HAVE_LIBPERL_SUPPORT),
> +       FEATURE_SUPPORT("libpython", HAVE_LIBPYTHON_SUPPORT),
> +       FEATURE_SUPPORT("libslang", HAVE_SLANG_SUPPORT),
> +       FEATURE_SUPPORT("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> +       FEATURE_SUPPORT("libunwind", HAVE_LIBUNWIND_SUPPORT),
> +       FEATURE_SUPPORT("libdw-dwarf-unwind", HAVE_DWARF_SUPPORT),
> +       FEATURE_SUPPORT("zlib", HAVE_ZLIB_SUPPORT),
> +       FEATURE_SUPPORT("lzma", HAVE_LZMA_SUPPORT),
> +       FEATURE_SUPPORT("get_cpuid", HAVE_AUXTRACE_SUPPORT),
> +       FEATURE_SUPPORT("bpf", HAVE_LIBBPF_SUPPORT),
> +       FEATURE_SUPPORT("aio", HAVE_AIO_SUPPORT),
> +       FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
> +       FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
> +       FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> +
> +       // this should remain at end, to know the array end
> +       FEATURE_SUPPORT(NULL, _)
> +};
> +
>  void list_common_cmds_help(void);
>  const char *help_unknown_cmd(const char *cmd);
>
> @@ -9,6 +55,7 @@ int cmd_annotate(int argc, const char **argv);
>  int cmd_bench(int argc, const char **argv);
>  int cmd_buildid_cache(int argc, const char **argv);
>  int cmd_buildid_list(int argc, const char **argv);
> +int cmd_check(int argc, const char **argv);
>  int cmd_config(int argc, const char **argv);
>  int cmd_c2c(int argc, const char **argv);
>  int cmd_diff(int argc, const char **argv);
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index d3fc8090413c..83dc0ac42fdb 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -50,6 +50,7 @@ static struct cmd_struct commands[] = {
>         { "archive",    NULL,   0 },
>         { "buildid-cache", cmd_buildid_cache, 0 },
>         { "buildid-list", cmd_buildid_list, 0 },
> +       { "check", cmd_check, 0 },
>         { "config",     cmd_config,     0 },
>         { "c2c",        cmd_c2c,        0 },
>         { "diff",       cmd_diff,       0 },
> --
> 2.41.0
>
