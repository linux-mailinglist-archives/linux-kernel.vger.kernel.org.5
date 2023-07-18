Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A939757F49
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjGROTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGROTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:19:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8BDE4C;
        Tue, 18 Jul 2023 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689689961; x=1721225961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EoZ4wzTcvybBt6VwW/afQjL0Q4yJDPrwIabLfIL4h8A=;
  b=WLAmWKSK7qBc8goSpmnuBMeIKxH1Isxxfcx5Yrm5C/uYKG0Y591RNgN4
   21e3x3NiDna29q3iTfbSrld87b2N896C1LyoiQ2N/tpt3atQLiQNKIZll
   yjV7lTtOBIpqfA4KBZWI+/Octa6jgVe5g+Vw6NksKDa58dZMLe1X9hcSb
   zorS00m5bUQO8JyF4SS93FZ1wbHBHmNCSH9JY8es+Qc/5MjM7sOhmgu45
   MJ5cK0ebpb+LefVoDNGkCR2HFREr82L2J53jiE5fKA/J9fQQ1dGsAJT4e
   mL3RqwG2H7U/nAM0VKz6ouxXSCx2W0CLhaHt9YCowj/fbSVCzHy0ZGaab
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="429978777"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="429978777"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054301231"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="1054301231"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2023 07:19:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlXo-00Gohu-1K;
        Tue, 18 Jul 2023 17:19:16 +0300
Date:   Tue, 18 Jul 2023 17:19:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: Re: [PATCH v2 next] media: i2c: fix error handling in
 ub960_rxport_add_serializer()
Message-ID: <ZLafZGjjS0xSGWX5@smile.fi.intel.com>
References: <20230718140659.4009167-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718140659.4009167-1-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:06:58AM -0700, Harshit Mogalapalli wrote:
> Smatch warns:
>  drivers/media/i2c/ds90ub960.c:1671 ub960_rxport_add_serializer():
>  err: 'rxport->ser.client' dereferencing possible ERR_PTR()
> 
> i2c_new_client_device() returns error pointers on failure and in
> dev_dbg statement we are dereferencing error pointer which is a bug.
> 
> Fix this by using IS_ERR() which checks for error pointers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


