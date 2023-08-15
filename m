Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD077C4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjHOAse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjHOAsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373621723
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C946D640F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F3CC433CB;
        Tue, 15 Aug 2023 00:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060499;
        bh=YH1Bc28nzEk45ZXRwo0o5JTtxWlnUgrQ7Atrmj3ROek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYn9I40SFgdPcfvO+C1hyvCYNpDILybAVYz26koAmqj/kKoLVs8PazZpg2vzGnFyG
         D+QnTkdkKTqjl9/c7LFQqsMCSe31rR9RqvluNm04G7sFNwExJ2BEX9D1xdgFxQj3q7
         g9ZiBKNtZCtVvRQcUrlUSbYqCGuO0eWBy24njidcrnEZNKQPsKSol0n+efHEJaJ3xL
         VYDMzZZCeJo6RBOUl2KkCZDpA0Aq5h/r6XDbJpWyJ/ugdrSD8DphbH+xRlcT0+N76q
         6yZq5j9IYGgWwnnvotQuESl5w9b97H8QiQ9Rk07XnY9l9Kc64Twm3/nI9PyNnfzSgr
         pD+WPdvs/ATOw==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 02/20] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Date:   Mon, 14 Aug 2023 17:47:55 -0700
Message-Id: <20230815004813.555115-3-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing ARC variants have 2 issues
 - Use ZOL which may not be present in forthcoming architecture
 - Byte loop based vs. generic version which is word loop based

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 96cf8720bb93..47b4acc7d0c9 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,8 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER if MMU
+	select GENERIC_STRNLEN_USER if MMU
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARC_MMU_V4
-- 
2.34.1

