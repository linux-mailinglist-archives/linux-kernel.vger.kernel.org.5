Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F678927C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjHYXmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjHYXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:41:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29872681
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693006883; x=1724542883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TP+As+nlB6Ht2oXJnL7zJjnZpxjV249m6p9AwdyS7o4=;
  b=ZB7P21+Uz9qwiBK5vrRsDQXtIZkq0T6v3mD0TrPQV9GQbNid4TQp/sW4
   xIOkq8t8bh0MYRRfNY8T0Ny51NX/2/oQ3u/4tbqiFLn7EC2sdlrjhkqrz
   6UTKqLLzol2xclgdvmNyVY3VjUwiF+hAwyBTtgp7AdLx5KHkLkjKVBS2O
   chmXELYPmL6ihg+xQHQAPIWSa6efLTlTcTTE69tN/hQA1sCjDE2d+t8g7
   Eea7xJv4eOkMZFjbZUoRlJ5Wa4tfSmTsDnYYbAIEzKNuSupumcPZ8O88A
   Fn5w5mhInfGOEi6qPRsgXNicfxq//C9sHfppam6eH8qrYWBTUugQQTLja
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="405820881"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="405820881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="861225184"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="861225184"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:41:18 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A252E109FED; Sat, 26 Aug 2023 02:41:15 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:41:15 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 11/12] x86/virt/tdx: Make TDX_MODULE_CALL handle
 SEAMCALL #UD and #GP
Message-ID: <20230825234115.wxuspnhiyuuf5bhu@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <de975832a367f476aab2d0eb0d9de66019a16b54.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de975832a367f476aab2d0eb0d9de66019a16b54.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:02:05PM +1200, Kai Huang wrote:
> SEAMCALL instruction causes #UD if the CPU isn't in VMX operation.
> Currently the TDX_MODULE_CALL assembly doesn't handle #UD, thus making
> SEAMCALL when VMX is disabled would cause Oops.
> 
> Unfortunately, there are legal cases that SEAMCALL can be made when VMX
> is disabled.  For instance, VMX can be disabled due to emergency reboot
> while there are still TDX guests running.
> 
> Extend the TDX_MODULE_CALL assembly to return an error code for #UD to
> handle this case gracefully, e.g., KVM can then quietly eat all SEAMCALL
> errors caused by emergency reboot.
> 
> SEAMCALL instruction also causes #GP when TDX isn't enabled by the BIOS.
> Use _ASM_EXTABLE_FAULT() to catch both exceptions with the trap number
> recorded, and define two new error codes by XORing the trap number to
> the TDX_SW_ERROR.  This opportunistically handles #GP too while using
> the same simple assembly code.
> 
> A bonus is when kernel mistakenly calls SEAMCALL when CPU isn't in VMX
> operation, or when TDX isn't enabled by the BIOS, or when the BIOS is
> buggy, the kernel can get a nicer error code rather than a less
> understandable Oops.
> 
> This is basically based on Peter's code.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
