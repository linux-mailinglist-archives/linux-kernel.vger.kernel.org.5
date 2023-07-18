Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D464757752
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjGRJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjGRJC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:02:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54EBFC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:02:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4tJZ2G4zzBQslb
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:02:54 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670974; x=1692262975; bh=+WirPAA20do70AKue5eXeKib7+H
        rEJbCo7UDP7zabYg=; b=MYiI/Qdb9bWYnAELmZjt15yUQoqyFpOvHCitr/qr0hM
        dZt6tFjVZtZHbt1cWrSggntJ3qoA57+sTRoQWJ44fj7Nooc4SOhmXKmdzj5V91RA
        sR+6JgrlE1+wEL//UVgtt41TzDytp2RZYADh1sy7aW9bAynVUSMRFHRSSDQdNgP2
        7BzMHKbzcVkL9R/LtiXx8Yt8MAMzeVWMqm80I54Sv1hmL/lBbT3CG2AGc2CuUnF+
        XWDfSlRs8XcfPbDsYnJ801jSnN8nkTRgHol5rr3sBKGX5gkXBGJOMewyZqaSQSOv
        jnEA3egPKAb7pEE/vAuQKqqG7ey3audn6keTlb95FDw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 53oHEb_Zm5OG for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:02:54 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4tJZ0t8pzBJBfd;
        Tue, 18 Jul 2023 17:02:54 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:02:54 +0800
From:   sunran001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] floppy: add missing put_device()
In-Reply-To: <20230718090203.17548-1-xujianghui@cdjrlc.com>
References: <20230718090203.17548-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <8d2649460d95597d2d4de3777b2043f7@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

./arch/sparc/include/asm/floppy_64.h:562:1-22: WARNING: Function
"for_each_node_by_name" should have of_node_put() before break around
line 567.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/sparc/include/asm/floppy_64.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/floppy_64.h 
b/arch/sparc/include/asm/floppy_64.h
index 53e77c0974f9..619255e8c9ac 100644
--- a/arch/sparc/include/asm/floppy_64.h
+++ b/arch/sparc/include/asm/floppy_64.h
@@ -594,7 +594,7 @@ static unsigned long __init sun_floppy_init(void)
          if (state_prop && !strncmp(state_prop, "disabled", 8)) {
              put_device(&op->dev);
              return 0;
-        }
+        }

          FLOPPY_IRQ = op->archdata.irqs[0];
