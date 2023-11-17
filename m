Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CF7EF88F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346239AbjKQUTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbjKQUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:19:08 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D01BD9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:18:41 -0800 (PST)
Received: from [IPV6:2601:646:9a00:1821:450e:710e:ed94:8bf9] ([IPv6:2601:646:9a00:1821:450e:710e:ed94:8bf9])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3AHKI3Ra357876
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 17 Nov 2023 12:18:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3AHKI3Ra357876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023111101; t=1700252285;
        bh=dRGdu0HcrSmC2htUtuixOXNvzjT2XsGAptdlNE8aBkQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZeIvx2zc0S0MQFNQ6hWhFf9xO/3B3o4I92vxaeklPeAm1eFSYn69hdDuQMOML5jCF
         uaImua6YGgdXP4COBK6Io4k2Sk3MZMNAV1iQTMDCuGrpKOxkBbYP1rGyHZ7VVp2EYd
         K/mJiMfJe7NSWkiGGSC11kRaXbnPYB9Y/ZEBMD0GRfBq3qISS1LbAf9v6ssvDGeCmR
         Ia4C8uRTjhGt592HS6vfxAlsOYFBLiUltIiTsR2sNCey/64tsGqY0eEcb6RCm8wlcS
         pMy2lWmW7U0XsPT3i4sdPbI9zIRWAYJAD/7q8Xw/F0n17ozL9hyx3kMAKh/u+0aOmS
         ZW3TrI8TsYSBw==
Message-ID: <45a7d005-ec54-43c8-8111-7712c3c2561f@zytor.com>
Date:   Fri, 17 Nov 2023 12:17:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231116191127.3446476-1-ubizjak@gmail.com>
 <eec64162-263e-4535-b637-4893d23d19a3@zytor.com>
 <CAMzpN2hY=JJRKPqsXr2BuyPZ5AJP3UzUPyMZoUNzTE00uN3iOw@mail.gmail.com>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <CAMzpN2hY=JJRKPqsXr2BuyPZ5AJP3UzUPyMZoUNzTE00uN3iOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/23 11:43, Brian Gerst wrote:>>
>> Why don't we simply have %gs_base == 0 as an invariant for !SMP?
> 
> The reason is stack protector, which is still stuck at %gs:40.  So
> GSBASE has to point at fixed_percpu_data, even on a UP build.  That is
> corrected by the patch series I recently posted, though.
> 

Right, that problem is gone.

>> If we
>> *REALLY* care to skip SWAPGS on !SMP systems, we could use alternativesYep, that is 
>> to patch out %gs: and lock (wouldn't even have to be explicit: this is
>> the kind of thing that objtool does really well.) We can use
>> alternatives without anything special, since it only matters after we
>> have entered user spae for the first time and would be concurrent with
>> patching out SWAPGS itself.
> 
> There is already support to patch out LOCK prefixes when running an
> SMP build on a single CPU (.smp_locks section).  Patching out the GS
> prefix would only work if the initial percpu area is not freed.
> Beyond that I don't think other optimizations are worth the effort,
> and would get very little testing.

Yes, that is basically my point.

	-hpa

