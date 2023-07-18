Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71D757529
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjGRHTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGRHTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:19:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E2CA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:19:15 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4r0r4DcHzBQslH
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:19:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689664748; x=1692256749; bh=02lJSJPounRmx9NX09cNlIbTqdQ
        t2nDvqXmaqTCd2+4=; b=OSaKdyaygyk5UVwB5TDspfZI+2QsIZPoG8YKYNH4n0P
        Q+7lqHcACigBTY0VdJPtRe+5e/nDbPTXNmDN6pADQb6SIk87Iw/qrs6HygFmrAai
        2EpBi1ZVzoAM1UOk8jVqyJh3WpMpYoSBmnnuWtSQ2jkAZzelfSw+iSekXTkqIGbP
        UuBPQRKYl+ti/uh8ciQlcjAl73FdWn9HPkQgN2IlV0cgwY0ygCCwqM9nd2xS5sch
        2cXvokPRcILw719Ml+0XBU/YuJvU4Q1AU1tMRlP7ZH027QsiV6qLSg7x/YwrbWuY
        WuAXSCmVv58uKwgy1lOhYv+slycEHMfJY5KyieMWe7w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Phu50ufRjbP for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 15:19:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4r0r2LcKzBHXh4;
        Tue, 18 Jul 2023 15:19:08 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 15:19:08 +0800
From:   sunran001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: add missing put_device()
In-Reply-To: <20230718071735.16312-1-xujianghui@cdjrlc.com>
References: <20230718071735.16312-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <4a1fd666ef4700ec17d1be60debf016b@208suo.com>
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
./arch/sparc/kernel/of_device_common.c:23:1-7: ERROR: missing
put_device; call of_find_device_by_node on line 18, but without a
corresponding object release within this function.
./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
put_device; call of_find_device_by_node on line 30, but without a
corresponding object release within this function.
./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
put_device; call of_find_device_by_node on line 42, but without a
corresponding object release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/sparc/kernel/of_device_common.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/of_device_common.c 
b/arch/sparc/kernel/of_device_common.c
index 60f86b837658..7851307de6d0 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -20,6 +20,7 @@ unsigned int irq_of_parse_and_map(struct device_node 
*node, int index)
      if (!op || index >= op->archdata.num_irqs)
          return 0;

+    put_device(op->dev);
      return op->archdata.irqs[index];
  }
  EXPORT_SYMBOL(irq_of_parse_and_map);
@@ -32,6 +33,7 @@ int of_address_to_resource(struct device_node *node, 
int index,
      if (!op || index >= op->num_resources)
          return -EINVAL;

+    put_device(op->dev);
      memcpy(r, &op->archdata.resource[index], sizeof(*r));
      return 0;
  }
@@ -45,6 +47,7 @@ void __iomem *of_iomap(struct device_node *node, int 
index)
      if (!op || index >= op->num_resources)
          return NULL;

+    put_device(op->dev);
      r = &op->archdata.resource[index];

      return of_ioremap(r, 0, resource_size(r), (char *) r->name);
