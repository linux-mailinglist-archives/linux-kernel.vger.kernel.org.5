Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A022C75301C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjGNDnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjGNDnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:43:35 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7349ACD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:43:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2HPs2GBlzBRSVN
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:43:29 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689306209; x=1691898210; bh=SCgw1WCmhD6P4vsV5hq9Xr7uYP9
        setPOegeKh2ZR/og=; b=V8ILV1ZwBGiiFJdC6+tlNJKDUEXN+p0iSjkZWWJGVNe
        f2ZE5EPEd3PO7w3iUZ58DyO/XJhrxUQXH/VHZ9DfBXKE+YFyMy20nx0eLMgz+TV4
        5ozlOQm9TYt3A+drTcan7+G77wd1/ppS9h4VuQT/OmOJIh9dMhDd9daNPVdAG8Sn
        Bi/+2gT/wT2IvdfupJA7FHfbGhcH9F39b7ZguXpZMPEukOOEHKZwyZ/8/SX8bJI3
        Y1S/ksrrY7xPGkytnkXrwYSpmGLWOAOoiBXCbcKs+jnR4t+kHrl0MgpHk/Zojj83
        I+Gku1ArEU5Lhtuz0XHOHGn+e5TzckJgjVFbcI3zkIg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EI4ObUIrq84E for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:43:29 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2HPs0696zBHXhN;
        Fri, 14 Jul 2023 11:43:28 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:43:28 +0800
From:   liubin001@208suo.com
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] irqchip:Use the "put_device" function to release the
 memory after calling the of_find_device_by_node function.
In-Reply-To: <tencent_C69953B5D14B406504315830D8DE7112EC0A@qq.com>
References: <tencent_C69953B5D14B406504315830D8DE7112EC0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <66d48e6ce0db4f89737172a2963195a9@208suo.com>
X-Sender: liubin001@208suo.com
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

Write the put_device function before return

Signed-off-by: Liu Bin <liubin001@208suo.com>
---
  drivers/irqchip/irq-renesas-rzg2l.c | 10 +++++++++-
  1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c 
b/drivers/irqchip/irq-renesas-rzg2l.c
index 4bbfa2b0a4df..a9d75135ba24 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -325,35 +325,42 @@ static int rzg2l_irqc_init(struct device_node 
*node, struct device_node *parent)

      pdev = of_find_device_by_node(node);
      if (!pdev)
+        put_device(pdev);
          return -ENODEV;

      parent_domain = irq_find_host(parent);
      if (!parent_domain) {
          dev_err(&pdev->dev, "cannot find parent domain\n");
+        put_device(pdev);
          return -ENODEV;
      }

      priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
      if (!priv)
+        put_device(pdev);
          return -ENOMEM;

      priv->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
      if (IS_ERR(priv->base))
+        put_device(pdev);
          return PTR_ERR(priv->base);

      ret = rzg2l_irqc_parse_interrupts(priv, node);
      if (ret) {
          dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+        put_device(pdev);
          return ret;
      }

      resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
      if (IS_ERR(resetn))
+        put_device(pdev);
          return PTR_ERR(resetn);

      ret = reset_control_deassert(resetn);
      if (ret) {
          dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", 
ret);
+        put_device(pdev);
          return ret;
      }

@@ -374,7 +381,7 @@ static int rzg2l_irqc_init(struct device_node *node, 
struct device_node *parent)
          ret = -ENOMEM;
          goto pm_put;
      }
-
+    put_device(pdev);
      return 0;

  pm_put:
@@ -382,6 +389,7 @@ static int rzg2l_irqc_init(struct device_node *node, 
struct device_node *parent)
  pm_disable:
      pm_runtime_disable(&pdev->dev);
      reset_control_assert(resetn);
+    put_device(pdev);
      return ret;
  }
