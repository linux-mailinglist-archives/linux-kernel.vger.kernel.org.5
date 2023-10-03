Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E987B72B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjJCUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjJCUq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:46:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3BAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696365981; x=1727901981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ocFdCaQn0YtyQXJZyENMtrHQHH5+3WfkzDHWrFzYugc=;
  b=fdP81XkphsdNi26kPEyeAYBCoasT9JdSd58DUH1aquCmt81rLgmRyJki
   0J0vHL4c4+WKe0lFma5wvgp+vTB3ZHI1J5cFlgl730dqaVu/l5JqMfuSu
   VaD4XDvYjK3uv6a0jKJED5B52EWybpSzsK5CS7K7/9NSFOyGOfcLz8+n1
   xr/7N8xRoLofiiAnevAYsh4c5Yt99IlPn4Pzu5d+ig1kuvObH+w9nV4K4
   YE/s7wbXm8fVbFpvYtuGEZB+Tna4K+TQZyr2lndx4c9PPO0OCaeJzE8G3
   ArPgrXjxtH+57nc3e05QxSoCbKAi/m6uMFHmx+LqfJroqnLQu7KQ2tb6h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="382883760"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="382883760"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:46:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="700854257"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="700854257"
Received: from ddiaz-mobl4.amr.corp.intel.com (HELO [10.209.57.36]) ([10.209.57.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 13:46:20 -0700
Message-ID: <1dad6a33-1cd0-0d0f-29c5-97fd2807f07a@intel.com>
Date:   Tue, 3 Oct 2023 13:46:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183>
 <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com>
 <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183>
 <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com> <ZRxmS/3nr6pDa1+z@gmail.com>
 <ZRxr79i5PAXRXjqr@gmail.com>
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <ZRxr79i5PAXRXjqr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 12:30, Ingo Molnar wrote:
> * Ingo Molnar <mingo@kernel.org> wrote:
>> Because not having NX in 2023 on any system that is threatened is a
>> big security vulnerability in itself, and whether the vendor or owner
>> intentionally did that or not doesn't really matter, and a failing
>> kernel testcase will be the least of their problems.
> BTW., it's also questionable whether the owner is *aware* of the fact that 
> NX is not available: what if some kernel debug option cleared the NX flag, 
> unintended, or there's some serious firmware bug?
> 
> However unlikely those situations might be, I think unconditionally warning 
> about NX not available is a very 2023 thing to do.

100% agree for x86_64.  Any sane x86_64 system has NX and the rest are
noise that can live with the error message, unless someone shows up with
a compelling reason why not.

For 32-bit, the situation is reversed.  The majority of 32-bit-only CPUs
never had NX.  The only reason to even *do* this check on 32-bit is that
we think folks are running i386 kernels on x86_64 hardware _or_ we just
don't care about 32-bit in the first place.

In the end, I think if we're going to do this test on i386, we should
_also_ do the 5-lines-of-code CPUID check.  But I honestly don't care
that much.  I wouldn't NAK (or not merge) this patch over it.
