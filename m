Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97575976C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjGSNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:53:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518AB19A;
        Wed, 19 Jul 2023 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689774803; x=1721310803;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=eLReTLR7T3Lczh0yY83eGVr+L00pnkRO/M98nIcTRXc=;
  b=E+aTPrw4iEGQ7xw5TrtWI3Lxk/lAt1Up0qkAhq1RyTjLZBTEKIuVoOZy
   Huah9C4X5g2BLDjbQLQpqXiCA7462GRL2tL9/dHMV92ojsNW6r7Th2qAQ
   G3PwyW/RSNvKTqtVcj+w/f8+AP5hwwdk2Pa9kRyqs5EtFgeyTModX2weR
   0KLrG3hJAzK6OmYcQbpGa+E2FAE1s1OxyTxcJbzKKLFqznUVf9aihWU75
   Kf/2oWk41+8/DrZMZlchQHK7VVtclTLbSr2OSniCF/Y5UjGF+m0NQHfF+
   JJVWSN1S2olRI6BvKU4PSINVU8oahRBep+SooYoClL7E6b14wMR8UhLgw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="430236114"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="430236114"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:53:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717986450"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717986450"
Received: from hhuan26-mobl.amr.corp.intel.com ([10.92.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 19 Jul 2023 06:53:21 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH] x86/sgx: fix a NULL pointer
References: <CU4OBQ8MQ2LK.2GRBPLQGVTZ3@seitikki>
 <20230717202938.94989-1-haitao.huang@linux.intel.com>
 <dfb1f233-aebd-50cf-8704-e83b91ee110a@intel.com>
 <op.18ah5mn3wjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <b5779418-e2a4-ca7a-866f-97e49cd272cb@intel.com>
 <op.18aontlmwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <eb1aea6f-3688-f871-2335-ff911a51ef52@intel.com>
 <op.18aqz7sbwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <ad2d9610-61c0-4719-9df1-0116ef317d8a@intel.com>
 <op.18asliuzwjvjmi@hhuan26-mobl.amr.corp.intel.com>
 <520111c9ccdd7356f9eaf20013e3e3c75b06398e.camel@intel.com>
 <d718cdda-2d5b-9b4b-d90d-55449ec1ac75@intel.com>
Date:   Wed, 19 Jul 2023 08:53:20 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel
Message-ID: <op.18b0u6evwjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <d718cdda-2d5b-9b4b-d90d-55449ec1ac75@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Kai
On Tue, 18 Jul 2023 19:21:54 -0500, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 7/18/23 17:14, Huang, Kai wrote:
>> Also perhaps the patch title is too vague.  Adding more information  
>> doesn't hurt
>> I think, e.g., mentioning it is a fix for NULL pointer dereference in  
>> the EAUG
>> flow.
>
> Yeah, let's say something like:
>
> 	x86/sgx: Resolve SECS reclaim vs. page fault race
>
The patch is not to resolve SECS vs #PF race though the race is a  
necessary condition to cause the NULL pointer. The same condition does not  
cause NULL pointer in the ELDU path of #PF, only in EAUG path of #PF.

And the issue really is the NULL pointer not checked and fix was to reuse  
the same code to reload SECS in ELDU code path for EAUG code path


How about this:

x86/sgx:  Reload reclaimed SECS for EAUG on #PF

or

x86/sgx: Fix a NULL pointer to SECS used for EAUG on #PF

BR
Haitao
