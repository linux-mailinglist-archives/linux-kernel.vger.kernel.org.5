Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF47B25D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjI1TRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:17:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663131A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695928616; x=1727464616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0Bd48FJIq/CzYjG5JiO8X9ToDofegyMVutfzhDHe34=;
  b=hTLHjaErDxPN6BW9MZic78jubAhk1u5TR5nTAokfdWAaBVLGJbLstM7v
   JuMCGUHHWKNaUNhTp0HxtT0/GxvWRbfhXl1cXz/kqypuGDyOs7uNumaEx
   dOAqVCuUIEJ3zJZp3VO2fO8D3pzkV16W0qUG0HY2gEoqItrnGswIfZx7l
   qB/BEFzinoZATDe+SSXyl9DFS/+tpde4rtAKEFJXyO65n6omQIN5/NYYW
   v2X6XHFCfZCfDcOI7Takdzgxn34vbpz1vio9EXdy71rTHUkuDBCLMaLPq
   +QVPqXCroxtMw+cEJtLwBkU6BMSAAOx1S9Khnm+jxDR/IKxU/p4moSgbM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="386017750"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="386017750"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="819954401"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="819954401"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:16:32 -0700
Message-ID: <340596c9-d55d-5f8a-fa27-d95b0e10b20a@intel.com>
Date:   Thu, 28 Sep 2023 12:16:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 0/7] Introduce persistent memory pool
Content-Language: en-US
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     Baoquan He <bhe@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        stanislav.kinsburskii@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-mm@kvack.org, kys@microsoft.com, jgowans@amazon.com,
        wei.liu@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        graf@amazon.de, pbonzini@redhat.com,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
 <b684d339-991d-be85-692c-75f21679ca69@intel.com>
 <20230928000230.GA20259@skinsburskii.>
 <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
 <20230928003831.GA20366@skinsburskii.>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230928003831.GA20366@skinsburskii.>
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

On 9/27/23 17:38, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 11:00:12AM -0700, Dave Hansen wrote:
>> On 9/27/23 17:02, Stanislav Kinsburskii wrote:
>>> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
>> ...
>>> Well, not exactly. That's something I'd like to have indeed, but from my
>>> POV this goal is out of scope of discussion at the moment.
>>> Let me try to express it the same way you did above:
>>>
>>> 1. Boot some kernel
>>> 2. Grow the deposited memory a bunch
>>> 5. Kexec
>>> 4. Kernel panic due to GPF upon accessing the memory deposited to
>>> hypervisor.
>>
>> I basically consider this a bug in the first kernel.  It *can't* kexec
>> when it's left RAM in shambles.  It doesn't know what features the new
>> kernel has and whether this is even safe.
>>
> 
> Could you elaborate more on why this is a bug in the first kernel?
> Say, kernel memory can be allocated in big physically consequitive
> chunks by the first kernel for depositing. The information about these
> chunks is then passed the the second kernel via FDT or even command
> line, so the seconds kernel can reserve this region during booting.
> What's wrong with this approach?

How do you know the second kernel can parse the FDT entry or the
command-line you pass to it?

>> Can the new kernel even read the new device tree data?
> 
> I'm not sure I understand the question, to be honest.
> Why can't it? This series contains code parts for both first and seconds
> kernels.

How do you know the second kernel isn't the version *before* this series
gets merged?

...
>> I still think the only way this will possibly work when kexec'ing both
>> old and new kernels is to do it with the memory maps that *all* kernels
>> can read.
> 
> Could you elaborate more on this?
> The avaiable memory map actually stays the same for both kernels. The
> difference here can be in a different list of memory regions to reserve,
> when the first kernel allocated and deposited another chunk, and thus
> the second kernel needs to reserve this memory as a new region upon
> booting.

Please take a step back from your implementation for a moment.  There
are two basic design points that need to be considered.

First, *must* "System RAM" (according to the memory map) be persisted
across kexec?  If no, then there's no problem to solve and we can stop
this thread.  If yes, then some mechanism must be used to tell the new
kernel that the "System RAM" in the memory map is not normal RAM.

Second, *if* we agree that some data must communicate across kexec, then
what mechanism should be used?  You're arguing for a new mechanism that
only new kernels can use.  I'm arguing that you should likely reuse an
existing mechanism (probably the UEFI/e820 maps) so that *ALL* kernels
can consume the information, old and new.

I'm not convinced that this series is going in the right direction on
either of those points.

> Can all this considered, as, say, the first kernel uses device tree to
> inform the second kernel about the memory regions to reserve?
> In this case the first kernel behaves a bit like a firmware piece for
> the second one.
> 
>> Can the hypervisor be improved to make this release operation faster?
> 
> I guess it can, but shutting down guests contributes to downtime the
> most. And without shutting down the guests the deposited memory can't be
> withdrawn.

Do you really need to fully shut down each guest?  Or do you just need
to get them to a quiescent state where the hypervisor and devices aren't
writing to the deposited memory?
