Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0E75A23B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGSWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGSWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6C81FFE;
        Wed, 19 Jul 2023 15:47:30 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lvQD2v47OmpQLyD6tCUDQcGs/nfoahlZfJXIfvLLcYo=;
        b=UqvDJVJRe5LZOSXZGm2bB8XM1Mk1rIIlyaXOhaJk7GHkbDN3tXNAPHgqAIDEQz0UeBzU5n
        uvJivKGrMSenYv6Tp6JublTu7yP7EOQZHrp6tM0yKFAeyKikUIILCJxU7za/vQ+UVihQmp
        b9aLv1NHzKqZgCeS0Zr3auDl9TjVLovt80Ede8WCyPCGiT/Plrlxp4lcI7+FcURuHciuRt
        Kjle8kRUpkj6L70wqCGUiwkBlG9qQtI5jy/+EgVNljxdBn57faFM1SDE/tuOQLp5ZHmkRp
        ygBG8v7n0F4WS1dKO7sxxy/r+SvO8qOk7LTu2g31JiyE339F7A72bbbkfmT/gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lvQD2v47OmpQLyD6tCUDQcGs/nfoahlZfJXIfvLLcYo=;
        b=u7t6VdWjBfSDDYL7xFkWTMamyppM0UzCasjX3eky7ygELW8Y4l3uhskFfyFdAbcr1n6W7O
        Vm6qBNAY1cin77CQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Wire in shadow stack interface
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684796.28540.5293840532791424484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     90359b0a7eed998740ae3794c66aac98d09d6ee1
Gitweb:        https://git.kernel.org/tip/90359b0a7eed998740ae3794c66aac98d09d6ee1
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:03 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:13:46 -07:00

x86/shstk: Wire in shadow stack interface

The kernel now has the main shadow stack functionality to support
applications. Wire in the WRSS and shadow stack enable/disable functions
into the existing shadow stack API skeleton.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-38-rick.p.edgecombe%40intel.com
---
 arch/x86/kernel/shstk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ea0bf11..d723cdc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -502,9 +502,17 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return -EINVAL;
 
 	if (option == ARCH_SHSTK_DISABLE) {
+		if (features & ARCH_SHSTK_WRSS)
+			return wrss_control(false);
+		if (features & ARCH_SHSTK_SHSTK)
+			return shstk_disable();
 		return -EINVAL;
 	}
 
 	/* Handle ARCH_SHSTK_ENABLE */
+	if (features & ARCH_SHSTK_SHSTK)
+		return shstk_setup();
+	if (features & ARCH_SHSTK_WRSS)
+		return wrss_control(true);
 	return -EINVAL;
 }
