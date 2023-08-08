Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17DC7743DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbjHHSLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHHSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:10:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAF91BAE6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691514785; x=1723050785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mhUr+URDNngCOROwuc7a7eHBnzo84/kxXYPI0jAI72U=;
  b=WWK5p9Rl/qRP6LajiMZyFFZ6QaEo2hrJ9p1yibf3X91xPeXFVGnzovOU
   f3bxr8rQ61DaNytrCS20Uf2IYOKSbZCMcxNjWZt5yrCPsXWze5N+i9qjN
   V/thq5tTT29az43fITuj7STHj15A6GP35MiPNpePRETtDbXx6eKXeUsZP
   df7fcUUQ0dL0Yj1B1VNCPIzG6gbuAb45Q5UNfQzKrhP5uc7ckIWFqRxJN
   Vvv36vYmDip1e7LWG1SjI1vc2WfI4bIZ4Z2362BzRtmyDHpkK0R+t4EU9
   BRPyBcKNlNXmu3zPb+TMrCieWltcRl+t07bcR7xyybm/m7tuTBLiD+XDV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="368347649"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="368347649"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="874829818"
Received: from mdaugher-mobl.amr.corp.intel.com (HELO [10.212.220.28]) ([10.212.220.28])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 10:13:07 -0700
Message-ID: <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
Date:   Tue, 8 Aug 2023 10:13:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 09:23, Kirill A. Shutemov wrote:
...
> On the other hand, other clock sources (such as HPET, ACPI timer,
> APIC, etc.) necessitate VM exits to implement, resulting in more 
> fluctuating measurements compared to TSC. Thus, those clock sources
> are not effective for calibrating TSC.

Do we need to do anything to _those_ to mark them as slightly stinky?

> In TD guests, TSC is virtualized by the TDX module, which ensures:
> 
>   - Virtual TSC values are consistent among all the TD’s VCPUs;
>   - Monotonously incrementing for any single VCPU;
>   - The frequency is determined by TD configuration. The host TSC is
>     invariant on platforms where TDX is available.

I take it this is carved in stone in the TDX specs somewhere.  A
reference would be nice.

We've got VMWare and Hyper-V code basically doing the same thing today.
So TDX is in kinda good company.  But this still makes me rather
nervous.  Do you have any encouraging words about how unlikely future
hardware is to screw this up, especially as TDX-supporting hardware gets
more diverse?
