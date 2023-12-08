Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3AA80A91E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574396AbjLHQfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574219AbjLHQfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B599198E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BC3C433C7;
        Fri,  8 Dec 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053313;
        bh=v2mYSDmjqdbapRfO1Kx9bcMiig2SVy+s9w1cLpmU0IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ME9PtPfym6Ef0DDZb+Yjsva6Tx8a2WFMT7p9z045HUvh9QMf6RYkYWO9RVuxKCFgU
         HJcwtvyeTDA4KEjFRvwrIbXOu7CmVeFAVv63UTCBUWBRfBvmLPohHZUqUw8UlH+OjM
         7XtiUv082yDmJAx1zPZCY03aeXILFNzg8yK+5FTCffZ4PiV0xSKCaQekcRzWHGLWdx
         tgDLBLsAWL7w1QN3PX4zxsuozv5RHP5xxw1+h7Ke6HDg5/vbmy6mu2P7Z7JC4Keetj
         GCv1sqJ1XsfaiO78KJ9MM0sDVB1FFKqvhgYXhoCOLIfq7BNf3nUgtbk23tcxonJOAV
         W9PhRJauc5uaQ==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 3/9] powerpc/ftrace: Remove nops after the call to ftrace_stub
Date:   Fri,  8 Dec 2023 22:00:42 +0530
Message-ID: <8ee5ec520e37d5523654bb2cd65a17512fb774e2.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ftrace_stub is within the same CU, so there is no need for a subsequent
nop instruction.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/kernel/trace/ftrace_entry.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_entry.S b/arch/powerpc/kernel/trace/ftrace_entry.S
index 17d1ed3d0b40..244a1c7bb1e8 100644
--- a/arch/powerpc/kernel/trace/ftrace_entry.S
+++ b/arch/powerpc/kernel/trace/ftrace_entry.S
@@ -162,7 +162,6 @@ _GLOBAL(ftrace_regs_caller)
 .globl ftrace_regs_call
 ftrace_regs_call:
 	bl	ftrace_stub
-	nop
 	ftrace_regs_exit 1
 
 _GLOBAL(ftrace_caller)
@@ -171,7 +170,6 @@ _GLOBAL(ftrace_caller)
 .globl ftrace_call
 ftrace_call:
 	bl	ftrace_stub
-	nop
 	ftrace_regs_exit 0
 
 _GLOBAL(ftrace_stub)
-- 
2.43.0

