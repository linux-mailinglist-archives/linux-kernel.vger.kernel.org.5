Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E937658EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjG0Qjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjG0Qjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:39:46 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B8273D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690475985; x=1722011985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RI85hPQlhBFAXR1YGTbviOk2eANaFYxndRW93QBWhOM=;
  b=P2G+LNmw18279LGidW2yUuVNkgRFf4wHz1sr+6lFsXOYxo4v0SuLWDG4
   /0EWvwucRQ5CuKLC/KfBkpqc8yiYuUaCsOUZ6yqscq0fmc9r4WQTTTtSA
   /btajunVQ/4bWOZ+zPWTCwtE7u/xanwCOPk0KdNeJmEukdbab1KCYg4J4
   KT1VCvI3jE/Iq+Yfor6VEmug0DVPF1+OkrClRGxC52xbCkTQQPYcDJGSI
   0dKF4eRD537CHQA8n3OC04UDfhM3ePws1DGa/6fMicKoc2sWcVyPx0Wme
   gpBA5oeOrlgHQAp3iALc9ze+NjLPaWnqzvKZWTLHRCDg7ZFgDXVEoSLV2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432181346"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="432181346"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="797114748"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="797114748"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 09:36:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 62ADC109503; Thu, 27 Jul 2023 19:36:30 +0300 (+03)
Date:   Thu, 27 Jul 2023 19:36:30 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 05/12] x86/tdx: Pass TDCALL/SEAMCALL input/output
 registers via a structure
Message-ID: <20230727163630.gcsczhebozgf2tsu@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd9886e5fffe5ccccf5895627be2fff209a69049.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:07PM +1200, Kai Huang wrote:
> diff --git a/arch/x86/virt/vmx/tdx/tdxcall.S b/arch/x86/virt/vmx/tdx/tdxcall.S
> index 6bdf6e137953..a0e7fe81bf63 100644
> --- a/arch/x86/virt/vmx/tdx/tdxcall.S
> +++ b/arch/x86/virt/vmx/tdx/tdxcall.S
> @@ -17,34 +17,33 @@
>   *            TDX module and hypercalls to the VMM.
>   * SEAMCALL - used by TDX hosts to make requests to the
>   *            TDX module.
> + *
> + *-------------------------------------------------------------------------
> + * TDCALL/SEAMCALL ABI:
> + *-------------------------------------------------------------------------
> + * Input Registers:
> + *
> + * RAX                 - TDCALL/SEAMCALL Leaf number.
> + * RCX,RDX,R8-R9       - TDCALL/SEAMCALL Leaf specific input registers.
> + *
> + * Output Registers:
> + *
> + * RAX                 - TDCALL/SEAMCALL instruction error code.
> + * RCX,RDX,R8-R11      - TDCALL/SEAMCALL Leaf specific output registers.
> + *
> + *-------------------------------------------------------------------------

So, you keep the existing asymetry in IN and OUT registers. R10 and R11
are OUT-only registers. It can be confusing for user since it is the same
structure now. I guess it changes in the following patches, but I would
prefer to make them even here if there's no good reason not to.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
