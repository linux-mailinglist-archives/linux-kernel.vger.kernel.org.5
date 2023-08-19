Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D64F781B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 02:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjHTANL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHTAM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:12:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779F1C10F6;
        Sat, 19 Aug 2023 14:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA4F60B3E;
        Sat, 19 Aug 2023 21:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B79C433C7;
        Sat, 19 Aug 2023 21:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692478899;
        bh=qbe2iUOiLxtyxy6qhDWT7qx6g5/yVASiIpL3Yfiwj2c=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R7gnCySXJb28CSSROnGH4ySy4pSdI8Q+MdQM1qNMg+kBZ03fPbJjv/H1KoZXScq43
         gVHRqlrB+BZndtfAUHkUda+JyUgDU+iuIlh7O5PcSdHdQIrO80zlGkNjF7X+mH3SI+
         wesLInlh8hc4VZ91Jo3uEOQJxvcAdJCdd9UHa6NFAGjwdIImPINCJPA/vkd5HIii6B
         vdu1Emvsif6hd3r2zfLTS3262erAvClM17c4XMWsYXd/kLmD3ZeXPaVQHoXzA1mMhE
         HfPNRq8WSXLClfohEh6ovun08k9hIpAgConk8u0/IlpRGRYE9+cPwsLXKlJGFczyur
         N02zfQCypMlmQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CFBA0CE00C5; Sat, 19 Aug 2023 14:01:38 -0700 (PDT)
Date:   Sat, 19 Aug 2023 14:01:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     eric.devolder@oracle.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        sourabhjain@linux.ibm.com, hbathini@linux.ibm.com
Subject: Re: [BUG resend next-20230818] error: 'prepare_elf_headers' defined
 but not used
Message-ID: <a6f29741-39e2-41fd-a253-1a0477b89a9f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
 <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
 <ZOC94WelqfS0vsFK@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOC94WelqfS0vsFK@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 09:04:33PM +0800, Baoquan He wrote:
> On 08/18/23 at 07:28pm, Paul E. McKenney wrote:
> > Hello!
> > 
> > This morning's rcutorture testing on next-20230818 complained about
> > prepare_elf_headers() being defined but unused on several rcutorture
> > scenarios.  The patch below makes rcutorture happy, but might or might
> > not be a proper fix.
> > 
> > This is a resend adding a few more people on CC, given a possible
> > relationship to 9f1f399ca999 ("x86/crash: add x86 crash hotplug support").
> > 
> > Thoughts?
> > 
> 
> Thanks for reporting this, Paul.
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 1d0f824559fce..926c39e22387b 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -127,7 +127,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  	crash_save_cpu(regs, safe_smp_processor_id());
> >  }
> >  
> > -#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
> > +#if (defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)) && defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
> 
> Hi Eric,
> 
> Now prepare_elf_headers() is needed for kexec_file_load and crash
> hotplug support of kexec_load, change it like this?
> 
> #if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)

If you mean the patch below:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

------------------------------------------------------------------------

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 1d0f824559fc..c92d88680dbf 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -127,7 +127,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
