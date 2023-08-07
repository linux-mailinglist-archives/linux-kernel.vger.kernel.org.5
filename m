Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F127727CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbjHGObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjHGObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:31:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBB10FC;
        Mon,  7 Aug 2023 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691418652; x=1722954652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b4ntnBblVTNwmgcGMyzwF6IHwP6pZoZCktC9WwMsxe8=;
  b=kxfxqlT+ni3cC35ZKhzYecW7pGoQuySeMGpBJaGNlZuQ1YxcjG1wB/1x
   t7JYN1VaaBezLUUgWoHb3A5NOqQ4E81rOsy1taIeu6EskdTBMRXhsiOyM
   7Uha+7mAEJYePRaBdcJzeM624k5MGbuiEuoJ4EE3jaUdfSqNWSU2RctwG
   jBoG8tdB4oKn+55lDO/rEyXughUgCc/eT+p0UFSa8IW06VyIZBzrPC2hf
   l9gV8vC+eVvSmlYPDvcE9RmHw0mSGq8ookICPxo+UES5GdAzRfSmwTnMe
   IZ7THO46fWcIbfeHqeNGcuxF0tepA41JDHxKLgNUhNy6xyBmvuUymTw+y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401530413"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="401530413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="724532691"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="724532691"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2023 07:30:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qT1FL-00FO0v-1x;
        Mon, 07 Aug 2023 17:30:11 +0300
Date:   Mon, 7 Aug 2023 17:30:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZND/8wd67YbGs8d5@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:19:54PM +0200, Jiri Kosina wrote:
> On Fri, 4 Aug 2023, Andy Shevchenko wrote:
> > On Thu, Jul 27, 2023 at 09:43:29PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 03, 2023 at 09:52:10PM +0300, Andy Shevchenko wrote:
> > > > After I updated GPIO library for the case Benjamin has with CP2112,
> > > > I have a brief look into the CP2112 driver itself.
> > > > 
> > > > From GPIO perspective it has two main (maitenance) issues:
> > > > - usage of ->to_irq() with IRQ chip present;
> > > > - having IRQ chip not immutable.
> > > > 
> > > > Besides that there are plenty small cleanups here and there.
> > > > Hence this series.
> > > 
> > > Any comments on this?
> > 
> > Gentle ping^2 for this...
> > 
> > Anything should I do to improve it or is it okay to go as is?
> 
> I have been off pretty much the whole July. I am now back and slowly 
> making my way through everything that accumulated, I will eventually get 
> to this.
> 
> Thanks for the patience,

Ah, okay, no worries and take your time!

I was thinking more on Benjamin's answer as last time he had a hw setup
to test... Not sure what the status of that now and if he has a chance
to test this or busy enough with something else.

-- 
With Best Regards,
Andy Shevchenko


