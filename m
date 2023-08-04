Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7F76FA4C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjHDGmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjHDGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:42:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2473DB9;
        Thu,  3 Aug 2023 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691131321; x=1722667321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4U+QTqNDGYbI6jRbOUJiaCIaXtaMMqtOAzSKPCfKoXM=;
  b=XCDa8Na8gGmn8URc6jByCGj4M7SiaJYQWAjBEXqUOdYhwklDGwWS3wj1
   +9NB6mOGkKlTR0wk5MllhHoOkFTLC5uCOQhPw6ALPaQUXikvD07t3u6iL
   df7E3mkLba9yxIgJZiJDt5xADg4+i+dvoObXus+Ql3Po+FN9GJDUZCxtl
   mJ1yF/cNYUKysEbvUgZBnyITH9yG6fsAZABDkohsQ7sbzyOehmQdX/d4j
   a3glAzJZx4/mGYrVRXkZ9AjNxm/EvIEtS13ftyPVNRO5ctcsdyARWSJKT
   Yqp+h+WPfPY83+SwnFdrWPursE71CpLhsWpj7zL5/dhoOsMGhzbA+hrZh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="349675780"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="349675780"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 23:40:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="764970022"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="764970022"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2023 23:40:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRoUT-00E1B4-0b;
        Fri, 04 Aug 2023 09:40:49 +0300
Date:   Fri, 4 Aug 2023 09:40:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
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

On Thu, Jul 27, 2023 at 09:43:29PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 03, 2023 at 09:52:10PM +0300, Andy Shevchenko wrote:
> > After I updated GPIO library for the case Benjamin has with CP2112,
> > I have a brief look into the CP2112 driver itself.
> > 
> > From GPIO perspective it has two main (maitenance) issues:
> > - usage of ->to_irq() with IRQ chip present;
> > - having IRQ chip not immutable.
> > 
> > Besides that there are plenty small cleanups here and there.
> > Hence this series.
> 
> Any comments on this?

Gentle ping^2 for this...

Anything should I do to improve it or is it okay to go as is?

-- 
With Best Regards,
Andy Shevchenko


