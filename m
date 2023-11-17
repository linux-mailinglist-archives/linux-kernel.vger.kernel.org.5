Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB047EEA49
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345585AbjKQAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjKQAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:23:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474CC11D;
        Thu, 16 Nov 2023 16:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700180615; x=1731716615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UrE/vjJRMr1sQ4SBUTBqQB3FZS2smt9NfEySrUQQePk=;
  b=B//PXgQGV7CG3oVXXgFfC6o8Zml992iVyTHX13zgtXRE5Kl6ZOW4zbFq
   MEZ7hs+oeQTqncpBja7qT22FUX9RyUEozcU5Pnuw8XIVrCpQTAXNqOYm/
   UobUwHayr5wBXOm7makh48fFmVwkiPXFE4txwUPL989N3ecUzTlub1C5K
   830Xsm/5zFq8cMlBb7hTA6ZWpGXdsgToJs7ADk3T7JMk0guKJIg6pqSs2
   aofoETAk9HMlNV6WQ+pCgrRURA+vjVxFB5OKo3pESlgJYkmTSQ8QClSRk
   qqFyKPpbDj7HZwYtbiCPtyzSvDWunfqW0zw/ebgZ1j02lj+TPARkrX5eJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="376258166"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="376258166"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:23:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="1096944836"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="1096944836"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:23:34 -0800
Date:   Thu, 16 Nov 2023 16:23:34 -0800
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
Subject: Re: [PATCH v6 03/16] KVM: TDX: Pass KVM page level to
 tdh_mem_page_add() and tdh_mem_page_aug()
Message-ID: <20231117002334.GC1277973@ls.amr.corp.intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <d3b140b63e0dc9773475724d97d566917d444791.1699368363.git.isaku.yamahata@intel.com>
 <ab5978fe-998f-4407-ae57-307606d5fb74@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab5978fe-998f-4407-ae57-307606d5fb74@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:18:28PM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> > diff --git a/arch/x86/kvm/vmx/tdx_ops.h b/arch/x86/kvm/vmx/tdx_ops.h
> > index e726102d3523..0f2df7198bde 100644
> > --- a/arch/x86/kvm/vmx/tdx_ops.h
> > +++ b/arch/x86/kvm/vmx/tdx_ops.h
> > @@ -63,6 +63,11 @@ static inline u64 tdx_seamcall(u64 op, u64 rcx, u64 rdx, u64 r8, u64 r9,
> >   void pr_tdx_error(u64 op, u64 error_code, const struct tdx_module_args *out);
> >   #endif
> > +static inline enum pg_level tdx_sept_level_to_pg_level(int tdx_level)
> > +{
> > +	return tdx_level + 1;
> > +}
> > +
> >   static inline void tdx_clflush_page(hpa_t addr, enum pg_level level)
> >   {
> >   	clflush_cache_range(__va(addr), KVM_HPAGE_SIZE(level));
> > @@ -104,11 +109,11 @@ static inline u64 tdh_mng_addcx(hpa_t tdr, hpa_t addr)
> >   	return tdx_seamcall(TDH_MNG_ADDCX, addr, tdr, 0, 0, NULL);
> >   }
> > -static inline u64 tdh_mem_page_add(hpa_t tdr, gpa_t gpa, hpa_t hpa, hpa_t source,
> > -				   struct tdx_module_args *out)
> > +static inline u64 tdh_mem_page_add(hpa_t tdr, gpa_t gpa, int level, hpa_t hpa,
> > +				   hpa_t source, struct tdx_module_args *out)
> >   {
> > -	tdx_clflush_page(hpa, PG_LEVEL_4K);
> > -	return tdx_seamcall_sept(TDH_MEM_PAGE_ADD, gpa, tdr, hpa, source, out);
> > +	tdx_clflush_page(hpa, tdx_sept_level_to_pg_level(level));
> > +	return tdx_seamcall_sept(TDH_MEM_PAGE_ADD, gpa | level, tdr, hpa, source, out);
> >   }
> 
> For TDH_MEM_PAGE_ADD, only 4K page is supported, is this change necessary?
> Or maybe huge page can be supported by TDH_MEM_PAGE_ADD in the future?


No and no. Will drop the argument. Nice catch.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
