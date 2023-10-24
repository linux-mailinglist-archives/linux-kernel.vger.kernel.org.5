Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F67D4EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjJXLRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjJXLRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:17:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E21D7B;
        Tue, 24 Oct 2023 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698146262; x=1729682262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yT3C7M/uPNjTrUCibeAzmCQLBq5xF4IThdbPcRCFoCc=;
  b=BHNtX25p9driK0xvzuo7A5z3P7nDwFqQvZ5L9VMbxN31Lge9Fz6DwElv
   R6/J98zc7/j9FYytYItXAMsaoCVjlmD/EOAABm/d3n4rqtncpt39/UDJO
   lUkrBMme+H1LLUMt+yjDK6i5vXYBnsuHelLwonsxGc7zjIWYjisGcVGhO
   pJLySIbd2WJnRn2+jwX6Y2AEXQ3qiRY2aSUmOsPk7WVu5NMQ/jtn4JAVD
   FfK+zqFE1Q1ToHGYCzk/lZQG40ufy3KlLCU2jO4iAn47pnY8O+2MkL0QZ
   p7wZYke3XNJ5rgcGQO0jkubBAUpS7Qp/vRF/sJod44d3TsZcf3vPhwuuf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384234774"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384234774"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="882091615"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="882091615"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:17:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qvFPk-00000008C7P-0TDP;
        Tue, 24 Oct 2023 14:17:36 +0300
Date:   Tue, 24 Oct 2023 14:17:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Christopher Obbard <chris.obbard@collabora.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] clk: composite: Fix handling of high clock rates
Message-ID: <ZTenz66dqsdUfz1t@smile.fi.intel.com>
References: <20230519190522.194729-1-sebastian.reichel@collabora.com>
 <20230519190522.194729-2-sebastian.reichel@collabora.com>
 <c8befb46085c43e1d09f27709b90e92dbce52c82.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8befb46085c43e1d09f27709b90e92dbce52c82.camel@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 08:57:16AM +0100, Christopher Obbard wrote:
> On Fri, 2023-05-19 at 21:05 +0200, Sebastian Reichel wrote:

...

> > -                       rate_diff = abs(req->rate - tmp_req.rate);
> > +                       if (req->rate >= tmp_req.rate)
> > +                               rate_diff = req->rate - tmp_req.rate;
> > +                       else
> > +                               rate_diff = tmp_req.rate - req->rate;

Btw, we have abs_diff() helper for this kind of cases.

-- 
With Best Regards,
Andy Shevchenko


