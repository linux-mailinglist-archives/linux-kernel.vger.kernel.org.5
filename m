Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8617A6894
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjISQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 12:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjISQGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:06:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903609D;
        Tue, 19 Sep 2023 09:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695139575; x=1726675575;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9SJWOh+sBbmoBDHuJDTvYjtZel5Tu2jwPotxz7MjXY=;
  b=hUmE/qXZSiQD+5XsknaEFo0x2rsll9vKPCfvl9ONYITWx+H9YLLoCqZS
   qKaVaY+AK22EzNm0VkDF5l9s5YV8zHIB1+5J0AOvaVNd6gEI/M3uLE1Me
   pj1KWt133UHBj3q+Il4a6uS8SWKaz2SfJcZSmFT3C4KJWufaF6YdCM4KR
   CGLy8WpeKzxGktRfoYftpcjZ8axJ23ggJFEfTmj/BV/zdgOM+NRlb3eNL
   efzjLXF76bSsnqJpYfA1YpSisgmv+ASJBL4JFypZpotDTIM4AV/19fyY1
   qmMKbJF5CgkficBqOjgol+qZyA80aS1tEAz5fGQuryHmFM50/3yB+C627
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="410908993"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="410908993"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:02:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="746294853"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="746294853"
Received: from rdromms-mobl4.amr.corp.intel.com (HELO [10.212.158.204]) ([10.212.158.204])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 09:02:08 -0700
Message-ID: <782b131a-c3b9-7679-824a-70625c966def@intel.com>
Date:   Tue, 19 Sep 2023 09:02:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Content-Language: en-US
To:     Matteo Rizzo <matteorizzo@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
 <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com>
 <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
 <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
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

On 9/19/23 08:48, Matteo Rizzo wrote:
>> I think the whole "make it one single compile-time option" model is
>> completely and fundamentally broken.
> Wouldn't making this toggleable at boot time or runtime make performance
> even worse?

Maybe.

But you can tolerate even more of a performance impact from a feature if
the people that don't care can actually disable it.

There are also plenty of ways to minimize the overhead of switching it
on and off at runtime.  Static branches are your best friend here.
