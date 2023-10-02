Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1046C7B4F1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjJBJee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjJBJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:34:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805991;
        Mon,  2 Oct 2023 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696239269; x=1727775269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1GT1UWrlrSBhJhLR0+f6TVTQGsa6UIei7Cq8O0jNEtY=;
  b=EFP3jlyMgGrEFargjOk2u9hqmwhCNPKXgKa7SLWseUhXcU+00sgo4OLW
   QRvHdy/3105kIR0niYHf5x/hAVi5XdtznQGgH6fiWOmJAe+xmMH+GV4Dn
   TlfeSM2Ts5wN214Zd8OVHlwDrYsYDVfqimctms8O2rxhk4VxzE8tSZlbg
   T9USAwxXshjFUHgI/M4wkqr8/mXF5FrF7wI3T9dPRfbSEggMO98iLDvwo
   4rvrb9ZCdLNFN+645QDtjK4A6RsiAMi2z3S3wDQ1BT0MxhRmkd91YY+xZ
   mWN55NBzxy2y4Cop0pgEq7gUsm/2xk882ZPXHFz6IFR6lKlZ6uR/meLXq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="379887282"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="379887282"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="840932285"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="840932285"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:34:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnFJn-000000027XT-2l93;
        Mon, 02 Oct 2023 12:34:23 +0300
Date:   Mon, 2 Oct 2023 12:34:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: ak8975: Fix 'Unexpected device' error
Message-ID: <ZRqOn8tnJqvU22ex@smile.fi.intel.com>
References: <20231001-ak_magnetometer-v1-1-09bf3b8798a3@apitzsch.eu>
 <20231002102745.0000540b@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231002102745.0000540b@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:27:45AM +0100, Jonathan Cameron wrote:
> On Sun, 1 Oct 2023 18:09:56 +0200
> André Apitzsch <git@apitzsch.eu> wrote:

> > Fixes: 4f9ea93afde1 ("iio: magnetometer: ak8975: Convert enum->pointer for data in the match tables")

^^^ (1)

...

> So we need the spacer until someone converts this driver to use
> pointers instead for both of and ACPI tables.

Isn't it done by (1) which is in your tree?

-- 
With Best Regards,
Andy Shevchenko


