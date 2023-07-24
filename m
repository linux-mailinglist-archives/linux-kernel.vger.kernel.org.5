Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09BC75EDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGXIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjGXIg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:36:57 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0C9AD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690187816; x=1721723816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDhtutM0pr0AK29Z2GxbbSWEScl9EcBUidY6d+4jQdQ=;
  b=FfriHYhB50uHGUv+Y+a5iS7RD5k5dkrG9TfQNrHniycwGCqbUuFDEQl1
   pBH6MBXIcokZrzwctSpHlPmSdETEOP8bmuC09O6+j4AfV5PbieLAGk7ct
   TLG9EQqLj9vsWX/FkqCmbb15eRKKB8bnnZTGijG1n0hTlhUyNyGfNDs5V
   w4uHstNa+OQxJA//D4CRVx5dtmlksq0Kwqjn71aIyFJaOfsNXHjkDRyOj
   Ais0sWNDc/GYH4SFdJLYGc2+adWH0/MPiyyRlo8Hp4fdvqAig5hGocOco
   I4KyBA2mDT04XP7jEYhxSPlP1h59WxrkPo+02414wml+donaJiCgqoxP6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370984571"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370984571"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 01:36:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="790886438"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790886438"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 01:36:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNr3U-004i0X-2v;
        Mon, 24 Jul 2023 11:36:36 +0300
Date:   Mon, 24 Jul 2023 11:36:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
Message-ID: <ZL44FFAkG8pKS1lv@smile.fi.intel.com>
References: <20230720173956.3674987-1-glider@google.com>
 <20230720173956.3674987-2-glider@google.com>
 <ZLyI+0EL1VztnHLe@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLyI+0EL1VztnHLe@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 06:57:23PM -0700, Yury Norov wrote:
> On Thu, Jul 20, 2023 at 07:39:52PM +0200, Alexander Potapenko wrote:

> > +		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
> 
> 'GENMASK(nbits - 1, 0) << offset' looks really silly.

But you followed the thread to get a clue why it's written in this form, right?

...

> With all that I think the implementation should look something like
> this:

I would go this way if and only if the code generation on main architectures
with both GCC and clang is better.

And maybe even some performance tests need to be provided.

...

> Alexander, can you please try the above and compare?

> In previous iteration, I asked you to share disassembly listings for the
> functions. Can you please do that now?

Exactly what we need before going with your suggestion(s).

-- 
With Best Regards,
Andy Shevchenko


