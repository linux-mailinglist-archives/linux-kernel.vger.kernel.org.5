Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CDE8122CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjLMX0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLMX0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:26:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903E7A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702509986; x=1734045986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A/ba4SiA2FRPgmLTnLmnHbfs6QQOwcs6Xl2vcb4F2eE=;
  b=PpUI5SohGlS0iWNqJHwQSsP3+2v86BlAS2WIItitcDe47d7ZRYdZiisx
   s2SzOkpiuHqrEBiblh+VyOZWaq24kdy/3rgZq6zrrnG49Vq88D9JVo24b
   +etpUtTWePQTYDdaf/4NJpFI6rC/cw2RJWu1q0x6bmxnL+3N+obTl1IVW
   BAR5Z1C9rFFU1gp3I9uA0jKqMTC+GSvqHtx2ZAFQPSRN8FrvGdmB86N1d
   pP2e616VEZiiTevCWnTeSOWXx+grZcSmnvbwlHid/DKv/AcoI1j/UezBd
   tiYiIZrB5qgwKydr5P/zOtbEs83DlHLM22hGGiQHQ6t3kMlO2GlDXMEjI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8437653"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="8437653"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:26:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="750302232"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="750302232"
Received: from gschoede-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.110])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:26:23 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9529B10A4DA; Thu, 14 Dec 2023 02:26:20 +0300 (+03)
Date:   Thu, 14 Dec 2023 02:26:20 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     dave.hansen@intel.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        peterz@infradead.org, tglx@linutronix.de, tony.luck@intel.com,
        mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH] x86/virt/tdx: Make TDX host depend on X86_MCE
Message-ID: <20231213232620.5apm2yt4bthw7ksc@box.shutemov.name>
References: <20231213222825.286809-1-kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213222825.286809-1-kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 11:28:25AM +1300, Kai Huang wrote:
> A build failure was reported that when INTEL_TDX_HOST is enabled but
> X86_MCE is not, the tdx_dump_mce_info() function fails to link:
> 
>   ld: vmlinux.o: in function `tdx_dump_mce_info':
>   ...: undefined reference to `mce_is_memory_error'
>   ...: undefined reference to `mce_usable_address'
> 
> The reason is in such configuration, despite there's no caller of
> tdx_dump_mce_info() it is still built and there's no implementation for
> the two "mce_*()" functions.
> 
> Make INTEL_TDX_HOST depend on X86_MCE to fix.
> 
> It makes sense to enable MCE support for the TDX host anyway.  Because
> the only way that TDX has to report integrity errors is an MCE, and it
> is not good to silently ignore such MCE.  The TDX spec also suggests
> the host VMM is expected to implement the MCE handler.
> 
> Note it also makes sense to make INTEL_TDX_HOST select X86_MCE but this
> generates "recursive dependency detected!" error in the Kconfig.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Closes: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/
> Fixes: 70060463cb2b ("x86/mce: Differentiate real hardware #MCs from TDX erratum ones")
> Link: https://lore.kernel.org/all/20231212214612.GHZXjUpBFa1IwVMTI7@fat_crate.local/T/#m1a109c29324b2bbd0b3b1d45c218012cd3a13be6
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
