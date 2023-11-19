Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750D37F0498
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 07:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjKSGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 01:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSGac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 01:30:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757AF192;
        Sat, 18 Nov 2023 22:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700375427; x=1731911427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fhSYPSwlbRdQhxu9SEMKRyeeuCTTrwd3mBt02oFDXq8=;
  b=neLJOy/59k1fMHpsDrvyHL58ubIbLSO+X3/IL0uyAHQQJci2LcmYWxGI
   8gv6Be5Ou+Odv4pNsQgUx4wySh1Ny6Bz2vhyQoxE5CtqqcZ6I8QJiXxuZ
   Mu0DiKEpaBS6QgsUackE7m1ZsdAcu0Ae/65ZYrpcxcff9xL1D37qutu0u
   meJHUVvJJqNAhgyBQOBcORSCqelbgSzZA5teOmPDiLbAvtx44RnJDMN5M
   Yl6ErP8/RioyrxIepchIwKgDSJkoQbB6AVmGiL6hurkHMO/D7stOOG+fw
   HAI4sTJLUScnztTGDjGDTgY765w/dDR+4FPHC8/ATujLcsbHORMxucW2m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="390333290"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="390333290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="795180209"
X-IronPort-AV: E=Sophos;i="6.04,210,1695711600"; 
   d="scan'208";a="795180209"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.93.8.180]) ([10.93.8.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 22:30:22 -0800
Message-ID: <2a5a38d9-28e2-4718-b8fc-2b8f27610706@linux.intel.com>
Date:   Sun, 19 Nov 2023 14:30:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 020/116] KVM: TDX: create/destroy VM structure
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1699368322.git.isaku.yamahata@intel.com>
 <997a92e4f667b497166ff8cc777ec8025b0f22bc.1699368322.git.isaku.yamahata@intel.com>
From:   Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <997a92e4f667b497166ff8cc777ec8025b0f22bc.1699368322.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/2023 10:55 PM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> As the first step to create TDX guest, create/destroy VM struct.  Assign
> TDX private Host Key ID (HKID) to the TDX guest for memory encryption and
> allocate extra pages for the TDX guest. On destruction, free allocated
> pages, and HKID.
>
> Before tearing down private page tables, TDX requires some resources of the
> guest TD to be destroyed (i.e. HKID must have been reclaimed, etc).  Add
> mmu notifier release callback before tearing down private page tables for
> it.
>
> Add vm_free() of kvm_x86_ops hook at the end of kvm_arch_destroy_vm()
> because some per-VM TDX resources, e.g. TDR, need to be freed after other
> TDX resources, e.g. HKID, were freed.
>
> Co-developed-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>
> ---
[...]
> +
> +static int tdx_reclaim_page(hpa_t pa)
> +{
> +	int r;
> +
> +	r = __tdx_reclaim_page(pa);
> +	if (!r)
> +		tdx_clear_page(pa);
> +	return r;
> +}
> +
> +static void tdx_reclaim_td_page(unsigned long td_page_pa)

This function is used to reclaim td control sturcture pages like TDCX, 
TDVPX,
TDVPR. Should this function name be more specific?
For me, it is a bit confusing.

Or maybe do "td page" have specific meaning referring to these control 
structures
pages in TDX?



> +{
> +	WARN_ON_ONCE(!td_page_pa);
> +
> +	/*
> +	 * TDCX are being reclaimed.  TDX module maps TDCX with HKID
> +	 * assigned to the TD.  Here the cache associated to the TD
> +	 * was already flushed by TDH.PHYMEM.CACHE.WB before here, So
> +	 * cache doesn't need to be flushed again.
> +	 */
> +	if (tdx_reclaim_page(td_page_pa))
> +		/*
> +		 * Leak the page on failure:
> +		 * tdx_reclaim_page() returns an error if and only if there's an
> +		 * unexpected, fatal error, e.g. a SEAMCALL with bad params,
> +		 * incorrect concurrency in KVM, a TDX Module bug, etc.
> +		 * Retrying at a later point is highly unlikely to be
> +		 * successful.
> +		 * No log here as tdx_reclaim_page() already did.
> +		 */
> +		return;
> +	free_page((unsigned long)__va(td_page_pa));
> +}
> +
[...]

