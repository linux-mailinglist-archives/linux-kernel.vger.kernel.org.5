Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3368075397D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbjGNL2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbjGNL2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:28:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29542D79
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689334091; x=1720870091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V4OAA33crh9kzRQhEws5le5Gfe8QPCdN1/Z5VE8YyEM=;
  b=dTziB8Hs8DLswp2X14A17/ySzySoSWvNotMSGP/Vdk6x2HkO/GscR1xT
   qq+1kXY3Ua/1enXNvmumoxXg/7KSpDsK9r091FJ1Aoy1Y3S1Fkh434n2U
   6gcKe3aBnW7f5NbLf1oBYxAMrcvMHobv7exRQH3HnhrYgqeiMuKSosQky
   1y7hn+gAOY3dftemcIj+Z/qtrxYkUjcmJuW24GsDKCnXgVkrS0h98uMQs
   in8QEQvxA2oWoKgSVehRl6C8b1p5NlHI76lXTOOjOGl2QIpG4tupMpVjU
   /ar6vM3LSENkQYGtVmnOQBRU7GahPHpeYHg+TX+hoUW0jtASi2sDyake1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365489855"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="365489855"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 04:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787821820"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="787821820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2023 04:28:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKGxy-002e4J-2C;
        Fri, 14 Jul 2023 14:28:06 +0300
Date:   Fri, 14 Jul 2023 14:28:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Alexander Potapenko <glider@google.com>, catalin.marinas@arm.com,
        will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
Subject: Re: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
Message-ID: <ZLExRvCytbxBcUef@smile.fi.intel.com>
References: <20230713125706.2884502-1-glider@google.com>
 <20230713125706.2884502-2-glider@google.com>
 <ZLA0TwHZOgAGCgKX@smile.fi.intel.com>
 <CAG_fn=WsPC_qMZfbVQHbXq_cGXP4ZfYkyGyJPzaAKSqurxoibw@mail.gmail.com>
 <ZLEBgGSsmOPs4Zu5@smile.fi.intel.com>
 <ZLEvM1s65L1k0PTx@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLEvM1s65L1k0PTx@fedora>
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

On Fri, Jul 14, 2023 at 07:19:15AM -0400, William Breathitt Gray wrote:
> On Fri, Jul 14, 2023 at 11:04:16AM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 13, 2023 at 08:05:34PM +0200, Alexander Potapenko wrote:
> > > On Thu, Jul 13, 2023 at 7:29 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Jul 13, 2023 at 02:57:01PM +0200, Alexander Potapenko wrote:
> > > > > The two new functions allow setting/getting values of length up to
> > > > > BITS_PER_LONG bits at arbitrary position in the bitmap.
> > > >
> > > > A couple of years (?) ago it was a series to achieve something like this with
> > > > better (?) code. Why not resurrect that one?
> > > >
> > > > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2195426.html
> > > 
> > > It looks more compact thanks to GENMASK, I can cook something based on
> > > the proposed bitmap_{set,get}_value (and change the names if you
> > > prefer the shorter ones).
> > > But I'd better avoid pulling in the rest of that series without a strong need.
> > 
> > William, what do you think on this?
> > 
> > I'm personally prefer William's version as not only it was published first
> > it was carefully designed and got a lot of review already. We just hadn't had
> > the user for it that time.
> 
> Yes, that version went through several revisions so it's been well
> tested and known to work -- as you pointed out it just lacked the users
> to warrant merging it into the tree. If it statisfies the use-case
> required here now, then I think we should it pick it up rather than
> reinvent the solution again.
> 
> Also, we probably don't need the "clump" code in there, so perhaps
> splitting it out to just the bitmap_{set,get}_value relevant code is
> fine.

Agree, thank you for your comments!

-- 
With Best Regards,
Andy Shevchenko


