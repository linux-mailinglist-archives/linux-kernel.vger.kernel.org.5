Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FBD7726BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjHGNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjHGNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED561703
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:28 -0700 (PDT)
Message-ID: <20230807135028.217017488@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yTx1K1TOgVQKpA16O0I6vT9VzfdHaMEzdywPzDbFuOw=;
        b=1WEqWUxRklJni9r/WJ5i62dKJgjJrRVTauTMWkeUrcmaMzCnOyozSrIq3E0nTa5V2PUSQv
        Yx2Ar7qZ2UAENEFcYO5Y9YQAdVQdbM+VhSgGg1/kzbr6Y0v/ATFnTPVEEnFM7ZR2M2D0jl
        9Q1LuETfQUK9Z7Jhock90JOkTBVIWtjPE4NcsxdT+nzC+UBZbVJ5Ch4RuwOI+x+lQVqnT0
        Wdfn27PEnJORrkqPRfLlg/u28peJ7E9Xxtv5a+Lh4wyuUVQ3DpXJUukKUu+WfS9Q7JuU/i
        Q4Nop8ha0qreLWjo9M1QHcA34BwG63GpdvA8NEBjtZrQnxWtnk4Msau42/Kd8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yTx1K1TOgVQKpA16O0I6vT9VzfdHaMEzdywPzDbFuOw=;
        b=7RtmB+XTjyJwlP4WRawDg3RmJTpeBvMUSdrIKC6b+z8/BwacVTc1qY73W6C5VjhXZdTScj
        LzRQsTbxaoGgHgCw==
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
Subject: [patch 34/53] x86/smpboot: Make error message actually useful
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:26 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"smpboot: native_kick_ap: bad cpu 33" is absolutely useless information.

Replace it with something meaningful which allows to decode the failure
condition.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1081,9 +1081,13 @@ int native_kick_ap(unsigned int cpu, str
 
 	pr_debug("++++++++++++++++++++=_---CPU UP  %u\n", cpu);
 
-	if (apicid == BAD_APICID || !test_bit(apicid, phys_cpu_present_map) ||
-	    !apic_id_valid(apicid)) {
-		pr_err("%s: bad cpu %d\n", __func__, cpu);
+	if (apicid == BAD_APICID || !apic_id_valid(apicid)) {
+		pr_err("CPU %u has invalid APIC ID %x. Aborting bringup\n", cpu, apicid);
+		return -EINVAL;
+	}
+
+	if (!test_bit(apicid, phys_cpu_present_map)) {
+		pr_err("CPU %u APIC ID %x is not present. Aborting bringup\n", cpu, apicid);
 		return -EINVAL;
 	}
 

