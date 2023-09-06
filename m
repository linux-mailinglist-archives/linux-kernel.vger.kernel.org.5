Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACECC793FAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjIFOy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjIFOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:54:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D5919BB;
        Wed,  6 Sep 2023 07:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694012072; x=1725548072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vk//cjnhY2oDIuOGEkFkGzdr0kjytapLaS56kH9oSpw=;
  b=PIu8/n5Iyy+wrHXltceVS/rRh5tPt8itJmJ8kqvC5JQBMhxxXwytYTKL
   92Wg9xbBU5Mr1j+wTRcsL3oCnQdQ2gRJoNb/SO/jms/bUkk+ZBx+t78GM
   +tDmgFQdJbg9trfWXZg/XO0Z/WMizz+BLd9B1TY3GTCx1BZ83xdJ/2LhS
   McMG8lXmEteFog9wFg+1x5BUl8bJOY06v/lc2zIkqNq69IEtjpTPjXyLp
   YJLFAV8H6dFkryTCYzvB3Lxi1YgCMgJnh7fEl4uRaVE8G4D2MRqfDQnOd
   r3kPIzn7lAArkOakM1Ijca80j32y5C1ewevEX0Q2q9slxXBsQDw7qlF+b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="377000030"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="377000030"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691312894"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="691312894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:54:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtvG-006y71-1f;
        Wed, 06 Sep 2023 17:54:26 +0300
Date:   Wed, 6 Sep 2023 17:54:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Message-ID: <ZPiSogB2GdyM+oJx@smile.fi.intel.com>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
 <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
 <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
 <05febba8-49a5-5f9d-34b0-d85d976e1416@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05febba8-49a5-5f9d-34b0-d85d976e1416@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:40:39PM +0200, Alexander Lobakin wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 31 Aug 2023 16:21:30 +0300
> > On Fri, Aug 25, 2023 at 04:49:07PM +0200, Alexander Lobakin wrote:
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Date: Thu, 24 Aug 2023 15:37:28 +0300
> >>
> >>> It may be new callers for the same macro, share it.
> >>>
> >>> Note, it's unknown why it's represented in the current form instead of
> >>> simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
> >>> bitfield type") doesn't explain that neither. Let leave it as is and
> >>> we may improve it in the future.
> >>
> >> Maybe symmetrical change in tools/ like I did[0] an aeon ago?
> > 
> > Hmm... Why can't you simply upstream your version? It seems better than mine.
> 
> It was a part of the Netlink bigint API which is a bit on hold for now
> (I needed this macro available treewide).
> But I can send it as standalone if you're fine with that.

I'm fine. Yury?

> >> [0]
> >> https://github.com/alobakin/linux/commit/fd308001fe6d38837fe820427209a6a99e4850a8

-- 
With Best Regards,
Andy Shevchenko


