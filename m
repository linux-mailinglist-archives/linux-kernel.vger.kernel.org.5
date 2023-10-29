Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EF57DB139
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJ2Xb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbjJ2XbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:31:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2558327E;
        Sun, 29 Oct 2023 15:58:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC2CC433AB;
        Sun, 29 Oct 2023 22:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620322;
        bh=j3zRutOngKhqvqthHq0n5oDAv//ZpGVCoHpJC5jHYPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pr1tNExjUV3XJVt3h0UQMZAdyz9BhmZi8cWC88TJRFv7MQCdF1HU50+/UMiMAPnkf
         eyns4Xmy95EQrD+LL3UEfU95Xlzc7AgkgyC+Z7qb8VqrsCNbz/ehu6iSOqCjwWi1rN
         pqMQ1vUrcVbnjSjaS3xMSjJji6WnuUjDMtI+CMa01Za+6OwWbwlF8V/jKDjLmK6iiM
         T4MvL4yEXpmmTonmgjo6pkgKbl4kQsjdul5xSix9sZ7hwhQl2fBF4P4QeJ3BhM4IEM
         C9Mv0mfveno/kA5QfRU8ClvJWaGmnDJTCyR+UMMsZBUjShFTKjuRCVCgGrzLs5KJqC
         2pxD1bCYUD4Lw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Deepak R Varma <drv@mailo.com>,
        Sasha Levin <sashal@kernel.org>, chenhuacai@kernel.org,
        chenfeiyang@loongson.cn, maobibo@loongson.cn, arnd@arndb.de,
        akpm@linux-foundation.org, loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 31/39] LoongArch: Replace kmap_atomic() with kmap_local_page() in copy_user_highpage()
Date:   Sun, 29 Oct 2023 18:57:03 -0400
Message-ID: <20231029225740.790936-31-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 477a0ebec101359f49d92796e3b609857d564b52 ]

Replace kmap_atomic()/kunmap_atomic() calls with kmap_local_page()/
kunmap_local() in copy_user_highpage() which can be invoked from both
preemptible and atomic context [1].

[1] https://lore.kernel.org/all/20201029222652.302358281@linutronix.de/

Suggested-by: Deepak R Varma <drv@mailo.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/mm/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index c74da7770e39e..f42a3be5f28d7 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -68,11 +68,11 @@ void copy_user_highpage(struct page *to, struct page *from,
 {
 	void *vfrom, *vto;
 
-	vto = kmap_atomic(to);
-	vfrom = kmap_atomic(from);
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
 	copy_page(vto, vfrom);
-	kunmap_atomic(vfrom);
-	kunmap_atomic(vto);
+	kunmap_local(vfrom);
+	kunmap_local(vto);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
-- 
2.42.0

