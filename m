Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0B7825C0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHUIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjHUIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:45:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E94A6;
        Mon, 21 Aug 2023 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692607546; x=1724143546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulwyj8L4iUR1Ogkpvo1Opc9auWIJJoa9ZPlFBjXThPc=;
  b=Gjd/Me4fKmJDamYX+SQ7MgkQW16dLHMzu8lBDC4S9U3rZV/Ykh7pqO42
   nAlddVPpZDpbTud5yB99FgS4CSI2bzucLEg+gGqE00miA+5B8YXx63wW2
   XJgqIIXaN1xYftQCwnbxpymlVcI41gED2ur8qA0cn/bW6VIjgGbGJvxaT
   w9rhnOexNrI8azmip1DG2pr9di3Hin6SJzWtvQFx2FdaV/qCpKkUhYnVP
   Jaz+ezGyk45SMhsHlV5OWtTv2zqYn/KI4Pmy+PxCepQMQICvQ1WtKW00f
   BJ7fKxty3c6xbTvf/XIbjNMCWsPmOU8/YBygPJpC66VPIdHr76QOHcHVk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="439908572"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="439908572"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 01:45:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="738819766"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="738819766"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 01:45:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0Xd-006EUT-0F;
        Mon, 21 Aug 2023 11:45:41 +0300
Date:   Mon, 21 Aug 2023 11:45:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     linux-serial@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        "open list:TTY LAYER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250_bcm7271: improve bcm7271 8250 port
Message-ID: <ZOMkNKwUBtoikb3q@smile.fi.intel.com>
References: <1692306801-13191-1-git-send-email-justin.chen@broadcom.com>
 <ZN9PHgS3Ds/Su8Tu@smile.fi.intel.com>
 <7332fd46-0310-8fdd-81a6-4ac722a6eda4@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7332fd46-0310-8fdd-81a6-4ac722a6eda4@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:22:25PM -0700, Justin Chen wrote:
> On 8/18/23 3:59 AM, Andy Shevchenko wrote:
> > On Thu, Aug 17, 2023 at 02:13:18PM -0700, Justin Chen wrote:

...

> > > +/* Broadcom BCM7271 UART */
> > > +#define PORT_BCM7271    76
> > 
> > 13 is free why not using it?
> 
> I was looking for a number close to another Broadcom port. I was
> prioritizing locality. But I have no issues with 13, I will change in v3.

Please, don't. I realized that they are defined in different file.
So, the first gap is 43. but I would like to compress the list first.

-- 
With Best Regards,
Andy Shevchenko


