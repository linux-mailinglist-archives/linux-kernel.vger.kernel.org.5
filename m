Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95E280613F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbjLEWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 17:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 17:01:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860A01A5;
        Tue,  5 Dec 2023 14:02:05 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="7313322"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="7313322"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:02:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="800116316"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="800116316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 14:02:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rAdUL-00000002C3Z-18UI;
        Wed, 06 Dec 2023 00:01:57 +0200
Date:   Wed, 6 Dec 2023 00:01:56 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <ZW-d1NZRIvmJlfcW@smile.fi.intel.com>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:

...

> > > IWYU is implemented using the IWYUScripts github repository which is a tool that is
> > > currently undergoing development. These changes seek to improve build times.
> > >
> > > This change to lib/string.c resulted in a preprocessed size of
> > > lib/string.i from 26371 lines to 5232 lines (-80%).
> >
> > It also breeds includes of asm/*.h, by the look of the output, which is
> > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> > outside of linux/uaccess.h is a bad idea.
> 
> It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> convention here that I'm missing?

The mandatory ones can be used, but not all of them.
In some cases you even must include asm and not linux
(unaligned.h, byteorder.h, maybe others...).

As I told, it comes with experience, we lack of the
respective documentation (or file which is good for
automation checks, like with IWYU).

-- 
With Best Regards,
Andy Shevchenko


