Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27C07DA1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346380AbjJ0UJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjJ0UJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 16:09:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF400187
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:09:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-542d3e46ee7so86694a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 13:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1698437346; x=1699042146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaSlgJixsmWlo+e2Cx7W2WmJWF+pgDHnH66BKZ3dK2Q=;
        b=UgHRp6kTVWQqPTAOFfrYOYgr3eWW1yPkPMQI/1MJiZM0BPfSLWzzeayC3mKQ8Fu3f0
         KODBjZJ3Kg5c5SU82jRldu+Q3tUi8MwsLr+oMdH7Z896+wZcKmSjjuUaORwIyYL45Rez
         FG9mbthO/T5OidyBuuX20XLnEwiz5x40eaRgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698437346; x=1699042146;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaSlgJixsmWlo+e2Cx7W2WmJWF+pgDHnH66BKZ3dK2Q=;
        b=aK1pxO1m2zpOMepCBxjY62lE6SPh/Pf3/GNeIXE5/Rti6tkWluJYt11r/RVB4SS8fM
         a1msXj9ErdjrS+HGfLaLC6clNY1wil4ALjV8JC/7K1LtWGLL20dfRAzCZEefhdxrRdR/
         RldXvJic2yThy/2lpDOWI2aoGdsCDcjVYyYi4HMdqaiEXtYiZp4AiSNpMyrSSaFX3fMo
         +QjFIlZxc6a7+bS2P1VRaOoCejCsWu+0KtG4XK0sY9cXY3mihbxpvC4snvvgsIdRirXx
         0kOW0OW1GFDJ+SVZX6pd59pnW5wgteWg2qgZHlp4AakhJ9e7TI4xRnpgg+3Xpl9GGiV7
         oKCw==
X-Gm-Message-State: AOJu0YzDdk71/rlIyDTQnInPfHSjYV2J1gMO+u8cLFOmU7xfiFQ5T1Mj
        Qk+/gaZTEuwK2qBDd4BTaQ7s1w==
X-Google-Smtp-Source: AGHT+IHp0yh7EJgDeAhPZnw5KMQGBu1JAz5Jcq8nYbdnDioi5wqHAtcfMjckXODC4+dNTl1MjoWt5w==
X-Received: by 2002:aa7:ccce:0:b0:53e:6db7:ea63 with SMTP id y14-20020aa7ccce000000b0053e6db7ea63mr3169337edt.14.1698437346242;
        Fri, 27 Oct 2023 13:09:06 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id i9-20020a50fc09000000b0053e88c4d004sm1658198edr.66.2023.10.27.13.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 13:09:06 -0700 (PDT)
Message-ID: <3c56e807-945c-4996-9ac1-3205a23248ab@citrix.com>
Date:   Fri, 27 Oct 2023 21:09:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/barrier: Do not serialize MSR accesses on AMD
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153458.GMZTvYou1tlK6HD8/Y@fat_crate.local>
 <20231027185641.GE26550@noisy.programming.kicks-ass.net>
 <20231027191633.GRZTwMkaiW1nyvnzzO@fat_crate.local>
 <20231027192907.GSZTwPg8v7NF6+Zn0w@fat_crate.local>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20231027192907.GSZTwPg8v7NF6+Zn0w@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 8:29 pm, Borislav Petkov wrote:
> On Fri, Oct 27, 2023 at 09:16:33PM +0200, Borislav Petkov wrote:
>> Thus the more conservative approach here.
> And on a second thought, I don't need any of that new stuff - I simply
> need a synthetic flag which says "MSRs need fencing" and set it on
> everything but AMD and Hygon. And we've solved this type of issue
> gazillion times already - why am I reinventing the wheel?!

Quoteth the APM (rev 3.41, June 2023):

16.11.2 WRMSR / RDMSR serialization for x2APIC Register

The WRMSR instruction is used to write the APIC register set in x2APIC
mode. Normally WRMSR is
a serializing instruction, however when accessing x2APIC registers, the
serializing aspect of WRMSR
is relaxed to allow for more efficient access to those registers.
Consequently, a WRMSR write to an
x2APIC register may complete before older store operations are complete
and have become globally
visible. When strong ordering of an x2APIC write access is required with
respect to preceding memory
operations, software can insert a serializing instruction (such as
MFENCE) before the WRMSR
instruction.

So which is right?  This commit message, or the APM?  (and yes, if
you're waiting on an APM update then the commit message should at least
note that one is coming.)


But, to the issue at hand.

There are other non-serialising MSRs on AMD CPUs, including the FS/GS
base MSRs on more modern parts which is enumerated in 8000_0021.eax[1].

So there isn't a boolean "MSRs need fencing, yes/no".  It is vendor
*and* model specific as to whether a particular MSR is serialising or
non-serialising.

*And* it's vendor specific as to what the fencing sequence is.  Intel
require mfence;lfence, while on AMD, mfence suffices.

Most MSR writes don't want to be architecturally serialising, and Intel
are introducing WRMSRNS for this purpose.  But ICR writes *do* need to
be ordered with respect to stores becoming globally visible, and it was
an error for MSR_X2APIC_ICR to be specified as non-serialising.


The only sanity-preserving (pseudo) API for this is something like:

vendor_msr_fence = { mfence;lfence (Intel) | mfence (AMD, Hygon) | ... }

and for each MSR separately, something like:

ALTERNATIVE("", vendor_msr_fence, $VENDOR_NEEDS_MSR_$X_FENCE);

because that's the only one which properly separates "what fence to use"
and "do I need to fence this MSR on the current vendor".

~Andrew
