Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023FC77C4B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjHOAtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbjHOAsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F91715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96AAB64006
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98F9C433C7;
        Tue, 15 Aug 2023 00:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060504;
        bh=u267G5jkhUA2JZr0XnWTZStLuMWUHc9Rgpk/dYQh5G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ASFBYNfgI8UKmQU2xybw7HWbdahnGkvkBKXmuux3FGHHYJr2LAor+IQiUoOX/yrZ+
         IkJz8/kHlfOsarUPlnTgeDn51+heWIXsSabeIg6u4xPvzkMQeQINyS7/FQ73x86k49
         fj/j70xVZRxghfaVJf9Mp7nhfi/u9CAuQAV1/LLxnJKExyh6dNN9UcTWUBdhPMenkU
         ftGLEbRHf9lY5lATxrfsqWL0/t8tlZVuEsFK21U3DoHNvOuBvyxX/RxIaP8CmrI5fK
         ej8ffxCfQaL3iXSAMbB6SoAnXsGaGC+jLwPveUJWB4EA7C04wmtRAxfTOSj0eMkNed
         VPKVKUMwHJWGQ==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 14/20] ARC: entry: ARcompact EV_ProtV to use r10 directly
Date:   Mon, 14 Aug 2023 17:48:07 -0700
Message-Id: <20230815004813.555115-15-vgupta@kernel.org>
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

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/kernel/entry-compact.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/entry-compact.S b/arch/arc/kernel/entry-compact.S
index 5cb0cd7e4eab..77f0090554c5 100644
--- a/arch/arc/kernel/entry-compact.S
+++ b/arch/arc/kernel/entry-compact.S
@@ -254,9 +254,8 @@ END(handle_interrupt_level1)
 
 ENTRY(EV_TLBProtV)
 
-	EXCEPTION_PROLOGUE
+	EXCEPTION_PROLOGUE	; ECR returned in r10
 
-	mov r2, r10	; ECR set into r10 already
 	lr  r0, [efa]	; Faulting Data address (not part of pt_regs saved above)
 
 	; Exception auto-disables further Intr/exceptions.
@@ -273,8 +272,7 @@ ENTRY(EV_TLBProtV)
 	;   -Access Violation	: 00_23_(00|01|02|03)_00
 	;			         x  r  w  r+w
 	;   -Unaligned Access	: 00_23_04_00
-	;
-	bbit1 r2, ECR_C_BIT_PROTV_MISALIG_DATA, 4f
+	bbit1 r10, ECR_C_BIT_PROTV_MISALIG_DATA, 4f
 
 	;========= (6a) Access Violation Processing ========
 	bl  do_page_fault
-- 
2.34.1

