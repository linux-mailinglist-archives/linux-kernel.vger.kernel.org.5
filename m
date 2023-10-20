Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132BF7D0688
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346857AbjJTCju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjJTCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:39:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4AC124;
        Thu, 19 Oct 2023 19:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697769588; x=1729305588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etfoBUI+RIl0nB/b1xlmfwQfjInOYn8Ns5BsaA0hVE0=;
  b=VkV071Ac7j9RR07FWXqUyEPH4foUFk7rqJy5rH3/EYLrYTZnXG45yrzD
   nDu97lSWEExdyzw9RCz3pRHUptCJXOIwXTFhCRjHb8wr6exKZXoelrW6i
   FYY9Tk+BOLQT8ql+c63IxOx9LyH/eZCKa/Tra8jHnYWBQCdmQhkk6mAst
   b8HUmac+MCPj9PpGhKRGrEBnFPP6LsETS/X7urNi0XAcHhDzi+Mkp+bAZ
   qZ85I5TrQOO237K4n1voCG0Y6A4/6Xj1t8NorZkA1tcd4lRj9VN7Bg4DK
   yJGjpL+5Amgarfjqw1ab/LJaJjOm5tb4lOF3Z09G8Z0arYHpizaVy9HaT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="5025590"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5025590"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 19:39:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="750761812"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="750761812"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2023 19:39:45 -0700
Date:   Fri, 20 Oct 2023 10:38:38 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: disable KUnit test suites when module support is
 enabled
Message-ID: <ZTHoLv4Ttvz4++H/@yilunxu-OptiPlex-7050>
References: <20231018163814.100803-1-marpagan@redhat.com>
 <ZTFBi7vfmEpR9TB0@yilunxu-OptiPlex-7050>
 <2023101924-hunk-conjuror-2d35@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023101924-hunk-conjuror-2d35@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:33:08PM +0200, Greg KH wrote:
> On Thu, Oct 19, 2023 at 10:47:39PM +0800, Xu Yilun wrote:
> > On Wed, Oct 18, 2023 at 06:38:13PM +0200, Marco Pagani wrote:
> > > The fpga core currently assumes that all manager, bridge, and region
> > > devices have a parent device associated with a driver that can be used
> > > to take the module's refcount. This behavior causes the fpga test suites
> > > to crash with a null-ptr-deref since parent fake devices do not have a
> > > driver. This patch disables all fpga KUnit test suites when loadable
> > > module support is enabled until the fpga core is fixed. Test suites
> > > can still be run using the KUnit default UML kernel.
> > > 
> > > Signed-off-by: Marco Pagani <marpagan@redhat.com>
> > 
> > LGTM, I've tested on my machine.
> > 
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > 
> > Hi Greg:
> > 
> > Could you help review and pull it in for 6.6-final if it's OK.
> > 
> > https://lore.kernel.org/linux-fpga/2023101825-ligament-undergrad-cc4d@gregkh/
> 
> Needs a "Fixes:" tag please, you can provide it here in this email
> thread and b4 will pick it up automatically for me.

Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")

Thanks,
Yilun

> 
> thanks,
> 
> greg k-h
