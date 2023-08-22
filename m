Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295478402A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjHVLyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjHVLyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:54:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BD7E66;
        Tue, 22 Aug 2023 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692705242; x=1724241242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcfp8eqaoM3pY02/1gNm55E8T7e3wQ+83xT+JBpXKCI=;
  b=ADm2eefeLrpIi0wUhsrDL41prMX25AvQHCMpgsz3GOdyE3bBbHzU6vt2
   1vT+47ukMKbNV4xkVeMEQ5NsKe89ayl+GMTvD5kYO5MCLTwekXSsLYeXa
   rGh2d7Ma+2aWFFkgySxQNC5vfuGpYXzABXBvt/eVu07wpj6+2qlFdVNcz
   VuCMwQKuUU34sY49DrUDJc8fW15QEd8XlVo7Qc++CzWUNtCUnFfJea7ej
   wALgPfyH+e8Hcy2LO53ex+HOXfzT9SEMHOgm5DW7PZHwyYDO/FsWohMmi
   T2sAiHDUGP+/bozv7rz6gofethzwLp3rJC05bA7+tevCfxiH+Xdqo0ITb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358847881"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="358847881"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801645548"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="801645548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 04:51:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYPvC-008tPh-2e;
        Tue, 22 Aug 2023 14:51:42 +0300
Date:   Tue, 22 Aug 2023 14:51:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: cherryview: fix address_space_handler()
 argument
Message-ID: <ZOShTk4se2dWDN4X@smile.fi.intel.com>
References: <20230822072340.8783-1-raag.jadav@intel.com>
 <20230822112034.GN3465@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822112034.GN3465@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:20:34PM +0300, Mika Westerberg wrote:
> On Tue, Aug 22, 2023 at 12:53:40PM +0530, Raag Jadav wrote:
> > First argument of acpi_*_address_space_handler() APIs is acpi_handle of
> > the device, which is incorrectly passed in driver ->remove() path here.
> > Fix it by passing the appropriate argument and while at it, make both
> > API calls consistent using ACPI_HANDLE().
> > 
> > Fixes: a0b028597d59 ("pinctrl: cherryview: Add support for GMMR GPIO opregion")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


