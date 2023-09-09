Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942C479973E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 12:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344281AbjIIKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIIKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 06:14:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E79D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 03:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694254477; x=1725790477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0PojMvFVMKfhl4FBzNZ4ZthlDzuXoCF2+N99oxsU6M=;
  b=MU5tFZ9JaWmf3xc0YZLSfWbO6ko2hhLY7pM3TH/oAdULR0dQP2/L2ffD
   0HtlwZVIm/msN8YH9+jlWk3gAyIv200lPsEpWOBi2JIt8pNEkaGW1GZHj
   jWBAI42XajUWKcAVbfP28pR4F1DmNVw3i1WxwLra425P2hE5uyhf7vJDo
   g5r3mePkP7U5WdvRo2q9R01zD5vEfuLrfHNRdim+9hTevUGlCAEKAYtft
   gNm6thEw/KKPALVD/hS9Z40ynBltb6/kIjGz8Ubl3/Sqx7gXurK3YPdjF
   Qkw8eOJWb++PMVS0DA9YINwVyc8nDjYkSHwqKKLQU8b3KuuTrtU+C9kfL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="368070791"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="368070791"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 03:14:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808282901"
X-IronPort-AV: E=Sophos;i="6.02,239,1688454000"; 
   d="scan'208";a="808282901"
Received: from rdota-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.216.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 03:14:32 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E64BD104CCE; Sat,  9 Sep 2023 13:14:29 +0300 (+03)
Date:   Sat, 9 Sep 2023 13:14:29 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Sagi Shahar <sagis@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Allow extended topology CPUID leafs to be
 emulated by hypercall
Message-ID: <20230909101429.otpzbwa6u5xrlxrq@box.shutemov.name>
References: <20230908175644.2478924-1-sagis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908175644.2478924-1-sagis@google.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:56:44AM -0700, Sagi Shahar wrote:
> The current TDX module does not handle extended topology leaves
> explicitly and will generate a #VE but the current #VE handler
> implementation blindly returns 0 for those CPUID leaves.
> 
> This currently causes TDX guests to see 0 values when querying the numa
> topology leading to incorrect numa configurations.
> 
> This patch fixes this behavior by emulating the extended topology leaves
> using the CPUID hypercall.
> 
> Change-Id: I427807e3ac8d9e3be50a6fac40ebd3f54b445b0c
> Signed-off-by: Sagi Shahar <sagis@google.com>

NAK. We are working on getting these and other leafs available to the
guest in a safe manner without #VE. It will take time, but it is going to
be there.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
