Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5848976B235
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjHAKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjHAKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D31BC1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:03 -0700 (PDT)
Message-ID: <20230801103816.037141488@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tJxhzLbo7FHsorrk3uDGkPGMiQ+vhYqtvOcmkhfQkMo=;
        b=U9fTojmo7YTcGSu2uGhvgsUHlJI8A0uXPv71+yTcZ/LYKQOKnqCp4KdCGgJw4v2lcxM49V
        ky/MTAMOsUJH7OUq3Mt8ct8bwPRSWMzi1TvSJYtXt4UWLaMEDFdNm53PnuZS6id+toeO3p
        AWABibgza6i0JB2Vhm3yy29WpSaJncxktS15YRbWrQdmvsS2RNXR/xD5ktZLv4omW3SmYB
        gWYj4EGJUdckSA7l0BdMDFpzSnhmuztNH6tmRYuhTxi/4Tyumy3IXtzoIBrWPg1v1Ov3IG
        TXQeAU2+ikWKRivcKd51/OROabMYmCR2CPk9TnISkZi+Cd+hwU0R18Kr2wzqPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tJxhzLbo7FHsorrk3uDGkPGMiQ+vhYqtvOcmkhfQkMo=;
        b=5j0195GBEXYU0jCLsBplnJJCcn8j0+ScICey6/FPzt7J14hupnC5EaVN4bslJ03Ax9Sj6S
        RUFCFbJmI8gyp2Dw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>
Subject: [patch V3 16/60] x86/xen/pv: Pretend that it found SMP configuration
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:47:01 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike all other SMP configuration "parsers" XEN/PV does not set
smp_found_config which is inconsistent and prevents doing proper decision
logic based on this flag.

Make XEN/PV pretend that it found SMP configuration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch to address XEN/PV breakage - Juergen
---
 arch/x86/xen/smp_pv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -182,7 +182,8 @@ static void __init _get_smp_config(unsig
 	if (subtract)
 		set_nr_cpu_ids(nr_cpu_ids - subtract);
 #endif
-
+	/* Pretend to be a proper enumerated system */
+	smp_found_config = 1;
 }
 
 static void __init xen_pv_smp_prepare_boot_cpu(void)

