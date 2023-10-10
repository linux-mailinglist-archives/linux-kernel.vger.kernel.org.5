Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E007BFFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjJJPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjJJPIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F3DB6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:08:45 -0700 (PDT)
Message-ID: <20231010150702.495139089@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/T+TzF884nNOcfjx73gfiSU4BbvmUfK//JWS9uWIFHE=;
        b=UjYOvh2VC6Qb27nBg0v5biPxpMwuhhQtZW6sc/vHworpZJWFUmmL1xs9xvUH5Q7bHov+Zo
        O3EJUgZCFv6JsmVenu4muN+hwxmC85oC3XUv7fkZsVczJLGNIMfk1XTDS0pAMdjAN7Yvij
        OmZnp1tPOnaS1iQ1qsXgvKxViMY08SlnC8qIpY+RQSOeM/GpF+JH/VCXfZroj0Z/A7ORnV
        gxPx0OCySchgvDvdY76I/W01PuvoDGvhoNOObe6g4yNn9jI/umpJBw+PU7RqG8zBxC1EAt
        3d1JcXusqK36cWnu+DJ1uAUOVNSRfeDI9+0AUki/3WHM/zX62Xra6CAiklthbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/T+TzF884nNOcfjx73gfiSU4BbvmUfK//JWS9uWIFHE=;
        b=Npgb09TuRPXz3VxOCdmN5TGC1qv8YH6pOzkUvF9voFqfDFS3bOjGpYBkfQhKqzucwwSUlV
        LhtveAMaQLv5t4AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch 2/5] x86/microcode/amd: Cache builtin microcode too
References: <20231010145130.987300357@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 Oct 2023 17:08:43 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

save_microcode_in_initrd_amd() fails to cache builtin microcode and only
scans initrd.

Use find_blobs_in_containers() instead which covers both.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/microcode/amd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -533,7 +533,7 @@ int __init save_microcode_in_initrd_amd(
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 

