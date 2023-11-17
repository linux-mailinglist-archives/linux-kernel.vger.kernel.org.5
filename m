Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13B17EEA8D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQBF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQBF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:05:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC3129;
        Thu, 16 Nov 2023 17:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700183123; x=1731719123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZyZe8XVOWfINF/HMRNgqPyY01tqqlcNLwl5nCO+VM18=;
  b=Csa+cC9FY4NvZWVfvAZPa1KG0b4TCEO7wFi1dNJ69XtOJ+fJlE1vvEMP
   AccI/EwZL7whWKFm+q8mFxrz5djQfddveGqy/5x0qZO0Yx8i4G7MtsnSQ
   NqsDal1fhczvLZjvsWLUUe56/UR7D2Np9CFHU2mx97PxylTjscftVwmhf
   g0sZDh74FGoUbPH861+ypkz1Pr3hfknzmZu/z1t4w8PDVjuce2mWwTksH
   1w/kYZlH1hbjcBcrTjmoVOBkZ8kQf4HsPXeZkgMAIyLspsPkdBN5CAsNF
   Qj8/2VkoHFgQKGO8m78HH94sTUxioZgmxSKwCUXlNFbX59f2SA4mlRuCC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="12761721"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="12761721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:05:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="741931030"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="741931030"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:05:22 -0800
Date:   Thu, 16 Nov 2023 17:05:21 -0800
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
Subject: Re: [PATCH v6 01/16] KVM: TDP_MMU: Go to next level if smaller
 private mapping exists
Message-ID: <20231117010521.GE1277973@ls.amr.corp.intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <439c7be59c35a03bced88a44567431e721fab3da.1699368363.git.isaku.yamahata@intel.com>
 <52b01c03-15eb-4151-b94b-2433a117cf3d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52b01c03-15eb-4151-b94b-2433a117cf3d@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 09:32:22AM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> 
> 
> On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > Cannot map a private page as large page if any smaller mapping exists.
> > 
> > It has to wait for all the not-mapped smaller page to be mapped and
> > promote it to larger mapping.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >   arch/x86/kvm/mmu/tdp_mmu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> > index 2c5257628881..d806574f7f2d 100644
> > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > @@ -1287,7 +1287,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> >   	tdp_mmu_for_each_pte(iter, mmu, is_private, raw_gfn, raw_gfn + 1) {
> >   		int r;
> > -		if (fault->nx_huge_page_workaround_enabled)
> > +		if (fault->nx_huge_page_workaround_enabled ||
> > +		    kvm_gfn_shared_mask(vcpu->kvm))
> As I mentioned in https://lore.kernel.org/kvm/fef75d54-e319-5170-5f76-f5abc4856315@linux.intel.com/,
> The change of this patch will not take effect.
> If "fault->nx_huge_page_workaround_enabled" is false, the condition
> "spte_to_child_sp(spte)->nx_huge_page_disallowed" will not be true.
> 
> IIUC, the function disallowed_hugepage_adjust() currently is only to handle
> nx_huge_page_workaround, it seems no special handling needed for TD.
> >   			disallowed_hugepage_adjust(fault, iter.old_spte, iter.level);
> >   		/*

You're correct. Now guest memfd memory attributes takes care of large page
mapping, this patch is uncessary.  Will drop this patch.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
