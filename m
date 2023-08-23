Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE44785682
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjHWLMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjHWLL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:11:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC56ECFE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692789116; x=1724325116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7lhvv0m0FRAc3xPq+YaVEQaHYC8M/wOu6WhO33cafNU=;
  b=JQoqeej0YXRCFKhIENwY/vwAHK1uN+fIKraY346svcmzKASn6ZTwOWxt
   QNC9nFi3N3rH7paN/r0sO2GCKMMfqlOyvuGvQD4t2WJv8IlZ171pAAolR
   XadIYqN2Dr1Bu9buPbu3eCm+SfxEbh643GTfbseXlTyxjjCQk7GP5s0vq
   PbsxZMxgc9DMI/boLDbZCbTd9NxUmg7WoYJ0WaBdjVIJGoGYrR6OMcXtx
   1HUF4E2/zF2dXwx30wMkg8HJdW4A88VNEHJlYlz3jUVVL4EoqLKbpS19j
   ervEi5UZJltXN5WzzMyhF+pzYvn5bRpZPenIVy9DEywYrGYnXcE3CowP3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="460501571"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="460501571"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 04:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="1067450061"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="1067450061"
Received: from bachaue1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.119])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 04:11:47 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DAA021098A2; Wed, 23 Aug 2023 14:11:44 +0300 (+03)
Date:   Wed, 23 Aug 2023 14:11:44 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/tdx: Mark TSC reliable
Message-ID: <20230823111144.x7g3cvbxjenldnih@box.shutemov.name>
References: <20230822231823.3205-1-kirill.shutemov@linux.intel.com>
 <f5dc2de9d3997c3a89bdedee6cb0bf554f400ccc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5dc2de9d3997c3a89bdedee6cb0bf554f400ccc.camel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 04:47:29AM +0000, Huang, Kai wrote:
> On Wed, 2023-08-23 at 02:18 +0300, Kirill A. Shutemov wrote:
> > In x86 virtualization environments, including TDX, RDTSC instruction is
> > handled without causing a VM exit, resulting in minimal overhead and
> > jitters. On the other hand, other clock sources (such as HPET, ACPI
> > timer, APIC, etc.) necessitate VM exits to implement, resulting in more
> > fluctuating measurements compared to TSC. Thus, those clock sources are
> > not effective for calibrating TSC.
> > 
> > In TD guests, TSC is virtualized by the TDX module, which ensures:
> > 
> >   - Virtual TSC values are consistent among all the TD’s VCPUs;
> >   - Monotonously incrementing for any single VCPU;
> 
> Nit:
> 
>     - Virtual TSC is monotonously incrementing ...
> 
> Otherwise here "incrementing" looks like a noun, which means you need to use
> "monotonous" rather than "monotonously".

Okay, will update.

> >   - The frequency is determined by TD configuration. The host TSC is
> >     invariant on platforms where TDX is available.
> > 
> > Reliable TSC is architectural guarantee for the TDX platform and it must
> > work for any sane TDX implementation.
> > 
> > Use TSC as the only reliable clock source in TD guests, bypassing
> > unstable calibration.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Acked-by: Kai Huang <kai.huang@intel.com>

Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
