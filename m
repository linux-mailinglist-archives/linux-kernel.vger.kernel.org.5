Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808F47726A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjHGNx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjHGNxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0BA19AF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:00 -0700 (PDT)
Message-ID: <20230807135027.272696521@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EYJQm55oUOskfK42q+cCkqIk4Ng20LK8t+Y3B5NsE1Q=;
        b=zU/CWefGrrijcHZNe0gp8+zI3xflV8ngWsF8njohR2f4n44hzAZZ83gdmS6ndp4hGx4glT
        XFvBE3diBtAuFI4fIEA3sYNoOxWEEy3GqImCH0fijuJcHtJ3WmN83k90zlZeJpRJNB0v1o
        xbklaBa/UbYNa92h3NuvNSiNcAtuQj0cvbgMSqA4Zdtsi8PXT/wUOoL3A+AhjePhMXFIXp
        wVz3C4V5R/AvkbWAfkSv3hMxiMbUqd2CgB0zgqxkF3JfLuoAR3VMEwBRgQrvio4733aGvP
        T6tzKGixPwJCoBstE4r/2ppRfjwxZy/UyPZqLwwKXFdCXQ+K/NfiuEPtJ0gMGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EYJQm55oUOskfK42q+cCkqIk4Ng20LK8t+Y3B5NsE1Q=;
        b=2AcvcxdJ5xheNZyDGUkC3lOpedA6m5v74DCE56NsaMpqFxzH2sM80u+O4KTMsw8S843rEW
        iYwf+/1fO8rMOGCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 16/53] x86/xen/smp_pv: Prepare for separate mpparse callbacks
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:52:58 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/xen/smp_pv.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -185,6 +185,11 @@ static void __init _get_smp_config(unsig
 	smp_found_config = 1;
 }
 
+static void __init xen_pv_smp_config(void)
+{
+	_get_smp_config(false);
+}
+
 static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
@@ -455,6 +460,8 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = _get_smp_config;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
+	x86_init.mpparse.get_smp_config		= _get_smp_config;
 }

