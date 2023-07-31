Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAAE769AE2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGaPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjGaPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:35:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ACC126;
        Mon, 31 Jul 2023 08:35:58 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690817757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXQ2UlHztnSm7+VktGweD1ERC2/wwrBIcTkCarc5xAU=;
        b=s6zw5x4dkby2sE8Od+vaTzPkZMiBkUxKhohNUIZOa7Qg4x08pRw8lpCIPnrpDYfD/XqPVN
        l6R8EwOZg/XV7r7JkNlobCvohEHmRFw6rGKxrgYScLVrP15smYySsdi2e8Lr7hPkrgoqCm
        BSstqyEqf2UgCIrq/UV1XyCU7FE/dZ5adKkG8cRNzoVGUqiJoH9BboLiVolIl+PA8TYSwm
        UeyrFtusegoLW+Bsu40giK9uAp2RjGSzO3hHvSFJRmY10W6qOyQp0ucYzH8k9aJnPqhHqw
        lMQ7Gt9CxYrIRsDsxwTDp9z9KIivVKV6eH5tpKwSBg/yTjFQqdnmLZxexKgyNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690817757;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXQ2UlHztnSm7+VktGweD1ERC2/wwrBIcTkCarc5xAU=;
        b=Txh65fJ0g+AhCBJiHTvb5jYL7Kn9pzOhRKQt1+5vEZ3Xlfw2hveeTw/Q8e7ubJ5EEJLg8W
        YZx5J3ONgKfryfBg==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/SMT: Fix cpu_smt_possible() comment
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230728155313.44170-1-rui.zhang@intel.com>
References: <20230728155313.44170-1-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <169081775691.28540.11108672281544540952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     52b38b7ad589c89a8c69272497bed20034f8e322
Gitweb:        https://git.kernel.org/tip/52b38b7ad589c89a8c69272497bed20034f8e322
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 28 Jul 2023 23:53:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 Jul 2023 17:32:44 +02:00

cpu/SMT: Fix cpu_smt_possible() comment

Commit e1572f1d08be ("cpu/SMT: create and export cpu_smt_possible()")
introduces cpu_smt_possible() to represent if SMT is theoretically
possible. It returns true when SMT is supported and not forcefully
disabled ('nosmt=force'). But the comment of it says "Returns true if
SMT is not supported of forcefully (irreversibly) disabled", which is
wrong. Fix that comment accordingly.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Link: https://lore.kernel.org/r/20230728155313.44170-1-rui.zhang@intel.com

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 7e8f1b0..f6811c8 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -676,7 +676,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu)
 	return !cpumask_test_cpu(cpu, &cpus_booted_once_mask);
 }
 
-/* Returns true if SMT is not supported of forcefully (irreversibly) disabled */
+/* Returns true if SMT is supported and not forcefully (irreversibly) disabled */
 bool cpu_smt_possible(void)
 {
 	return cpu_smt_control != CPU_SMT_FORCE_DISABLED &&
