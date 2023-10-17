Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502B37CCC96
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJQTvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjJQTvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:51:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E7A9E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:51:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697572259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fU3PjbOBEICWOY9geuV7YVLEe9SL9UWyFkhVyXQhTgQ=;
        b=huYkDnXDCRTZwPXAh+BhOQqVEwJVQ9lLc3Xq91xlaSR1ImoBhfxCBH59w3T8YKfbWFRZL8
        alPmsUKk4RGR5Y4kTtzmzf8+8/qcuz8fq50gi5iaz0f+Ld637x71lZgVpVo84PGcdjXebD
        4jobHsDTNXOEJ7vdfePSNNCvr2OEGLyLIfy8mDCA1AfcGYKyxNFeP7TvlJ8bIZhHQXRG7b
        pAM+ikZYKENEdoKe1Ow866vv2d7/VJf1BcyNOenqMrfnT504upf0V0U2HWxFMMYh4zzEUl
        945mgqJf7eRY6h/kUx8Y47aVFuGBWOSThTNuqWKtJvnT+FEZSpkzWpxUaXSBzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697572259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fU3PjbOBEICWOY9geuV7YVLEe9SL9UWyFkhVyXQhTgQ=;
        b=EnQf5wBryklsDFGMJoVEdNzGsR4fXm6CAv8iJug5eVfDg8FWKo6VDoZ7qshCmYQlRh17IC
        yGAh4IzBGWLhmIBQ==
To:     Ingo Molnar <mingo@kernel.org>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steve Rutherford <srutherford@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] x86/sme: Mark the code as __head in
 mem_encrypt_identity.c
In-Reply-To: <ZS6DngTm9ILei4dM@gmail.com>
References: <cover.1697525407.git.houwenlong.hwl@antgroup.com>
 <b2670a8a79a7b4a5c8993fb916904af7c675b7f8.1697525407.git.houwenlong.hwl@antgroup.com>
 <ZS6DngTm9ILei4dM@gmail.com>
Date:   Tue, 17 Oct 2023 21:50:58 +0200
Message-ID: <874jip58pp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17 2023 at 14:52, Ingo Molnar wrote:
> * Hou Wenlong <houwenlong.hwl@antgroup.com> wrote:
>> -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>> -static inline void __init sme_enable(struct boot_params *bp) { }
>> +static inline void sme_encrypt_kernel(struct boot_params *bp) { }
>> +static inline void sme_enable(struct boot_params *bp) { }
>
> So I think we should preserve the previous convention of marking functions 
> __init in the header-declaration and at the definition site as well, and do 
> the same with __head as well?

I'm not convinced about the value of prototype annotations, but have no
strong preference either.

Thanks,

        tglx
