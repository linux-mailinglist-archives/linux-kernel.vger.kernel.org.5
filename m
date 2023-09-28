Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD97B2488
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjI1SAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjI1SAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:00:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A11A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695924014; x=1727460014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k08d4cJZrEP2o/SLqjoaj5SIzc6BygHuqPno8v6qPGw=;
  b=erVdUsq8wJiHgfk0UayMzNXLfUjAOsWt01wEIfPCIbEMlEI+4E3m+8bA
   dwEZBUyGZBQdXvgnf6FjBOIBOamb0jerYYw/ZWsdKrS8LLncxZh+jzZw2
   kGXwHNU9wQTjg0Nv1iS3KnRojmOI+xV7OLiXwDEIjRTsfkWdUmrt9J/n8
   IIzcS7fM6N7if+zeCZqO02n/YnB5vXQE9g2UF108assN3fgl1CqGQcLGh
   wK47pk9ag9JfxxDLa3KYvljYSac8MoJQDbJhME+ddhRTYiKSZmapoQhuC
   hD1K8nlJkz5QFxzm1LA9vaXRJ7u8MhJKZ/o+x9atchxURtAF4Bl7m/Zzf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="468414165"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="468414165"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699374241"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="699374241"
Received: from jveerasa-mobl.amr.corp.intel.com (HELO [10.255.231.134]) ([10.255.231.134])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:00:12 -0700
Message-ID: <760bbb08-83b4-7bb1-822f-2ceba26278a6@intel.com>
Date:   Thu, 28 Sep 2023 11:00:12 -0700
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230928000230.GA20259@skinsburskii.>
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

On 9/27/23 17:02, Stanislav Kinsburskii wrote:
> On Thu, Sep 28, 2023 at 10:29:32AM -0700, Dave Hansen wrote:
...
> Well, not exactly. That's something I'd like to have indeed, but from my
> POV this goal is out of scope of discussion at the moment.
> Let me try to express it the same way you did above:
> 
> 1. Boot some kernel
> 2. Grow the deposited memory a bunch
> 5. Kexec
> 4. Kernel panic due to GPF upon accessing the memory deposited to
> hypervisor.

I basically consider this a bug in the first kernel.  It *can't* kexec
when it's left RAM in shambles.  It doesn't know what features the new
kernel has and whether this is even safe.

Can the new kernel even read the new device tree data?

>> Can't the deposited memory just be shrunk before kexec?  Surely there
>> aren't a bunch of pathological things consuming that memory right before
>> kexec, which is basically a reboot.
> 
> In general it can. But for this to happen hypervisor needs to release
> this memory. And it can release the memory iff the guests are stopped.
> And stopping the guests during kexec isn't something we want to have in the
> long run.
> Also, even if we stop the guests before kexec, we need to restart them
> after boot meaning we have to deposit the pages once again.
> All this: stopping the guests, withdrawing the pages upon kexec,
> allocating after boot and depostiting them again significatnly affect
> guests downtime.

Ahh, and you're presumably kexec'ing in the first place because you've
got a bug in the first kernel and you want a second kernel with fewer bugs.

I still think the only way this will possibly work when kexec'ing both
old and new kernels is to do it with the memory maps that *all* kernels
can read.

Can the hypervisor be improved to make this release operation faster?
