Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85F789276
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjHYXht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjHYXhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:37:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE752D42
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693006624; x=1724542624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z3d1Mun7oeHENjApVvVpUT/wbDwYHE18/gqW60GjQAI=;
  b=DtIv1v6lK+Lrp3QmW0JBr+9U7/jfJGD0HWte7e0VHS+XOsK2RQopnBBN
   jscC6RpSLxeLexjKWGZF43qrPoeONDsCCKzannAsY1iDf7l17fFlt2/HN
   2IzKfR8uFws1ZTZLTJ+0izcrYuiB/1ypj+sCAK+OS7Kdo4GTFLhRP21vx
   K/jWEGOPBgELJBkSRn1ozGiiaHsfQ/zQqLpHi+gsklaFv9PVi/UEKVHtU
   gMM97Zb7ytZz56J6r/nuauUjbsEPtUMVi1Fkfe6TL4kor46kC2BD6oKF2
   AkTPHJI20waG5ttpwP3NEdXksRbXFvu5m2TzRzLeuspp1j9aPi8wc3kIY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="374798767"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="374798767"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:36:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="687493411"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="687493411"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:36:01 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 98982109FED; Sat, 26 Aug 2023 02:35:58 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:35:58 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230825233558.xzqukr3vbccii7f4@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cbf25e7aee3256288045023a31f65f0cef90af4.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:02:01PM +1200, Kai Huang wrote:
> +	/*
> +	 * Failure of __tdcall_hypercall() indicates a failure of the TDVMCALL
> +	 * mechanism itself and that something has gone horribly wrong with
> +	 * the TDX module.  __tdx_hypercall_failed() never returns.
> +	 */
> +	if (__tdcall_hypercall(TDG_VP_VMCALL, &margs))
> +		__tdx_hypercall_failed();

Do we even need __tdx_hypercall_failed() anymore? Just call panic()
directly, no?


-- 
  Kiryl Shutsemau / Kirill A. Shutemov
