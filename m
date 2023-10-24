Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4925E7D4E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjJXLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjJXLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:01:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C568410C9;
        Tue, 24 Oct 2023 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698145292; x=1729681292;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=85PAA1+GqsYhqFpnQoQXck2TLmZV/C60H5Ubi4po3Rw=;
  b=AwRgj5dnohVDVzsjGaFMMX3QUrcpYU6brBLDHQFsPgOq6rZ3ukFQYd76
   kWW7DqfAD2Mpcx7ty4zOHYnyvAU3apwJ+A1AbbRjcxhZiIf7fvxA2tlUX
   xVML909SqnPt5sXMuJa+upyiBexIQxRG43YS+G1+r1N9bPZk8+K3ztlg/
   1d7plWKcK/BYzsKIPe1YhF0C1vgywycBR+Ff7naL3RK+7iDpLdAEgeUXU
   l33PwfycajpKoxI5v9aBsZfThk4wKLVpGo/KC1WegboTUeAAUnBvoBd6j
   3YOjgQho21+rOXKSsWErng3SWoxuz5x1uTpi82cFDGvEB1ZNqvF9BjxX6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="377408813"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="377408813"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708244687"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="708244687"
Received: from nkraljev-mobl.ger.corp.intel.com ([10.249.41.91])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:29 -0700
Date:   Tue, 24 Oct 2023 14:01:26 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>
cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
In-Reply-To: <20231024161425.0b382725@canb.auug.org.au>
Message-ID: <a7d53cbd-d934-f0d3-af2a-fc16f642c4b9@linux.intel.com>
References: <20231024161425.0b382725@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, Stephen Rothwell wrote:

> Hi all,
> 
> After merging the pci tree, today's linux-next build (arm64 defconfig)
> failed like this:
> 
> In file included from <command-line>:
> drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_ep_irq_thread':
> include/linux/compiler_types.h:435:45: error: call to '__compiletime_assert_497' declared with attribute error: FIELD_PREP: value too large for the field
>   435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |                                             ^
> include/linux/compiler_types.h:416:25: note: in definition of macro '__compiletime_assert'
>   416 |                         prefix ## suffix();                             \
>       |                         ^~~~~~
> include/linux/compiler_types.h:435:9: note: in expansion of macro '_compiletime_assert'
>   435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>    68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>       |                 ^~~~~~~~~~~~~~~~
> include/linux/bitfield.h:114:17: note: in expansion of macro '__BF_FIELD_CHECK'
>   114 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>       |                 ^~~~~~~~~~~~~~~~
> drivers/pci/controller/dwc/pcie-tegra194.c:498:29: note: in expansion of macro 'FIELD_PREP'
>   498 |                 val = 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | LTR_MSG_REQ;
>       |                             ^~~~~~~~~~
> 
> Caused by commit
> 
>   18ca6c2c2d0e ("PCI: dwc: Use FIELD_GET/PREP()")
> 
> I have reverted that commit for today.

Thanks for providing the full error message. I already was trying to
investigate it and reproduce the problem because LKP's report I got about 
this failed to provide the full error message.

It seems that the original code was more complex than it looked and the 
patch is wrong and suboptimal on multiple counts. I'll provide a fixed 
v2.

-- 
 i.

