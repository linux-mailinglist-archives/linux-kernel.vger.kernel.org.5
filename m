Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2175348F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjGNIEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjGNIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:04:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C1A3C20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689321700; x=1720857700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptuJ9ReMboKqbXzVKP4EvoaiDEiZU+g+UkL2iYfqyiM=;
  b=ZdoXtM2zPEDVJPUavgFhgNuhIXcGrEhA+PNGkh4N28pmrWFOU6JGgcIx
   247dSDpoyHyWtvT05QQPjIIZ4l4B7ZRmlvBCjIaEy+QvVMu1kUkfZGMwr
   d7xGTettKeNIr6+zoyIqmjaPVUaMNjWv00Y7A+oxczoYEWHljZM0qNp2B
   TTVBcYby8DERZaqkPyba0hRTdFa7efIIQSgS6yuj9pIj5SPbJ5S7jJEML
   aEShD8FjwiM9c5KiIy/IN+i0xvXtz3uveoz0rNM1k1YnH++2haJ5hlaAy
   jfqwtubVJPXAUY3VPQveC96JRy1a4QhRw4+/vj0naiZnqmDXXLKNFMD6D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="355355322"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="355355322"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 01:01:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1052976022"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="1052976022"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 01:01:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKDk6-002b7J-2Y;
        Fri, 14 Jul 2023 11:01:34 +0300
Date:   Fri, 14 Jul 2023 11:01:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
Message-ID: <ZLEA3oxst2FBDWhC@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-4-glider@google.com>
 <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
 <ZLBQCFbBOaBUTQmB@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLBQCFbBOaBUTQmB@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 12:27:15PM -0700, Yury Norov wrote:

...

> > > +	void *storage = ea0_storage(handle);
> > > +	int size = ea0_storage_size(handle);

> > > +	if (!handle || !storage)
> > > +		return;
> > 
> > You use handle before this check. Haven't you run static analysers?
> 
> This approach is called 'defensive programming' as I learned from
> previous iteration.

No, this approach called "let compiler optimize the check away". :-)

When compiler sees something like

	TYPE bar = MACRO(foo); // FUNC(foo);

	if (!foo)
		blalblabla;

the conditional can be eliminated as the optimizer thinks the way "okay,
developer already _used_ the foo in some code, it means it can't not be NULL,
let's drop a dead code".

(Yes, I know what defensive programming means and we actually quite rarely
 use it in the kernel for the internal APIs)

-- 
With Best Regards,
Andy Shevchenko


