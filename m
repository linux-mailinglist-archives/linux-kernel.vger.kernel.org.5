Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADA78927F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjHYXo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHYXol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:44:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3F9173F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693007078; x=1724543078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afV1EmfwK9TDCDNv6ko/rEgplg/i5FXByvQcTjF8y40=;
  b=DdvOVqMmdspJldRUuxeXlwl2+1UoQeYuX3MN4OQy9b/amI1fKfeFGs91
   Wu0Mzpj+sG/a/Or5Vd+t6eV7D6axBDLavzdh7dVtesynbS19G4fQOzd1H
   4nfs60exHNBvcU97Jrs2bI2jsiMwPZLBpL5A1fb8aPjMpA556lWN1PQBA
   6espIBo37RMCiM0peA0eKjcoE2bDIIdzz9Xwls53nX06ho53ptKqP78PQ
   MkZSWyclqnPAay/ZUFKWIeUdMjzHxpaNF0D3KeYC1ur+W838U9/WKwkfN
   QptfZYQKGaMHovOoX00dW+FOEK9f20qtfRr1YTxuSz2olNt9m0hknhO4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461190115"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="461190115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:44:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="852147630"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="852147630"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:44:35 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 809B6109FED; Sat, 26 Aug 2023 02:44:32 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:44:32 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Message-ID: <20230825234432.3ynoxtlguhqj4axl@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <fb599b890b34c7d76c57543a784c281111ea0bf0.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb599b890b34c7d76c57543a784c281111ea0bf0.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:02:06PM +1200, Kai Huang wrote:
> diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
> index 74fc466dfdcd..8d1427562c63 100644
> --- a/arch/x86/include/asm/shared/tdx.h
> +++ b/arch/x86/include/asm/shared/tdx.h
> @@ -58,24 +58,31 @@
>   * Used in __tdcall*() to gather the input/output registers' values of the
>   * TDCALL instruction when requesting services from the TDX module. This is a
>   * software only structure and not part of the TDX module/VMM ABI
> + *
> + * Note those *_unused are not used by the TDX_MODULE_CALL assembly.
> + * The layout of this structure also matches KVM's kvm_vcpu_arch::regs[]
> + * layout, which follows the "register index" order of x86 GPRs.  KVM
> + * then can simply type cast kvm_vcpu_arch::regs[] to this structure to
> + * avoid the extra memory copy between two structures when making
> + * TDH.VP.ENTER SEAMCALL.

I still don't like KVM details leak here. I don't feel strong enough about
it to NAK the patch, but...

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
