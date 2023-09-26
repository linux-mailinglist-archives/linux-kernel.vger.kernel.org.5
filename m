Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70257AF728
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjI0AOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjI0AMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:12:40 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C181F2A8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1695771029;
        bh=MbrBGLxP+0Stq0F10v63Xe15gOAo5JV50TCT1Ux7SP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMQfIFhVOG1WEgplNfBuehwT9eOc4eMw0UaR/IhOIewXYTTeJgZi0HeV/Kkx/0lU4
         xUcL1blLHdBHij5VNNzhUAMrT2fU+EB66Xn8faua+DaVX+d5Gm54EJsQkewvSfDuRV
         MD58sa5IYyzwONRABNLDX/hWmaAB/aKl1OydQ6uc=
Date:   Wed, 27 Sep 2023 01:30:28 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
Message-ID: <e8ed17e6-8eb3-404d-9669-5e5b413904ed@t-8ch.de>
References: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
 <20230926133647.467179-2-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926133647.467179-2-rodrigo@sdfg.com.ar>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

thanks for your patch!

Some comments below.

On 2023-09-26 15:36:47+0200, Rodrigo Campos wrote:
> Centos-7 doesn't include statx on its linux/stat.h file. So, let's just
> define it if the include doesn't define STATX_BASIC_STATS.

Could you mention which version of the kernel headers you compiled this
with and with which version you tested it?
Also which is the exact revision you use to extract nolibc?
Does nolibc actually support statx()/stat() on centos-7 with these changes?

I'm asking because I tried to reproduce it and for me CentOS 7 with 
kernel-headers 3.10.0-1160.99.1.el7 doesn't define __NR_statx.
Without this symbol the statx() and stat() functions should just always
return -ENOSYS.
It seems a bit wasteful to introduce 200 new lines of code for a "feature"
that will not do anything.

FYI the hard requirement for the statx syscall is fairly new, it was
added in commit af93807eaef6 ("tools/nolibc: remove the old sys_stat support").

As you are vendoring nolibc, if you don't need stat/statx support in
for your usecase you could drop the support for it in your vendored
copy.
Or we try to reintroduce compatibility for stat() without the statx()
syscall. But given the really limited applicability, personally I'm
against that.

Some more notes below.

> This makes nolibc work on centos-7 just fine, before this patch it
> failed with:
> 
> 	nolibc/sys.h:987:78: warning: ‘struct statx’ declared inside parameter list [enabled by default]
> 	 int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> 
> Please note that while on types.h we can still include linux/stat.h
> and it won't cause any issues, it seems simpler if we just always
> include "statx.h" instead of that file and be safe. That is why I
> changed types.h too.

All of nolibc will end up included into the same namespace by design.
It seems weird that it would make a difference from where this file is
included.

> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  tools/include/nolibc/statx.h | 218 +++++++++++++++++++++++++++++++++++
>  tools/include/nolibc/sys.h   |   2 +-
>  tools/include/nolibc/types.h |   2 +-
>  3 files changed, 220 insertions(+), 2 deletions(-)
>  create mode 100644 tools/include/nolibc/statx.h
> 
> diff --git tools/include/nolibc/statx.h tools/include/nolibc/statx.h
> new file mode 100644
> index 000000000000..d05528754154
> --- /dev/null
> +++ tools/include/nolibc/statx.h
> @@ -0,0 +1,218 @@

Below you mention that this was copied from 
tools/include/uapi/linux/stat.h, but...

> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */

The original code was "GPL-2.0 WITH Linux-syscall-note".

> +/*
> + * Compatibility header to allow using statx() on old distros.
> + * Copyright (C) 2023 Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>

Assuming copyright for copied code is not great.

> + */
> +
> +#ifndef _NOLIBC_STATX_H
> +#define _NOLIBC_STATX_H
> +
> +/* We should always include this file instead of linux/stat.h, so nolibc works
> + * in old distros too.
> + *
> + * The problem is centos-7, that doesn't have statx() defined in linux/stat.h.
> + * We can't include sys/stat.h because it creates conflicts, so let's just
> + * define it here.
> + * No other distros seem affected by this, so we can remove this file when it
> + * hits EOL (06/2024).
> + */
> +#include <linux/stat.h>  /* for statx() */
> +
> +#ifndef STATX_BASIC_STATS
> +
> +/* This is just a c&p from tools/include/uapi/linux/stat.h as it is in
> + * Linux 6.6-rc3.
> + * We don't need it all, but it's easier to just copy it all in case in the
> + * future we start using more of it, as we won't have CI running on centos-7.
> + */
> +#include <linux/types.h>
> +
> +#if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
> +
> +#define S_IFMT  00170000
> +#define S_IFSOCK 0140000
> +#define S_IFLNK	 0120000
> +#define S_IFREG  0100000
> +#define S_IFBLK  0060000
> +#define S_IFDIR  0040000
> +#define S_IFCHR  0020000
> +#define S_IFIFO  0010000
> +#define S_ISUID  0004000
> +#define S_ISGID  0002000
> +#define S_ISVTX  0001000
> +
> +#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
> +#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
> +#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
> +#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
> +#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
> +#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
> +#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
> +
> +#define S_IRWXU 00700
> +#define S_IRUSR 00400
> +#define S_IWUSR 00200
> +#define S_IXUSR 00100
> +
> +#define S_IRWXG 00070
> +#define S_IRGRP 00040
> +#define S_IWGRP 00020
> +#define S_IXGRP 00010
> +
> +#define S_IRWXO 00007
> +#define S_IROTH 00004
> +#define S_IWOTH 00002
> +#define S_IXOTH 00001

We already have all of these in types.h.

> +
> +#endif

> [..]

> diff --git tools/include/nolibc/sys.h tools/include/nolibc/sys.h
> index fdb6bd6c0e2f..d3e45793682a 100644
> --- tools/include/nolibc/sys.h
> +++ tools/include/nolibc/sys.h
> @@ -20,9 +20,9 @@
>  #include <linux/time.h>
>  #include <linux/auxvec.h>
>  #include <linux/fcntl.h> /* for O_* and AT_* */
> -#include <linux/stat.h>  /* for statx() */

So this means that compatibility with user applications that also
include <linux/stat.h> on their own is broken?
That would not be good.

>  #include <linux/prctl.h>
>  
> +#include "statx.h"       /* for statx() */
>  #include "arch.h"
>  #include "errno.h"
>  #include "types.h"

> [..]
