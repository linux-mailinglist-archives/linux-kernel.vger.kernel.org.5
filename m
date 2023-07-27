Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E57659C3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjG0RPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232640AbjG0ROu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:14:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E3035B8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690478075; x=1722014075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ujXb8LfvFNVC0UOOG3v0gUrrKZ3aE0O8LdWpe34Cauk=;
  b=huGaDRKG1wvmXNsKIEqwY87agi/ch1WaZAVd1GD+WoOC9WoYPF8uBgFh
   w20jnbvjX/nAxYnLTVVMrVwYjgdCsJ1Nj8ttcMqLwgpYczwTvdB2RLSti
   uJrLeVzl6zrdanF6IlUTWz3slM63+UreZ4OLF6sDxbOZt/MsfV8zMVbVO
   R+PsNryLawcWEcNQRubdSqvNlIqgUOoP7HizdXMQ40ZdMdswfxMMeYahz
   iGGnvQqf4Pipi+RMlCMOff3f6Zirp9qh0hJqM9frlCxQZm3to4OYdQ7vW
   V/UEqsjhN6FI2kxR3VDdwAL76sSO+3hzMMjKsDEmUkG1pYzd+Ng2J5Vn+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353290858"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="353290858"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 10:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="792465554"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="792465554"
Received: from lzhiguno-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.37.222])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 10:10:10 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 60418109503; Thu, 27 Jul 2023 20:10:08 +0300 (+03)
Date:   Thu, 27 Jul 2023 20:10:08 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:25:09PM +1200, Kai Huang wrote:
> 
> Remove the __tdx_hypercall_ret() as __tdx_hypercall() already does so.

Hm. So we now update struct on all VMCALLs. Is it a good idea? We give
more control to VMM where it is not needed. I would rather keep the struct
read-only where possible.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
