Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3004765717
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjG0PMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjG0PMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:12:14 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A85B5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690470734; x=1722006734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aLnYfgXFu9qFwcn/sovr3DuEibzC1WZUxyf9Izpe7QI=;
  b=GwkqZjoSTO7IIPMeGVPy9b1H02xaY9BJocOMe0PFDh7L9M5WAtqiX1K1
   f5c6mqx4TM047CX8hAmHajdgTnrsu0TV31iYuFlmV6OpmaKDX+Mvg1H2g
   fTnZRjnTif5pTm7HyzWn98y3vZewZJHAFANMR8L7RuI49WfN+LaHJU5Jw
   HmF+D+7zMaIKHDCoCm4aFJPHjHFVJT4CF/Lkh8CuNgUzEYot4UvIlf3tC
   c2lDDI5GRDrTENwr0i3BTm/RdyIkd0a6GBQlSyFFLx6kvcBfL8hATEQl+
   u5/xICra9bMIBEQjxmbycQa0+c3oJMhoBTrjhMPwE4XTw8VdRIy3NuRol
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="368353700"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="368353700"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 08:12:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="900906746"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="900906746"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 08:12:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP2eq-009OVn-2G;
        Thu, 27 Jul 2023 18:12:04 +0300
Date:   Thu, 27 Jul 2023 18:12:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH] mtd: fix use-after-free in mtd release
Message-ID: <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727145758.3880967-1-alexander.usyskin@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:57:58PM +0300, Alexander Usyskin wrote:
> I case of partition device_unregister in mtd_device_release

In

device_unregister()
mtd_device_release()

> calls mtd_release which frees mtd_info structure for partition.

mtd_release()

> All code after device_unregister in mtd_device_release thus

device_unregister()
mtd_device_release()

> works already freed memory.

uses?

> Move part of code to mtd_release and restict mtd->dev cleanup

mtd_release()

> to non-partion object.
> For partition object such cleanup have no sense as partition
> mtd_info is removed.
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption")

Closes: ?

-- 
With Best Regards,
Andy Shevchenko


