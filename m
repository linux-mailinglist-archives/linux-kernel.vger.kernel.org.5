Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4670792B1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbjIEQsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354320AbjIEKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:41:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB38199;
        Tue,  5 Sep 2023 03:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693910504; x=1725446504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCTJM66KQGwvClf1+dcoU1IHhDUz9tVaja1XN/F3RyA=;
  b=GYNJe5WQhpv6k82MTdiAxPOq3iC+2ytyerbfuFY+/M8LLbRIfzk5tkQ8
   8GpzdIFSbSCCmttAXDw82DXo9LYj/IqXoLtYJ/D3WW6r9Qz1mblNn+msX
   CmCyRCBdJ9q/ui0d2aDI81KdwnUQSyb4qQOSEY8ASG8Gz4JbwEImpvVf5
   mxi+8PJO7mYnJ8/S15JSpf3gRAYoo8N5mHlQH4SsG3Mfm1X7x5liPPagb
   6eBCUUdWToBvYxljcuDT3Wv4PRV3dq7BXv2I9W5rhQafdV+3drKFHgep0
   dOsZLWHl68+aGx7TRgOg6R35BaNH3lhJbR6NXQfGn7yxc1//bujoker0L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="443161982"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="443161982"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="1071930708"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="1071930708"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:41:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdTV0-006eoC-2V;
        Tue, 05 Sep 2023 13:41:34 +0300
Date:   Tue, 5 Sep 2023 13:41:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xingui Yang <yangxingui@huawei.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, damien.lemoal@opensource.wdc.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        himanshu.madhani@cavium.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, uma.shankar@intel.com,
        anshuman.gupta@intel.com, animesh.manna@intel.com,
        linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        prime.zeng@hisilicon.com, kangfenglong@huawei.com,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v6 3/3] scsi: qla2xxx: Use DEFINE_SHOW_STORE_ATTRIBUTE()
 helper for debugfs
Message-ID: <ZPcF3tAeTt66IH+A@smile.fi.intel.com>
References: <20230905024835.43219-1-yangxingui@huawei.com>
 <20230905024835.43219-4-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905024835.43219-4-yangxingui@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:48:35AM +0000, Xingui Yang wrote:
> Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for read-write file to reduce some
> duplicated code.

I was talking about comment only, but okay, this is good enough, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


