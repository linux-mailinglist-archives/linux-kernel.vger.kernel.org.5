Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7A7B184C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjI1Kcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjI1Kcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:32:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C7122;
        Thu, 28 Sep 2023 03:32:41 -0700 (PDT)
Date:   Thu, 28 Sep 2023 10:32:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695897159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYmau7IMl7WD2vSqAsJO1NOZjklCa/Lh+h32BSGKsfg=;
        b=dq9tZ/c6tKrFbBdurzccbRSM4NT/LiWfOSNApkP0hxdWF5JtgR45DwlWSGedTwqs/4Myen
        WyGMQ1doOG9XCSGZ+pyTgE+BMxVj0jwKtb1ZkOyoFcRmKwaXTwMKuz6IRmMzCpZxbW7br8
        9BXdzsGkx+VNbogDftJS2RjvcNGWA3FINyftTEJYYBvJ6VSxZSe6Y4BJ/2mXUiXCcGCEzx
        0bBz30V44qkdENThcfGvXw889e5HMm65HMI1SSXohhyZP/JRWc9FA3BslqLuxc4mmcNtZE
        fF1uglxixSvwOz3xWOfrAjNJ+kyJ0B58/RuRytz7PukYzxFANKFtz0U3VvpmVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695897159;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYmau7IMl7WD2vSqAsJO1NOZjklCa/Lh+h32BSGKsfg=;
        b=OjLa2oqg288XV6d2qE/rfOCJsuuRZ0uUWotWLBBFxO+3qqDn6HGauMKpbRa5MelEocOIfG
        p6ZXKRB/UAyiHyDg==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Annotate struct irq_domain with __counted_by
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230922175127.work.214-kees@kernel.org>
References: <20230922175127.work.214-kees@kernel.org>
MIME-Version: 1.0
Message-ID: <169589715833.27769.918219900124749489.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6260ecd04594360ae2af104fb2641317728a66e4
Gitweb:        https://git.kernel.org/tip/6260ecd04594360ae2af104fb2641317728a66e4
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 22 Sep 2023 10:51:27 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 Sep 2023 12:25:31 +02:00

irqdomain: Annotate struct irq_domain with __counted_by

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct irq_domain.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/r/20230922175127.work.214-kees@kernel.org

---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 51c254b..ee0a82c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -174,7 +174,7 @@ struct irq_domain {
 	irq_hw_number_t			hwirq_max;
 	unsigned int			revmap_size;
 	struct radix_tree_root		revmap_tree;
-	struct irq_data __rcu		*revmap[];
+	struct irq_data __rcu		*revmap[] __counted_by(revmap_size);
 };
 
 /* Irq domain flags */
