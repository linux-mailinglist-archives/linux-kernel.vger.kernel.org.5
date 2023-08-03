Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036176E738
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjHCLqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235489AbjHCLp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:45:59 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F935A4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691063153; x=1722599153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xEbhqq4qZmMZHeYJD5mYwHHsq6tkrYv3gIa6jEYvF5Y=;
  b=QXjLgghAmT5oj8/ZkbA8wACD2eej+qVEaEB5MGFcUOQ2Jy8FjXeGUHqm
   VNWD6JXGwwxiwYiqSyAspaEnInU3QlP0EEHyT5Bgs0FYK/qO6L6J0XfA6
   H6n2dfYnukKvHbChPu2e9Eu8TSuwLAQTp2r06TKhKSO3xhhxtb+iY0b2k
   rnKAIjUuAUojkelpcuF9O9NdArAsUxZ23dl5ngY77k8nbb8EKvpgWCFog
   iVUDB6wEko6mav9Itrh0hJ+bwugKqVDORRSa52B2HOVOueAqV2TgaXZ+Z
   RORJV5HMtXh/LLwJusQP0M09tltJb9ea26MMWoOTlibzn+w3ZHeeZcbti
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="400790303"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="400790303"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="759097971"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="759097971"
Received: from gvarshne-mobl2.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.63.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:45:49 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B8E72109FCF; Thu,  3 Aug 2023 14:45:46 +0300 (+03)
Date:   Thu, 3 Aug 2023 14:45:46 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>
Subject: Re: [PATCH v3 07/12] x86/tdx: Make TDX_HYPERCALL asm similar to
 TDX_MODULE_CALL
Message-ID: <20230803114546.em5qsjs33i5b7ogh@box.shutemov.name>
References: <cover.1690369495.git.kai.huang@intel.com>
 <6f92d08855491b3e9ff1221d2bb7af873d546afd.1690369495.git.kai.huang@intel.com>
 <20230727171008.aw3z6oxh4vfnahep@box.shutemov.name>
 <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e75603996f88941892a19181c852ecfdc9adf06c.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 11:05:35PM +0000, Huang, Kai wrote:
> On Thu, 2023-07-27 at 20:10 +0300, kirill.shutemov@linux.intel.com wrote:
> > On Wed, Jul 26, 2023 at 11:25:09PM +1200, Kai Huang wrote:
> > > 
> > > Remove the __tdx_hypercall_ret() as __tdx_hypercall() already does so.
> > 
> > Hm. So we now update struct on all VMCALLs. Is it a good idea? 
> > 
> 
> Do you mean we "unconditionally save output registers to  the structure", right?
> 
> > We give
> > more control to VMM where it is not needed. 
> > 
> 
> I don't quite follow this.  Can you elaborate?
> 
> Do you worry about VMM being malicious and putting malicious values to the
> registers?

Yes. Caller of the hypercall may expect that the register is in-only and
re-use the field for other stuff. And it would work until VMM decide
otherwise.

> > I would rather keep the struct
> > read-only where possible.
> > 
> 
> We can achieve this if there's a clean way to do, but I don't see that.

Keep _ret() and non-_ret() versions?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
