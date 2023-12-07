Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6EA80887C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjLGMwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjLGMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:52:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E9122;
        Thu,  7 Dec 2023 04:52:47 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="398105685"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="398105685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771724258"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771724258"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 04:52:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rBDrs-00000002bPB-40QR;
        Thu, 07 Dec 2023 14:52:40 +0200
Date:   Thu, 7 Dec 2023 14:52:40 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZXHAGDy_KcwElsLP@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
 <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
 <20231205221521.GH1674809@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205221521.GH1674809@ZenIV>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:15:21PM +0000, Al Viro wrote:
> On Wed, Dec 06, 2023 at 12:01:56AM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> > > On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:

...

> > > > > IWYU is implemented using the IWYUScripts github repository which is a tool that is
> > > > > currently undergoing development. These changes seek to improve build times.
> > > > >
> > > > > This change to lib/string.c resulted in a preprocessed size of
> > > > > lib/string.i from 26371 lines to 5232 lines (-80%).
> > > >
> > > > It also breeds includes of asm/*.h, by the look of the output, which is
> > > > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> > > > outside of linux/uaccess.h is a bad idea.
> > > 
> > > It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> > > convention here that I'm missing?
> > 
> > The mandatory ones can be used, but not all of them.
> > In some cases you even must include asm and not linux
> > (unaligned.h, byteorder.h, maybe others...).
> > 
> > As I told, it comes with experience, we lack of the
> > respective documentation (or file which is good for
> > automation checks, like with IWYU).
> 
> It would certainly be nice to have such information in the tree;
> "where should I pick $SYMBOL from?" is something one needs to
> find out often enough.  To a large extent it's covered by "where
> in include/*.h do we have it defined?", but that's not all there
> is to it.  E.g. "get_user() => use linux/uaccess.h".
> 
> There's also stuff like "$SYMBOL should not be used outside of arch/*
> and include/*, better use $OTHER_SYMBOL", etc.

Precisely! That's what many developers will benefit from!

-- 
With Best Regards,
Andy Shevchenko


