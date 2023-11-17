Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A567EEA24
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbjKQAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKQAFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:05:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE89EA;
        Thu, 16 Nov 2023 16:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700179500; x=1731715500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCpoMe2jdL8uHEa4QpYFjqifiicTJLTeMzgEjOKcuyQ=;
  b=Uh3ZDMaBZFfBL0YjdfoXjvpRL1ALDc4zpVwYiHkjPzkKGKkFVqyBL9Jp
   ZrJpj8L7fhTuu+aHHPIphX0JZp+BnEncQOC5OLdIRh2zi2jqXaAtDHsWn
   lBIWlnCeLhHotyysS6YNCK68gXoTfQ/X+fx1UbG1uoBCrmAZlK8Ie+7kO
   Z/YPQAbCTow+1kgRQ7X2AJoInAfEhUENKprVDnxKiZOU2rArUUeToc7oG
   GgOK3K55mwWX+vIG85MBRBiZRJh/8P8SVyoOFeFo/wdxg6M6gtF7dsBGQ
   V6SEtrCadFYg1UxA24A0SEqSytPIKuJVK2RkbX3nrFIeX+BLFNY/bkRBH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="390988321"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="390988321"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:05:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="889073721"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="889073721"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 16:04:58 -0800
Date:   Thu, 16 Nov 2023 16:04:58 -0800
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
        hang.yuan@intel.com, tina.zhang@intel.com, gkirkpatrick@google.com,
        isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v17 059/116] KVM: TDX: Create initial guest memory
Message-ID: <20231117000458.GB1277973@ls.amr.corp.intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <e8fdc92439efeed0ee05f39b1cd2dc1023014c11.1699368322.git.isaku.yamahata@intel.com>
 <c9413cb8-8aae-4233-b55f-fbac91459173@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9413cb8-8aae-4233-b55f-fbac91459173@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:35:33PM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> 
> 
> On 11/7/2023 10:56 PM, isaku.yamahata@intel.com wrote:
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > Because the guest memory is protected in TDX, the creation of the initial
> > guest memory requires a dedicated TDX module API, tdh_mem_page_add, instead
> > of directly copying the memory contents into the guest memory in the case
> > of the default VM type.  KVM MMU page fault handler callback,
> > private_page_add, handles it.
> > 
> > Define new subcommand, KVM_TDX_INIT_MEM_REGION, of VM-scoped
> > KVM_MEMORY_ENCRYPT_OP.  It assigns the guest page, copies the initial
> > memory contents into the guest memory, encrypts the guest memory.  At the
> > same time, optionally it extends memory measurement of the TDX guest.  It
> > calls the KVM MMU page fault(EPT-violation) handler to trigger the
> > callbacks for it.
> > 
> > Reported-by: gkirkpatrick@google.com
> > Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> > 
> > ---
> > v15 -> v16:
> > - add check if nr_pages isn't large with
> >    (nr_page << PAGE_SHIFT) >> PAGE_SHIFT
> > 
> > v14 -> v15:
> > - add a check if TD is finalized or not to tdx_init_mem_region()
> > - return -EAGAIN when partial population
> > ---
> >   arch/x86/include/uapi/asm/kvm.h       |   9 ++
> >   arch/x86/kvm/mmu/mmu.c                |   1 +
> >   arch/x86/kvm/vmx/tdx.c                | 167 +++++++++++++++++++++++++-
> >   arch/x86/kvm/vmx/tdx.h                |   2 +
> >   tools/arch/x86/include/uapi/asm/kvm.h |   9 ++
> >   5 files changed, 185 insertions(+), 3 deletions(-)
> > 
> [...]
> > +static int tdx_sept_page_add(struct kvm *kvm, gfn_t gfn,
> > +			     enum pg_level level, kvm_pfn_t pfn)
> 
> For me, the function name is a bit confusing.
> I would relate it to a SEPT table page instead of a normal private page if
> only by the function name.
> 
> Similar to tdx_sept_page_aug(), though it's less confusing due to there is
> no seam call to aug a sept table page.

How about tdx_mem_page_{add, aug}()?
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
