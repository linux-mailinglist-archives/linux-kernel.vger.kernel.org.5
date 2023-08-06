Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D62C77148C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjHFLlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjHFLli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 07:41:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F8BE50
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691322097; x=1722858097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XrZMQmI6MoNirDc2KHAZ0SOGCMPeMfTWWbIJA4afiow=;
  b=Cbd5M8L4vXfIKFfYZ6D6HBliWF3A9/b86rWx9TLr1sb6veDoqmOSx5AP
   wAPTZniaIj6aCGWc8pwEjGZemKXigXEaGvVY7AT+K8ozvh2ABgnQCNxdf
   bRiJuZo75a/gRuYfl5JF2k1CEWXv6r/aEvtHuNbcMn2djRq4AWYVuf0+b
   vp43ECXuO1EEwElpY8Tl8MjTEiMXI2Uz0TaHQQauQjPDHbEyX6nYahWUl
   XiWIxYEZrs0gHbRRbPYRaAq7YGnCbaxlXGZQZyuODrBJpckBH0Sdqw6Y/
   JP3e1S2vUEHHXqKF38bpOCe+pr8gl1Lyt40aPBFeSCANQ4buMyRr043XA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="373128360"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="373128360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="760136661"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="760136661"
Received: from mvalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.63.122])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2023 04:41:34 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5D26510A117; Sun,  6 Aug 2023 14:41:31 +0300 (+03)
Date:   Sun, 6 Aug 2023 14:41:31 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 11/12] x86/virt/tdx: Allow SEAMCALL to handle #UD and
 #GP
Message-ID: <20230806114131.2ilofgmxhdaa2u6b@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659b10910c206cb4a8de314fcf7cd58814279aa6.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:13PM +1200, Kai Huang wrote:
> @@ -20,6 +21,9 @@
>  #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
>  #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
>  
> +#define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
> +#define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)

Is there any explantion how these error codes got chosen? Looks very
arbitrary and may collide with other error codes in the future.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
