Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E841A806175
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbjLEWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjLEWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:10:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CEA183;
        Tue,  5 Dec 2023 14:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WFSiYAwur+U3RCrPnGEwUFixm4ostxp7ATn0GBN/ugg=; b=4CEtjMFyJF9oSIsasW5M/S7aaD
        SEP7hNIHAD4ZHeCURIL6pYOfzEldrdUGFNQh0mt5B49AATe+Fj0V/Asfu2xXYIEkmmV9ExuL+9On5
        RRc8dBZb4AsWmjlEirHbxYI6lhF0iWVsDkX+yEJ77X74vrfwqgdlu4BAGyZAXO+A0WuaZtQPU1WMb
        s69FYs8nxT08zMqZhSWkK7w+gcSYJlZUNRkPhOFBQ4jtPwNv8+/RSOOsB+ntgYECMf40aFmvuiGmE
        wLS4PPEggFvu7RV3hF112qXY7UV9a/u22uVvIJ0SF7ABxQT03k68OZv8+Vyr0fLdLRyUq/GFDLFut
        nXPygM1Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdce-008UYm-20;
        Tue, 05 Dec 2023 22:10:32 +0000
Message-ID: <34e27c57-fc18-4918-bf44-4f8a53825361@infradead.org>
Date:   Tue, 5 Dec 2023 14:10:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Content-Language: en-US
To:     Andy Shevchenko <andy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 14:01, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
>> On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> 
> ...
> 
>>>> IWYU is implemented using the IWYUScripts github repository which is a tool that is
>>>> currently undergoing development. These changes seek to improve build times.
>>>>
>>>> This change to lib/string.c resulted in a preprocessed size of
>>>> lib/string.i from 26371 lines to 5232 lines (-80%).
>>>
>>> It also breeds includes of asm/*.h, by the look of the output, which is
>>> not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
>>> outside of linux/uaccess.h is a bad idea.
>>
>> It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
>> convention here that I'm missing?
> 
> The mandatory ones can be used, but not all of them.
> In some cases you even must include asm and not linux
> (unaligned.h, byteorder.h, maybe others...).
> 
> As I told, it comes with experience, we lack of the
> respective documentation (or file which is good for
> automation checks, like with IWYU).

I have an unpublished Linux Best Known Practices txt file with
this "rule" and some other info that I have collected over a few
years. I wouldn't say that it's up to date. Anyway, it's copied below
FWIW.

-- 
~Randy

---

=================================
Linux Kernel Best Known Practices
=================================

N.B.: This is an evolving document.


No need to init variables in bss to 0. bss is always cleared to 0.

User interfaces should use explicit types (and hence type sizes)
instead of generic types like "long" or "unsigned int".
E.g.
Also see Documentation/process/botching-up-ioctls.rst

Unused fields of API structures or flags bits should be checked
for value 0 on input and warn if they are not 0.

submit-checklist Rule #1.

use the kmalloc() helpers for variable-size array allocations.

Generic drivers should not (do not) #include header files from
<asm-generic>. Only arch code and arch-specific drivers do that.

Don't use <asm/header.h> in generic driver code. Instead use
some <linux/header.h> that then #includes <asm/header.h>.
asm/ headers are implementation; linux/ headers are API.

Use __maybe_unused to driver suspend/resume functions instead of
surrounding them with #ifdef CONFIG_PM_SLEEP / #endif.

Many API families provide full stub support for when their
Kconfig option is disabled. This means that these APIs can still be used
with COMPILE_TEST. Examples of these API families are:
CONFIG_OF, <more>.

CONFIG_namespace belongs to Kconfig files. A driver or filesystem or
whatever should not have a local macro (or variable!) whose name
begins with "CONFIG_".

see Documentation/process/submit-checklist.rst

run scripts/checkpatch.pl

use Documentation/core-api/printk-formats.rst

Don't introduce any new build errors or warnings
Yes, that means that you need to check for warnings when you build.
Yes, that includes Documentation or kernel-doc warnings or errors
  (now that we have those down to zero).

Do NOT use stack space for DMA.

Don't use 'extern' on function prototypes. (deprecated)

Don't depend on Makefile order to control builtin module/driver init
calls. Use initcall levels instead.

In a Kconfig dependency list,
by convention, please keep "|| COMPILE_TEST" last in the list.

Shell scripts should use /bin/sh instead of another shell
as much as possible.

When making a patch such as a coding-style patch that should have
no effect on the produced code, do a before/after comparison of the
binary files to show that they are the same. If they are not the same,
explain why not.

Most scripts in the kernel source tree try to avoid bashisms.
There may be some exceptions to this, such as bpf-related scripts
and perf-related scripts.

Don't use BIT() macros in UAPI headers. Either open-code bit fields
or use _BITUL().

"sigcontext is accessible to user; do *NOT* assume that sigreturn will find what the kernel had written there" (Viro)

Please just use whole numbers for patch versions, there's no need for .X
for this type of thing as our tools do not know how to catch that, and
it makes no sense.
Just keep bumping the number please. (gkh)

C99 style comments are OK in source code except in UAPI header files.
They may be used with cstd=C90, which does not accept // comments.

TODO:

Should we say something about __delay() not being available in all
arch-es so some other delay function is preferable.
[maybe add something like this to checkpatch?]

#####

