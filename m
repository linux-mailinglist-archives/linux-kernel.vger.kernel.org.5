Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A8F7A4EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjIRQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjIRQUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5549324995;
        Mon, 18 Sep 2023 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695053712; x=1726589712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D4xBX8r/3NDKqkwzlZDpf10xVrGyNATd0L8iCBQH01w=;
  b=a4RwzZBhhEizowUahWksPn+tOdzqTdy9XXOfufbnG5hPD0IxkYTBV8gb
   wvSxQn/x1dyPXEwDOsYLiXSwXafYcIdI3CiD2S0NoQWNFo/S7ZbcJR/Sv
   6oMQVYvXtL4y1CAbwOd84d6oFc43V5kHKWoQEvt1GEaDw02BDnkPQmmNG
   JZK55j/UL3ztXSQ0gcOShcm/NzYq7XRukJdpNn2qms7w845yV/160VHVx
   jukZYmlG5afwqDTKRYFktAIp4WlIRUyiijibMQJ+N9ZTuTGWeB7H4fu89
   zxaXMEewYCCgsno3/gSTSz4tT7CJNius1GE5JEhCkbB38VtZx4cjL435r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="379596552"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="379596552"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:38:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="816077146"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="816077146"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:38:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiGKK-0000000Crwq-0SzJ;
        Mon, 18 Sep 2023 18:38:20 +0300
Date:   Mon, 18 Sep 2023 18:38:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 2/2] platform/x86: think-lmi: Use strreplace() to
 replace a character by nul
Message-ID: <ZQhu647Bo9gsldIF@smile.fi.intel.com>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
 <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
 <c6caae28-01fc-2354-6c7a-3f515a0e1402@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6caae28-01fc-2354-6c7a-3f515a0e1402@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:48:40PM +0200, Rasmus Villemoes wrote:
> On 13/09/2023 11.27, Andy Shevchenko wrote:

> > -		p = strchrnul(value, ';');
> > -		*p = '\0';
> > +		strreplace(value, ';', '\0');
> 
> So how do you know that the string contains at most one ';'? Same for
> all the other replacements. If that's not guaranteed, this is not at all
> equivalent.
> 
> Or maybe the result is just used a normal string afterwards, and it
> doesn't matter at all how the content after the first ';' has been mangled?
> 
> It's certainly not obvious to me that this is correct, but of course I
> know nothing about this code.

If you read the comment and code slightly above you may get that this is not
a problem at all. There are no side effects as the part after first occurrence
of ; is not used and original string is NUL-terminated.

-- 
With Best Regards,
Andy Shevchenko


