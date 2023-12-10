Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6647380B933
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjLJFwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 00:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:52:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F35F2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 21:52:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA205C433C9;
        Sun, 10 Dec 2023 05:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702187570;
        bh=WRkgdiINfUAiL/A802TZAKcyuKt/HNwO0NadgthM0XM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CVMAn78/0pcwJm9Swlh6ENxYmlEf5810HmxwU5GJ5IUsA3e+oCLZlASL9Czp7oMWd
         MNyADFHEYhXdavBma84hoZXHmpHBGbGtROuAECpQux4PnbmhdRKbZUumlSFEwA/vpG
         GwjDPCOhFNuqNAhF8MQ5rt3yk//dPO4ukN2/HTaqUqOgY1n1k2sTuthou2Ol3meZiP
         1KzKixUXzGHQtjXyKYEfJRZ7XFaG5mSN/MZs5bA1y1jD5cGTVQN9W9HSBeJU0ZXtS/
         ZvzmKtGUBw0NVZGBGEzyR//cvb92TfrACuQDXW+TIIr8yM60V7g3KcoPPD/EYmMGvZ
         V9kATKjg4pIww==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6d9d59d6676so2492872a34.1;
        Sat, 09 Dec 2023 21:52:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxNkLk0DcOeQai0KCBYiypaHm0rl2ioF6mitfrppqo68FvMV4XF
        9uAMh7oo0BtN6HJgCbv+n/7GsgQ5Lg+tXSEzecQ=
X-Google-Smtp-Source: AGHT+IGMEPLcTrEakPY5e88xnadIxF/aNSR+V3uGs428wU82D8C4HwBkw8i+6e3+0ElsADR7avi0hu6xOrk5B9eIwJg=
X-Received: by 2002:a05:6871:114:b0:1fb:75b:2fc2 with SMTP id
 y20-20020a056871011400b001fb075b2fc2mr3015994oab.89.1702187570316; Sat, 09
 Dec 2023 21:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20231205165648.GA391810@dev-arch.thelio-3990X> <20231206012441.840082-1-xujialu@vimux.org>
In-Reply-To: <20231206012441.840082-1-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 10 Dec 2023 14:52:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQAAZXV3i1sM0ZTFDC3eOaDWBVzOV9FmiLUM5YoX=89Wg@mail.gmail.com>
Message-ID: <CAK7LNAQAAZXV3i1sM0ZTFDC3eOaDWBVzOV9FmiLUM5YoX=89Wg@mail.gmail.com>
Subject: Re: [PATCH v4] gen_compile_commands.py: fix path resolve with
 symlinks in it
To:     Jialu Xu <xujialu@vimux.org>
Cc:     nathan@kernel.org, justinstitt@google.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, morbo@google.com, ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 10:26=E2=80=AFAM Jialu Xu <xujialu@vimux.org> wrote:
>
> When a path contains relative symbolic links, os.path.abspath() might
> not follow the symlinks and instead return the absolute path with just
> the relative paths resolved, resulting in an incorrect path.
>
> 1. Say "drivers/hdf/" has some symlinks:
>
>     # ls -l drivers/hdf/
>     total 364
>     drwxrwxr-x 2 ...   4096 ... evdev
>     lrwxrwxrwx 1 ...     44 ... framework -> ../../../../../../drivers/hd=
f_core/framework
>     -rw-rw-r-- 1 ... 359010 ... hdf_macro_test.h
>     lrwxrwxrwx 1 ...     55 ... inner_api -> ../../../../../../drivers/hd=
f_core/interfaces/inner_api
>     lrwxrwxrwx 1 ...     53 ... khdf -> ../../../../../../drivers/hdf_cor=
e/adapter/khdf/linux
>     -rw-r--r-- 1 ...     74 ... Makefile
>     drwxrwxr-x 3 ...   4096 ... wifi
>
> 2. One .cmd file records that:
>
>     # head -1 ./framework/core/manager/src/.devmgr_service.o.cmd
>     cmd_drivers/hdf/khdf/manager/../../../../framework/core/manager/src/d=
evmgr_service.o :=3D ... \
>     /path/to/out/drivers/hdf/khdf/manager/../../../../framework/core/mana=
ger/src/devmgr_service.c
>
> 3. os.path.abspath returns "/path/to/out/framework/core/manager/src/devmg=
r_service.c", not correct:
>
>     # ./scripts/clang-tools/gen_compile_commands.py
>     INFO: Could not add line from ./framework/core/manager/src/.devmgr_se=
rvice.o.cmd: File \
>         /path/to/out/framework/core/manager/src/devmgr_service.c not foun=
d
>
> Use pathlib.Path.resolve(), which resolves the symlinks and normalizes
> the paths correctly.
>
>     # cat compile_commands.json
>     ...
>     {
>       "command": ...
>       "directory": ...
>       "file": "/path/to/blabla/drivers/hdf_core/framework/core/manager/sr=
c/devmgr_service.c"
>     },
>     ...
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jialu Xu <xujialu@vimux.org>
> ---
>  scripts/clang-tools/gen_compile_commands.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-=
tools/gen_compile_commands.py
> index 180952fb91c1b..99e28b7152c19 100755
> --- a/scripts/clang-tools/gen_compile_commands.py
> +++ b/scripts/clang-tools/gen_compile_commands.py
> @@ -11,6 +11,7 @@ import argparse
>  import json
>  import logging
>  import os
> +from pathlib import Path
>  import re
>  import subprocess
>  import sys
> @@ -172,8 +173,9 @@ def process_line(root_directory, command_prefix, file=
_path):
>      # by Make, so this code replaces the escaped version with '#'.
>      prefix =3D command_prefix.replace('\#', '#').replace('$(pound)', '#'=
)
>
> -    # Use os.path.abspath() to normalize the path resolving '.' and '..'=
 .
> -    abs_path =3D os.path.abspath(os.path.join(root_directory, file_path)=
)
> +    # Make the path absolute, resolving all symlinks on the way and also=
 normalizing it.
> +    # Convert Path object to a string because 'PosixPath' is not JSON se=
rializable.
> +    abs_path =3D str(Path(root_directory, file_path).resolve())
>      if not os.path.exists(abs_path):
>          raise ValueError('File %s not found' % abs_path)
>      return {





Is there any reason why you didn't simply replace
os.path.abspath() with os.path.realpath() ?



This patch uses pathlib.Path() just in one place,
leaving many call-sites of os.path.*() functions.

If it is just a matter of your preference,
you need to convert os.path.*() for consistency
(as a follow-up patch).





I see one more os.path.abspath()



    return (args.log_level,
            os.path.abspath(args.directory),
            args.output,
            args.ar,
            args.paths if len(args.paths) > 0 else [args.directory])




Does it cause a similar issue for the 'directory' field
with symbolic link jungles?







--
Best Regards
Masahiro Yamada
