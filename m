Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A447C7EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjJMHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjJMHnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:43:13 -0400
Received: from galois.linutronix.de (unknown [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021D6B8;
        Fri, 13 Oct 2023 00:43:10 -0700 (PDT)
Date:   Fri, 13 Oct 2023 07:42:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697182974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXCw9IkWlk0gd+BE15eTwbCAJMYeblimrkybqcODQ5A=;
        b=vOWQZ2HVJve7Q7G4FKO1RF4VhTJw5c2C2c4o+mA5cSrJ4HsAU6GKQL52NIHC4XAahlT7g2
        yD3xWSymfAPFXqMWMrwJk5S2ia1FDBnMslyJ5m3kw/GAdQFONsjU51DYTbckxYGkAyZlz9
        EHJxBfnpVMI5zcoGfs+NAiF46KSzYQIqHAi4jII3owqvtki+c4pU6S0oiJuS5F+kYzRGqX
        G9vyMDgtB+Hh7Xx8TwMT2dzQli/kxZthtJFHdRx5692MkI98ojB3uo2AcZ+icKrCpnt/oG
        t+sDHrTyvrPGoHteshZRL43IfGtvyy4qKunXrcBQ3I08ar9wJTloV/x0ZFvWKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697182974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXCw9IkWlk0gd+BE15eTwbCAJMYeblimrkybqcODQ5A=;
        b=R9PsJqevuuCjd/Jh1qHhsJfbFTxS+V00pb8yqFn+XNEgFAMwwImUU3re+L2vlyetAM6xA3
        SKFEzJ+WCQN03SDQ==
From:   "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Fix uninitialized return value
 in amd_uncore_init()
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
MIME-Version: 1.0
Message-ID: <169718297336.3135.15401455533118971114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7543365739a4ff61d40ad53ab68c17d2e7dfb0c9
Gitweb:        https://git.kernel.org/tip/7543365739a4ff61d40ad53ab68c17d2e7dfb0c9
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Fri, 13 Oct 2023 10:18:12 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Oct 2023 09:32:50 +02:00

perf/x86/amd/uncore: Fix uninitialized return value in amd_uncore_init()

Some of the error paths in this function return don't initialize the
error code.  Return -ENODEV by default.

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain
---
 arch/x86/events/amd/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 9b444ce..a389828 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -1009,7 +1009,8 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 static int __init amd_uncore_init(void)
 {
 	struct amd_uncore *uncore;
-	int ret, i;
+	int ret = -ENODEV;
+	int i;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
