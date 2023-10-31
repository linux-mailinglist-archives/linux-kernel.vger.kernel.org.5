Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2237DCAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343643AbjJaKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjJaKWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:22:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D583;
        Tue, 31 Oct 2023 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698747772; x=1730283772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VISwYifRZkoN4jWwcGitg4uU+PDhruRG2nnbbHQj4JI=;
  b=QlsckmpkJlr4OaomiK2xaLpSgtTh/6oK//8h8P6gQeE/PRSRJ3nar/l+
   wGQDCM9sXBXaLlmMA3R2inLls7GmGX509DxeFlPbCLpjMlVWKsDFHbkEv
   5xw8hYX6h9+RG6xAJpHJ+kpGlmDho1KlXFmPDEpOPJirKhPk7q7AcJBFY
   /Ab3WRgtshFo/ShP7szK35zVTNLV4a1LZ4A1C+GPJQvldBQphn1EQpZep
   /SpHultyQSBn+yYvdvKfcqN625UOsNc1uH8W16YUHb9ikYgqbwqx/STeh
   LX6zeaSgMom+rjQRs8Y1Q2Lpd5D0VyZcWEvzhGi6gk7jnRaqECsqEGHxs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="391128353"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="391128353"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:22:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="754097005"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="754097005"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 03:22:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qxltX-0000000A6wI-1TV6;
        Tue, 31 Oct 2023 12:22:47 +0200
Date:   Tue, 31 Oct 2023 12:22:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Move default strength
 assignment to a switch-case
Message-ID: <ZUDVdyAXr8SlJlnx@smile.fi.intel.com>
References: <20231030155340.3468528-1-andriy.shevchenko@linux.intel.com>
 <ZUAcffriaEkNcRH_@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUAcffriaEkNcRH_@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 11:14:11PM +0200, Raag Jadav wrote:
> On Mon, Oct 30, 2023 at 05:53:40PM +0200, Andy Shevchenko wrote:
> > iWhen ->pin_config_set() is called from the GPIO library (assumed
> > GpioIo() ACPI resource), the argument can be 1, when, for example,
> > PullDefault is provided. In such case we supply sane default in
> > the driver. Move that default assingment to a switch-case, so
> > it will be consolidated in one place.
> 
> Looks good.

Thank you for review. Can you give your Rb tag then?

> iWhen -> When

I'll fix it locally.

-- 
With Best Regards,
Andy Shevchenko


