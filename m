Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387E4758D12
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGSF1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGSF1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:27:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262AA1FF6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689744422; x=1721280422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7XPVa2B9jBhfsmExj6J5l6vD5LjQjir0Va+s/j090YU=;
  b=arii/z8vC1Ii+mKfKU7g4syaPJ6+gYzDNBOdpjiPp99+BdgLbGXziguW
   rNjaaUmQyURfZQMnEwV4wbX7KBPcIEgCES0RwsFjCqeZylDQSHq2cbbMM
   msToX7xdCc6BZvSa2mHVL/wA9DVxE4Vj6bxGCaOqnsHHph3+fCzZj63xY
   qM1FhKGO/qBjcd8wDw0+0iS4l7XUBejtrj3yK7nKz8DpJZGSJrWpcBNig
   2NmBZDa0FBrQfg0vHhUe490gSa48eA+KJdi6j0SmIrpled+xIDqtofGVQ
   2gBPsEJaG8qHr4o3FmEX5NufvSZ4E+/bJBxmyDJd8DMgeBrQytgaUIKPT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="430141128"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="430141128"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 22:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="793882577"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="793882577"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2023 22:26:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLziC-00D4M4-0o;
        Wed, 19 Jul 2023 08:26:56 +0300
Date:   Wed, 19 Jul 2023 08:26:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] seq_file: Replace strncpy()+nul by strscpy()
Message-ID: <ZLd0IDr+m6hAe4CK@smile.fi.intel.com>
References: <20230717093332.54236-1-andriy.shevchenko@linux.intel.com>
 <168963536094.1395996.315062356944871422.b4-ty@chromium.org>
 <202307182147.A5B81B67D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202307182147.A5B81B67D@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:00:24PM -0700, Kees Cook wrote:
> On Mon, Jul 17, 2023 at 04:09:23PM -0700, Kees Cook wrote:
> > On Mon, 17 Jul 2023 12:33:32 +0300, Andy Shevchenko wrote:
> > > Privided seq_show_option_n() macro breaks build with -Werror
> > > and W=1, e.g.:
> > > 
> > > In function ‘strncpy’,
> > >     inlined from ‘ocfs2_show_options’ at fs/ocfs2/super.c:1520:3:
> > > include/linux/fortify-string.h:68:33: error: ‘__builtin_strncpy’ output may be truncated copying 4 bytes from a string of length 4 [-Werror=stringop-truncation]
> > >    68 | #define __underlying_strncpy    __builtin_strncpy
> > >       |                                 ^
> > > include/linux/fortify-string.h:151:16: note: in expansion of macro ‘__underlying_strncpy’
> > >   151 |         return __underlying_strncpy(p, q, size);
> > >       |                ^~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/1] seq_file: Replace strncpy()+nul by strscpy()
> >       https://git.kernel.org/kees/c/c30417b20f49
> 
> Gah, I dropped this from my tree since it was actually wrong[1]. This is an
> ugly corner case with strscpy vs strncpy: the cast be32 from hfs/hfsplus[2]
> looks unterminated to strscpy, so it would return -E2BIG, but really
> FORTIFY noticed the over-read (strscpy is correctly checking the 5th
> byte for NUL).
> 
> So... I think we need to fix seq_show_option_n() using memcpy+NUL, drop
> the ocfs2 usage, and clarify that the seq_show_option_n() docs mean
> "n means _exactly_ n bytes"...

Sounds like a plan!

Please go ahead with that. My intention is to make eventually build kernel with
`make W=1` when CONFIG_WERROR=y.

> [1] https://lore.kernel.org/lkml/0000000000000a88cb0600ccef54@google.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/hfsplus/options.c?h=v6.4#n221

-- 
With Best Regards,
Andy Shevchenko


