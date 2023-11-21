Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAE57F29AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjKUKCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:02:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKUKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:02:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3112C;
        Tue, 21 Nov 2023 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700560962; x=1732096962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P53K9nuYns+G3kNjOrAT6WDUrhQtdzcmrGZfrt36JG4=;
  b=DdEJoy7BLQPpraGlwMaUlxhU1r6bCQ+xy5OyfH5s8HAqzTuMS8gJHs4T
   M6B4MEHBaSU+DE+fxq3qmtd3QewOPZT/lcmtwo+xx732vMRvvn5krhrNK
   lRTLE06kiFRZRS4IY8wSfoE9SNk68qutKWYuAg8uFD41wlDPIeI7jPdi4
   8UQKcFjeSzju9sNpBnnimo1qkZ4CUk20pK2K0FQoaydTiOFJ9OQp6WEDi
   4eMI1s2D81z9twojdeuRKLk7hqqWU1nOKFdXoHeXmfGYErlvyYVXuK3Dr
   D67w4NLfH35YxEqecVnCUa1uuejAn7bQqzBGx+KXh4C8wQCEEq8Q1QJcm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371980560"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371980560"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:02:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="8033718"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:02:42 -0800
Date:   Tue, 21 Nov 2023 02:02:41 -0800
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     Binbin Wu <binbin.wu@linux.intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v6 07/16] KVM: MMU: Introduce level info in PFERR code
Message-ID: <20231121100241.GE1109547@ls.amr.corp.intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <ea9057ece714a919664e0403a3e7f774e4b3fedf.1699368363.git.isaku.yamahata@intel.com>
 <8e0934a0-c478-413a-8a58-36f7d20c23e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e0934a0-c478-413a-8a58-36f7d20c23e9@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 06:54:07PM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> 
> 
> On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > For TDX, EPT violation can happen when TDG.MEM.PAGE.ACCEPT.
> > And TDG.MEM.PAGE.ACCEPT contains the desired accept page level of TD guest.
> > 
> > 1. KVM can map it with 4KB page while TD guest wants to accept 2MB page.
> > 
> >    TD geust will get TDX_PAGE_SIZE_MISMATCH and it should try to accept
> s/geust/guest
> 
> >    4KB size.
> > 
> > 2. KVM can map it with 2MB page while TD guest wants to accept 4KB page.
> > 
> >    KVM needs to honor it because
> >    a) there is no way to tell guest KVM maps it as 2MB size. And
> >    b) guest accepts it in 4KB size since guest knows some other 4KB page
> >       in the same 2MB range will be used as shared page.
> > 
> > For case 2, it need to pass desired page level to MMU's
> > page_fault_handler. Use bit 29:31 of kvm PF error code for this purpose.
> 
> The level info is needed not only for case 2, KVM also needs the info so
> that
> it can map a 2MB page when TD guest wants to accept a 2MB page.

"MMU's page_fault_handler" = KVM MMU page fault handler, isn't it?
I'll replace it with KVM MMU page fault handler for clarity.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
