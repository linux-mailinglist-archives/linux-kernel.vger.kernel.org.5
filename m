Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F361B79094D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjIBTJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIBTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:09:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A11B1
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693681755; x=1725217755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fSjfGaXGlAsrjYrGOMD0sns6m9N6eH2bRsHVr4szo2Q=;
  b=hzopoZSiuYoo+wKkTa49Zs4kgBtf41ldHcV1g0heMhBckYMc9CoQwOLf
   yg69mRocW9X7/Ywn1EEls9cILiiSrgkMCKGb+DL1EMH66GVAArq70/rAd
   eqKBVbWj8wC5rqviPak9ebKsmT9TkLozbqiWWzbGP0eypZPV+WrnweiHM
   tveulHb6Qj42ITnU0f8/q8bciW8Qs3o5WkmgFSNAHVM9OwR++zW86Gae2
   NJTtBp3OllUwZ40Fv3oyxiDRElqQzBmylrbB0xWUVsYqQ705KrD3RyJ3h
   Spubzj39J3P1O84fE/28RcuGwEmk9rPvvY0DlhPgTaKtm6ycaPMRMyGKE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="355888233"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="355888233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 12:09:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10821"; a="830476514"
X-IronPort-AV: E=Sophos;i="6.02,223,1688454000"; 
   d="scan'208";a="830476514"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2023 12:09:14 -0700
Date:   Sat, 2 Sep 2023 12:09:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Yi Sun <yi.sun@intel.com>, dave.hansen@intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ilpo.jarvinen@linux.intel.com,
        heng.su@intel.com, tony.luck@intel.com,
        dave.hansen@linux.intel.com, yi.sun@intel.intel.com
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZPOIVmC6aY9GBtdJ@tassilo>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPMTVNM2oBCdSYjJ@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Instead of adding overhead to the regular FPU context saving/restoring code 
> paths, could you add a helper function that has tracing code included, but 
> which isn't otherwise used - and leave the regular code with no tracing 
> overhead?
> 
> This puts a bit of a long-term maintenance focus on making sure that the 
> traced functionality won't bitrot, but I'd say that's preferable to adding 
> tracing overhead.

Or just use PT

% sudo perf record --kcore -e intel_pt/cyc=1,cyc_thresh=1/k --filter 'filter save_fpregs_to_fpstate' -a sleep 5
% sudo perf script --insn-trace --xed -F -comm,-tid,-dso,-sym,-symoff,+ipc
[000] 677203.751913565:  ffffffffa7046230               nopw  %ax, (%rax)
[000] 677203.751913565:  ffffffffa7046234               nopl  %eax, (%rax,%rax,1)
[000] 677203.751913565:  ffffffffa7046239               mov %rdi, %rcx
[000] 677203.751913565:  ffffffffa704623c               nopl  %eax, (%rax,%rax,1)
[000] 677203.751913565:  ffffffffa7046241               movq
0x10(%rdi), %rsi
[000] 677203.751913565:  ffffffffa7046245               movq  0x8(%rsi), %rax
[000] 677203.751913565:  ffffffffa7046249               leaq 0x40(%rsi), %rdi
[000] 677203.751913565:  ffffffffa704624d               mov %rax, %rdx
[000] 677203.751913565:  ffffffffa7046250               shr $0x20, %rdx
[000] 677203.751913565:  ffffffffa7046254               xsaves64 (%rdi)
[000] 677203.751913565:  ffffffffa7046258               xor %edi, %edi
[000] 677203.751913565:  ffffffffa704625a               movq 0x10(%rcx), %rax
[000] 677203.751913565:  ffffffffa704625e               testb  $0xc0, 0x240(%rax)
[000] 677203.751913636:  ffffffffa7046265               jz 0xffffffffa7046285    IPC: 0.16 (14/85)
...


So it took 85 cycles here.

(it includes a few extra instructions, but I bet they're less than what
ftrace adds. This example is for XSAVE, but can be similarly extended
for XRSTOR)

-Andi
