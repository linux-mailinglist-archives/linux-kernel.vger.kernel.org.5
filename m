Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71527F120C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjKTLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjKTLdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:33:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1009D;
        Mon, 20 Nov 2023 03:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479995; x=1732015995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkgwfC9q+Fm8LcV+fAvpsTxPWqX3sTwTmzLmwkZ+BNc=;
  b=GWI6uDWp0VFHMjB8DjswmjZZoiwK7Z1/Hrsq459h5BUEv0BZCKQ0ScFl
   XjIbLRUYM2eAeUX7HdZ2Dpl5lhtfeM8n3vfTh2i+TAAcZLefv9BH7EKgv
   8oJSkYFlNjlR+RBTFQDU7+mqckHIxTf7W0djcUZLtqGR0FTaiGNf2eHDb
   qEp8LvvYmNyiIT/W2hEbyo8/Dn8BL+HlWWW0JMHlZdn1jG2KNApgaB1qS
   6fuCiB5bVAGEea5BMGk8gqmFbJ90cYHw6Nzyd8nlA8V6IBB9tdpPdZLDP
   +QVkqid+w/FNowcEc5390lJKyTwphVYk0ISGdLF+CZX2sz+2B99RzT362
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381989519"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="381989519"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:33:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742697708"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="742697708"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:33:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r52Wc-0000000FXGt-09EJ;
        Mon, 20 Nov 2023 13:33:10 +0200
Date:   Mon, 20 Nov 2023 13:33:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpio: tangier: simplify locking using cleanup helpers
Message-ID: <ZVtD9elOfE1Uxgib@smile.fi.intel.com>
References: <20231118072037.10804-1-raag.jadav@intel.com>
 <20231120095615.GA1074920@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095615.GA1074920@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:56:15AM +0200, Mika Westerberg wrote:
> On Sat, Nov 18, 2023 at 12:50:37PM +0530, Raag Jadav wrote:
> > Use lock guards from cleanup.h to simplify locking.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


