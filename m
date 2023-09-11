Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209279C3C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241755AbjILDKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjILDJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:09:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F8B4838A;
        Mon, 11 Sep 2023 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694467290; x=1726003290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KyY0bt2hfAVv84BS0o9R1NkNlZaPTKwHSs6qfsZUiAk=;
  b=cCaYbKSTWKNo2h2qMm3/Yhd3D0xsADxPNBln8Tw7zIHu4zs2djORQAl/
   KygbELGfItnGajoHGMknOlWTAtLPI9AMR93DjHmFujV7JoePvXL+359zC
   Q+z991VvGZwTzjxjgZbbBPDNacpe14kF5SVauqseR03FWuq0VbJm959I9
   cCFQAXwRt1AtzqaoHXVTcjMzT5Jm0nTvgCIyadjAyc48X2AttLwaXFjp4
   G2ILuejYxYLObxh6KBT9jM3nCloaDqpk5fuO4GZrl11CcYWOTS7XgIu8e
   ef0CH6y4Xbcr/J7MiTPL48c4Kea6HTBraTUWra6NYqq/lheCR38IO7Mlv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="380907811"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="380907811"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:19:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="813545721"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="813545721"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:19:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfoJc-008QUx-1r;
        Tue, 12 Sep 2023 00:19:28 +0300
Date:   Tue, 12 Sep 2023 00:19:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 1/4] platform/x86: intel_scu_ipc: Check status after
 timeout in busy_loop()
Message-ID: <ZP+EYOkT2kVX2UCi@smile.fi.intel.com>
References: <20230911193937.302552-1-swboyd@chromium.org>
 <20230911193937.302552-2-swboyd@chromium.org>
 <ZP+D4hlUXhAboFBJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP+D4hlUXhAboFBJ@smile.fi.intel.com>
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

On Tue, Sep 12, 2023 at 12:17:22AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 11, 2023 at 12:39:33PM -0700, Stephen Boyd wrote:

...

> > +	err = read_poll_timeout(ipc_read_status, status, !(status & IPC_STATUS_BUSY),
> > +				100, jiffies_to_usecs(IPC_TIMEOUT), false, scu);
> 
> Since "false" you probably can utilize readx_poll_timeout().

...and because only a single parameter taken.

> > +	if (err)
> > +		return err;

With that,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


