Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6187C4DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345717AbjJKJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbjJKJBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:01:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284CC4;
        Wed, 11 Oct 2023 02:01:04 -0700 (PDT)
Date:   Wed, 11 Oct 2023 09:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697014863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9cZVj4bv4IpZlK8V2Dgi2eMXLGVornMslcY7baLwK4=;
        b=nX1CgwAs+3m5gpdkkHJ4vcUcxYXmcyzLm1jjRIU5W877u9mics17VqOLVzexqfU4gNmcQo
        fv8QdEWZG/UWY9naMFcRwhiIyOnYgejC/xMMv7Sbvzgy1BRtj6/xCb5QQ6TI9ZSD5S9mYV
        /hKFrCxiGmxZCbizSIbU/eWR+ASggNtkvxF8DImS/iapqwryGc6TUJ3zWh69duQB0vklEU
        xclAR297r6HNIbMDwCGVdEmWOxHz0J/k0xZGkkDRGblNOmcKmtv33ade47S0cqAWCDFaim
        7+RcBcbuR80PBqh9CJELQbNsRD/eeGo+PqIxsABzIggyWHq0FkJr0DLfA2ej/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697014863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9cZVj4bv4IpZlK8V2Dgi2eMXLGVornMslcY7baLwK4=;
        b=Ab+3TSfpUHzELfL2r1tHpruNuVDjRRItOvoGXV9UF2HMIkO9TccQa74Zw7fG//lyc97Xl/
        gfkdqVVzQKP8+FCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Cache builtin microcode too
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.495139089@linutronix.de>
References: <20231010150702.495139089@linutronix.de>
MIME-Version: 1.0
Message-ID: <169701486183.3135.695611343878814881.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a983f3245ac2178cb697996e19d1fadee9648bfb
Gitweb:        https://git.kernel.org/tip/a983f3245ac2178cb697996e19d1fadee9648bfb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Oct 2023 19:44:59 +02:00

x86/microcode/amd: Cache builtin microcode too

save_microcode_in_initrd_amd() fails to cache builtin microcode and only
scans initrd.

Use find_blobs_in_containers() instead which covers both.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.495139089@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f6ed2c5..046b3a6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -533,7 +533,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
