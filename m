Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4977A770750
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHDRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjHDRvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:51:23 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0949FF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:51:20 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 72DE240E01EE;
        Fri,  4 Aug 2023 17:51:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VvYt1BylTJyO; Fri,  4 Aug 2023 17:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691171468; bh=jZYCKzbp7hTLxTqi78NZ0uPmLjmpqo3m1vnYlEp6bVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIZf2pxpXnhQLzuG8SkIMt5JO49XKi0cxAMRNTLIh/XVp5PVtNl3nm6Wst2SyR9Wj
         Tw9vJ1g3MO7y0ccVszX8JswtgLL0SXQdmBURLWMHG0Ejnmif7YPOEzTkwrOpB/SqQW
         Ao3abBZEnO/PeNcnx4kcZpiJWU0MGPBmfDm3DAc1E04ekd3mDwje+CFRkmiHiXMdlm
         B92X+RJqx0F0QmtzQ24p+BZqRJStqab0J6FEcONsm4HrjbAsOLWzmZ9b+ZaUGLJRKQ
         rW6dESiCuzzw9Pk37oVHkpC/vrn85bfWzzX4IJ18oHDcwchy4ypHJRLC4qwU3Dpmdj
         Bnm46QEyBx3JrXDPKGk+dke3gK2qvbVfmcQ2C19QGlsCKeXTPF3p4huCyYmeqMhjyk
         2aoaiGJEzdXOzNYcNWfMrbo2hzm0BZhDiwcDM4UntvusqD0UiMQ/Aal9xu+cyybGxh
         i22bkGmT59M4c4uQLlS4EvVueVZAZYffjr4dxssq0mcmAWXdu5BYws+l4+cUwnbs5Y
         JY42t4aLeNlftMlpXHfLyGgtEUF68lIv5ghB0nW/qTuFKDdG0YTdvAy3HwFlFsDDo1
         2OgM/KVbdtJ/XMoqO7D0sJfsjCbjF6IXsWGK2+mkmKElyXQckp1/QiibtXPLlCi8uD
         Ml7NNOOcFXfaM21DSMrONEuo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6686340E01A4;
        Fri,  4 Aug 2023 17:50:57 +0000 (UTC)
Date:   Fri, 4 Aug 2023 19:50:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch V3 01/40] cpu/SMT: Make SMT control more robust against
 enumeration failures
Message-ID: <20230804175051.GKZM06e6VTtAYwTRWO@fat_crate.local>
References: <20230802101635.459108805@linutronix.de>
 <20230802101932.758513086@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802101932.758513086@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 12:20:59PM +0200, Thomas Gleixner wrote:
>  kernel/cpu.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -630,6 +630,12 @@ static inline bool cpu_smt_allowed(unsig

As discussed on IRC, the name and what the function does is kinda
conflicting.

What it actually queries is whether the CPU can be booted. So something
like this ontop I guess:

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f93ce69f7e3d..e4195d5425cb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -659,7 +659,7 @@ static inline bool cpu_smt_thread_allowed(unsigned int cpu)
 #endif
 }
 
-static inline bool cpu_smt_allowed(unsigned int cpu)
+static inline bool cpu_bootable(unsigned int cpu)
 {
 	if (cpu_smt_control == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
@@ -691,7 +691,7 @@ bool cpu_smt_possible(void)
 EXPORT_SYMBOL_GPL(cpu_smt_possible);
 
 #else
-static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
+static inline bool cpu_bootable(unsigned int cpu) { return true; }
 #endif
 
 static inline enum cpuhp_state
@@ -794,10 +794,10 @@ static int bringup_wait_for_ap_online(unsigned int cpu)
 	 * SMT soft disabling on X86 requires to bring the CPU out of the
 	 * BIOS 'wait for SIPI' state in order to set the CR4.MCE bit.  The
 	 * CPU marked itself as booted_once in notify_cpu_starting() so the
-	 * cpu_smt_allowed() check will now return false if this is not the
+	 * cpu_bootable() check will now return false if this is not the
 	 * primary sibling.
 	 */
-	if (!cpu_smt_allowed(cpu))
+	if (!cpu_bootable(cpu))
 		return -ECANCELED;
 	return 0;
 }
@@ -1725,7 +1725,7 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 		err = -EBUSY;
 		goto out;
 	}
-	if (!cpu_smt_allowed(cpu)) {
+	if (!cpu_bootable(cpu)) {
 		err = -EPERM;
 		goto out;
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
