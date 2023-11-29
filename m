Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758F67FD3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjK2KRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjK2KRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:17:10 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FABD1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:17:15 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0993C40E019F;
        Wed, 29 Nov 2023 10:17:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eyamEeQAGL8V; Wed, 29 Nov 2023 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701253030; bh=eFpNg/8twFDseGoZdnKubcbW6QXAZq0sTnyKCpFgpmg=;
        h=From:To:Cc:Subject:Date:From;
        b=XkVZFO98xVwh9JQxSzThGl3CVW5z18BdSeSg5uF0TOx+rnKUajPg2K0hLx0nmhaH3
         k+2PendEeZ9iC5mpuGxoV99zu+D22bmQAaJhwBPD5QoQ+Blz0Pv6E/mKAGXvB41U45
         apEAhmJHvGHeHZt5/NbHdtqvEp3gWXQS/gd5AQmYHLe6a4nq+BCBwI3J8b68FLSQND
         TzMuXEmZzP8gbMJ288JXeGuhn5uyhxC6pqM/tvIfYfQAPgVfdXLq3WEeuNMoqJPkun
         wSW5PCWJvwwkBwWBE+Ewd+gsDU/J09hIZ5d7SuzUaZYSWjpAAe4RQNsi8JRT2q3dqA
         GVrqIbSFXgvMXsAqojjg74d/Hbwz1MzBzeioqGee0ygrcJEIC4BWI+7hRxMXmbhTrS
         cpY6iVfaO65eMc9qn5iXZIMeO5yvQqaXdVKYHnMoLoyt18GY9z/u8GvygpCqlSCTyl
         6S1gFUPDzveHAQ/l00Wg0cIDhHjxGWDOGrBZjJ1ObP8106DJ8klfcFGxy3C+7MIbrC
         urUbjmDnc5LB+afgOA1atYn/G+Fa7Kaa6toFTOD98gC9fNuf2eiUpBLOj5OE9HYlL1
         pg7OgTUDH53VrCIrWjHFYH1DCTCB8XCoBJseh8YTry7RjNXO+hlwbmuRQ0fJIgGLqO
         v9QT9hYAvIgo+LGgvwRvHW3o=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2DDEA40E0031;
        Wed, 29 Nov 2023 10:17:08 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation/x86: Document what /proc/cpuinfo is for
Date:   Wed, 29 Nov 2023 11:17:00 +0100
Message-ID: <20231129101700.28482-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

This has been long overdue. Write down what x86's version of
/proc/cpuinfo is and should be used for.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 Documentation/arch/x86/cpuinfo.rst | 79 ++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/Documentation/arch/x86/cpuinfo.rst b/Documentation/arch/x86/=
cpuinfo.rst
index 08246e8ac835..cede6aad27c0 100644
--- a/Documentation/arch/x86/cpuinfo.rst
+++ b/Documentation/arch/x86/cpuinfo.rst
@@ -7,27 +7,64 @@ x86 Feature Flags
 Introduction
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-On x86, flags appearing in /proc/cpuinfo have an X86_FEATURE definition
-in arch/x86/include/asm/cpufeatures.h. If the kernel cares about a featu=
re
-or KVM want to expose the feature to a KVM guest, it can and should have
-an X86_FEATURE_* defined. These flags represent hardware features as
-well as software features.
-
-If users want to know if a feature is available on a given system, they
-try to find the flag in /proc/cpuinfo. If a given flag is present, it
-means that the kernel supports it and is currently making it available.
-If such flag represents a hardware feature, it also means that the
-hardware supports it.
-
-If the expected flag does not appear in /proc/cpuinfo, things are murkie=
r.
-Users need to find out the reason why the flag is missing and find the w=
ay
-how to enable it, which is not always easy. There are several factors th=
at
-can explain missing flags: the expected feature failed to enable, the fe=
ature
-is missing in hardware, platform firmware did not enable it, the feature=
 is
-disabled at build or run time, an old kernel is in use, or the kernel do=
es
-not support the feature and thus has not enabled it. In general, /proc/c=
puinfo
-shows features which the kernel supports. For a full list of CPUID flags
-which the CPU supports, use tools/arch/x86/kcpuid.
+The list of feature flags in /proc/cpuinfo is not complete and
+represents an ill-fated attempt from long time ago to put feature flags
+in an easy to find place for userspace.
+
+However, the amount of feature flags is growing by the CPU generation,
+leading to unparseable and unwieldy /proc/cpuinfo.
+
+What is more, those feature flags do not even need to be in that file
+because userspace doesn't care about them - glibc et al already use
+CPUID to find out what the target machine supports and what not.
+
+And even if it doesn't show a particular feature flag - although the CPU
+still does have support for the respective hardware functionality and
+said CPU supports CPUID faulting - userspace can simply probe for the
+feature and figure out if it is supported or not, regardless of whether
+it is being advertized somewhere.
+
+Furthermore, those flag strings become an ABI the moment they appear
+there and maintaining them forever when nothing even uses them is a lot
+of wasted effort.
+
+So, the current use of /proc/cpuinfo is to show features which the
+kernel has *enabled* and supports. As in: the CPUID feature flag is
+there, there's an additional setup which the kernel has done while
+booting and the functionality is there and ready to use. A perfect
+example for that is "user_shstk" where additional code enablement is
+present in the kernel to support shadow stack for user programs.
+
+So, if users want to know if a feature is available on a given system,
+they try to find the flag in /proc/cpuinfo. If a given flag is present,
+it means that the kernel supports it and is currently making it
+available.  If such flag represents a hardware feature, it also means
+that the hardware supports it.
+
+If the expected flag does not appear in /proc/cpuinfo, things are
+murkier.  Users need to find out the reason why the flag is missing and
+find the way how to enable it, which is not always easy.
+
+There are several factors that can explain missing flags: the expected
+feature failed to enable, the feature is missing in hardware, platform
+firmware did not enable it, the feature is disabled at build or run
+time, an old kernel is in use, or the kernel does not support the
+feature and thus has not enabled it. In general, /proc/cpuinfo shows
+features which the kernel supports. For a full list of CPUID flags which
+the CPU supports, use tools/arch/x86/kcpuid.
+
+Regarding implementation, flags appearing in /proc/cpuinfo have an
+X86_FEATURE definition in arch/x86/include/asm/cpufeatures.h. These flag=
s
+represent hardware features as well as software features.
+
+If the kernel cares about a feature or KVM want to expose the feature to
+a KVM guest, it should only then expose it to the guest when the guest
+needs to parse /proc/cpuinfo. Which, as mentioned above, is highly
+unlikely. KVM can synthesize the CPUID bit and the KVM guest can simply
+query CPUID and figure out what the hypervisor supports and what not. As
+already stated, /proc/cpuinfo is not a dumping ground for useless
+feature flags.
+
=20
 How are feature flags created?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
--=20
2.42.0.rc0.25.ga82fb66fed25

