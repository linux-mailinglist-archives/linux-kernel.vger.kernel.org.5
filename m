Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB90A7763D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjHIPe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjHIPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:34:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BBE2112;
        Wed,  9 Aug 2023 08:34:15 -0700 (PDT)
Date:   Wed, 09 Aug 2023 15:34:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691595254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PA6m/cipfB/Kt7wihXUNPLDEBFHyt5mexzg3R7RdIR8=;
        b=1JW5RsTGqmJvexKJlM7Nc74NuWZBmFyi5b5mbQqguETpR04TQ5BnEQb4+6G057hgEAHTN0
        qFyPz027I84GFcrgT4RoD5juntXD+HIwA0jK1i41UVkppvoO0GL2x0BMtp8b7jAiAjum8A
        0sLAJOE/F6YzVVaQcR1PWqclHB/CM96Syo22bXbt2uldA7YwsChSO2xQlZAQQEJV7n9ToY
        CzyA8Gx1NTPfEFJr0j0vG2DDJnMBC3dyv8lP9Yj7yRwTuTg5oDQA1Y/sRlTi5l/FZGFL6K
        EzT3ns3ybz8y62UP0rRdzMCr6qRd1Su++ozKGjOKEl0Cz+J2bOlksci4mT9Arg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691595254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PA6m/cipfB/Kt7wihXUNPLDEBFHyt5mexzg3R7RdIR8=;
        b=aSET9ubUQcXkJxjnIEdHfsRHnfJn6IdaQ9HfFpCDB80zBqolZX3AgOpITN0TNnGGX+HH2i
        t9pX7iijbJQNaHCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/pv: Pretend that it found SMP configuration
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169159525359.27769.9154782569983000758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8fd2ac6c0d74f59897eeb83de72aeb3278a54ae8
Gitweb:        https://git.kernel.org/tip/8fd2ac6c0d74f59897eeb83de72aeb3278a54ae8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 08:10:11 -07:00

x86/xen/pv: Pretend that it found SMP configuration

Unlike all other SMP configuration "parsers" XEN/PV does not set
smp_found_config which is inconsistent and prevents doing proper decision
logic based on this flag.

Make XEN/PV pretend that it found SMP configuration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
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
