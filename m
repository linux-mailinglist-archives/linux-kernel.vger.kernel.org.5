Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A17F29B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjKUKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKUKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:04:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EEFF5;
        Tue, 21 Nov 2023 02:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700561070; x=1732097070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gnQy3DoUBVgZgIiqzEiYYxsRhdFMGruPTOBwuYMfzo=;
  b=I4u0HnMQTlw4HC94zXwdobiAT4g/1y/y4fEkq3B8NEJ1MKxz8AgVGGcA
   WUowDY4GQsZsFdOrGI7bXRyHM7Io3yIWP0BVdBh1BHuRtDp3azu4cSW1n
   YZrx/lkyEqX0gTlat7TS6T6asJUBynJ5CF50BHur0F4sZ99ax/dABXOYU
   qTYrdOWpTKaJZ7jCtI925UfqSlaFjRd6lJ0+Kb1w7TCyv2Am9l//V9aIM
   u3i1AzYYOL6Ueef7j63DT2Kw4ne+yguSAG0q2Lc1CtfTq9WQQbtp0aoRx
   9zZ4fXkOzPEBl/7PVMWBkTJecUXsaIiAoXzSf3WfBma0hbkHKnH+nH2gN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="376842924"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="376842924"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="770212819"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="770212819"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:04:18 -0800
Date:   Tue, 21 Nov 2023 02:04:18 -0800
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
Subject: Re: [PATCH v6 08/16] KVM: TDX: Pin pages via get_page() right before
 ADD/AUG'ed to TDs
Message-ID: <20231121100418.GF1109547@ls.amr.corp.intel.com>
References: <cover.1699368363.git.isaku.yamahata@intel.com>
 <c8d8b880963cc6799b681f7905a956022e47f16f.1699368363.git.isaku.yamahata@intel.com>
 <c62e8f7e-46ed-47e3-b7ff-231bd1f343e5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c62e8f7e-46ed-47e3-b7ff-231bd1f343e5@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:05:39PM +0800,
Binbin Wu <binbin.wu@linux.intel.com> wrote:

> 
> 
> On 11/7/2023 11:00 PM, isaku.yamahata@intel.com wrote:
> > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > 
> > When kvm_faultin_pfn(), it doesn't have the info regarding which page level
> > will the gfn be mapped at. Hence it doesn't know to pin a 4K page or a
> > 2M page.
> > 
> > Move the guest private pages pinning logic right before
> > TDH_MEM_PAGE_ADD/AUG() since at that time it knows the page level info.
> This patch looks strange, the code has nothing to do with the shortlog.
> It seems that the change of this patch has already been covered by 06/16.
> 
> Something went wrong when formatting the patch?

Oh, right. This patch doesn't make sense any more. I''ll drop this patch.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
