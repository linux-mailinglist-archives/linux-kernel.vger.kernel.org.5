Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB3C7BBD7C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjJFRJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjJFRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:09:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C282ED6;
        Fri,  6 Oct 2023 10:09:45 -0700 (PDT)
Date:   Fri, 06 Oct 2023 17:09:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696612183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D/T1SE2RZgkOb3wpa/nFU1nXcIAWzxDzhnuzBmYadWg=;
        b=Y2p2Eu53v+tG2dB2XWqPMIzBm0vMjL5aZYQ87LSbLZ5oh4Jt4O0+R+m4IpZrSLTJ0mQIFm
        Ca5sYcX5pCbKTJ0DGhVgWlL6+0hn7Ur/vkLUFfzOhLmd5/K7F2eU32dJAj8rPw7tDY3jDz
        VTziY6z1oZHyMw++eSufqQ9Mtf0gOm9W2ZzEeWLuAAnVUSF5maK5YkJJmpX2XgYpnx5TWl
        YGvixg2b3Qir4YL9mLj+vaCUJ0/mnnF+sMslnVnrm6mrAVpGflPd0C+/MGAmYgJJNLcfWQ
        3bkkKFvojDqfvngTJccmPnk1GIOyYVKt0oA+ESSYKL0rmF3QpN7g+ULc1ll1MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696612183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D/T1SE2RZgkOb3wpa/nFU1nXcIAWzxDzhnuzBmYadWg=;
        b=CB8qQdGeH6YX+/DcYvcbxlCtritv0BSkvY9i0S7bOukgReept2iYFlN74YxY8GEcWxgdkb
        SdsA8DMcsQQbdjCQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Mark TSC reliable
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169661218292.3135.7318812818696091080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     9ee4318c157b9802589b746cc340bae3142d984c
Gitweb:        https://git.kernel.org/tip/9ee4318c157b9802589b746cc340bae3142=
d984c
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 06 Oct 2023 17:45:49 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 06 Oct 2023 10:00:04 -07:00

x86/tdx: Mark TSC reliable

In x86 virtualization environments, including TDX, RDTSC instruction is
handled without causing a VM exit, resulting in minimal overhead and
jitters. On the other hand, other clock sources (such as HPET, ACPI
timer, APIC, etc.) necessitate VM exits to implement, resulting in more
fluctuating measurements compared to TSC. Thus, those clock sources are
not effective for calibrating TSC.

As a foundation, the host TSC is guaranteed to be invariant on any
system which enumerates TDX support.

TDX guests and the TDX module build on that foundation by enforcing:

  - Virtual TSC is monotonously incrementing for any single VCPU;
  - Virtual TSC values are consistent among all the TD=E2=80=99s VCPUs at the
    level supported by the CPU:
    + VMM is required to set the same TSC_ADJUST;
    + VMM must not modify from initial value of TSC_ADJUST before
      SEAMCALL;
  - The frequency is determined by TD configuration:
    + Virtual TSC frequency is specified by VMM on TDH.MNG.INIT;
    + Virtual TSC starts counting from 0 at TDH.MNG.INIT;

The result is that a reliable TSC is a TDX architectural guarantee.

Use the TSC as the only reliable clock source in TD guests, bypassing
unstable calibration.

This is similar to what the kernel already does in some VMWare and
HyperV environments.

[ dhansen: changelog tweaks ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.int=
el.com>
Reviewed-by: Erdem Aktas <erdemaktas@google.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20231006144549.2633-1-kirill.shutemov%40lin=
ux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3e6dbd2..2f27ae1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -816,6 +816,9 @@ void __init tdx_early_init(void)
=20
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
=20
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	cc_vendor =3D CC_VENDOR_INTEL;
 	tdx_parse_tdinfo(&cc_mask);
 	cc_set_mask(cc_mask);
