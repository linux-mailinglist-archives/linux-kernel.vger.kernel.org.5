Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E2758725
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjGRV3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGRV3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:29:32 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16DC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:29:30 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4R5Bsx63Gxz9sls;
        Tue, 18 Jul 2023 23:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keresztesschmidt.de;
        s=MBO0001; t=1689715765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9Df8GqjNPTE2V3Xmvj2wteO34K0hy8AG7QJdN/GObA=;
        b=BxJtTIAteYW5lZjmJmkgR3zZqsonL/65QFd47C6IozXbL14uqWg9017mEpCOG1oNK9IYNt
        fz+ewHq+EMBsyOLq7xmzM1GCcZwtEKzgn+QsLTe7SaxspCLVB20oVrtxmWpEZcOhITdQ9i
        ePOcE+cOJrVko2ys/lXe/i+M/LBqz+q7ZP6c+pgVyiGNJ5NiYJSgs13XS6U8mjF+0/7j//
        v2yyuOaufljL3BfHYgFQWfIY90ldGovSYhFtG9LqHV7r0BS0i9elBtt6O8z/0JWIKQCM6R
        itBvbX2FAQj+yJxt9dE2fYC/Rzqt5d80j/OTF8LeXI0FrD8YhvKaUuv8NQlqvg==
Message-ID: <ffc889de-3181-791e-f985-ce461b992bfc@keresztesschmidt.de>
Date:   Tue, 18 Jul 2023 23:29:23 +0200
MIME-Version: 1.0
Subject: Re: [patch 50/58] x86/apic: Provide common init infrastructure
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.058365439@linutronix.de>
From:   Peter Keresztes Schmidt <peter@keresztesschmidt.de>
In-Reply-To: <20230717223226.058365439@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4R5Bsx63Gxz9sls
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas!

On 18.07.23 01:15, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/apic/bigsmp_32.c
> +++ b/arch/x86/kernel/apic/bigsmp_32.c
> @@ -119,10 +119,8 @@ bool __init apic_bigsmp_possible(bool cm
>  
>  void __init apic_bigsmp_force(void)
>  {
> -	if (apic != &apic_bigsmp) {
> -		apic = &apic_bigsmp;
> -		pr_info("Overriding APIC driver with bigsmp\n");
> -	}
> +	if (apic != &apic_bigsmp)
> +		apic_install_driver(&apic_noop);

Could apic_noop be a typo? Shouldn't it be apic_bigsmp?

>  }
>  
>  apic_driver(apic_bigsmp);

Thanks,
Peter
