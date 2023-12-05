Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183B48060E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjLEViG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEViF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:38:05 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEFAD3;
        Tue,  5 Dec 2023 13:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HKW4QFdw1SLSy+SkuqSHdm3s7yV1a+qPMBI8CTnpIIQ=; b=YnhA+Lw601956o/BXGvoJwVs6b
        HJ/ruVA7o7YK8GsFiaU8pesx1TY1HZe1YgvI/ZNQpHpMBDU1HidBuw3Kug5y5Z8Oys6bgmCguEvDr
        MhBtL7J+wjd/TtYdnXZt1YFqpBQbN0xHEt0ohsYHTviT3X8TcdUj6b6B7VGrkd4Btgr7vUCxP0fLQ
        WI97i5i8K2w8RdHp73Gq3qQb8+t2H73w2SbEWYijKjHabtCMOokySCrhY0UI/i9cvJHpuI4DzyrZN
        TbR3KybOl1fMP5diqdjKNvn7tcSi9twOa7taauWBAPPv6yKEQp9/3QvK2reorfJe4Hhfq65+pD7JO
        UTb3UfQw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rAd7H-007TNt-26;
        Tue, 05 Dec 2023 21:38:07 +0000
Date:   Tue, 5 Dec 2023 21:38:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     tanzirh@google.com
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <20231205213807.GE1674809@ZenIV>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list changing indirect includes to direct includes.

How does it account for arch- and config-dependent indirect includes?

In particular, on sh this patch breaks, since there word-at-a-time.h does not
contain an include of kernel.h, even though it uses REPEAT_BYTE.  This is
a very simple case (they really ought to include kernel.h, same as all other
instances of word-at-a-time.h), but I would expect arseloads of more subtle
breakage in anything less trivial.

And I'm not at all sure that there's no config-dependent breakage as well -
this had been caught by quick make allmodconfig + make lib/string.o on
a bunch of architectures; the graph of indirects includes (as well as the
set of symbols needed for given header) is very much config-dependent.

> IWYU is implemented using the IWYUScripts github repository which is a tool that is
> currently undergoing development. These changes seek to improve build times.
> 
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5232 lines (-80%).

It also breeds includes of asm/*.h, by the look of the output, which is
not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
outside of linux/uaccess.h is a bad idea.

> If there are any problems with the output of the tool please raise an
> issue on the github.

Sorry, no.  Your tool, your workflow, of course, but I don't do github issues.
You are welcome to the contents of this reply, but I'm not using browser-based
UI without very strong reasons; this one isn't.
