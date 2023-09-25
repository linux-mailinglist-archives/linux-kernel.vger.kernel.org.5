Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8187AD7EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjIYMX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:23:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC6AFC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695644599; x=1727180599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U3cmCcOFZtDa3Y2ZK/TkeGbMFs8jv8OQbBC9obIBuKM=;
  b=DJYeRt+axot+sQLekY8Bsa3db6LnxzDz0qbTGTmEnKHb4jfPGjGsuaMG
   r8ZXswiXNMcjCL2H1DymG7PzjWPSpABqnTJ3htsvooO+xKSM/fMweC3ug
   qrHwrEjAZH5cBsp+h4Ywig/lLiI0sRV0lMKWm1MZ3Pq6AK0q51vs8pRAA
   vYYTW9mU2xFskkD9qbhKEzDmi33HRFWAWamI5n49qFQEbk82K0wEI17rm
   2WDev7MhgND3f987mtk1Mf+BZlKOBHqyJFzLPREYjKziodQQt9pPBNMDw
   K0Q9la0x0cpuhuajbQyPPgVhY7tLMgwXTD77q78wM7MdGtetBK9rhP15x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447726111"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="447726111"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="724978754"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="724978754"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 05:23:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkkcJ-00000000LLO-2C8M;
        Mon, 25 Sep 2023 15:23:11 +0300
Date:   Mon, 25 Sep 2023 15:23:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v5 2/5] lib/test_bitmap: add tests for
 bitmap_{read,write}()
Message-ID: <ZRF7r0ZjxcL9C8U8@smile.fi.intel.com>
References: <20230922080848.1261487-1-glider@google.com>
 <20230922080848.1261487-3-glider@google.com>
 <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UeFoyhZvPJ7pGPrc5011D9h1e4ioffat4eUfVHP6Hd-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:16:37PM +0200, Alexander Potapenko wrote:

...

> > +/*
> > + * Test bitmap should be big enough to include the cases when start is not in
> > + * the first word, and start+nbits lands in the following word.
> > + */
> > +#define TEST_BIT_LEN (1000)
> 
> Dunno why this didn't fire previously, but CONFIG_CPU_BIG_ENDIAN=y
> kernel reports mismatches here, presumably because the last quad word
> ends up partially initialized.

Hmm... But if designed and used correctly it shouldn't be the issue,
and 1000, I believe, is carefully chosen to be specifically not dividable
by pow-of-2 value.

> The easiest fix is to make TEST_BIT_LEN divisible by 64 (e.g. 1024)

Wouldn't it hide the real issue somewhere?

-- 
With Best Regards,
Andy Shevchenko


