Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2955811F40
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378325AbjLMTqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjLMTpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:45:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DC9D4B;
        Wed, 13 Dec 2023 11:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702496756; x=1734032756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NkInTmywTVeWZDXhb8Nql959C4qM12kBZjmIfc1IU9o=;
  b=JdmOvEPt3V1lJlMt5Unkc9dLgjraP+394ASeJ07ySW+MVwEFi2FLVGtK
   IQ1fOKMRC0+kdMxu7U9SgBOBSd162qz/mDeS52oEp8Zv/J9cvPm0xbncs
   Mt1d6N5lRxPuGz+1T2DopMsm91yG71lZidkqek2DR/Ey+CmH1Q0fmzAF/
   EFUdQSAOueGHCNKmo2tNUWZkdsCceucPRFhKhWYlK0PriNq5cirns3CdG
   14uxAtfIX3+Y1mw3H+wh1KZNci789+/8rg9+zqVBqXaVh9L/HkqAci+55
   NyuGNnjywJtttP4t5/kwRqvxJ1Ld5aSwB3ep/66ZHP/4xswrsPUXhc+zh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16568780"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="16568780"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:45:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947292068"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="947292068"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:45:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDVB0-00000005d1h-0bhM;
        Wed, 13 Dec 2023 21:45:50 +0200
Date:   Wed, 13 Dec 2023 21:45:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/6] of: irq: Add default implementation for
 of_irq_to_resource()
Message-ID: <ZXoJ7WG4lJ4wMM8w@smile.fi.intel.com>
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.4.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213110009.v1.4.I31d4dd6a7e5a3e5eee05c87b358e63cd1aa0e467@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:00:22AM -0700, Mark Hasemeyer wrote:
> Similar to of_irq_to_resource_table(), add a default implementation of
> of_irq_to_resource() for systems that don't have CONFIG_OF_IRQ defined.

...

> +extern int of_irq_to_resource(struct device_node *dev, int index,
> +			      struct resource *r);

It looks like you may put this on a single line as this file has longer lines.
Note you do not need "extern" for function. You may even update the header
to drop all of them at once.

-- 
With Best Regards,
Andy Shevchenko


