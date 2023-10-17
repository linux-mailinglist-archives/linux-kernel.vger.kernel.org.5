Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE417CCAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 20:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJQSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJQSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 14:43:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310BB90;
        Tue, 17 Oct 2023 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697568183; x=1729104183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fvN8JtK1YQPBPAULHsac4WHfv28eYma/gXCpzRF16tM=;
  b=eQfUATeFDDyaDE1nWuHKO+aXCJ9/SulXoQKfZbi8x0hu5WWFD7cqgegl
   Eh1f28n+wrXeAdR6XlfjVIMmrX6agBjwf54ZA0bPTl/5L9fWzEn7aKWuJ
   jSNfVw1tTz+liBKJ6xCvy1xqJl/KRm2CG85SOP6L2MkY/8TK9McQ4yTqL
   UQa+xQ52P07v2zLyauvKw57yqn7B4rAO2x4rTtR4ZyTz7Dx7hpz63kA22
   Q61NuRlGYsxMH3SfIyf8MxEeNn189Eu39UqUYm1w4IAN/1JMTGKL/TIAB
   101GNGmTHAbLhRcGsPyHyyydatspn8lrmp1GZ+5dQFRwKN+hDOUFX0xZ6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="388720984"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="388720984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:43:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785584710"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785584710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 11:42:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsp1r-00000006Ohp-3Usv;
        Tue, 17 Oct 2023 21:42:55 +0300
Date:   Tue, 17 Oct 2023 21:42:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v3 1/2] amba: bus: balance firmware node reference
 counting
Message-ID: <ZS7VrxX6If8Afl5R@smile.fi.intel.com>
References: <20231006145732.3419115-1-andriy.shevchenko@linux.intel.com>
 <169756785858.2487391.2620832432762980006.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169756785858.2487391.2620832432762980006.robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 01:37:43PM -0500, Rob Herring wrote:
> On Fri, 06 Oct 2023 17:57:31 +0300, Andy Shevchenko wrote:

...

> Applied, thanks!

Thanks, I hope w.o. patch 2 as it seems it can't be enabled on non-ARM
platforms due to some strange MM APIs.

-- 
With Best Regards,
Andy Shevchenko


