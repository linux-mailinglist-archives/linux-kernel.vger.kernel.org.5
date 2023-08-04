Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDC677037C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjHDOtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHDOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5E949C1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E65960C58
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 14:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF6C433C9;
        Fri,  4 Aug 2023 14:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160541;
        bh=xQy0735LbfWCkytz1dXsO/muUeNMgiKlX1anJPkBEHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nABWueLbmtLzqyKR8KGQBt4dq+v1tebs0Y/Wal5qtcKyPqnR3CKFbEoO94AiCqY3d
         yHUP83Dpi2ywalDYsdGEJy3HNXenf59G/4yB33p41bi2iqD/uibNtdNh1rKBDqwVab
         VSen3p2K42vvLa0MAEZazwEM7LBV5sICPs0lfqVOtiYsf7RcJEAAR5hrDolRBcQG9Z
         JZ3tJ21qi+N8VWoL6pIkTF+21f9UNTyA1f176ocEVZLEqqqZvQG3tAWrkiV2KUBfg1
         KTUOAnAM9l/CGkucfhW8VUqLtg3gbB5+76yLi05wIFORbl0XhiNQ3qiBBAvVbIlY0q
         ZysMW50RzNp8w==
Date:   Fri, 4 Aug 2023 07:48:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] lib: test_scanf: Add explicit type cast to result
 initialization in test_number_prefix()
Message-ID: <20230804144859.GA3027708@dev-arch.thelio-3990X>
References: <20230803-test_scanf-wconstant-conversion-v1-1-74da994dedbc@kernel.org>
 <ZMx9nDQVaoRwN5oK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMx9nDQVaoRwN5oK@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 07:25:00AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 03, 2023 at 11:14:42AM -0700, Nathan Chancellor wrote:
> > A recent change in clang allows it to consider more expressions as
> > compile time constants, which causes it to point out an implicit
> > conversion in the scanf tests:
> > 
> >   lib/test_scanf.c:661:2: warning: implicit conversion from 'int' to 'unsigned char' changes value from -168 to 88 [-Wconstant-conversion]
> >     661 |         test_number_prefix(unsigned char,       "0xA7", "%2hhx%hhx", 0, 0xa7, 2, check_uchar);
> >         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   lib/test_scanf.c:609:29: note: expanded from macro 'test_number_prefix'
> >     609 |         T result[2] = {~expect[0], ~expect[1]};                                 \
> >         |                       ~            ^~~~~~~~~~
> >   1 warning generated.
> > 
> > The result of the bitwise negation is the type of the operand after
> > going through the integer promotion rules, so this truncation is
> > expected but harmless, as the initial values in the result array get
> > overwritten by _test() anyways. Add an explicit cast to the expected
> > type in test_number_prefix() to silence the warning. There is no
> > functional change, as all the tests still pass with GCC 13.1.0 and clang
> > 18.0.0.
> 
> >  do {										\
> >  	const T expect[2] = { expect0, expect1 };				\
> > -	T result[2] = {~expect[0], ~expect[1]};					\
> > +	T result[2] = {(T)~expect[0], (T)~expect[1]};				\
> 
> Can we add spaces as above, while at it?
> 
> 	T result[2] = { (T)~expect[0], (T)~expect[1] };				\

Sure. I can send a v2 on Monday to give folks a chance to chime in with
other comments.

> >  	_test(fn, &expect, str, scan_fmt, n_args, &result[0], &result[1]);	\
> >  } while (0)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
