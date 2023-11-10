Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5935C7E825E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjKJTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344735AbjKJTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:17:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12326ED09;
        Fri, 10 Nov 2023 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699642646; x=1731178646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PsUHmw8XJtOySRw9f9IVC9DTbHAfdP93sARl5SFEqG0=;
  b=AHDgGZbTrC4cWP1sLgvK3wN6AD+8plOFRveJ30vvrNfON/OhrjQDzy47
   pfiCGmyqmAKPEZ2tqvBvmy8wJsiL+jRHGUFV14+q+/bLBpTi6WTs4ujZ2
   qT/+Tk/Ro9rMzCShP5LbE9nlD1SDUQdi5LOQHcw989N7wLYsFvAumlQkr
   vKF9o0qTe6YGq5A9y464qvqPJGbHCDFA08RF/WrKO1JlOZ0ghODqpyOW/
   gx83BoGKCmrXT+e3TLu3YrIV0iqoRHHB8xGRdfYXwuiBYxTTGXw9vzH9B
   CM8iegE9I5M/lGjnFWyIZ5K5eHCi1b8sbLxEna0M7+mQwQTMvyAe4vJxh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="11772167"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="11772167"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="887414566"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="887414566"
Received: from melindac-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.43.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:57:19 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2683C103614; Fri, 10 Nov 2023 21:57:16 +0300 (+03)
Date:   Fri, 10 Nov 2023 21:57:16 +0300
From:   kirill.shutemov@linux.intel.com
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Message-ID: <20231110185716.tyhfjim4cnxxboe4@box.shutemov.name>
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
 <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
 <20231110124626.ifq3hqaiqvgpnign@box>
 <5a80bfd8-7092-4a85-93a6-189a16725642@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a80bfd8-7092-4a85-93a6-189a16725642@linux.microsoft.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 02:42:31PM +0100, Jeremi Piotrowski wrote:
> On 10/11/2023 13:46, kirill.shutemov@linux.intel.com wrote:
> > On Fri, Nov 10, 2023 at 01:27:08PM +0100, Jeremi Piotrowski wrote:
> >>> Maybe just remove incorrect info and that's it?
> >>>
> >>
> >> I disagree, other users and I find the print very useful to see which coco
> >> platform the kernel is running on and which confidential computing features
> >> the kernel detected. I'm willing to fix the code to report correct info.
> > 
> > For TDX, we already have "tdx: Guest detected" in dmesg. sme_early_init()
> > can do something similar.
> > 
> 
> That doesn't cover TDX guests with TD partitioning on Hyper-V.

I am sure Hyper-V can report what mode it runs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
