Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843B2771497
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHFLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHFLue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CD13E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691322633; x=1722858633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ba9pH4Ej96kIzhLD9374A9bsflq4WpKM4PvDVeUYqSA=;
  b=cX+n/S6yZ/lZE5mLiB3GlHEZDFzkKaTJw+RhwT5CRkgmLv70gh+N6WPq
   rcM4ESLo/Q3XRPrPV5B492fpKohBhe0Ipn6bc091m1SKHaDrIIZYSYxAx
   UBc0FmvGwis0koeVmrEE3AZp8zuwybKgJr/ZGMf8kkcTG7jNp1Ab02gxp
   NM/E1AWibjt2k1xnXPOrHBaAIEv3E/sOxm1aVqHq7C/mzaO4NRhA0kxQD
   gBrmbRsucMhB2rkkVhX020CwoTT5FG/LSSobZ5GZ8rgjGpIb+yKZoTjbi
   Y/NgbQYBRE+rvrYWhficGZIsSsB2Uq0g3+CZI496Js4nATf41PgzyFWGo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="373128851"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="373128851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10794"; a="760137935"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="760137935"
Received: from mvalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.63.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:50:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A989A10A117; Sun,  6 Aug 2023 14:50:24 +0300 (+03)
Date:   Sun, 6 Aug 2023 14:50:24 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 12/12] x86/virt/tdx: Adjust 'struct tdx_module_args'
 to use x86 "register index" layout
Message-ID: <20230806115024.k3oc6u3yu42q7h5l@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61daaaad871e79eabf5ae25f5c4631640ffd288.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:14PM +1200, Kai Huang wrote:
> For TDX guest, KVM needs to call __seamcall_saved_ret() to make the
> TDH.VP.ENTER SEAMCALL to enter the guest, possibly taking all registers
> in 'struct tdx_module_args' as input/output.
> 
> KVM caches guest's GPRs in 'kvm_vcpu_arch::regs[]', which follows the
> "register index" hardware layout of x86 GPRs.  On the other hand, the
> __seamcall_saved_ret() takes the pointer of 'struct tdx_module_args' as
> argument, thus there's a mismatch.
> 
> KVM could choose to copy input registers from 'vcpu::regs[]' to a
> 'struct tdx_module_args' and use that as argument to make the SEAMCALL,
> but such memory copy isn't desired and should be avoided if possible.

I doubt the copy will be visible on any profile.

I personally don't like that kvm implementation detail leaks here. It
suppose to be generic TDX code.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
