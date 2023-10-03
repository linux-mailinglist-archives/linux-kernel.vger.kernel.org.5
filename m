Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954597B6481
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjJCIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJCIkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:40:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C1B97;
        Tue,  3 Oct 2023 01:40:00 -0700 (PDT)
Date:   Tue, 03 Oct 2023 08:39:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696322398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh+KBuPKg3zOxbyl3qdxgTFuvx+rQ61ZCEuRvw4p5qA=;
        b=DAN3eu7UVcKi68fFPvkfSkxMb7MC7WvcakDcRMGxLl7NFqKr9Sdgs/zXZrhYAv8mo5Jpgz
        fTNvmM4hM145DfG6D0QTVEucM/L/9JYzQzz7CGfyCMsY0Uw08eLCjPB67CLhetc5pvEixy
        ra6vS6NqBwtLfFUUf9pzz6LAxB/kLqivSWQRRmXI7wUmFUt+LzPHNRWRolfhZk19q7AKaV
        Zu7U5KiowlFi+tpc9HlEXF622AN4KnsxuYBwE9Xg7sEGh+5fF6dYvIoH7uHqttF8ZyaUZi
        UIpKsKWWVtFHsAvfz6sNHL5m8PGuMyYWvYgdV3SARCMnGBK36V8XZl/eYyR+wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696322398;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qh+KBuPKg3zOxbyl3qdxgTFuvx+rQ61ZCEuRvw4p5qA=;
        b=JEb8DR3EE0vc3TPb3DJ5rsYyYRUq1+4Dr2YvH4YHwwstDKrtYhVjsnVXlRS2UxKr0sXvTG
        45YSowApvpodFwDA==
From:   "tip-bot2 for Yuntao Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Fix incorrect startup_gdt_descr.size
Cc:     Yuntao Wang <ytcoode@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807084547.217390-1-ytcoode@gmail.com>
References: <20230807084547.217390-1-ytcoode@gmail.com>
MIME-Version: 1.0
Message-ID: <169632239730.3135.5499875554711156270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     001470fed5959d01faecbd57fcf2f60294da0de1
Gitweb:        https://git.kernel.org/tip/001470fed5959d01faecbd57fcf2f60294da0de1
Author:        Yuntao Wang <ytcoode@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 16:45:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 10:28:29 +02:00

x86/boot: Fix incorrect startup_gdt_descr.size

Since the size value is added to the base address to yield the last valid
byte address of the GDT, the current size value of startup_gdt_descr is
incorrect (too large by one), fix it.

[ mingo: This probably never mattered, because startup_gdt[] is only used
         in a very controlled fashion - but make it consistent nevertheless. ]

Fixes: 866b556efa12 ("x86/head/64: Install startup GDT")
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20230807084547.217390-1-ytcoode@gmail.com
---
 arch/x86/kernel/head64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629..bbc2179 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -80,7 +80,7 @@ static struct desc_struct startup_gdt[GDT_ENTRIES] = {
  * while the kernel still uses a direct mapping.
  */
 static struct desc_ptr startup_gdt_descr = {
-	.size = sizeof(startup_gdt),
+	.size = sizeof(startup_gdt)-1,
 	.address = 0,
 };
 
