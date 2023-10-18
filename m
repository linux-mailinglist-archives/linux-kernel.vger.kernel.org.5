Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B965B7CDD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJRNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJRNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:24:10 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7B783;
        Wed, 18 Oct 2023 06:24:08 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D5B040E0196;
        Wed, 18 Oct 2023 13:24:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PW8Ammz9t8hd; Wed, 18 Oct 2023 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697635444; bh=KKdXn+jk+LH5SYspzTnz0xjWorkps4s5tMVwILJV4Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4b7m8JKo0YGIpM3N2VwSm5LFPcIiBd8+rSQK4C7Oh8S2VF85151KzPZ+8NKU016o
         kToA08GsRix4kTyhQfM3L/NM8KRysJWbj8lHeAvbV7c29e+xfeMmoLcWY6QGt/qDrh
         QtKhOx2j8eYjTzSzVucbwILtldiJrO9uLh6oDmiNXKbAyauPE3S4pkGiUr5n1HxCzx
         f4HsvEa/8eBpA2+qxQxGgb/WSfF26tTurvZSeegohDDK5rJJbb0i7v00axWmio/8zZ
         ir3ZhHZUG5/133AutcBEZ+pVUBqAxRasQ+0mbiclPqdGoJY9fr423LIi6ecY3Uekg4
         4bqQTcQSsp3HLJONCSGsNMJAe38S+01e6KmLq6xApWyuB3Tzg4L4+qT3bKQyNKmrbX
         yLHAjP6mPZXQt7GXInZMGH44NjgxzWQxAtK3qAEaCWuQJ3Rhc9OnZpMwEQU6S/RIfk
         jr3DruKNXrbYZkF6fRPhDyziUouv6S7rzwDFsPmrrBeQfHjVeWHCm1EUkUdpvSb5Bq
         Zsv7L51xV+ClYRnDrRDzZrqScaepMBun0FT+pgUii/JbCAucQyWRKLKdbDwyXLGVFn
         87xmJKgeXa2ZHV/FNjmE9zdLnMr+DA/Ys9aF3A/y4bqaqxrUQ7uvWL65TCmnKRPrRF
         nY8Eq+h3TFH5WdHRaGBBd2+o=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81CA440E0177;
        Wed, 18 Oct 2023 13:23:57 +0000 (UTC)
Date:   Wed, 18 Oct 2023 15:23:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        David Kaplan <david.kaplan@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Message-ID: <20231018132352.GBZS/caGJ8Wk9kmTbg@fat_crate.local>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 05:50:35PM -0000, tip-bot2 for David Kaplan wrote:
>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -	ANNOTATE_UNRET_SAFE
> -	ret
> +	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS

I'm wondering if panicking people's boxes isn't too harsh.

Also, we don't BUG() if we can continue so perhaps this should be
a really loud warn instead:

---
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b96927a..f230f396c9c1 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -357,6 +357,8 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
+extern void check_thunks(void);
+
 #ifdef CONFIG_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab8466b91..e4b2dfbf3de5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2849,3 +2849,8 @@ ssize_t cpu_show_gds(struct device *dev, struct device_attribute *attr, char *bu
 	return cpu_show_common(dev, attr, buf, X86_BUG_GDS);
 }
 #endif
+
+void check_thunks(void)
+{
+	WARN(1, "Unconverted return thunk\n");
+}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3f3a478b74dd..ca9024ef0a7c 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -366,8 +366,7 @@ SYM_FUNC_END(call_depth_return_thunk)
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret),"ud2", X86_FEATURE_ALWAYS
-	int3
+	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE;ret;int3),"call check_thunks; ret", X86_FEATURE_ALWAYS
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
