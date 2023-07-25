Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C9760DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGYJAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjGYJAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:00:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0A2BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690275616; x=1721811616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3pN/cixh5HH/mEXhEXj2LQ+Isx90fihL4pt1tCUTbLE=;
  b=kqMk6XGdxqW6UGBvzMvytxI97z93omOy73uox1X53hPSEmYtqULajQhT
   0fD5+Gniosn79JKlK7NvJDr0jQl/yd5cUiuiBoFiRJTuuw7bnq1V90uJ7
   JNNp+v3aeFxYwiFk8/fMK1Gb3+OeofbLMVhOrkvPb1VQ04i57g7A68EQn
   Y4t3aybyMTMvo8zVTCF57aJAVMYcB0aWFHNMwbjOVqtqh5ywovptu850B
   OJpUS8g8Q/5Zp6Qj8Z03tJuaMjCH4snVBymuQd6dwSk4+b2qGCcpMyscg
   IwWI3kdSj0xkPXM8iC3WaeyCDO9faCxnPvjp6XPel+11cM0mV6Ap9h8Mm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="454043053"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="454043053"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719973331"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719973331"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 02:00:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qODtp-002FuM-20;
        Tue, 25 Jul 2023 12:00:09 +0300
Date:   Tue, 25 Jul 2023 12:00:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZL+PGXMOf18Kc5Cu@smile.fi.intel.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
 <ZL44FFAkG8pKS1lv@smile.fi.intel.com>
 <ZL9X0TZb/QhCbEiC@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL9X0TZb/QhCbEiC@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:04:34PM -0700, Yury Norov wrote:
> On Mon, Jul 24, 2023 at 11:36:36AM +0300, Andy Shevchenko wrote:
> > On Sat, Jul 22, 2023 at 06:57:23PM -0700, Yury Norov wrote:
> > > On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:

...

> > > 'GENMASK(nbits - 1, 0) << offset' looks really silly.
> > 
> > But you followed the thread to get a clue why it's written in this form, right?
> 
> Yes, I did. But I don't expect everyone looking at kernel code would spend
> time recovering discussions that explain why that happened. So, at least it
> would be fine to drop a comment.

See also below.

...

>           w = *map & (end < BITS_PER_LONG ? ~GENMASK(end, start) : BITMAP_LAST_WORD_MASK(start));

This GENMASK() may generate worse code as compiler uses more instructions
instead of simple approach with the above..

...

> bitmap_write                                   -     271    +271
> my_bitmap_write                                -     248    +248
> bitmap_read                                    -     229    +229

my_ -- means your proposal? Do you mean you have it better in size than original one?

-- 
With Best Regards,
Andy Shevchenko


