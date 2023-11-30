Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADEB7FF019
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345527AbjK3N2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjK3N2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:28:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F0D48;
        Thu, 30 Nov 2023 05:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701350904; x=1732886904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ghr+ezRKo3dkSi3M8C6UorBjmizIlKFEixhMc9v7FuQ=;
  b=JZRyFXkwsJor42bwB5QyvAtMoZHpMHeRfnh6aranOBz8kQ+60+XoL3mU
   MJorakhkFM2nUFqX4cfKI7ucOdKInV7ujDUdHjBIKVMYHnhmvB0QMYLOe
   Gys9Zxm5+UmyHmHU85qBXEbwt7RfQsQuucJcI/0corgE35Z5mBYxvJhgy
   92nlzCRWz8iwbr8nhOKYwG+qyhs4whS36lEhFauexnx02NCgfehW+3Mt4
   nQxD2AtweapRMhe96HAxvm6ElXjNw/tph6fVGmM82g5nzz3JDpU09qstX
   BnCOUgKK3kTXd6TPEGaXrVK5oAgWiFRTEdmBB4Ck1I2esdibEFKmsT9Io
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392187071"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392187071"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:28:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769307685"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="769307685"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:28:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8h5W-00000000ht8-1SQQ;
        Thu, 30 Nov 2023 15:28:18 +0200
Date:   Thu, 30 Nov 2023 15:28:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 19/24] i2c: designware: Uninline i2c_dw_probe()
Message-ID: <ZWiN8sY-I8cyNWCs@smile.fi.intel.com>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-20-andriy.shevchenko@linux.intel.com>
 <20231129232151.ueum2axn74qzuzes@zenone.zhora.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129232151.ueum2axn74qzuzes@zenone.zhora.eu>
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

On Thu, Nov 30, 2023 at 12:21:51AM +0100, Andi Shyti wrote:
> Hi Andy,
> 
> On Mon, Nov 20, 2023 at 04:42:01PM +0200, Andy Shevchenko wrote:
> > Since i2c_dw_probe() is going to be extended, uninline it to reduce
> > the noise in the common header.
> 
> where is it going to be extended? It's not in thie series. I'm
> fine with the patch anyway as it cleans up the header file.

It's used to be in the previous versions of the series where I have
device_set_node() API to be used.

-- 
With Best Regards,
Andy Shevchenko


