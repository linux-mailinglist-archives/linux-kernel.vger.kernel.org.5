Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12BC7C7515
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441858AbjJLRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379666AbjJLRuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:50:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354ADBB;
        Thu, 12 Oct 2023 10:50:38 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:50:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697133036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFxajUsa9FTTUCqjV6kFt+MmxG7sRnqRbV03Tf5QmSg=;
        b=G27L8g81QXJ0Nw7WnkBAjE7UiVbFXS+sbY613+GwywcUE7ddFpRN2uk6ZI7Mk6tH0IQ/58
        DXq3L3hvWj7aeUS5u1DEqbCcVOBYQeo7vMqHHWP2xL8m3tun5/eGeO7GhOF646YTTZaQZW
        OXcf9fFVflj0uNlxXruQ+M8wNlmpfireUtVQWGrvbi2UuaOgs6L6u7doBO8ENfR9qh18Em
        EdZNNnadShfHTKKtgNOEHElumWjMT3P9kC2jVzmi4G/okwetHwoxgd/ScH7CNKooqTxz2D
        XE5kAqzgItfT019iISeANY3kEe+O4/KoX1bm7qL4tOspXG0Q77OQijrX7S4u2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697133036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IFxajUsa9FTTUCqjV6kFt+MmxG7sRnqRbV03Tf5QmSg=;
        b=M/xcXtbU1GuWoz+MgWoxyLUQY5q7DW6ozBwTHaFXYOgeuYx+WiqVlSHIVQ/n4L12FxgfIG
        bv1VEScAFB5QMzBw==
From:   "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/vdso: Run objtool on vdso32-setup.o
Cc:     David Kaplan <david.kaplan@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010171020.462211-3-david.kaplan@amd.com>
References: <20231010171020.462211-3-david.kaplan@amd.com>
MIME-Version: 1.0
Message-ID: <169713303595.3135.9716744359353391644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     99b5bf0276d4ae5028ab9743053c6d16044009ea
Gitweb:        https://git.kernel.org/tip/99b5bf0276d4ae5028ab9743053c6d16044009ea
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Tue, 10 Oct 2023 12:10:19 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Oct 2023 19:44:07 +02:00

x86/vdso: Run objtool on vdso32-setup.o

vdso32-setup.c is part of the main kernel image and should not be
excluded from objtool.  Objtool is necessary in part for ensuring that
returns in this file are correctly patched to the appropriate return
thunk at runtime.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231010171020.462211-3-david.kaplan@amd.com
---
 arch/x86/entry/vdso/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 6a1821b..83c0afb 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -42,7 +42,8 @@ vdso_img-$(VDSO64-y)		+= 64
 vdso_img-$(VDSOX32-y)		+= x32
 vdso_img-$(VDSO32-y)		+= 32
 
-obj-$(VDSO32-y)			+= vdso32-setup.o
+obj-$(VDSO32-y)				 += vdso32-setup.o
+OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)
