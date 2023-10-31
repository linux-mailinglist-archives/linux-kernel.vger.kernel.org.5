Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052B7DC645
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjJaGIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjJaGII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:08:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DF0C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698732486; x=1730268486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9ANZeDcgmHx9iL3ddFW3DF4jmJ3lz3vvm7zaz2lgJJ4=;
  b=eYeN/ZvwsyiH/0V8KEO60DdIkQv170G8WZhAv4dbKNKZlSj7X/4kFNf5
   FDXROcKIi1Tl+mg1iydDVOdQR0uhaE7iLAXCd9iVmkj8mzkfiUh9ko7rQ
   KueOzzdqa+QYzNNUN1z7WzNhSjrHJ9r0YKF22ICRg2tsmR3mCsKPxzGue
   I5S0lXuFcOEeW2twgdRA6XPCeAs3T4UTOOcltKVFDg6qRBKXEWundEZzn
   CZLicsSWOFmNqW21DKPV6XM+QshtpIY49CYeF5TJimGFaF/Il9unV6qaa
   U+bAowXjAWpc0F5oMZL2NzZBKllLDDQZxFC7CFDOIR9aL2AMq5GnPm8Ik
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1069938"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1069938"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="904229084"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="904229084"
Received: from esukhov-mobl2.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.34.41])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:08:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id D054E10A2BD; Tue, 31 Oct 2023 09:07:59 +0300 (+03)
Date:   Tue, 31 Oct 2023 09:07:59 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Message-ID: <20231031060759.xkiwmwuihqvqjizr@box.shutemov.name>
References: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
 <20231030082714.pbma2bg2p354cuft@box.shutemov.name>
 <f4232326b949f96aa88bd40309389d4b99288fa1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4232326b949f96aa88bd40309389d4b99288fa1.camel@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:58:37PM +0000, Edgecombe, Rick P wrote:
> > It intended to get upstream alongside with the caller fixes to leak
> > memory
> > on failure, right? Maybe get it into one patchset?
> 
> Why do you think? Since the callers are smattered across various
> drivers, and those changes are now disconnected from the changes to
> CPA, I thought to just follow up each area separately. For example I
> was going to put all the hyper-v related changes together, but that
> part is RFC due to the fact that I can't really test it. The MS folks
> said they could help out there. So the different areas were feeling
> like separate series.

I am okay with doing it separately. I just was not clear on your plans
with the fixes.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
