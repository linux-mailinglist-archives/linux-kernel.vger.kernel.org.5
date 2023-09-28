Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577D27B23E8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjI1R3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjI1R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:29:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62735CC2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695922174; x=1727458174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+i5DZweb1DmFnq+1NXhKYb+RqfLnbbybywHY7SzT/fw=;
  b=Rkr6Wfgr533nqJfLWabab+QzWnq5P+vCXd7l84zQwWxvjd2unvfqW1ay
   IF/0qEQeb0w+Ola8LGcLTNq9TV0xPrBfny2Re5z/qB0v0U315Zw7nMRTq
   I554QHHRBpAVKLM4P3osY0LZqSdWWBDPfv88gEVRYvUfR9aA+uRDofSVO
   RW9rXoL6MfxvpF3TJMCs/OnZQqG5VphnYfOKZpHHZWXb9IMrVYl7Np4gV
   wz9e55o2HON/HFyrZ0C44nvIM2BGGgQ2cHTWeM1pSaUqTbYiBnEEXbYkk
   a7nxxLvFzTfe1CxbJhluyOTazL0lXSFVcIx+GbiexwWEqO8ERIkfJbNEp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="384939693"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="384939693"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="743149449"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="743149449"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:29:33 -0700
Message-ID: <b684d339-991d-be85-692c-75f21679ca69@intel.com>
Date:   Thu, 28 Sep 2023 10:29:32 -0700
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
        graf@amazon.de, pbonzini@redhat.com
References: <01828.123092517290700465@us-mta-156.us.mimecast.lan>
 <ZRPBRkXrYvbw8+Lt@MiWiFi-R3L-srv> <20230927161319.GA19976@skinsburskii.>
 <ee1907a1-2f04-cfa3-9f09-75b94994e88b@intel.com>
 <20230927232548.GA20221@skinsburskii.>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230927232548.GA20221@skinsburskii.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/23 16:25, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 06:22:54AM -0700, Dave Hansen wrote:
>> On 9/27/23 09:13, Stanislav Kinsburskii wrote:
>>> Once deposited, these pages can't be accessed by Linux anymore and thus
>>> must be preserved in "used" state across kexec, as hypervisor state is
>>> unware of kexec.
>>
>> If Linux can't access them, they're not RAM any more.  I'd much rather
>> remove them from the memory map and move on with life rather than
>> implement a bunch of new ABI that's got to be handed across kernels.
> 
> Could you elaborate more on the new ABIs? FDT is handled by x86 already,
> and passing it over kexec looks like a natural extension.
> Also, adding more state to it also doens't look like a new ABI.
> Or does it?

FDT makes it easier to pass arbitrary data around, but you're still
creating a new "default_pmpool" device tree node on one end and
consuming it on the other.  That's a new ABI in my book.

> Let me also comment on removing this regions from the memory map. The
> major peculiarity here is that hypervisor distinguish between the pages,
> deposited for guests to rnu and the pages deposited for the Linux root
> partition to keep the guest-related portion of hypervisor state in the
> root partition. And the latter is the matter in question.
> 
> We can indeed isolate and deposit a excessive amount of memory upfront
> in hope that hypervisor will never get into the situation, when it needs
> more memory.
> However, it's not reliable, as the amount of memory will always be an
> estimation, depending on the number of expected guests, guest-attached
> devices, etc. And this becomes even a bigger problem when most of the
> memory is already removed from the memory map to host guest partitions.
> It's also not efficient as the amount of memory required by hypervisor
> can grow or shrink depending on the use case or host configuration, and
> deposting excessive amount of memory will be a waste.
> 
> But, actually, the idea of removing the pages from memory map was
> reflected to some extent in the first version of this proposal,
> so let me elaborate on it a bit.
> 
> Effectively, instead of reserving and depositing a lot of memory to
> hypervisor upfront, the memory can be allocated from kernel memory when
> needed and then returned back when unused.
> This would still require pages removal from the memory map upon kexec,
> but that's another problem.

Let's distill this down a bit.

I agree that it's a waste to reserve an obscene amount of memory up
front for all guests for rare cases.  Having the amount of consumed
memory grow is a nice feature.

You can also quite easily *shrink* the amount of memory on a given
kernel without new code.  Right?

The problem comes when you've grown the footprint of hypervisor-donated
memory, kexec, and *THEN* want to shrink it.  That's what needs new
metadata to be communicated over to the new kernel.

1. Boot some kernel
2. Grow the deposited memory a bunch
3. Kexec
4. Shrink the deposited memory

Right?

That's where you lose me.

Can't the deposited memory just be shrunk before kexec?  Surely there
aren't a bunch of pathological things consuming that memory right before
kexec, which is basically a reboot.
