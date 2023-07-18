Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA5D757DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjGRNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjGRNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:35:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDFF97
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:35:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689687320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdiFb9acXjiaE46RP92ZjhxBVngsERCbg4/W6c9wpXA=;
        b=p/vVA91LNJQy0GkXT+GoS8G/f6GvvDxOh35uY+Sry1oagYzWzKWJnp+ofv35G3izE+nPJR
        0HNZNtSjgK9UwuDgJigbdZfH+YvO0OCMTNnmElZxCx6R3bqko27Lk3y0aT67ID4A+/rjzo
        DNDf+T0q/UYaqMqWHWxxQdCf4bYF5Xl+JgO1geP4eRF+vN5HZ+DR6wL8YOVOz86TlupjI+
        lBxtEpwn07yO2DWL8bHV0B6sV+7GvkF5EQ8vmjlnitaJ/+Z6ewl9DDA6U6Tdat4XRjXpkl
        CYogxDqrGNxlE7Egetnk59wZBki5D4Cq70UV7ew9cum3sxs7xvABpWXb3wuBDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689687320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PdiFb9acXjiaE46RP92ZjhxBVngsERCbg4/W6c9wpXA=;
        b=WrPm16VWC0xGmen6zkPJRAn+1FsrKXCg7NJOhrt8Yju2Y3YHV5HJZ/0p2YrsN3mOT0nmIT
        QvYG8cB26E6pUJBQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 58/58] x86/apic: Turn on static calls
In-Reply-To: <20230717223226.538475803@linutronix.de>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.538475803@linutronix.de>
Date:   Tue, 18 Jul 2023 15:35:19 +0200
Message-ID: <87bkg9xrzc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18 2023 at 01:16, Thomas Gleixner wrote:
>  static __always_inline void __apic_send_IPI_mask(const struct cpumask *mask, int vector)
>  {
> -	apic->send_IPI_mask(mask, vector);
> +	static_call(apic_call_send_IPI_mask)(mask, vector);
>  }
>  
>  static __always_inline void __apic_send_IPI_self(int vector)
>  {
> -	apic->send_IPI_self(vector);
> +	static_call(apic_call_send_IPI_self)(vector);
>  }

I obviously must have missed to read the huge documentation section
about static_call() and modules. These two need to be static_call_mod().

I've force pushed the fixed up git branch to:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/apic

Delta patch on top of the original pile below.

Thanks,

        tglx
---
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 78dfe8aaed83..f7eb72a1ae00 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -429,7 +429,7 @@ static __always_inline void __apic_send_IPI(int cpu, int vector)
 
 static __always_inline void __apic_send_IPI_mask(const struct cpumask *mask, int vector)
 {
-	static_call(apic_call_send_IPI_mask)(mask, vector);
+	static_call_mod(apic_call_send_IPI_mask)(mask, vector);
 }
 
 static __always_inline void __apic_send_IPI_mask_allbutself(const struct cpumask *mask, int vector)
@@ -449,7 +449,7 @@ static __always_inline void __apic_send_IPI_all(int vector)
 
 static __always_inline void __apic_send_IPI_self(int vector)
 {
-	static_call(apic_call_send_IPI_self)(vector);
+	static_call_mod(apic_call_send_IPI_self)(vector);
 }
 
 static __always_inline void apic_wait_icr_idle(void)
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 0c63d2d9d75c..66d531876d3b 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1875,6 +1875,7 @@ static __init void try_to_enable_x2apic(int remap_mode)
 		 * be addressed must not be brought online.
 		 */
 		x2apic_set_max_apicid(apic_limit);
+		x2apic_phys = 1;
 	}
 	x2apic_enable();
 }
