Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCEC47A2FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjIPLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbjIPLOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:14:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53E01A8;
        Sat, 16 Sep 2023 04:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694862876; x=1726398876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6LByGd6BJ/KoBVbB5quf9dys3O4g3Rte15yl6U221g8=;
  b=MOal2r9zJrpGbYM4CJ1+UPByaY8s6RQuqvymjOTESOkd8LNJ48jKr4Fp
   w5NAg82U8+b3tLewesd//ihzuCMz2PWIFz+PNn3lSLnTN6SmqixQ9BxES
   KPLHoPu9zCyrSgCqilkOkt+rAGeARUfBisuSAYhP0lsNRgxBJ14A5j3p5
   zSiHiDnH7nW3SMI9lkEPzWZ20GVl0ooIQodE/hFjVJ/KQ9AFnQOrRe3hK
   A5IHNjax3o5rV8XqlHt/8kFnkX750k/c1LwtnGdF+BpbRnYLxl3f46OI7
   +C6gjT6BbYF/vBwei79z5pmDOyC0RqcIPz4wbhbwh0Y1MU3xf62kxkiKW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="359655880"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="359655880"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 04:14:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="869045162"
X-IronPort-AV: E=Sophos;i="6.02,152,1688454000"; 
   d="scan'208";a="869045162"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2023 04:14:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qhTFX-0000000Gg9M-2NuF;
        Sat, 16 Sep 2023 14:14:07 +0300
Date:   Sat, 16 Sep 2023 14:14:07 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v4 3/4] platform/x86: intel_scu_ipc: Don't override scu
 in intel_scu_ipc_dev_simple_command()
Message-ID: <ZQWN/xpN2801loCo@smile.fi.intel.com>
References: <20230913212723.3055315-1-swboyd@chromium.org>
 <20230913212723.3055315-4-swboyd@chromium.org>
 <58e817b0-1872-6ff1-58bb-1aeeb572361@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58e817b0-1872-6ff1-58bb-1aeeb572361@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 05:45:42PM +0300, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Stephen Boyd wrote:
> 
> > Andy discovered this bug during patch review. The 'scu' argument to this
> > function shouldn't be overridden by the function itself. It doesn't make
> > any sense. Looking at the commit history, we see that commit
> > f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
> > removed the setting of the scu to ipcdev in other functions, but not
> > this one. That was an oversight. Remove this line so that we stop
> > overriding the scu instance that is used by this function.
> > 
> > Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com
> 
> This looks somewhat unusual way to tag it. I'd just drop the Closes tag 
> as the email list is not a bug tracter.

This is a new requirement enforced by checkpatch.pl. If commit message has
the Reported-by: tag it should have Closes: one as well.


-- 
With Best Regards,
Andy Shevchenko


