Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1779D58E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236430AbjILPwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbjILPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:52:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E17E10EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:52:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EECC433B7;
        Tue, 12 Sep 2023 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694533964;
        bh=fqPeDI8Tt7B0BD4Ll8OcOc/JgS0VBc5dnAfvkG4MkHA=;
        h=From:To:Cc:Subject:Date:From;
        b=aLrIal6ZBzeZEM9eVXol0jhbD+o/w6bFN9FN/ICV1ES4EnPJ7tD5Y9I/X5WIuaWfR
         0lopRtj467/JrGLuvj+KBwqHmb8epOKqfprax0FE6uhUn9nOWcvi6jngib9p3Ucr/n
         VVfZojXeLLwiRyD+5d7fjpLxmYfP/KAMjpMa/8xmrj4cR0b4tH05SMW4d+KUe0mpqL
         lh10N/RyoNZuGnVGvIvyAVaLdSz/fec+agf5+7sADsdNnrKAmnL2RhsEpmLkcNlkTc
         y+20tJdpBECCdaVHPzUVGCxOxn6SkrL1Lcf8kZLrG6dABf4wUyePl2ePQeSuv0Qwbt
         /w52sn23BGfLg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: don't probe unaligned access speed if already done
Date:   Tue, 12 Sep 2023 23:40:40 +0800
Message-Id: <20230912154040.3306-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If misaligned_access_speed percpu var isn't so called "HWPROBE
MISALIGNED UNKNOWN", it means the probe has happened(this is possible
for example, hotplug off then hotplug on one cpu), and the percpu var
has been set, don't probe again in this case.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/cpufeature.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..e12cd22755c7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -568,6 +568,10 @@ void check_unaligned_access(int cpu)
 	void *src;
 	long speed = RISCV_HWPROBE_MISALIGNED_SLOW;
 
+	/* We are already set since the last check */
+	if (per_cpu(misaligned_access_speed, cpu) != RISCV_HWPROBE_MISALIGNED_UNKNOWN)
+		return;
+
 	page = alloc_pages(GFP_NOWAIT, get_order(MISALIGNED_BUFFER_SIZE));
 	if (!page) {
 		pr_warn("Can't alloc pages to measure memcpy performance");
-- 
2.40.1

