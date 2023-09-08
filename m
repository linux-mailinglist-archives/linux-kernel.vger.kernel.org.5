Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E3798BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbjIHSAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbjIHSAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:00:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE00F1FCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694196011; x=1725732011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJcDDd1iiAVsiZV2Yf1EraA6YBLwWFpJzpmN/FxXRqU=;
  b=ZxnScoGiz8s/raedoaRDbkoZDPz+edlfX6vjhxpNNJoEPYrCOunWI8Xu
   qIEXvLKMIbgI4IOmfJZxKl5nYwte2tb5BHSsiBXJo3t66QYOY1UebLFq3
   ZcXZFlxzViY8jQA9+0FABcBE1woF7a6A9RetEpSCNA7tXPu/Va3zUoUob
   pe98Mzy+TUd7u22EiAQpyNgtLwAmniTtQFJZeEwwnvBYDX2fu/wupDIlt
   CISoScY1i6EcOR+CXFltDe91k1mb6dU8xOw+XtNoJQAxBbR6EL4w7lnf9
   QW0zliotl9eDpQYNDddE3GRDmpiOviOY3ME+Ou72LTD8DNbErqyCQuMBs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="381527330"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="381527330"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832738267"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832738267"
Received: from fgilganx-mobl1.amr.corp.intel.com (HELO [10.209.17.195]) ([10.209.17.195])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 11:00:09 -0700
Message-ID: <d08303a4-321b-419c-5b3b-11f05e4286ae@intel.com>
Date:   Fri, 8 Sep 2023 11:00:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] x86/tdx: Allow extended topology CPUID leafs to be
 emulated by hypercall
Content-Language: en-US
To:     Sagi Shahar <sagis@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Vishal Annapurve <vannapurve@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230908175644.2478924-1-sagis@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230908175644.2478924-1-sagis@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/23 10:56, Sagi Shahar wrote:
> The current TDX module does not handle extended topology leaves
> explicitly and will generate a #VE but the current #VE handler
> implementation blindly returns 0 for those CPUID leaves.
> 
> This currently causes TDX guests to see 0 values when querying the numa
> topology leading to incorrect numa configurations.
> 
> This patch fixes this behavior by emulating the extended topology leaves
> using the CPUID hypercall.

... and thus acquires the data from the untrusted VMM.  Right?

What are the security implications of consuming this untrusted data?
