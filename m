Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13F17D0E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377137AbjJTLhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377043AbjJTLhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB4D49;
        Fri, 20 Oct 2023 04:37:16 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oxp3oWmcGVFMqwfRiRPU/lknufhrrZQDAJne/2r8wOg=;
        b=PvaQyMeyUFM/eN8VEJot3l7iNSkxxPqN/CclPPDeZScNgJI7IFLosYGHVj+usgvxM4Myth
        5jSVXo6+fEvBenjgjNE37oZraD73rZKtln8QpKf3q3F9+YbmNlLeVjO06KfQBmgNhqIB9k
        i/GC3xI/UyGdgZ9u/oW7DAOWPlkExxOQedHGOes52i5W//7hQC96eDJKbwPMPRo83e1KTS
        o/2wHXD3gg0iv2toOG56oR+K5l0PTd1VyFGEt0KxvBQLuYE6NgshpQTn9BiVykDKjj491A
        maX8NYsJgSQZpy6lvN1KReJoyG5eYWnMVOkYNOvkoj3L8RWMj5fxhNdpMNia9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801835;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oxp3oWmcGVFMqwfRiRPU/lknufhrrZQDAJne/2r8wOg=;
        b=0UXrhkq62t2zhL0b/WF43wN2gw538xjmLZS2uik952ZV7D5WgBbK3dyDJYLhUTrqdZqyq9
        Z1bHZrV1JS4pahDg==
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
Message-ID: <169780183431.3135.3111084432260817314.tip-bot2@tip-bot2>
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

Commit-ID:     b587fef124f98f3ab1322dba8e37cdff660acd8c
Gitweb:        https://git.kernel.org/tip/b587fef124f98f3ab1322dba8e37cdff660acd8c
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Tue, 10 Oct 2023 12:10:19 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:58:27 +02:00

x86/vdso: Run objtool on vdso32-setup.o

vdso32-setup.c is part of the main kernel image and should not be
excluded from objtool.  Objtool is necessary in part for ensuring that
returns in this file are correctly patched to the appropriate return
thunk at runtime.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
