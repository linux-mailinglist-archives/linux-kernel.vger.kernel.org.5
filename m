Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108F3757545
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjGRH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGRH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:26:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E871410C2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:26:40 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4r9M5swnzBR1P6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:26:31 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689665191; x=1692257192; bh=7Zq0KXs4LdQJv8qUlSyypIEzAXQ
        gaHBqN4S/GDmW28Q=; b=Sfy0JnJ+ITl/8S+w+Gk7Nt9sV4P31cNW2tq5l21Yv0r
        DYR7lKUauTQiFORSfFOn0K2FlP5xnmm0hwd6HWitUuk/FSyloGRNkkKi5E6qc8T2
        4ijRaxndHfC0m5CfHNBSE1qqsX3c/W2Lrb62LvepGJ57hFhxdXkYzEYCUTxbLEYW
        MJJaa3mHuQjhMYfShIQppK30lLqR7oYgV3QZc16DxAsD9Wmx9wNHNzXdDFQvr9ho
        CYy5Zx3oPWrQfGFkS+UkpJM11NTEAQBui0FftbN1Frhr8nJnFuP8bfPkSf64xW99
        YWpp3ws8fXFROapQa8uycnLfOphkEJK8dwBuv3XvGRg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id moXnw6E4OJAz for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:26:31 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4r9M3lLfzBR0gv;
        Tue, 18 Jul 2023 15:26:31 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:26:31 +0800
From:   sunran001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: kernel: add missing put_device()
In-Reply-To: <20230718072514.16432-1-xujianghui@cdjrlc.com>
References: <20230718072514.16432-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4125a3a7bda2d099b59e32e20f733a92@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Detected by coccinelle with the following ERRORS:
./arch/sparc/kernel/pci_psycho.c:308:2-8: ERROR: missing put_device;
call of_find_device_by_node on line 290, but without a corresponding
object release within this function.
./arch/sparc/kernel/pci_psycho.c:350:0-1: ERROR: missing put_device;
call of_find_device_by_node on line 290, but without a corresponding
object release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/sparc/kernel/pci_psycho.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/pci_psycho.c 
b/arch/sparc/kernel/pci_psycho.c
index f413371da387..45f8370bbfad 100644
--- a/arch/sparc/kernel/pci_psycho.c
+++ b/arch/sparc/kernel/pci_psycho.c
@@ -305,6 +305,7 @@ static void psycho_register_error_handlers(struct 
pci_pbm_info *pbm)
       */

      if (op->archdata.num_irqs < 6)
+        put_device(op->dev);
          return;

      /* We really mean to ignore the return result here.  Two
@@ -347,6 +348,7 @@ static void psycho_register_error_handlers(struct 
pci_pbm_info *pbm)
          PSYCHO_PCICTRL_EEN);
      tmp &= ~(PSYCHO_PCICTRL_SBH_INT);
      upa_writeq(tmp, base + PSYCHO_PCIB_CTRL);
+    put_device(op->dev);
  }

  /* PSYCHO boot time probing and initialization. */
