Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8662C7B550D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjJBOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjJBOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:23:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21DBAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696256593; x=1727792593;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lUSBW27X5TbkpCfBFIk3FcOkcviHgP3tIGt/RUD5CEA=;
  b=XwWrlBFQBbnvs2Bb1hidlKFiLUV/nV4fJDDurxHCpUO9+Li3a2adXb4j
   +Ag3a0GLgcCwWD5FYZl1qA3jgxfzHi15I8FEmttxbDfyryoOD/bL7CFma
   WN+ELCnPw061NPH2ALDPbda/D3DgtjjF/JCHNR3c50RUOEGYvuvRA5nZj
   z5D/LZT1vBlyBgER/K+9XRysvpVmuHy1wDcUuDQVfhw6yZtFf1gXaDt9I
   ZcPootOak77s7723JQSA4QQ3Xb1E3YNd5YmJuEXIPcZn8g61+p/iUdET+
   HZZd7jklcPt6vsoMnRf/yamzciWiVkK+T2I8EtelAkfPTUTk70VX7itk4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="446805144"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="446805144"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:23:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1533594"
Received: from dbhattac-mobl.amr.corp.intel.com (HELO [10.212.142.100]) ([10.212.142.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:22:30 -0700
Message-ID: <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
Date:   Mon, 2 Oct 2023 07:23:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 09:31, Alexey Dobriyan wrote:
> Here is how it works:
> 
> * fault and fill the stack from rsp with int3 down until rlimit allows,
> * fill upwards with int3 too, overwrite libc stuff, argv, envp,
> * try to exec int3 on each page and catch it with either SIGSEGV or
>   SIGTRAP handler.
> 
> Note: trying to execute _every_ int3 takes 30-40 seconds even on fast
> machine, so only 1 int3 per page is tried.
> 
> Tested on F37 kernel and on custom kernel which did
> 
> 	vm_flags |= VM_EXEC;
> 
> to stack VMA.

I guess the subject implies it, but it's probably worth a sentence or
two in the changelog about this being 64-bit only.

IIRC, there _are_ x86_64 CPUs that don't support NX.  It's also entirely
possible for a hypervisor to disable NX enumeration for a guest.  Those
two are (probably) rare enough that they can be ignored for now.  But it
might mean adding a CPUID check at some point.

Basically, could you spend a moment in the changelog to talk about:

1. 32-bit kernels on NX hardware
and
2. 64-bit kernels on non-NX hardware

?
