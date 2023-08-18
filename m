Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8C781291
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378995AbjHRSH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379340AbjHRSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722F02D70;
        Fri, 18 Aug 2023 11:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECD65616B0;
        Fri, 18 Aug 2023 18:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDE2C433C8;
        Fri, 18 Aug 2023 18:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692382031;
        bh=8bazFKC2EtD5qKvG3tFrbUBhe0yoc4Mir5hc0laHKwc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sifg1jVnl3dmDGkgBrKYqRHMkKVTqGylITP0QwHlWSXw2wzlRGVWigvfG7Cx12xrH
         vDleChZKhI+RG2hyqI/buzSPwfEFrUR9w+G3T10bLq1nvQWJylweqd17AAeDXcyXBX
         tD3QJ7rfGljQvO4C6Vz0YB0EMp9qlQK+xk6ra4Q5f2nCxUs2MFtdEdkhYTmPEkvuX1
         USYMKew1I2DQ9hbTj+n/ikHQqvJc8GDsqhuLkMz4ubKUmkk0GE2PJQw4yDLEJtuAMs
         NMmmeDTqimRkbLYxrltx3Cw4vn7aXAJnk9wcD6oEhAg87KHmhz3+g/sP+9GXgXZWpO
         HG1R6V2oug6yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB9ABCE039C; Fri, 18 Aug 2023 11:07:10 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:07:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Subject: [BUG next-20230818] error: 'prepare_elf_headers' defined but not used
Message-ID: <08fc20ef-854d-404a-b2f2-75941eeeccf8@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
