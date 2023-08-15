Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237777CE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjHOO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbjHOO02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:26:28 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2CB8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:26:23 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 02C9340E0196;
        Tue, 15 Aug 2023 14:26:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fiE7i3-YNHqc; Tue, 15 Aug 2023 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692109572; bh=K3P291BTdQmbsgyGc2rUDKvAAUDf7S3nA/mDPsNeP/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZ1VMTWykZuEpJ1aGy7uHNF8U2OIdvReuC9zrXtskh78n62UUcfpc1qrBF7mAC45u
         VBUBc1SpFwWc6JBQxhwAuv7yCUAcUL23yuJO70odPATmT/gmK4N1yrq6FZsOnjdtH9
         AR2gRCv48jIUwQnWce6LifgacIR4BMTGvaDOEmfC39GsgCGch5+I5vIDjiNvhIneDp
         k1AMrxSo6mDqYdeMMS45dmglZWhDwzBInjyTKWkzVadj6CIIL3nHflS/CfE1nuyGbD
         YOqYSi37nntjWxbuZ8i4wNa2kcFOwvQgck5nNED7abMrU+RicGcRvynFLo1shGrBej
         A+bQ2Bvw6rKrXUhi2LU7wmrmiDLRjhhMRsCAnHv73ixmH0uZwO+VM9uSa+u9AkL2Px
         eU5Y5RwHE0wVcnW2uHKIkZg6WjPLVBX7GE1eqtn1PZbYaYG5DLoW35JDYwV/a2sUCp
         yNdwlZkM5u61Av/zqwTZL7Tdtp/kJ7zyTR70AFO8VakVbx10vTbb4SDU2j5lZ8sek7
         1OE/9ms4mFvUcP189Ewqh/Kvt5W2zuddkNPwcRJe8wnTnuTJcqpvxX/lfcb2qy3d7w
         9zUxhsXbF2HtyVu2qV+1+hRulc+LTAvqv2H+OkUnk01zEw5JYn99PUJss+f1eybV8e
         CANJcyFHi/A2a5ckOcOof1AI=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9AC840E0194;
        Tue, 15 Aug 2023 14:26:04 +0000 (UTC)
Date:   Tue, 15 Aug 2023 16:26:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: [PATCH] x86/srso: Explain the untraining sequences a bit more
Message-ID: <20230815142600.GEZNuK+NyJdReK466b@fat_crate.local>
References: <20230814114426.057251214@infradead.org>
 <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
 <20230814195153.2zxtp6zx552trgh6@treble>
 <20230814200128.ioas5lk2r3yzfkkv@treble>
 <20230814200916.GJZNqJ7H3MaO0ZTO5/@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814200916.GJZNqJ7H3MaO0ZTO5/@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Mon, 14 Aug 2023 21:29:50 +0200

The goal is to eventually have a proper documentation about all this.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 915c4fe17718..e59c46581bbb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -183,6 +183,25 @@ SYM_CODE_START(srso_alias_return_thunk)
 	ud2
 SYM_CODE_END(srso_alias_return_thunk)
 
+/*
+ * Some generic notes on the untraining sequences:
+ *
+ * They are interchangeable when it comes to flushing potentially wrong
+ * RET predictions from the BTB.
+ *
+ * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
+ * Retbleed sequence because the return sequence done there
+ * (srso_safe_ret()) is longer and the return sequence must fully nest
+ * (end before) the untraining sequence. Therefore, the untraining
+ * sequence must fully overlap the return sequence.
+ *
+ * Regarding alignment - the instructions which need to be untrained,
+ * must all start at a cacheline boundary for Zen1/2 generations. That
+ * is, instruction sequences starting at srso_safe_ret() and
+ * the respective instruction sequences at retbleed_return_thunk()
+ * must start at a cacheline boundary.
+ */
+
 /*
  * Safety details here pertain to the AMD Zen{1,2} microarchitecture:
  * 1) The RET at retbleed_return_thunk must be on a 64 byte boundary, for
-- 
2.42.0.rc0.25.ga82fb66fed25

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
