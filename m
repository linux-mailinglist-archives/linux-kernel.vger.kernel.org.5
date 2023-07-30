Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE9768692
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjG3RF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3RFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9528C10C8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A3360C8F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 17:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EA4C433C8;
        Sun, 30 Jul 2023 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690736748;
        bh=f6knECm1fSH39bAiPEYJzLYKh7YYP7L6/h+4LW/qes4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQOJWLr/LbONgAeQgr7lYLT3cyw9wn+Hadapyh65h14zthl4gHBLmf23gr8haxCC7
         wztWJ9FwyAmETNwqSFs+OrHVCy5x6Y84J7mkE9Fe8vCMcyBnzFiQcSoMCou03Lc6Oo
         gQwM4BEnrL/PIoZfTFcqmDoUD8GaVIwaQoKBG8qi/rtzy0OS4mw//dmKw2rg223voo
         yl3Il6e34075yBC9IiN5H+kH9vGSGTJW8T/1UAItkxD9Xzk906yJ4JiG/wF308/9iL
         eDYGHIQuShl9C/FJ4Q8i5mFROJ4N3E8dcUrC5dwjr+9lKm5UvUKrKU8Y45w/vrRuAf
         wDBtRqsg8HHvw==
Date:   Sun, 30 Jul 2023 10:05:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'kernel test robot' <lkp@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <20230730170546.GA1666163@dev-arch.thelio-3990X>
References: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
 <202307290943.ODVeyeK6-lkp@intel.com>
 <b6bbfa2e3c374714a6f0f7d5a3cb9afa@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bbfa2e3c374714a6f0f7d5a3cb9afa@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 02:55:50PM +0000, David Laight wrote:
> From: kernel test robot
> > Sent: 29 July 2023 03:01
> > 
> > kernel test robot noticed the following build errors:
> > 
> ...)
> > compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git
> > 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290943.ODVeyeK6-
> > lkp@intel.com/reproduce)
> > 
> ...
> > >> mm/percpu.c:3102:10: error: static assertion expression is not an integral constant expression
> >                    base = min(ptr, base);
> >                           ^~~~~~~~~~~~~~
> ...                    ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
> >            (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
> >            ^
> ...
> >    mm/percpu.c:3102:10: note: cast that performs the conversions of a reinterpret_cast is not allowed
> > in a constant expression
> 
> That is a C++ error that seems to have crept into C.
> The relevant definition is:
> 
> #define is_signed_type(type)  (((type)(-1)) < (type)1)
> 
> This seems to have been fixed in clang 16.0.0.

Indeed, it looks like

https://github.com/llvm/llvm-project/commit/a181de452df311d7647329120d05f4eb9c158b6c

fixed this as a result of the discussion at

https://github.com/llvm/llvm-project/issues/57687, which certainly makes
sense.

Cheers,
Nathan
