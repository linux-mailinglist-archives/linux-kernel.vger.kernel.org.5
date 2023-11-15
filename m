Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA07EC413
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbjKONtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344009AbjKONtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:49:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFE9B;
        Wed, 15 Nov 2023 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700056153; x=1731592153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PC2cUnJ3yMixJGG9GCDdE6fgLsA8r1OE7l/THWKQIlE=;
  b=PtTZB3obeGHgtmeWA/Zb636qESJZyQDvd3lk7ZgrPq7SMopU3QAKy+sU
   nK8C9p5KDkFDinbQOVrcGULKBBfR/NC3Ha7WPuvkfVvqGhBhE3ePxtJcH
   UCMJOWigVW+nnu69MaalfmB3N7v9Sq5bC6n+jWLQFFv/11P/ysWruI2IJ
   Pgr75if7YynkX+GdawX2FApx56KT7mSf8skd99QFEagAUQejHR6uee/PB
   pvHMPoWgloNdRn6VVyM5vR0gTbwi3v/WgZUPWIgcYECEUQwg6CkFD4BJ8
   yt5Y17Ml8OBes5q06vmUFr5JnmwSzJhzPJZTpVD3Xzh/qu7aP1qEIgYI7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390673129"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="390673129"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="799856229"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="799856229"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 05:49:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r3GGQ-0000000EKOk-0swo;
        Wed, 15 Nov 2023 15:49:06 +0200
Date:   Wed, 15 Nov 2023 15:49:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 01/25] i2c: designware: Delete adapter before
 disabling in i2c_dw_pci_remove()
Message-ID: <ZVTMUWn3UT99sRaU@smile.fi.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
 <20231110182304.3894319-2-andriy.shevchenko@linux.intel.com>
 <fa91c90d-c0d6-49d1-a7e5-732aac0c7ed5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa91c90d-c0d6-49d1-a7e5-732aac0c7ed5@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:45:10AM +0200, Jarkko Nikula wrote:
> On 11/10/23 20:11, Andy Shevchenko wrote:
> > Make i2c_dw_pci_remove() to be aligned with dw_i2c_plat_remove() on
> > the sequence of the ceasing I²C operations.
> > 
> > Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
> 
> I think this is wrong. Commit 18dbdda89f5c is 12 years ago so is this patch
> really fixing a real bug that was hiding all these years?

Why not? But let me check more careful the ordering between two and probe.

-- 
With Best Regards,
Andy Shevchenko


