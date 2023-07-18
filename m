Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664AB757639
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGRIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjGRIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:09:08 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801311C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:09:06 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4s6R6p6DzBQskq
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:09:03 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689667743; x=1692259744; bh=ZhffnlSd+6JbLRwdRLYVfu2pikG
        Dw7nl33ahQKmhj1Y=; b=K1KYRQdAvqYQMuaHnwEZNSDDQx1wNGX2jp0LUd9PVdL
        T7lSm1k6xobK7tVsZPLTj+0xsNfMy6MXBVkInzKABehf/Me0GV3Crgvbdwz2sLud
        Ib5qujc6CwjxB8X6GZNvfl7zJoiy/CDxf/3UGk1I0janFA9z9l/sppHth2uqoOJE
        qKZhmeBKRgf+ghCB1tYoi0u6sDQRRx79n++Uyo5D8R/R+nfIqZSWRkfcm9znRRyg
        Wd14bkYduBfpMAa7jF2ZiJyG86Busjid9QoSXO3ZaVwX/ug1+aPYA+vHYbAZ4jky
        ulrMkRy7J7N5IDYzT5HXWd0+xOsjz6V3e4QBfiKNzOw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZnaWbATf5eqt for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:09:03 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4s6R5CLpzBJBf8;
        Tue, 18 Jul 2023 16:09:03 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:09:03 +0800
From:   sunran001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] floppy: add missing put_device()
In-Reply-To: <20230718080812.16801-1-xujianghui@cdjrlc.com>
References: <20230718080812.16801-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <98a14fa23e4fb81d4630264cba0cecc8@208suo.com>
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

Detected by coccinelle with the following ERROR:
./arch/sparc/include/asm/floppy_64.h:595:3-9: ERROR: missing put_device;
call of_find_device_by_node on line 589, but without a corresponding
object release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/sparc/include/asm/floppy_64.h | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/floppy_64.h 
b/arch/sparc/include/asm/floppy_64.h
index 070c8c1f5c8f..e74a4d4e6519 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -592,6 +592,7 @@ static unsigned long __init sun_floppy_init(void)

          state_prop = of_get_property(op->dev.of_node, "status", NULL);
          if (state_prop && !strncmp(state_prop, "disabled", 8))
+            put_device(&op->dev);
              return 0;

          FLOPPY_IRQ = op->archdata.irqs[0];
