Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE5806122
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjLEV53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEV50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:57:26 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801961B8;
        Tue,  5 Dec 2023 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4R8XorxoFVOpovwERfSrloKkn2fMEhR5jZoBji1BSzM=; b=qlh/FNeDT4RM5b8OO4gTtNwyyw
        Yj566rfENDUFrZyrSODB7/RDqkMAoxkYS6Kqmvz/6ib39OUcGVHBY2AdXtFHtOrWZMpAmntVEYmeq
        Q4ox4UkGCyDPct/YjeoqTVzAak1qLHfUSr9eHYzJgCGeaSv/ofdJavh6WHUxRUviF/KOMiAeXuHxx
        cjvhQlTkXKiQ53swhQP37deCDEWQT51eQYoWRVjm+ZboLMI1xvqJT8iHwcV73gQGDV35Gccz1AUGz
        LGYZmNwp1qXNNKD2M9l634UMZw0J2f7EEHy8VVTMz28+ht0YI6Xh6xz2sEm6PBrlsNsU6Kl7peIep
        16Q8aXKQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdQ1-007Tjl-1a;
        Tue, 05 Dec 2023 21:57:29 +0000
Date:   Tue, 5 Dec 2023 21:57:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     tanzirh@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231205215729.GG1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205213807.GE1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:38:07PM +0000, Al Viro wrote:

> It also breeds includes of asm/*.h, by the look of the output, which is
> not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> outside of linux/uaccess.h is a bad idea.

Let me elaborate a bit:

Consider e.g. a situation when we have linux/foo.h pulling asm/foo.h;
among the things declared there is foo_bar(), which is identical in
18 instances of asm/foo.h (out of current 21).

At some point we notice that; the obvious approach would be to have
3 unusual architectures have their asm/foo.h define _ARCH_HAS_ODD_FOO_BAR
and put the common variant in linux/foo.h under ifndef _ARCH_HAS_ODD_FOO_BAR.

Except that any file that pulls asm/foo.h will get broken by that.
And something like your tool might convert the users of linux/foo.h to
asm/foo.h - all it takes is using only the primitives that currently
happen to be in asm/foo.h on all architectures.

This is not an artifical example, BTW - look at the history of uaccess.h and
checksum.h...
