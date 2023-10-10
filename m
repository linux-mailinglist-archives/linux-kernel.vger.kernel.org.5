Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE87BFFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjJJPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjJJPIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F9B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:45 -0700 (PDT)
Message-ID: <20231010150702.433454320@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/dRmcfKTBD1nPb/bBtlpyqt18JVyxAdIVX4toDGASiY=;
        b=DzcjhKjec/HHmzId8VVPKDDwwFMm/I+4Yd/trZfPPuxIgG+eObrHAnLgf0/u2vF2ZJoSJ1
        xqqmNksAUH2KKabDwfwHcceeYK9fDzwvc7QxQqOxkR4LtLQRq6c9gdpOKVspbQq7nEZYPV
        h58lNiXIQGpkHkmBi5T/lVX+phVETaWnmodWj7dstXfMboi1lk7SyBiyoZQb6/xvgwJ7Sl
        66XmQFXS0wnfJPjLAuK14jws7qITYQ/URCZyTF82JJFyLQRXQLPcsWU6mmZrWGBwvKVETF
        Dic3its1C/wUQpG88IbFXkXOP4kFsWZ1ItzKRXREtZWzlgD1skc4S6K55IugAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/dRmcfKTBD1nPb/bBtlpyqt18JVyxAdIVX4toDGASiY=;
        b=IGTbKaraLoDpbolKmIG2d1HTGDgUpBWIx+aPe56XLk/PWuYYQEMayKIqnWQR1A4s8uUGdu
        DN/k2H6kz754k4BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 1/5] x86/microcode/amd: Use correct per CPU ucode_cpu_info
References: <20231010145130.987300357@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Oct 2023 17:08:41 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_blobs_in_containers() is invoked on every CPU but overwrites
uncoditionally ucode_cpu_info of CPU0.

Fix this by using the proper CPU data and move the assignment into the call
site apply_ucode_from_containers() so that the function can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -503,9 +503,6 @@ static void find_blobs_in_containers(uns
 	if (!get_builtin_microcode(&cp, x86_family(cpuid_1_eax)))
 		cp = find_microcode_in_initrd(ucode_path);
 
-	/* Needed in load_microcode_amd() */
-	ucode_cpu_info->cpu_sig.sig = cpuid_1_eax;
-
 	*ret = cp;
 }
 
@@ -513,6 +510,9 @@ static void apply_ucode_from_containers(
 {
 	struct cpio_data cp = { };
 
+	/* Needed in load_microcode_amd() */
+	ucode_cpu_info[smp_processor_id()].cpu_sig.sig = cpuid_1_eax;
+
 	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return;

