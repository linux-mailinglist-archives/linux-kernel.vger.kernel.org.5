Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0664F7816A9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243935AbjHSC2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjHSC2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:28:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91B4220;
        Fri, 18 Aug 2023 19:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4C962625;
        Sat, 19 Aug 2023 02:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA92C433C8;
        Sat, 19 Aug 2023 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692412114;
        bh=tkZt2GqJGksQZ2JXkMK3YT4deGgiOKhxt303O7V/ft0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JT6+ssijzlTs9imRh7B8rwrJEXpAcl5U/OYMu60PgbKNxs1A/+9dJsp7RVrrIhubD
         /gofihc790OaYdYetLol3Ar+iyJhKU07k0chNwPqUROgnENOC2hWi4SIgO2B2DthAt
         peH2/yJJSudIWgKe9nvB7Qb2xQyWew4v0980B4T5WJWjvHK8gMrlYTbC9j+VtKahfQ
         w03vI69h/y4eMTDCIPhd1hwbwRvNB/QASq0l7VOaldtbAe6x6630HC3JlWjRJ07ntx
         SHSKNdGzPZmY8yO2IVSN0Tx+NzivwIA3PHP9SEVDdpaLNnfquFbOkh+skT0MLF2jvJ
         ezg4LjNTdOu5g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42A98CE039C; Fri, 18 Aug 2023 19:28:34 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:28:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, eric.devolder@oracle.com, sourabhjain@linux.ibm.com,
        hbathini@linux.ibm.com, bhe@redhat.com
Subject: [BUG resend next-20230818] error: 'prepare_elf_headers' defined but
 not used
Message-ID: <4a991983-da2e-4fcd-965c-5b65de6700da@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This morning's rcutorture testing on next-20230818 complained about
prepare_elf_headers() being defined but unused on several rcutorture
scenarios.  The patch below makes rcutorture happy, but might or might
not be a proper fix.

This is a resend adding a few more people on CC, given a possible
relationship to 9f1f399ca999 ("x86/crash: add x86 crash hotplug support").

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 1d0f824559fce..926c39e22387b 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -127,7 +127,8 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)
+#if (defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_DUMP)) && defined(CONFIG_SMP) && defined(CONFIG_X86_LOCAL_APIC)
+
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
