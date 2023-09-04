Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EA37914F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343650AbjIDJpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjIDJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:45:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B4EA0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693820704; x=1725356704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gq96YdNaDvfrwwjhLYhQU2u/Wn9c6Xob/+QQ/xTdlLM=;
  b=kfXHhTEOgIlC2MBkISOmt6of1SfHOviqzL2V2oGubRmMF35usdXVoyzy
   L7j+dT4ZmlNX2prd92uCs2xnYAdJHxjsjcOyZv4Zq/zj/rNxFo08Wva5Q
   0moVLMb4SDuUOdZax+2wPk2z0MzpHiORMfX8xM8iBlTssbehTYH2Sx3GT
   y547GHVNoC9kEWXj1HbohUkpPwS81KAmhZajXPpr3lin1An6US009bRQ/
   LJ6+s7dz0hAnqzsj9xk7FRK3LBSP9zHPD0F0TCq3xni5RMoCoW1/FnoxQ
   LSpXAJbrZRSMyCNGCDeGXvHo6Dv3mg3CRs0+myyz8KETaXP+X79t46R7k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376493686"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="376493686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="1071533630"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="1071533630"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:44:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd68f-006ODa-0c;
        Mon, 04 Sep 2023 12:44:57 +0300
Date:   Mon, 4 Sep 2023 12:44:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Edward AD <eadavis@sina.com>,
        syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] kobject: fix kobj and fmt are both null
Message-ID: <ZPWnGAeMdmqWpTPw@smile.fi.intel.com>
References: <0000000000007b589e0604578e70@google.com>
 <20230903124231.3748101-1-eadavis@sina.com>
 <2023090328-slam-verbose-957d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023090328-slam-verbose-957d@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 02:54:53PM +0200, Greg KH wrote:
> On Sun, Sep 03, 2023 at 08:42:31PM +0800, Edward AD wrote:
> > If kobj and fmt are both NULL, it will cause an exception in kvasprintf_const,
> > then when this situation occurs, -EINVAL is directly returned.
> 
> How can this happen?  Are there any in-kernel users that cause this to
> occur?

Theoretically anything which uses

	dev_set_name(dev, dev_name(dev));

is affected, but practically it happens only when _previous_ dev_set_name()
fails, which _only_ may happen due to fault injection.

> If so, which ones, why not fix that?

In any case the real fix is here:
https://lore.kernel.org/all/20230828145824.3895288-1-andriy.shevchenko@linux.intel.com/

> And your description isn't quite correct here, you are not checking for
> kobj, but rather kobj->name.

-- 
With Best Regards,
Andy Shevchenko


