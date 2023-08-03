Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE076E77E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjHCL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjHCL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:57:16 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66E52D69;
        Thu,  3 Aug 2023 04:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063835; x=1722599835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dWAkvZfkdY2GodxCzS1MLy/1nlnMDwiTj8DiqAXt9HY=;
  b=MBhJOJ2gxuvurbUbhrTJ6tUu5QmammjlwjkdTYMHwyuXRV31dNNje03f
   d3NvfLJnNq4q8S2w3OUIJVQAv8hhHm0HAI/Q9akApn1v2T7CyuiA10nA8
   95ErgajrKIQzuyIwScaQUALe3pTk+St8sqJT7SI05LXGyQ4DVw+Za/p79
   rIiiBZNFwN4hdQDtkSpEHtiRVdch4JcmclRh9i5h8lRWEvfJrkZ9Sg9o1
   Ih0G2fXx4/IBsML8Ph+R1Lg/n+sq4Jz/7cDtowN941gioxhfW3xHMU2ra
   Svctphlq5y4m9zqHDVFjDTwvmkDzgQYzBAoNfbYOPrSHZXqmX3du88k+4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="354769780"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="354769780"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:57:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="903348133"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="903348133"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 03 Aug 2023 04:57:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRWx6-00B91Q-0C;
        Thu, 03 Aug 2023 14:57:12 +0300
Date:   Thu, 3 Aug 2023 14:57:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: i2c: ds90ub9x3: Fix use of uninitialized
 variables
Message-ID: <ZMuWF71x0thq/aTs@smile.fi.intel.com>
References: <20230803-ub9xx-uninit-vars-v1-0-284a5455260f@ideasonboard.com>
 <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803-ub9xx-uninit-vars-v1-1-284a5455260f@ideasonboard.com>
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

On Thu, Aug 03, 2023 at 11:41:38AM +0300, Tomi Valkeinen wrote:
> smatch reports some uninitialized variables:
> 
> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v1'.
> drivers/media/i2c/ds90ub913.c:481 ub913_log_status() error: uninitialized symbol 'v2'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_local_data'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_input_ctrl'.
> drivers/media/i2c/ds90ub953.c:655 ub953_log_status() error: uninitialized symbol 'gpio_pin_sts'.
> 
> These are used only for printing debug information, and the use of an
> uninitialized variable only happens if an i2c transaction has failed,
> which will print an error. Thus, fix the errors just by initializing the
> variables to 0.
> 
> Fixes: 6363db1c9d45 ("media: i2c: add DS90UB953 driver")
> Fixes: c158d0d4ff15 ("media: i2c: add DS90UB913 driver")

I would prefer two separate changes on per driver basis. This is a good
practice to make backporting easier (generally speaking).

-- 
With Best Regards,
Andy Shevchenko


