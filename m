Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7A7A6868
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbjISP4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjISP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:56:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3D91;
        Tue, 19 Sep 2023 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695138995; x=1726674995;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MTfiqiF4/0w5l1l9tVfSC4owCNKEdyk4op+fHK4J8/c=;
  b=YgdFHXqZ6KV0as4AbU2ESzYzLn8scrzRmLs47zqtA1kRK7KS/CnIEs7k
   Wymc60YxzwniLYAzytgSRjAP+bRZdJ2LSRx2rKr9JusPPuzRfmNy5DgcO
   2Nxq24zC3jDJuky7mfpAoP2dWMA8SrtTlbP0q1rVBwboEzWVU8kZjiKPl
   sb/7ZxRU1XVXt3rmLHwWjwZW53kXuhmISOQn4EK/UDp81bzzA+2IxT4Dw
   Kwm+PwSTm2ZpHa2f8A8C/oYWU3k0H9hNkKkGAQfsIZO5d0cDSkDtjzklU
   6RkqO8jkxA617klxXS0nJoT4EDJTN2DlJNWBCG96Tczh49peHFFashuA/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410906320"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410906320"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 08:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="816486416"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="816486416"
Received: from rdromms-mobl4.amr.corp.intel.com (HELO [10.212.158.204]) ([10.212.158.204])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 08:56:31 -0700
Message-ID: <d04f77ff-e95b-6012-9be6-daf20ba9e272@intel.com>
Date:   Tue, 19 Sep 2023 08:56:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
 <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com>
 <CAHKB1wKneke-dyvMY0JtW-xwW8m=GaUdafoAqdCE0B9csY7_bw@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHKB1wKneke-dyvMY0JtW-xwW8m=GaUdafoAqdCE0B9csY7_bw@mail.gmail.com>
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

On 9/19/23 06:42, Matteo Rizzo wrote:
> On Mon, 18 Sept 2023 at 19:39, Ingo Molnar <mingo@kernel.org> wrote:
>> What's the split of the increase in overhead due to SLAB_VIRTUAL=y, between
>> user-space execution and kernel-space execution?
>>
> Same benchmark as before (compiling a kernel on a system running the patched
> kernel):

Thanks for running those.  One more situation that comes to mind is how
this will act under memory pressure.  Will some memory pressure make
contention on 'slub_kworker_lock' visible or make the global TLB flushes
less bearable?

In any case, none of this looks _catastrophic_.  It's surely a cost that
some folks will pay.

But I really do think it needs to be more dynamic.  There are a _couple_
of reasons for this.  If it's only a compile-time option, it's never
going to get turned on except for maybe ChromeOS and the datacenter
folks that are paranoid.  I suspect the distros will never turn it on.

A lot of questions get easier if you can disable/enable it at runtime.
For instance, what do you do if the virtual area fills up?  You _could_
just go back to handing out direct map addresses.  Less secure?  Yep.
But better than crashing (for some folks).

It also opens up the door to do this per-slab.  That alone would be a
handy debugging option.
