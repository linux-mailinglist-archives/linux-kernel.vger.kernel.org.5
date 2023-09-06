Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD057944B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbjIFUqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbjIFUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:46:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4542E9;
        Wed,  6 Sep 2023 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033192; x=1725569192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5zvRhW8pHPVPvumASeRUDz78JQVHT52yAzi/mOU2s4=;
  b=Ogl0BcPuJKoqShZC1nqR6pkjqcKH10beBqNKNJRHKnY1YM/rQGp613TA
   iENB9ggApLbcW8hGQMpPiraELMQiyhMdxUEEFEE/1eC0O1+p3EmO1jdT7
   YNWAYPLADoeVedLlvUiz0w7nXMo/9P1to4naSjzFvZq+EXvhaB2Zrhlom
   BLiSKnx5HpjDJH+feqVSvk/G/oiAHu6yvTHwSGf0lqT+sIgoPAufHnC90
   RoiRkhdySuVyfazr5Sg3GdEF3SEP0A3ftiaK7g+0WhJyhXOaHvWl/1ryY
   LS7iygEgKBJbnZl2WPNakJdPi3+Uz3P5Tdjnl7w1nu8FtmAjX4wFKrQrC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="377093188"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="377093188"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="776772647"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="776772647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:46:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdzPv-0079X0-0D;
        Wed, 06 Sep 2023 23:46:27 +0300
Date:   Wed, 6 Sep 2023 23:46:26 +0300
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
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipc: Fail IPC send if
 still busy
Message-ID: <ZPjlIhDykHd44YTz@smile.fi.intel.com>
References: <20230906180944.2197111-1-swboyd@chromium.org>
 <20230906180944.2197111-4-swboyd@chromium.org>
 <ZPjdZ3xNmBEBvNiS@smile.fi.intel.com>
 <CAE-0n53iGCL3q=CsDKZr28eMjx40miLNG6+-jf12JKMxuAKkKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n53iGCL3q=CsDKZr28eMjx40miLNG6+-jf12JKMxuAKkKg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:22:43PM -0500, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2023-09-06 13:13:27)
> > On Wed, Sep 06, 2023 at 11:09:43AM -0700, Stephen Boyd wrote:

...

> > > @@ -450,6 +468,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> > >               return -ENODEV;
> > >       }
> >
> > >       scu = ipcdev;
> >
> > Side observation: Isn't this a bug? We should not override the supplied parameter.
> 
> If it is a bug that would be great to know. I wanted to make an API that
> got the scu if it wasn't busy but then I ran across this code that
> replaced the scu with ipcdev.

To me this seems like a bug, because in other similar code we don't do that.
And even reading this one, why do we have a parameter if it's always being
rewritten?

-- 
With Best Regards,
Andy Shevchenko


