Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807DC8063B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjLFAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376387AbjLFAzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:55:43 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD948C6;
        Tue,  5 Dec 2023 16:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X8KK4VSJFZP6TzOCTWGDStmgVhNuLq23YhUpuTUXAQ4=; b=iJ9aLbum3b2L5pwcfpjDF8tL5c
        Qw2bPrYFGW7a5lznqCq8i9u3nNWRbvjN7WQUj4HYjv6+sNjh+kog7kBKCGMuLYgbQHzHzVqjklWes
        UuXdI2UR8wvKVkuhilt+p67cLOZpSpo2vc/9RhZGBI+/z06wkrKxktMjKalVjP2Zew4/wwWNj/ebc
        0n8EUyr9K3F1qFsFA0VDlCv79YGqzTBJBbEfxeGDgECMPvZ5Ez9CzP87q/S6IA3sQmlrakoL8RifS
        4nyrx9wCeSUL6aRFTMjPFvamsyEihswzbbTInErnbgjJWEx/rmLQHAAYV9weWJtKXu9ynsbxsqAPH
        N+Q1KODw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAgCU-007Wc9-2y;
        Wed, 06 Dec 2023 00:55:42 +0000
Date:   Wed, 6 Dec 2023 00:55:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg KH <greg@kroah.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231206005542.GJ1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <2023120608-ivy-snowdrop-890d@gregkh>
 <CAKwvOdmFJ=ZGN8ZScS5oQpXnAL0wwtTDCeNNGpBKZXzQ4kRAVA@mail.gmail.com>
 <2023120657-henna-spongy-9ef6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120657-henna-spongy-9ef6@gregkh>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 08:46:50AM +0900, Greg KH wrote:
> > >
> > > But of course, it doesn't always hold true, there are a few minor
> > > exceptions, but they are rare.
> > 
> > $ grep -r \\#include lib | grep asm
> > 
> > shows quite a few exceptions, and just in lib/.
> > 
> > For example, lib/math/int_log.c includes asm/bug.h.  Is that a case
> > where lib/math/int_log.c should be #include 'ing linux/bug.h rather
> > than asm/bug.h?
> 
> Probably yes, but we don't normally go back and take coding style fixes
> for old files like this as it doesn't make much sense to do so.
> 
> But, if you are cleaning up the headers for large portions with the goal
> of faster builds, that's a good reason.

FWIW, the most common (by far - about 13% of such includes, over drivers/, fs/,
mm/, net/ and sound/) is asm/unaligned.h.

The next are asm/io.h (10%), asm/byteorder.h (6%), asm/irq.h (5%), asm/div64.h (3%),
asm/page.h and asm/dma.h (2% each).  The rest is below that (the next is a bit over
1%).

In fs/* unaligned.h is again the top one (37 out of 139), followed by
byteorder.h (30 out of 139), div64.h (12), page.h (10) and then comes random
shite - I do not believe that fs/coda/psdev.c might have a legitimate
reason to pull asm/io.h, for one thing...
