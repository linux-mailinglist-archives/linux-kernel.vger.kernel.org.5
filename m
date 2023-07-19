Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567175A26A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGSWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjGSWrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB22135;
        Wed, 19 Jul 2023 15:47:38 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=om13jL7O3l4YcuKziXRHIegrg+cbxJkA71mYNJPzON4=;
        b=t9bVuNO9bZzacbOkHO2yZm1GLciWDX5vkiomGwK9NpvP30y0hydDFsRG2pV3gqeKc9R3GS
        mXTFDj3udXwEhEAc+fbuEbpwY3IYa4ltgA6QvLxHuM1MWaW1/hbA+zdwgJ6Bt4J//9QImr
        IDhG+WcVwknujkR+Dcvxp+zzQ4Dsv1z4fO3BHdwz2g2U0HF+9K+MCUacTHfquA1M2H98Xe
        xq/diKFA8hyfvs6CbDA90T7B1fqU17MC3ENXKI41Qeb+adP+0OvoZLvxFehjH3WLvCHuv4
        fKkmmuFrmDDy3n5h0urG/FOX9htwlnRTfShQGBUUZGgAY3Tgm5H0vwTH4TalQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=om13jL7O3l4YcuKziXRHIegrg+cbxJkA71mYNJPzON4=;
        b=AQy3D+cCKZr/dZuaP4GDR2HDNNDCkUBeXeBlviuDvNapa8yJZIeQvsaiTBBy7ZrzNZc8+T
        6AN1lbzmLLsJsUCw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm/mmap: Add shadow stack pages to memory accounting
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685594.28540.7546277412646689186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     00547ef73ff282eea59cd33b8952f1dcbb4bd4b8
Gitweb:        https://git.kernel.org/tip/00547ef73ff282eea59cd33b8952f1dcbb4bd4b8
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:45 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:19 -07:00

mm/mmap: Add shadow stack pages to memory accounting

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-20-rick.p.edgecombe%40intel.com
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a7d9e98..018f5c3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -538,14 +538,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 }
 
 /*
- * Stack area - automatically grows in one direction
+ * Stack area (including shadow stacks)
  *
  * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
  * do_mmap() forbids all other combinations.
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return (flags & VM_STACK) == VM_STACK;
+	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
 }
 
 /*
