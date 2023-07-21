Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECC75C4AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGUK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjGUK3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:29:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EADFD;
        Fri, 21 Jul 2023 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935394; x=1721471394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ehIc6SVTRowtZLkUcYzIyA6jks/ZdEIT3lElrCx+RlE=;
  b=cTXx9UfOOyEyIOhlmMxR5uItANjdviuJo/9IDOrUZ+k/dHFV8WVtgkiU
   uo8Z8Ojw+ghpCTGYDk9j2GjBj17DujxLAu0ao7LcTEPBWpZk1otGorE67
   WwqeokWvnzoMIWwJhBwMmft8HXaSuffDKZ5JtoHlqCvEYQwvEGS2thR6A
   xLyii7k6xYK6VfL0IHEmyktRBxN/aMdERENs6X0vNYNygKuwgJDLmjtQS
   T4fq9J8XvteAGsoRT1MU5BKtDb/9jOcs3JO3pDlSiSYmaOeahEJ/B95HH
   I0HFGCA5YvuieyIfoqftaO/MqJPXFbuYKfl/d48xbK005zO29uVzcTL0q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="364455163"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="364455163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:29:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718772366"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718772366"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 03:29:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMnOO-0005gR-2U;
        Fri, 21 Jul 2023 13:29:48 +0300
Date:   Fri, 21 Jul 2023 13:29:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] media: i2c: ds90ub953: Restructure clkout
 management
Message-ID: <ZLpeHG9/99YjdKtW@smile.fi.intel.com>
References: <20230720-fpdlink-additions-v2-0-b91b1eca2ad3@ideasonboard.com>
 <20230720-fpdlink-additions-v2-6-b91b1eca2ad3@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-fpdlink-additions-v2-6-b91b1eca2ad3@ideasonboard.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 01:30:37PM +0300, Tomi Valkeinen wrote:
> Separate clkout calculations and register writes into two functions:
> ub953_calc_clkout_params and ub953_write_clkout_regs, and add a struct
> ub953_clkout_data that is used to store the clkout parameters.
> 
> This simplifies the clkout management.

...

> +struct ub953_clkout_data {
> +	u32 hs_div;
> +	u32 m;
> +	u32 n;

I don't think it makes driver worse. The V4L2 UAPI has similar struct which is
used widely, hence I see no issues in using u32_fract here.

OTOH I'm not a maintainer, so...

> +	unsigned long rate;
> +};

-- 
With Best Regards,
Andy Shevchenko


