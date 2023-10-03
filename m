Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82B7B738D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241286AbjJCVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241282AbjJCVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:54:04 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF43A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:54:02 -0700 (PDT)
Received: from [127.0.0.1] ([99.8.153.148])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 393LrRTV1773610
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 3 Oct 2023 14:53:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 393LrRTV1773610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1696370009;
        bh=s7M3jPu88VzYxvgafIQdD5PZlhNhSK8uSfdd5mIZprE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qzHo+0PywrAnDtUs+udBREyLz4hUEKi9doXzhFtkFdo77Fv7ui7OYR9Ax6GYZOnKx
         bXnnwptIBB9zO9YNGLLnXajY9GOyqIrGNQ5agwyHxUuzCfFGDJF3Kbql8AR9f5RXcO
         q782sQ2bfjGV3BN+pbSBZIvlQLceo2zPj0385P6FMJkekQPxe4/bnFNP0oPOBcQCi2
         7doeleL3AEm4Ok8ryLr4nhIUgNdmiTgiG5kVOal89kzmb4WOqaMZl7fdXKJV9KRhcH
         fdSJe8dIhyey0ubvt19FbZmEvKpyvspHuh2JUCYTkYBVUOeoCiXXnXhri6rqixPJgY
         fULQp5QXR/I0w==
Date:   Tue, 03 Oct 2023 14:53:17 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>
CC:     Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: test that userspace stack is in fact NX
User-Agent: K-9 Mail for Android
In-Reply-To: <1dad6a33-1cd0-0d0f-29c5-97fd2807f07a@intel.com>
References: <4b78a714-5ac3-4783-8256-1dda4673db01@p183> <1d5223b8-0275-619d-db1c-e2aaaddb173e@intel.com> <d468d13c-6c4b-4d8d-8e2d-e4314b4bb1a7@p183> <f972d59c-40dd-2a68-ff13-a2658513a25b@intel.com> <ZRxmS/3nr6pDa1+z@gmail.com> <ZRxr79i5PAXRXjqr@gmail.com> <1dad6a33-1cd0-0d0f-29c5-97fd2807f07a@intel.com>
Message-ID: <060F14C5-3E81-4A9B-8576-8905410EF830@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 3, 2023 1:46:20 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> =
wrote:
>On 10/3/23 12:30, Ingo Molnar wrote:
>> * Ingo Molnar <mingo@kernel=2Eorg> wrote:
>>> Because not having NX in 2023 on any system that is threatened is a
>>> big security vulnerability in itself, and whether the vendor or owner
>>> intentionally did that or not doesn't really matter, and a failing
>>> kernel testcase will be the least of their problems=2E
>> BTW=2E, it's also questionable whether the owner is *aware* of the fact=
 that=20
>> NX is not available: what if some kernel debug option cleared the NX fl=
ag,=20
>> unintended, or there's some serious firmware bug?
>>=20
>> However unlikely those situations might be, I think unconditionally war=
ning=20
>> about NX not available is a very 2023 thing to do=2E
>
>100% agree for x86_64=2E  Any sane x86_64 system has NX and the rest are
>noise that can live with the error message, unless someone shows up with
>a compelling reason why not=2E
>
>For 32-bit, the situation is reversed=2E  The majority of 32-bit-only CPU=
s
>never had NX=2E  The only reason to even *do* this check on 32-bit is tha=
t
>we think folks are running i386 kernels on x86_64 hardware _or_ we just
>don't care about 32-bit in the first place=2E
>
>In the end, I think if we're going to do this test on i386, we should
>_also_ do the 5-lines-of-code CPUID check=2E  But I honestly don't care
>that much=2E  I wouldn't NAK (or not merge) this patch over it=2E

Perhaps we should also complain at people who are still running 32-bit ker=
nels on 64-bit hardware? It has been 20 years=2E=2E=2E
