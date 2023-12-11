Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454280DF50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345246AbjLKXKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjLKXKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:10:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B469C9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702336244; x=1733872244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fdZ2x/5+NDcHqfPGDDUoiJaMPSKPPuvvjvF9z/kpukA=;
  b=hxk66eJJFbvWrSlYgym/xWotfSSem/NLIN7Z/EOS24ltAIBF4Oggcb/S
   Cy6o3semsjSVe7kpPLCB6s/gLORZAy4IrgZfenskKwvRU7ikCumz6O2Rk
   bHG9GJkzLwqjstoBoK3ysQLp3kvOFg2Logiom1IgitHgQQRe3TSruXIjO
   1oXeIA2UxnzEG02PwCLs0LevhKnjD61TkpokaOVLQ2+1VYkxytX4SGBsd
   eBIZPOWTxDJuM/iJxlKb3CHdlars98zqu4u5eaOg9PQH00LH8+2JiALmm
   zMJHN1l236ouayX6JR4V2azrOzCGzJl95s2Z0aL0LkwaQGvTGFYYQ9wWz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374229721"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="374229721"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="722994661"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="722994661"
Received: from liviuoct-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.47.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:10:38 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9998110A290; Tue, 12 Dec 2023 02:10:35 +0300 (+03)
Date:   Tue, 12 Dec 2023 02:10:35 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCHv4 05/14] x86/kvm: Do not try to disable kvmclock if it
 was not enabled
Message-ID: <20231211231035.743cesujphsp5eve@box.shutemov.name>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205004510.27164-6-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 03:45:01AM +0300, Kirill A. Shutemov wrote:
> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
> 
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> 
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
> 
> Do not disable kvmclock if it was not enabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>

Paolo, Sean, any chance you can get it in through KVM tree while the rest
of kexec patchset is pending? The problem is visible on normal reboot too.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
