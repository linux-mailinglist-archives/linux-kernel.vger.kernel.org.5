Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E17F7B1EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjI1NkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjI1NkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:40:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44165136
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695908419; x=1727444419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oPKqTqDJMkCV23vGa5LNVnNbgdlafADxMIVcynlp6Lo=;
  b=Dp+ZTjtmnrWHRvsg+m67Sy+xLNNfSuqqhLnSqzMuTX1YcFdHNV/dtHA0
   xkbqep/PvoiWLv5eJHNgq295w5gl/8W2NCACX0hMpWt9oNc49NWQ72o0A
   CniXWvi4Yc7WDtrq09Hl4Jef/QBeq48uJIrcesb7qPmsGNWuPcoBUAEox
   69WXHDl6lT1u0ctHaULuo7Ed8enz0M0oKZgWYqB0CQYVUaJm/vK8sHZIq
   lrxd6JoETL2oj7A7WZWHCMLuYzVmuIMEAsuCXa5psLzr2MWl1ApJR4BFL
   E2gggyW2VLZhQv6An2FJBN6QgUaKJqvT53YaNOXxtLUlxof0fpzYsqKly
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="3627000"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="3627000"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749601019"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="749601019"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 06:40:18 -0700
Message-ID: <a5fbcf09-2445-28f1-4113-0de4f72b7f90@intel.com>
Date:   Thu, 28 Sep 2023 06:40:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] x86/bugs: Add a separate config for each mitigation
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20230628142129.2468174-1-leitao@debian.org>
 <ZRV1bIuSXjZ+uPKB@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZRV1bIuSXjZ+uPKB@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 05:45, Breno Leitao wrote:
> 1) Create one Kconfig entry per mitigation, so, the user can pick and
> choose what to enable and disable. (Version 3 of this patch. May need a
> re-spin due to the new mitigations being added.)

This means, what, roughly 18 today?

#define X86_BUG_CPU_MELTDOWN		X86_BUG(14)
...
#define X86_BUG_GDS                     X86_BUG(30)

Plus two bonus ones:

#define X86_BUG_SRSO                    X86_BUG(1*32 + 0)
#define X86_BUG_DIV0                    X86_BUG(1*32 + 1)

... and we've slowed down the rate at which we're adding these, but
we're still seeing a couple a year.

Perhaps Pawan and the others actually _doing_ the patches for these can
speak up, but I don't think adding a Kconfig option will be too much
additional work for each new X86_BUG.

I still think it's highly unlikely that someone will come through and
pick and choose among a few dozen vulnerabilities.
