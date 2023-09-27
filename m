Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0C7B0BE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjI0SXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjI0SXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:23:45 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB779F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1695839020;
        bh=f9XvLelyD4gxKFC2vKNlyuGFWTV9NfoMmqk3Bkzrlbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kq+LwBeHhDuIhEb/VDL8AmCp3e0SIS4iC8rvaJAYIcK1JWZfJ4dLF1S/d4MaY+FLd
         NBLo2oQ2L6keX3rykloGBbzEee1tpKp8DAS+UfcwsjDvfykfJWrh4GQCfHYdi8Bhn/
         Eui35lwChy1bWk516z6fbsESjAjmuzxeKdO+MnII=
Date:   Wed, 27 Sep 2023 20:23:39 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
Message-ID: <5d4d14f5-b90d-4fd7-865e-0d64b8520c0e@t-8ch.de>
References: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
 <20230926133647.467179-2-rodrigo@sdfg.com.ar>
 <e8ed17e6-8eb3-404d-9669-5e5b413904ed@t-8ch.de>
 <c658a72a-b3f6-4504-a940-7ff946c81559@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c658a72a-b3f6-4504-a940-7ff946c81559@sdfg.com.ar>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-27 15:06:03+0200, Rodrigo Campos wrote:
> On 9/27/23 01:30, Thomas Weißschuh wrote:
> > thanks for your patch!
> 
> Thank you for nolibc :)

You need to thank Willy for the most part :-)

> > On 2023-09-26 15:36:47+0200, Rodrigo Campos wrote:
> > > Centos-7 doesn't include statx on its linux/stat.h file. So, let's just
> > > define it if the include doesn't define STATX_BASIC_STATS.
> > 
> > Could you mention which version of the kernel headers you compiled this
> > with and with which version you tested it?
> 
> It was on CI using vagrant, it is:
> 
>  kernel-headers   x86_64 3.10.0-1160.99.1.el7
> 
> And this kernel:
> 
> Linux cirrus-task-6368858685046784 3.10.0-1160.95.1.el7.x86_64 #1 SMP Mon
> Jul 24 13:59:37 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> 
> Luckily this info is exposed in their CI easily, see here:
> https://cirrus-ci.com/task/6368858685046784?logs=host_info#L1. The host_info
> and "Run install_dependencies" have this kind of info.
> 
> > Also which is the exact revision you use to extract nolibc?
> 
> As from Linux 6.6-rc3 (6465e260f48790807eef06b583b38ca9789b6072)
> 
> > Does nolibc actually support statx()/stat() on centos-7 with these changes?
> 
> Oh, I haven't tried that, sorry I didn't mention. We are basically just
> using exceve(), but the thing is that "sutrct statx" and "STATX_BASIC_STATS"
> are used in sys.h, so compilation fails.
> 
> And just a forward declaration of the struct won't help, as it is not just a
> pointer, in stat() we instantiate it.
> 
> 
> > I'm asking because I tried to reproduce it and for me CentOS 7 with
> > kernel-headers 3.10.0-1160.99.1.el7 doesn't define __NR_statx.
> > Without this symbol the statx() and stat() functions should just always
> > return -ENOSYS.
> > It seems a bit wasteful to introduce 200 new lines of code for a "feature"
> > that will not do anything.
> > 
> > FYI the hard requirement for the statx syscall is fairly new, it was
> > added in commit af93807eaef6 ("tools/nolibc: remove the old sys_stat support").
> 
> Oh, great pointer, thanks!
> 
> > As you are vendoring nolibc, if you don't need stat/statx support in
> > for your usecase you could drop the support for it in your vendored
> > copy.
> > Or we try to reintroduce compatibility for stat() without the statx()
> > syscall. But given the really limited applicability, personally I'm
> > against that.
> 
> We can definitely remove that struct statx bits in our vendoring. It will
> simplify updating if we don't have to patch it, so if we can't include a fix
> in nolibc, I think we will continue doing the hack ourselves and that is
> all. It is not too bad :)

How often are you planning on updating your vendoring?
In the timeframe before you are dropping centos-7 support?

The "nice" thing about the breakage is that it will break loudly during
compilation so it will be easy to notice and fix it up.

> I don't think it is worth for nolibc, at least for this use case, to
> reintroduce compatibility for stat() without statx().

It wouldn't even be full compatibility. The code would compile but be
unusuable for stat()/statx(). And I don't think any application expects
stat() to return -ENOSYS.

It's a bit ugly code to support a kernel that has been EOL upstream for
six years for a fairly specific usecase.
But who knows, maybe Willy has a soft spot for the 3.10 kernel :-)
Let's wait for his input.

> For now we are work-arounding it by doing basically the same thing I'm doing
> here:
> 	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/xstat.h
> 
> We then include this file before nolibc.h, and then the type works as fine:
> 	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/_dmz.c
> 
> Would it be acceptable for nolibc if I just define what we use:
>  * struct statx
>  * struct statx_timestamp (used inside struct statx)
>  * STATX_BASIC_STATS (or STATX_* constants too, as you prefer)

Without __NR_statx this would still only result in dead code.

*IF* we want to fix/work around this in nolibc it would be more like

  #ifdef __NR_statx
  
  /* whatever was done before */
  
  #else
  
  int stat(const char *path, struct stat *buf)
  {
  	return __sysret(-ENOSYS);
  }
  
  #endif

Or we drop the #else completely to make it obvious for applications that
stat() will just not work.

> > 
> > Some more notes below.
> > 
> > > This makes nolibc work on centos-7 just fine, before this patch it
> > > failed with:
> > > 
> > > 	nolibc/sys.h:987:78: warning: ‘struct statx’ declared inside parameter list [enabled by default]
> > > 	 int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> > > 
> > > Please note that while on types.h we can still include linux/stat.h
> > > and it won't cause any issues, it seems simpler if we just always
> > > include "statx.h" instead of that file and be safe. That is why I
> > > changed types.h too.
> > 
> > All of nolibc will end up included into the same namespace by design.
> > It seems weird that it would make a difference from where this file is
> > included.
> 
> No, sorry, I just wanted to say that we should include "statx.h" instead of
> "<linux/stat.h>" as that does the define for old distros that don't do it.
> 
> It is true that we can include "statx.h" in nolibc.h and that should do the
> trick too.

Got it.

> > > diff --git tools/include/nolibc/statx.h tools/include/nolibc/statx.h
> > > new file mode 100644
> > > index 000000000000..d05528754154
> > > --- /dev/null
> > > +++ tools/include/nolibc/statx.h
> > > @@ -0,0 +1,218 @@
> > 
> > Below you mention that this was copied from
> > tools/include/uapi/linux/stat.h, but...
> > 
> > > +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> > 
> > The original code was "GPL-2.0 WITH Linux-syscall-note".
> 
> Oh, great point, sorry I didn't realize. What should we do, then?
> 
> Do you know what is the proper way to just define the same types here (i.e.
> struct statx and what I mentioned is what we really need a few lines above)?

Not entirely sure. Personally I would just try to avoid all of it :-)

> > > +#define S_IFMT  00170000
> > > +#define S_IFSOCK 0140000
> > > +#define S_IFLNK	 0120000
> > > +#define S_IFREG  0100000
> > > +#define S_IFBLK  0060000
> > > +#define S_IFDIR  0040000
> > > +#define S_IFCHR  0020000
> > > +#define S_IFIFO  0010000
> > > +#define S_ISUID  0004000
> > > +#define S_ISGID  0002000
> > > +#define S_ISVTX  0001000
> > > +
> > > +#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
> > > +#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
> > > +#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
> > > +#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
> > > +#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
> > > +#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
> > > +#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
> > > +
> > > +#define S_IRWXU 00700
> > > +#define S_IRUSR 00400
> > > +#define S_IWUSR 00200
> > > +#define S_IXUSR 00100
> > > +
> > > +#define S_IRWXG 00070
> > > +#define S_IRGRP 00040
> > > +#define S_IWGRP 00020
> > > +#define S_IXGRP 00010
> > > +
> > > +#define S_IRWXO 00007
> > > +#define S_IROTH 00004
> > > +#define S_IWOTH 00002
> > > +#define S_IXOTH 00001
> > 
> > We already have all of these in types.h.
> 
> Yes, I realized but I thought it was simpler conceptually if we include the
> whole file. This way there are no differences if the host has this or not.

They are already defined inside types.h of nolibc itself.
So it wouldn't matter if the host has it.

> I can definitely remove this if you prefer and just define what we strictly
> need.
> 
> > > diff --git tools/include/nolibc/sys.h tools/include/nolibc/sys.h
> > > index fdb6bd6c0e2f..d3e45793682a 100644
> > > --- tools/include/nolibc/sys.h
> > > +++ tools/include/nolibc/sys.h
> > > @@ -20,9 +20,9 @@
> > >   #include <linux/time.h>
> > >   #include <linux/auxvec.h>
> > >   #include <linux/fcntl.h> /* for O_* and AT_* */
> > > -#include <linux/stat.h>  /* for statx() */
> > 
> > So this means that compatibility with user applications that also
> > include <linux/stat.h> on their own is broken?
> > That would not be good.
> 
> 
> Hmm, no, it just means that if we want to get struct statx in all distros,
> including centos-7, we should use the other include that will define it for
> centos.
> 
> We can keep this here as long as we also include xstat.h, in some other
> part.

Got it.
