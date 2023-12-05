Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B728061C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbjLEWcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbjLEWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:32:03 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9651AA;
        Tue,  5 Dec 2023 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OD1ItpAr/xwE+UpWJnM3+Hd/hQwe/hOCe/5jv7jdpPk=; b=o3XjrazSh2WGCShw9aY/0MdGor
        WF/MV/1Do8TzOamoGOVtnVRhVIgvJskn2l6UJWaEeZEmj+4dwxL76HA0H++pOcs6oN1rBP4G3TAGM
        O49edbXY/MAVM8YI8RYccB/BSkYD7R8cmfjcQQtbZdcHjpEeRBLvCfPy5/YBZVEs2EacTBwMiKz3F
        EFnMjJy4sugxWkBqyUfIyGI/ful9aw733BnaYxs+d37x6zDXx7ETTYk1vM68ZoVsBlqit646m6ZXZ
        jkfzHR7B6ixmSjlYeJA7jhB9clkviA6ryNnRG7gC3aushuA5OK3QKfv2wjAjor4svyZSR9LFbAhqu
        LI2H81eQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdxV-007UJ0-0T;
        Tue, 05 Dec 2023 22:32:05 +0000
Date:   Tue, 5 Dec 2023 22:32:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231205223205.GI1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
 <20231205221521.GH1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205221521.GH1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:15:21PM +0000, Al Viro wrote:

> It would certainly be nice to have such information in the tree;
> "where should I pick $SYMBOL from?" is something one needs to
> find out often enough.  To a large extent it's covered by "where
> in include/*.h do we have it defined?", but that's not all there
> is to it.  E.g. "get_user() => use linux/uaccess.h".
> 
> There's also stuff like "$SYMBOL should not be used outside of arch/*
> and include/*, better use $OTHER_SYMBOL", etc.

Speaking of...

arch/arm64/include/asm/asm-prototypes.h:18:#include <asm/uaccess.h>
arch/powerpc/include/asm/inst.h:8:#include <asm/uaccess.h>
arch/powerpc/kvm/book3s_xive_native.c:16:#include <asm/uaccess.h>
arch/powerpc/mm/book3s64/radix_pgtable.c:31:#include <asm/uaccess.h>
arch/riscv/kernel/sys_riscv.c:15:#include <asm/uaccess.h>
arch/xtensa/include/asm/asm-prototypes.h:10:#include <asm/uaccess.h>
include/linux/uaccess.h:11:#include <asm/uaccess.h>
tools/testing/crypto/chacha20-s390/test-cipher.c:8:#include <asm/uaccess.h>

Only one of those is legitimate (linux/uaccess.h); asm-prototypes.h
ones are borderline, but probably should be pulling linux/uaccess.h,
everything in *.c is really wrong.  Powerpc asm/inst.h is the really
unpleasant one here - it's pulled by quite a few other places, including
several asm/*.h.  Hell knows; might be worth splitting the
{__,}{get_user_instr,copy_inst_from_kernel_nofault}() off to
a separate header (asm/inst-uaccess.h?), to be included only by the
files that use any of those (that would be
arch/powerpc/kernel/{align,hw_breakpoint_constraints,module_32,traps,vecemu}.c
and arch/powerpc/kernel/trace/{ftrace,ftrace_64_pg}.c - not a single header
among them).  That header would pull linux/uaccess.h and asm/inst.h wouldn't
need any uaccess at all; might spill into explicit includes of linux/uaccess.h
in some of the places in arch/powerpc that pull asm/inst.h, directly or
not...
