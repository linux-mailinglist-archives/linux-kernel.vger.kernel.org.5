Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56087A29C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237033AbjIOVuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbjIOVt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:49:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B4C6;
        Fri, 15 Sep 2023 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694814594; x=1726350594;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q2f++CQ4YvVjqHtWEWqnDjoY5zgYMBznv/GocztfsC4=;
  b=GCISf/hKlXOOhb0nFREYhUo1qSG8cygUXHftBeuKT230LF4Bc/sTvVKD
   P7XmCXCbiLOQeqAoDbfBRf0cG9YKr08Di1GhqaEMAQma+ep2K3KONHgaS
   8bTnY2R60RTMN+wjmOR1z+ip1CXRaxtBpjtwNeM6GVztedRAg/mg9Swjt
   xTM2JOBGWxahhKbwMCsBmzwAR3Shctdn5mGUVfLc2v1BIX8uMuGKfGRym
   ZOoAKXYyB8Rgp177nOLr0LXw1lTRVhxLqk9iJ84KmaRiDL6dbNywAMrhz
   cARwbFGIfCphyKZnJnTB70FE96Pjde/cOrxxF7AVO+mYMaZBbioXqgTFo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358766847"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="358766847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075917495"
X-IronPort-AV: E=Sophos;i="6.02,150,1688454000"; 
   d="scan'208";a="1075917495"
Received: from spswartz-mobl.amr.corp.intel.com (HELO [10.209.21.97]) ([10.209.21.97])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 14:49:52 -0700
Message-ID: <64e62982-6d0e-f742-be5c-15390d8e7c2b@intel.com>
Date:   Fri, 15 Sep 2023 14:49:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 10/14] x86: Create virtual memory region for SLUB
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com, ardb@google.com
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-11-matteorizzo@google.com>
 <202309151410.E65B8300F@keescook>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202309151410.E65B8300F@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/23 14:13, Kees Cook wrote:
> On Fri, Sep 15, 2023 at 10:59:29AM +0000, Matteo Rizzo wrote:
>> From: Jann Horn <jannh@google.com>
>>
>> SLAB_VIRTUAL reserves 512 GiB of virtual memory and uses them for both
>> struct slab and the actual slab memory. The pointers returned by
>> kmem_cache_alloc will point to this range of memory.
> 
> I think the 512 GiB limit may be worth mentioning in the Kconfig help
> text.

Yes, please.

> And in the "640K is enough for everything" devil's advocacy, why is 512
> GiB enough here? Is there any greater risk of a pathological allocation
> pattern breaking a system any more (or less) than is currently possible?

I have the feeling folks just grabbed the first big-ish chunk they saw
free in the memory map and stole that one.  Not a horrible approach,
mind you, but I have the feeling it didn't go through the most rigorous
sizing procedure. :)

My laptop memory is ~6% consumed by slab, 90% of which is reclaimable.
If a 64TB system had the same ratio, it would bump into this 512GB
limit.  But it _should_ just reclaim thing earlier rather than falling over.

That said, we still have gobs of actual vmalloc() space.  It's ~30TiB in
size and I'm not aware of anyone consuming anywhere near that much.  If
the 512GB fills up somehow, there are other places to steal the space.

One minor concern is that the virtual area is the same size on 4 and
5-level paging systems.  It might be a good idea to pick one of the
holes that actually gets bigger on 5-level systems.

