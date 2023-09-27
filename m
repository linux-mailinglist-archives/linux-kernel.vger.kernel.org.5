Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C2F7B04EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjI0NGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjI0NGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:06:14 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4061BF4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:06:12 -0700 (PDT)
Received: from [IPV6:2a02:8109:aa40:4e0:b5c6:9671:3477:8fde]
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 27 Sep 2023 13:06:05 +0000
Message-ID: <c658a72a-b3f6-4504-a940-7ff946c81559@sdfg.com.ar>
Date:   Wed, 27 Sep 2023 15:06:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools/nolibc: Add workarounds for centos-7
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
References: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
 <20230926133647.467179-2-rodrigo@sdfg.com.ar>
 <e8ed17e6-8eb3-404d-9669-5e5b413904ed@t-8ch.de>
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <e8ed17e6-8eb3-404d-9669-5e5b413904ed@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 01:30, Thomas Weißschuh wrote:
> thanks for your patch!

Thank you for nolibc :)

> On 2023-09-26 15:36:47+0200, Rodrigo Campos wrote:
>> Centos-7 doesn't include statx on its linux/stat.h file. So, let's just
>> define it if the include doesn't define STATX_BASIC_STATS.
> 
> Could you mention which version of the kernel headers you compiled this
> with and with which version you tested it?

It was on CI using vagrant, it is:

  kernel-headers   x86_64 3.10.0-1160.99.1.el7

And this kernel:

Linux cirrus-task-6368858685046784 3.10.0-1160.95.1.el7.x86_64 #1 SMP 
Mon Jul 24 13:59:37 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux

Luckily this info is exposed in their CI easily, see here: 
https://cirrus-ci.com/task/6368858685046784?logs=host_info#L1. The 
host_info and "Run install_dependencies" have this kind of info.

> Also which is the exact revision you use to extract nolibc?

As from Linux 6.6-rc3 (6465e260f48790807eef06b583b38ca9789b6072)

> Does nolibc actually support statx()/stat() on centos-7 with these changes?

Oh, I haven't tried that, sorry I didn't mention. We are basically just 
using exceve(), but the thing is that "sutrct statx" and 
"STATX_BASIC_STATS" are used in sys.h, so compilation fails.

And just a forward declaration of the struct won't help, as it is not 
just a pointer, in stat() we instantiate it.


> I'm asking because I tried to reproduce it and for me CentOS 7 with
> kernel-headers 3.10.0-1160.99.1.el7 doesn't define __NR_statx.
> Without this symbol the statx() and stat() functions should just always
> return -ENOSYS.
> It seems a bit wasteful to introduce 200 new lines of code for a "feature"
> that will not do anything.
> 
> FYI the hard requirement for the statx syscall is fairly new, it was
> added in commit af93807eaef6 ("tools/nolibc: remove the old sys_stat support").

Oh, great pointer, thanks!

> As you are vendoring nolibc, if you don't need stat/statx support in
> for your usecase you could drop the support for it in your vendored
> copy.
> Or we try to reintroduce compatibility for stat() without the statx()
> syscall. But given the really limited applicability, personally I'm
> against that.

We can definitely remove that struct statx bits in our vendoring. It 
will simplify updating if we don't have to patch it, so if we can't 
include a fix in nolibc, I think we will continue doing the hack 
ourselves and that is all. It is not too bad :)

I don't think it is worth for nolibc, at least for this use case, to 
reintroduce compatibility for stat() without statx().

For now we are work-arounding it by doing basically the same thing I'm 
doing here:
	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/xstat.h

We then include this file before nolibc.h, and then the type works as fine:
	https://github.com/opencontainers/runc/blob/96a61d3bf0dcc26343bfafe5112934d73d280dd3/libcontainer/dmz/_dmz.c

Would it be acceptable for nolibc if I just define what we use:
  * struct statx
  * struct statx_timestamp (used inside struct statx)
  * STATX_BASIC_STATS (or STATX_* constants too, as you prefer)

?

> 
> Some more notes below.
> 
>> This makes nolibc work on centos-7 just fine, before this patch it
>> failed with:
>>
>> 	nolibc/sys.h:987:78: warning: ‘struct statx’ declared inside parameter list [enabled by default]
>> 	 int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
>>
>> Please note that while on types.h we can still include linux/stat.h
>> and it won't cause any issues, it seems simpler if we just always
>> include "statx.h" instead of that file and be safe. That is why I
>> changed types.h too.
> 
> All of nolibc will end up included into the same namespace by design.
> It seems weird that it would make a difference from where this file is
> included.

No, sorry, I just wanted to say that we should include "statx.h" instead 
of "<linux/stat.h>" as that does the define for old distros that don't 
do it.

It is true that we can include "statx.h" in nolibc.h and that should do 
the trick too.

>> diff --git tools/include/nolibc/statx.h tools/include/nolibc/statx.h
>> new file mode 100644
>> index 000000000000..d05528754154
>> --- /dev/null
>> +++ tools/include/nolibc/statx.h
>> @@ -0,0 +1,218 @@
> 
> Below you mention that this was copied from
> tools/include/uapi/linux/stat.h, but...
> 
>> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> 
> The original code was "GPL-2.0 WITH Linux-syscall-note".

Oh, great point, sorry I didn't realize. What should we do, then?

Do you know what is the proper way to just define the same types here 
(i.e. struct statx and what I mentioned is what we really need a few 
lines above)?

>> +#define S_IFMT  00170000
>> +#define S_IFSOCK 0140000
>> +#define S_IFLNK	 0120000
>> +#define S_IFREG  0100000
>> +#define S_IFBLK  0060000
>> +#define S_IFDIR  0040000
>> +#define S_IFCHR  0020000
>> +#define S_IFIFO  0010000
>> +#define S_ISUID  0004000
>> +#define S_ISGID  0002000
>> +#define S_ISVTX  0001000
>> +
>> +#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
>> +#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
>> +#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
>> +#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
>> +#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
>> +#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
>> +#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
>> +
>> +#define S_IRWXU 00700
>> +#define S_IRUSR 00400
>> +#define S_IWUSR 00200
>> +#define S_IXUSR 00100
>> +
>> +#define S_IRWXG 00070
>> +#define S_IRGRP 00040
>> +#define S_IWGRP 00020
>> +#define S_IXGRP 00010
>> +
>> +#define S_IRWXO 00007
>> +#define S_IROTH 00004
>> +#define S_IWOTH 00002
>> +#define S_IXOTH 00001
> 
> We already have all of these in types.h.

Yes, I realized but I thought it was simpler conceptually if we include 
the whole file. This way there are no differences if the host has this 
or not.

I can definitely remove this if you prefer and just define what we 
strictly need.

>> diff --git tools/include/nolibc/sys.h tools/include/nolibc/sys.h
>> index fdb6bd6c0e2f..d3e45793682a 100644
>> --- tools/include/nolibc/sys.h
>> +++ tools/include/nolibc/sys.h
>> @@ -20,9 +20,9 @@
>>   #include <linux/time.h>
>>   #include <linux/auxvec.h>
>>   #include <linux/fcntl.h> /* for O_* and AT_* */
>> -#include <linux/stat.h>  /* for statx() */
> 
> So this means that compatibility with user applications that also
> include <linux/stat.h> on their own is broken?
> That would not be good.


Hmm, no, it just means that if we want to get struct statx in all 
distros, including centos-7, we should use the other include that will 
define it for centos.

We can keep this here as long as we also include xstat.h, in some other 
part.




Best,
Rodrigo
