Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22987CCF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbjJQVXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344006AbjJQVXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A44EC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:31 -0700 (PDT)
Message-ID: <20231017211722.236208250@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TpbhN6EH+jiNlFeBACxkVLlnyXpjPlsl7WjVUOBjb5E=;
        b=gC+x+EvVfxKAiZ+DOfyq1S+E4UaAqAWTAhR2/44EsOyBdYqnC0XdpOjonqRbQZwkw0QvWM
        orzrrros9FpES4ZxI0VXcDwdkPLZdGFWFdkJYXUrC/bpvs3TXeH/MjBrSv3zHq8/ZMZP7H
        9CXQa5cmD++WmrUqWMyqHrwTfv2LbH8kw3BhOhEr2gfCteT72eDyU4xHdNHbVVcmEKGaAP
        /vP76MYFHPa7R3KzGpbIBJOYTTnrnPGpmuk8dhVXHuJcyn8qHm0FV5kI6SDC9wijiAis5O
        V1thLANRD7Op8EHub7NxEaxAwgfwnec6Lwf7nsL7vYSv3WjYVRbaeqP703hk9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TpbhN6EH+jiNlFeBACxkVLlnyXpjPlsl7WjVUOBjb5E=;
        b=j32YI3DV5qMsZhqQBC7g0Ug5QDUZSpAr2/+R/2s5yWoU4vHzcj7nSGY8Wn/a2RZMtNBCgk
        pxrZPwFMarHTYnBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 05/39] x86/microcode: Provide CONFIG_MICROCODE_INITRD32
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:29 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Create an aggregate config switch which covers X86_32, MICROCODE and
BLK_DEV_INITRD to avoid lengthy #ifdeffery in upcoming code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 arch/x86/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)
---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d8ff206e503f..cadea3f3161e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1313,6 +1313,10 @@ config MICROCODE
 	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
 
+config MICROCODE_INITRD32
+	def_bool y
+	depends on MICROCODE && X86_32 && BLK_DEV_INITRD
+
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
 	default n

