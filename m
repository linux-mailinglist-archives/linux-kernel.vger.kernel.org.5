Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7816C777883
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjHJMe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjHJMe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:34:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE6268E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F050865B9F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469ABC433C8;
        Thu, 10 Aug 2023 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691670866;
        bh=y1OGkcrDWN2UhgTfwGpsxeg9TBDGE2j/iZr/nffl+jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=phwjtVKOP176Ez+BEhi5GxJC1GploMx3rtC+V9YRArJna8IlbXdeJVMCY0OkAzorJ
         d5V8OZcYEOTmgiNUI5Kb2HU4NWu+dJDEIRfjVYqMU2bwCTSzvKDUK0FCXlkyb/Q97V
         o2SGbF8AXOoAzTBZHoxrarUKH0uFGeUGNugqFXgAuQO0GRBVyExjXKPTE4iro3ZD6U
         ZQ3L4XVidv8Vy3+2c+Pvu6Sb7NIk5muajnNfmnhv4f3Z6mTsfDyDmIFdU7UBFENtRk
         5YEQWDgUpEkEOyWmdGfslPz21jjFT0m0+zOx29ahI6b+auoy8CR0hB5oJSEGAekQQU
         rnHuKc0krlmWw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] irqchip: i8259: mark i8259_of_init() static
Date:   Thu, 10 Aug 2023 14:33:56 +0200
Message-Id: <20230810123404.1222332-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810123404.1222332-1-arnd@kernel.org>
References: <20230810123404.1222332-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

i8259_of_init() is only used as an initcall and does not need to be global,
so mark it static to avoid:

drivers/irqchip/irq-i8259.c:343:12: warning: no previous prototype for 'i8259_of_init' [-Wmissing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-i8259.c b/drivers/irqchip/irq-i8259.c
index b70ce0d3c092e..115bdcffab248 100644
--- a/drivers/irqchip/irq-i8259.c
+++ b/drivers/irqchip/irq-i8259.c
@@ -340,7 +340,7 @@ static void i8259_irq_dispatch(struct irq_desc *desc)
 	generic_handle_domain_irq(domain, hwirq);
 }
 
-int __init i8259_of_init(struct device_node *node, struct device_node *parent)
+static int __init i8259_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *domain;
 	unsigned int parent_irq;
-- 
2.39.2

