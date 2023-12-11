Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90BB80D4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbjLKRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjLKRy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:54:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F2DD64
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:54:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3216FC433C7;
        Mon, 11 Dec 2023 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702317249;
        bh=Ae4/apPtu2qVDtyWUKMc0acmOcBz6ycK0QKMshewLZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k8UONH8Fsvpv9P6sElnOdB4OtaxmloX5YxC+LhyNZSRMQT/RqeMPedezuwG9By+Jm
         afGXxFlDIbkOr08f4Cws/GXwu1g0kfI4mF96RCBwikTxh/SZqeQEoc5JLyXi3+acfT
         I9d080O/DxQzAkCqBDltyAauDgZp1sjR7MWFi5VLPjdBOuVo0S4cFdYfp5A09k900R
         SWcd9+dOf7VraOr2ZRIxaslG/4DtGpoiMzOsZT+Mx5n1cmQv5bBVThR1sVnQvYK913
         4CFppwji9kaeiavIM0AGPhD4LdWuQ0GTCr+hClGQBG2KUybtCyzjmJpCaXiiAG6wY4
         ix2z/5I1qSAgA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1efb9571b13so2919634fac.2;
        Mon, 11 Dec 2023 09:54:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzXbYIM8vBgORFmH6f9b1v181dC/VQ7q7v8W0N20CU9mJlW3WIV
        BjohppZMCnICQi2NQOHTugmb5WA1ez9bxxj7C68=
X-Google-Smtp-Source: AGHT+IH3YWplGc8affe6Z5G16cCMbxz0Ejp/HQYPpcSEYz2Jv1Vgz6V06YKP4LE8oV6w3fjJNR0JuEBZ2zTCUkgWph8=
X-Received: by 2002:a05:6870:d10a:b0:1fb:7f3:252b with SMTP id
 e10-20020a056870d10a00b001fb07f3252bmr4670680oac.7.1702317248614; Mon, 11 Dec
 2023 09:54:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQAAZXV3i1sM0ZTFDC3eOaDWBVzOV9FmiLUM5YoX=89Wg@mail.gmail.com>
 <20231210070533.925534-1-xujialu@vimux.org> <20231210070533.925534-2-xujialu@vimux.org>
In-Reply-To: <20231210070533.925534-2-xujialu@vimux.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 Dec 2023 02:53:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=rnVqJYfoo-t7EhC8G4E20r1B-xQCKF9W2zgyigi-2w@mail.gmail.com>
Message-ID: <CAK7LNAS=rnVqJYfoo-t7EhC8G4E20r1B-xQCKF9W2zgyigi-2w@mail.gmail.com>
Subject: Re: [PATCH v5] gen_compile_commands.py: fix path resolve with
 symlinks in it
To:     Jialu Xu <xujialu@vimux.org>
Cc:     justinstitt@google.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com
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

On Sun, Dec 10, 2023 at 4:06=E2=80=AFPM Jialu Xu <xujialu@vimux.org> wrote:
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
>     /path/to/src/drivers/hdf/khdf/manager/../../../../framework/core/mana=
ger/src/devmgr_service.c
>
> 3. os.path.abspath returns "/path/to/src/framework/core/manager/src/devmg=
r_service.c", not correct:
>
>     # ./scripts/clang-tools/gen_compile_commands.py
>     INFO: Could not add line from ./framework/core/manager/src/.devmgr_se=
rvice.o.cmd: File \
>         /path/to/src/framework/core/manager/src/devmgr_service.c not foun=
d
>
> Use os.path.realpath(), which resolves the symlinks and normalizes the pa=
ths correctly.
>
>     # cat compile_commands.json
>     ...
>     {
>       "command": ...
>       "directory": ...
>       "file": "/path/to/bla/drivers/hdf_core/framework/core/manager/src/d=
evmgr_service.c"
>     },
>     ...
>
> Also fix it in parse_arguments().
>
> Signed-off-by: Jialu Xu <xujialu@vimux.org>



Applied to linux-kbuild. Thanks.




--=20
Best Regards
Masahiro Yamada
