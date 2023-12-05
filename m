Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F212806184
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346480AbjLEWPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjLEWPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:15:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F016D181;
        Tue,  5 Dec 2023 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=rZoIuLBpqfTTD+G5pnGLC4N3Ey8O5mo3kg+Q6utlpas=; b=jiyhtCeIWsiKOT/rohzO/I+nDh
        AxEBv15Ye8BphlvJO+A+wMPPR/fAvFrUpGa0hCfwk91iGjGojhOa/ukdRiYT2jMYQAOi6pkgz5t0B
        nvBO0F7sd6DrP6Kx+G/J2VHtEnjn2oJ6JIYkPWBn0DO2OsaoJUO2DrRQYwV5ClA/b1ngnNb4VhjLG
        6QSimRhRuC2TZwPRh9k9x1Q6hTJrdF73bi+k2sHzqSc2o+AkzhWuylWi1R6INJYnkZBfyCUbZo3s4
        qqwLnvZNdkivu7Fq8bZgazpXS9exwm0LLb+uMi6vntxf1+PMRQ2o7lQQXxGfH2KrvNtPRrlIfTdBR
        WiW60Rvg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAdhJ-007U2Q-2b;
        Tue, 05 Dec 2023 22:15:21 +0000
Date:   Tue, 5 Dec 2023 22:15:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231205221521.GH1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 12:01:56AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> 
> ...
> 
> > > > IWYU is implemented using the IWYUScripts github repository which is a tool that is
> > > > currently undergoing development. These changes seek to improve build times.
> > > >
> > > > This change to lib/string.c resulted in a preprocessed size of
> > > > lib/string.i from 26371 lines to 5232 lines (-80%).
> > >
> > > It also breeds includes of asm/*.h, by the look of the output, which is
> > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> > > outside of linux/uaccess.h is a bad idea.
> > 
> > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > convention here that I'm missing?
> 
> The mandatory ones can be used, but not all of them.
> In some cases you even must include asm and not linux
> (unaligned.h, byteorder.h, maybe others...).
> 
> As I told, it comes with experience, we lack of the
> respective documentation (or file which is good for
> automation checks, like with IWYU).

It would certainly be nice to have such information in the tree;
"where should I pick $SYMBOL from?" is something one needs to
find out often enough.  To a large extent it's covered by "where
in include/*.h do we have it defined?", but that's not all there
is to it.  E.g. "get_user() => use linux/uaccess.h".

There's also stuff like "$SYMBOL should not be used outside of arch/*
and include/*, better use $OTHER_SYMBOL", etc.
