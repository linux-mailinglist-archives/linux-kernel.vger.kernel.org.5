Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0301B753B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbjGNMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjGNMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:32:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A013AAD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337933; x=1720873933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JdFpBHyC/qLU5qvdOKxXfGdeJI86rvSkdXEkIR/E2gc=;
  b=ZAIJAAvVaEZfBvYmFYUp4E7egCIX26yj0VLCGLcW8q+VM12JpTce6e+x
   J65JZDhkLYmtt7QV4UdqJwHcAYOJJU6nIs9olN6F/dKK/KgJh8zFZMxZN
   BBS5WhMM9ZwsGMa/DkaF7KRvna9uDXGOatEuub7xw6+7Ah+Uc+uSupRjW
   KgWNapVSjblI+6heXKCRNxXAuySL7ZgL8uQ3O4IF09Tj+Um9w7AJrmO6f
   mWWm7ucMzPBdXrVjEVRAJizsHIGhsHuVtLbmnPH4mVgUbLL9FALK4BMyo
   vTv+coRUWNVdk6Ldf+6emrTFYhrGC9tgRejJl5HggVWroba1/w9BerfJD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431634503"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="431634503"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="716323813"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="716323813"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 14 Jul 2023 05:30:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKHwI-002eu6-1E;
        Fri, 14 Jul 2023 15:30:26 +0300
Date:   Fri, 14 Jul 2023 15:30:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
Message-ID: <ZLE/4ihjymUbtXj6@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
 <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
 <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com>
 <ZLEvM1s65L1k0PTx@fedora>
 <ZLExRvCytbxBcUef@smile.fi.intel.com>
 <CAG_fn=XFBFByn7i1aw69rttJK9GZWSge81aa8yTK=qFZYAE7AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG_fn=XFBFByn7i1aw69rttJK9GZWSge81aa8yTK=qFZYAE7AQ@mail.gmail.com>
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

On Fri, Jul 14, 2023 at 02:07:45PM +0200, Alexander Potapenko wrote:
> On Fri, Jul 14, 2023 at 1:28 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jul 14, 2023 at 07:19:15AM -0400, William Breathitt Gray wrote:
> > > On Fri, Jul 14, 2023 at 11:04:16AM +0300, Andy Shevchenko wrote:
> > > > On Thu, Jul 13, 2023 at 08:05:34PM +0200, Alexander Potapenko wrote:

...

> > > > William, what do you think on this?
> > > >
> > > > I'm personally prefer William's version as not only it was published first
> > > > it was carefully designed and got a lot of review already. We just hadn't had
> > > > the user for it that time.
> > >
> > > Yes, that version went through several revisions so it's been well
> > > tested and known to work -- as you pointed out it just lacked the users
> > > to warrant merging it into the tree. If it statisfies the use-case
> > > required here now, then I think we should it pick it up rather than
> > > reinvent the solution again.
> > >
> > > Also, we probably don't need the "clump" code in there, so perhaps
> > > splitting it out to just the bitmap_{set,get}_value relevant code is
> > > fine.
> >
> > Agree, thank you for your comments!

> So would it be fine if I split off bitmap_set_value() and
> bitmap_get_value() from that series and send it (with the appropriate
> attribution) instead of my patch 1/5?
> We'll probably still need to retain patch 2/5 (with the function names
> changed).

Sounds good to me.

-- 
With Best Regards,
Andy Shevchenko


