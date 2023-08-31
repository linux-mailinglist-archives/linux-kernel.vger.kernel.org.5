Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B93E78F269
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbjHaSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjHaSTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:19:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA4CE63;
        Thu, 31 Aug 2023 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693505983; x=1725041983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T78YspwzWrX2p/IRwKWPHz+urVC7whdLr4wWxeReeSQ=;
  b=OqMCBR4LLvk6Tby6OHKD8+i8b+jtvcDyQdhKtxb740HmIN0s15SWb9r+
   qlZAt11yOhSUvIjRzJcRJwsW9uyPduO8li7IoF8sqcFHNMWzz699rGviP
   3t0XB/LSlxEEmuTPaLdmH5Wut6cyWm/gdj5/QuBiBDle/EGFKv6fOUSjX
   oqFkJyXXWKxCvQTpagJ4JhpE1Y0V0lYGDYJTaUIIODh2RNI/BEs9a4eAt
   5haXsf+Px5zQt7V3BnqfeS/o9dCWYrwmyhzcUd9ip3RNpyJIUrf8gLAmL
   EdlVQ0QWxzfVpNJYbiW6dREE8WoS3yziHssZhbOFVjCeGQyu6dYmwkc1C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374935409"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374935409"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="716454307"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="716454307"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:19:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbmGU-005TOF-0l;
        Thu, 31 Aug 2023 21:19:34 +0300
Date:   Thu, 31 Aug 2023 21:19:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luo Jiaxing <luojiaxing@huawei.com>
Cc:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        john.garry@huawei.com, himanshu.madhani@cavium.com,
        felipe.balbi@linux.intel.com, gregkh@linuxfoundation.org,
        uma.shankar@intel.com, anshuman.gupta@intel.com,
        animesh.manna@intel.com, linux-usb@vger.kernel.org,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v4 0/5] Introduce a new helper macro
 DEFINE_SHOW_STORE_ATTRIBUTE at seq_file.c
Message-ID: <ZPDZtR8W1TLcOHW+@smile.fi.intel.com>
References: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605164864-58944-1-git-send-email-luojiaxing@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:07:38PM +0800, Luo Jiaxing wrote:
> We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
> for read-only file, but we found many of drivers also want a helper macro
> for read-write file too.
> 
> So we add this macro to help decrease code duplication.

Are you going to pursue this one?

-- 
With Best Regards,
Andy Shevchenko


