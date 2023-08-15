Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BB677C4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjHOAsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHOAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5B11723
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A241F64BEE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D212C433CC;
        Tue, 15 Aug 2023 00:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060502;
        bh=yWcyUxif3dikEYknmSArzeGyfZedu8yajJX9cu4DT8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIuvLqPbU//pLE4JPxKRp9UCHkrq9i+/o1874YalJxOHW1DzCuOc5eTpgw+36PDDD
         2aOy8LOzN/4I/Y66XzxsCN/UDZ1ZlY544oyu35GmmcdnL7yq0qCBggnlJcDCF580Rx
         b2xdpHvMrUc/wnQ1wJTJYlgeosSMYovaiGmHWOcPHkxLTCNCtCKV3v7sRF8bov3N6R
         4KTt9Ifyn9CofxXD/PVV8Ebi4mYtym7AeLTudA5ZA+xApAxDL242HS3ZDBNETyHs/y
         qpHDFhaLXhhTveQNORVxZZ6zFk+UD+YbDI7/VrH5bxw/OVgzuk2z7VRZE21OhoWNSA
         vlDa9wN4DEArQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 10/20] ARC: kernel stack: INIT_THREAD need not setup @init_stack in @ksp
Date:   Mon, 14 Aug 2023 17:48:03 -0700
Message-Id: <20230815004813.555115-11-vgupta@kernel.org>
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

There are 2 pointers to kernel mode stack of a task
 - task_struct.stack: base address of stack page (max possible stack top)
 - thread_info.ksp  : runtime stack top in __switch_to

INIT_THREAD was setting up ksp to stack base which was not really needed
 - it would get overwritten with dynamic value on first call to
   __switch_to when init is switched out for the very first time.
 - generic code already does
      init_task.stack = init_stack
   and ARC code uses that to retrieve task's stack base.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/processor.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index fb844fce1ab6..82ddc929d6e7 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -33,9 +33,7 @@ struct thread_struct {
 #endif
 };
 
-#define INIT_THREAD  {                          \
-	.ksp = sizeof(init_stack) + (unsigned long) init_stack, \
-}
+#define INIT_THREAD  { }
 
 /* Forward declaration, a strange C thing */
 struct task_struct;
-- 
2.34.1

