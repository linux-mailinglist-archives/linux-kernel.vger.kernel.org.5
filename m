Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1494080134D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379396AbjLATFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLATFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:05:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99325AD;
        Fri,  1 Dec 2023 11:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701457552; x=1732993552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZP1RzYH2Aq8QYjlUFJTnaunXEEMQ2NZv9unTBub7OZk=;
  b=AacGJeTFzKbLvvRRqfzDk8ujJj7BAQywIBa0VmaY4YNMAfdLsuWjeCVF
   ETaQRGAxliNDP132cgHgv7yas/uWNjw0M/H3MOvwM8BV0s1VKl0oCBBWA
   LGXKh+aAHzxvVD5y+Q6TioD/8IcrsbUGNgdM6L6aJwcV6evKn5MfxQYtC
   /ioZ5BFerC7VdXIFL7UqKUYfVOIVvQvAcDqHm0dGat9eQFq5WH9UKvq5b
   8efBi4LJRgISXMRCIQxAZe3U5pQlsBJ1LUyTW0g3l0FOtzjn1CdktnuK/
   jQ4q5jlFoBpeCMHRcu/1FcyogMjLeEdEM1NBpJpsy4DyNXf65mAFS7B3I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="390707556"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="390707556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="913666321"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="913666321"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 11:05:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r98pg-000000015Ma-0BGp;
        Fri, 01 Dec 2023 21:05:48 +0200
Date:   Fri, 1 Dec 2023 21:05:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/5] params: harden string ops and allocatio ops
Message-ID: <ZWouiyBnNN-8DFT7@smile.fi.intel.com>
References: <20231120151419.1661807-1-andriy.shevchenko@linux.intel.com>
 <170145261350.53238.3359968215284616685.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170145261350.53238.3359968215284616685.b4-ty@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:43:34AM -0800, Kees Cook wrote:
> On Mon, 20 Nov 2023 17:11:41 +0200, Andy Shevchenko wrote:
> > A couple of patches are for get the string ops, used in the module,
> > slightly harden. On top a few cleanups.
> > 
> > Since the main part is rather hardening, I think the Kees' tree is
> > the best fit for the series. It also possible to route via Greg's
> > sysfs (driver core?), but I'm open for another option(s).

[...]

> Applied to for-next/hardening, thanks!

Awesome, thanks!

-- 
With Best Regards,
Andy Shevchenko


