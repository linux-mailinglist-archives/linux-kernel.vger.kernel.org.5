Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4D7EF75E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjKQSQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjKQSQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:16:47 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FFD5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 10:16:42 -0800 (PST)
Received: from [IPV6:2601:646:9a00:1821:450e:710e:ed94:8bf9] ([IPv6:2601:646:9a00:1821:450e:710e:ed94:8bf9])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3AHIFtUU324528
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 17 Nov 2023 10:15:56 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3AHIFtUU324528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023111101; t=1700244957;
        bh=rldfpkIKQWTQW6V8Tvh/c478ucg2EydlDLInfQStja0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zugJ26awpulXFLHfyAsUg2BKPMrsxcnuWWyQQj2g1aCAkJXHvT0gGsOJxM9ITp1OL
         HGbtOA9mkjsqpaTbvCqYFEAaIlg2xc+Y527FP4/IodDK86Sm8h3f4Eop8fSgDsyw6r
         2eD2ztygTRXKLYEWTtgxhzOLwm49Xf9CGXYzkWcWx4YvmAWjkUSzFVfbuDdpv7a/M5
         lwHVNHoupqFuRWI+wcWIYB9w910JA4hJeXDs+MntW1qK8IDQ6JZw7uodOOEs0ZUehN
         ScSAzs42AB5ikGunu3Z765QciTeR1RX5HFQdgbetjyskoS+gdolQ4QAMevL4Hnq8an
         SeAJcvsou/l3Q==
Message-ID: <eec64162-263e-4535-b637-4893d23d19a3@zytor.com>
Date:   Fri, 17 Nov 2023 10:15:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231116191127.3446476-1-ubizjak@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20231116191127.3446476-1-ubizjak@gmail.com>
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

On 11/16/23 11:10, Uros Bizjak wrote:
> %RIP-relative addresses are nowadays correctly handled in alternative
> instructions, so remove misleading comment and improve assembly to
> use %RIP-relative address.
> 
> Also, explicitly using %gs: prefix will segfault for non-SMP builds.
> Use macros from percpu.h which will DTRT with segment prefix register
> as far as SMP/non-SMP builds are concerned.

OK, this is starting to feel silly. One could seriously question the use 
case for supporting !SMP builds x86-64. It isn't like our performance 
for SMP builds on UP systems is significantly worse, it is mostly just a 
matter of code size, and the difference isn't huge, either, especially 
considering that on systems of the x86-64 era the kernel is a rather 
small part of system memory (unlike the very early i386 era, for those 
of us who remember those ancient times.)

The number of UP x86-64 systems is really very small (since 
multicore/SMT became ubiquitous at roughly the same time x86-64 was 
introduced), and as far as I know none of them lack APIC which is really 
the most fundamental difference between SMP and !SMP on x86.

Why don't we simply have %gs_base == 0 as an invariant for !SMP? If we 
*REALLY* care to skip SWAPGS on !SMP systems, we could use alternatives 
to patch out %gs: and lock (wouldn't even have to be explicit: this is 
the kind of thing that objtool does really well.) We can use 
alternatives without anything special, since it only matters after we 
have entered user spae for the first time and would be concurrent with 
patching out SWAPGS itself.

If we really *do* care about UP builds, we could teach objtool to do 
this patching at compile time for the !SMP builds.

Also, didn't we at least use to have a way to mark a function as "init 
on UP" so that it could be jettisoned with the init code if we find 
ourselves on a uniprocessor system?

	-hpa

