Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955275F9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGXOcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGXOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:32:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723210D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690209145; x=1721745145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/7McPeueNkR5CKjfh+1JkwAc43EdhYfRO57egeVcAM=;
  b=XuOP+pG5Rzl+0YYLLc9HTN4L56PYZhXzzt+Jla2HNCkiZtt8PV7okOPo
   +Ztyltjlb8orF50o7KOp+Z2rZzV391h8AEMSyqttwqnug7DikjvOcAm93
   mJUb4PO6RsUGfaGFltxDl+PpHRyeZajpVGAsQmWPx49K+jB4oQ/ZrpIvR
   lse+ttPqln6UFIfbhIOk3ZmLKqCNFcD1CQaVaDIdXiapM8xoFVmkxtPnI
   w5DmqFUCz+hjv3YmUQrOTdkK7EY0OEsmWfewUN+LIlCVUlmHoWMICwgin
   0Cuq8xLvqovUxQ+u3DwEHnDONlDHffCVtbFSk4jPdhbxibgeoSKP7vG4Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398363210"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398363210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="790986953"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790986953"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 07:32:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNwbS-00H4oV-2M;
        Mon, 24 Jul 2023 17:32:02 +0300
Date:   Mon, 24 Jul 2023 17:32:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Herve Codina <herve.codina@bootlin.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yang Guang <yang.guang5@zte.com.cn>
Subject: Re: [PATCH v1 1/1] Revert "um: Use swap() to make code cleaner"
Message-ID: <ZL6LYvUpuRtwmWXZ@smile.fi.intel.com>
References: <20230724142307.28411-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724142307.28411-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:23:07PM +0300, Andy Shevchenko wrote:
> This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.
> 
> The sigio.h is clearly user space code which is handled by

Should be .c

> arch/um/scripts/Makefile.rules (see USER_OBJS rule).
> 
> The above mentioned commit simply broke this agreement,
> we may not use Linux kernel internal headers in them without
> thorough thinking.
> 
> Hence, revert the wrong commit.

Missing Reported-by

> Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/

I have just sent a v2: https://lore.kernel.org/r/20230724143131.30090-1-andriy.shevchenko@linux.intel.com.

-- 
With Best Regards,
Andy Shevchenko


