Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB7787495
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbjHXPtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbjHXPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:49:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E2019A3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:49:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692892145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=km71JZdPEneG2hyb5yjpKibchTWDGBjqCksdxoHBWus=;
        b=pEVOz96ceBu2FdCJll9tSqYX+nK/THiLfa9PjpotPw7A3ANHjaBjsjZyOiZ84Nnonc9q+K
        zs/eF2icRGJjQ4T0D6PAm+R94Fhumr7L2cQgJ7a0uITDYfwf/QuI91QRe/nGrVfs8pLWr1
        aKSsljIHVDAdkoluJOgqP7ink8YK+Ky1JON1+d0afXvsNtd/0UuIVudTILgkrda8Z06igh
        R9ND9k/My8IMFFc+eIeHa9Thw6P6PAtxicEBOTdA4N4wGBh3AD5GpYT/6fkuboMir2IaWk
        SHDmr4DeS3BlaJlKKianq7Cio4XQatopWJRe6cg7j2WbeKiqf8N/Fhx+hP7opw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692892145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=km71JZdPEneG2hyb5yjpKibchTWDGBjqCksdxoHBWus=;
        b=AFYl1uaN2QcvqPzOgyJwUtVz1nHiB7tpKSWhiI3j1/SdycnZlEwYABrKkNhB4TqOTN5aBj
        dmBmMgfgzGdDIwDA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/tdx: Mark TSC reliable
In-Reply-To: <20230808200111.nz74tmschph435ri@box>
References: <20230808162320.27297-1-kirill.shutemov@linux.intel.com>
 <ecc11d54-6aaa-f755-9436-ae15b94fb627@intel.com>
 <20230808200111.nz74tmschph435ri@box>
Date:   Thu, 24 Aug 2023 17:49:05 +0200
Message-ID: <87bkewcufi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 23:01, Kirill A. Shutemov wrote:
> On Tue, Aug 08, 2023 at 10:13:05AM -0700, Dave Hansen wrote:
>> I take it this is carved in stone in the TDX specs somewhere.  A
>> reference would be nice.
>
> TDX Module 1.0 spec:
>
> 	5.3.5. Time Stamp Counter (TSC)
>
> 	TDX provides a trusted virtual TSC to the guest TDs. TSC value is
> 	monotonously incrementing, starting from 0 on TD initialization by the
> 	host VMM. The deviation between virtual TSC values read by each VCPU is
> 	small.

Nice weasel wording. What's the definition of "small"?

Any OS needs a guarantee that vCPUs cannot observe time going backwards,
which is obviously possible when the deviation is not small enough.

> Wording in the spec looks okay to me. We can only hope that implementation
> going to be sane.

Hope dies last :)
