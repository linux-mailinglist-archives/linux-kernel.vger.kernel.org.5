Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90F978C81B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjH2O4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjH2O4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:56:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B6194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320989; x=1724856989;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xHLmxKAojHAYQH1wQs2MZ9sNBjGyNfv+Sf7oaPJ8n7g=;
  b=A3tl/W8YjD3R6gk2fZfDqiBBaQ4B7WXqshLpIjLfeQqrnAN7ibJzqSWN
   //SKckbXc1aMGF1P8EwGVPC+YMSc/5SElpMFfOeeuyK4iMyYnhcL7bq0a
   S/139MiNXtQ0t6yX8I8HWTUx7cv4/Dt8jyP6uJGm15ZxCQH85BLSxpEDi
   Qsg/XpNp89y4RHEqQRx70y62VlF4UU+QyYkVvhNEr+tv9fg3YM5x3d29M
   AGgn+aTA6SC2U4ctYE3M9oYhAj0EyrFfpJxZ8XfSVD/3il3PibFExxkzr
   D/C1dTC8D/mCWydXCoEjl4VEFlcRvVcyJcHkFY6u+SfzxJLNgUKDrq+uT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406381208"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406381208"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773713228"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="773713228"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 29 Aug 2023 07:56:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb08l-004uLz-15;
        Tue, 29 Aug 2023 17:56:23 +0300
Date:   Tue, 29 Aug 2023 17:56:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] bitmap: rework bitmap_{bit,}remap()
Message-ID: <ZO4HF51PXuwklAfS@smile.fi.intel.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
 <5247e354-cb7f-4df7-37a5-95cebed43d4c@rasmusvillemoes.dk>
 <ZO304SCFoP2wmnNA@smile.fi.intel.com>
 <CAAH8bW-jO=BEY3j5JVJcuVsCeUzWsgNqfg-b7EHt-w00vjP+gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH8bW-jO=BEY3j5JVJcuVsCeUzWsgNqfg-b7EHt-w00vjP+gQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:50:08AM -0700, Yury Norov wrote:
> On Tue, Aug 29, 2023 at 6:39 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 29, 2023 at 09:33:29AM +0200, Rasmus Villemoes wrote:

...

> > I posted one patch to replace these APIs with something else, more particular
> > for GPIO case(s). Have you chance to look at that? With that taking in, I'm
> > fully agree on the above statement (as we lose the user of this complicated
> > thingy which is a niche of the NUMA as you mentioned already).
> 
> I saw the code in a comment in some thread but not as a separate patch, and
> AFAIK you said it's a work-in-progress.

The patch itself is self-contained, the only problem it has no users as is.
The work-in-progress for the test cases, but before I continue with that I want
to hear if it's accepted approach.

> Sorry if I missed your submission. Can you please send the patch or point me to
> the previous submission?
> 
> Also, if after your change bitmap_remap would become a NUMA-specific, should
> protect it with NUMA guards?

Rasmus' idea was to move that completely out of the bitmap namespace and scope.

-- 
With Best Regards,
Andy Shevchenko


