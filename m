Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ECC77683B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjHITN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHITMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4E12D51;
        Wed,  9 Aug 2023 12:12:29 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pdWJDpX5OTqpDzDal/j+s+UQGog4zIEnnHtytOW9qys=;
        b=1MM5Fdyf25wpL2SGZLcttqlLji1FK5BUoT1KMGDsyDE2jMpz43Lj0S2vLoBroJn8dMQrc4
        Ku9GnqDKQ0sm5ZLp5Q87kPgokz7VrOiUHdzYHVnzHBLjjtno1G3WL/AOW7efJCz1kibR9a
        1cOvo3s0ieqM3b3h87onFBAqSkcGoN8urFvZ3RaPh+2kUhPftTIYKwGNZ88qwkmalZUD8C
        y9L8oKO3vxdduSDLdWidrIQ+3VDhkv57EgJEg+YxKmjd4IBhvwKXj2i4HKOIn2bsAK1XNd
        J/CKpVdVWEz2X08iQdVFWU7T9RvDTMsLQyN/PIC9bUjgMuq+GF3yFURHAPcDFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pdWJDpX5OTqpDzDal/j+s+UQGog4zIEnnHtytOW9qys=;
        b=07OSYgy0g1NnSm9NgjidLlBQovLAAFIonSr/fd4PdKmRSs1YvSPLm8SQOo5BQQwQY+3RWL
        aSLTN3GcA99ixsCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/pv: Pretend that it found SMP configuration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834367.27769.6523645283813577814.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     24889a3a5314f71e7bca586b607882d87c71799c
Gitweb:        https://git.kernel.org/tip/24889a3a5314f71e7bca586b607882d87c71799c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:21 -07:00

x86/xen/pv: Pretend that it found SMP configuration

Unlike all other SMP configuration "parsers" XEN/PV does not set
smp_found_config which is inconsistent and prevents doing proper decision
logic based on this flag.

Make XEN/PV pretend that it found SMP configuration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/xen/smp_pv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index c6b42c6..a0f07bb 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -182,7 +182,8 @@ static void __init _get_smp_config(unsigned int early)
 	if (subtract)
 		set_nr_cpu_ids(nr_cpu_ids - subtract);
 #endif
-
+	/* Pretend to be a proper enumerated system */
+	smp_found_config = 1;
 }
 
 static void __init xen_pv_smp_prepare_boot_cpu(void)
