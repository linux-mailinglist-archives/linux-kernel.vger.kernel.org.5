Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04D783B40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjHVH5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjHVH5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:57:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B5612C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:57:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a5457b930so1095488b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692691052; x=1693295852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Szhn++uT+SYj6J/tWZZP4rlg/L1C49hUSBzJ8Ssqt1g=;
        b=RwpH8vrb6VXQRxM/AlIPIJ3VCMlJXsiU+Jcy3mFvihkxBc/+v1RBQUv7SNMyGrkl/D
         /xcBWM3c1AwUhJnHiCRGykcoKXlkvoSqLgtwB6ejCl5+n+Dy9sSRlw9VJ29YS3QtGe4W
         d7wTXSsyiVe6wN8r6GkS02Uyet+N/mnKsumsrv99Qs5d6BQENfwgpP8KpEmbpUMOeceE
         R6Us9SlhfYj9xN23v4HAnav2GNfbgFhzW8BrvhoiMES8xeotx/ikpw5+sWWK2zdzR79J
         jJuFVIxMqkTT7tPFpXsO6jHlh9lYngkbTWYFMShq7ZTbPyfl/Kv0JpSkEVqkhYa0okQ6
         P7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692691052; x=1693295852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Szhn++uT+SYj6J/tWZZP4rlg/L1C49hUSBzJ8Ssqt1g=;
        b=NBPr9InAhf0QEIjuehbsqg+cpO9Li6nroGgG1l/aShxl8napbTWO15tNP7VT6GctEo
         WWijiNrLU2KUo5DfjBbTbCvIFTR9mRC8rHb9MRUBkf/i6ki7fFUS8Syi20MQsOXWGDof
         ixE6VQlG15TDqzMV0B2aGaGx0ruHwR60TqMSDjbTzNhMdiHHWsfqihLbCtUUBnS6m7EQ
         GabaIRI8yVYy2GnV5ci1LNKSPfGXselqncPLeFSY5UN6d0GmT4YcQtr8QQ3pa+fsarcP
         Vn9ms7/gsFYpj7n3JPnSWA502KXWYzWtFsl0BHWo4G0wmMJvxpXangaCNyun7OZ0Xz1w
         fVFw==
X-Gm-Message-State: AOJu0YzLpBTmX6UwJ9pXhVI23wysorkxEDrAz/c+hrJXl/TxgC+S60jQ
        ycUBOBD+nKZn9bZFiOoSZWLkjg==
X-Google-Smtp-Source: AGHT+IHzuGh/GnrDJJmgwJkjKkhWD5Y5FpL9RMw8HSrxsNKp4Lswt/hx5zRYFeFIXQOOu9oFht/7qg==
X-Received: by 2002:a05:6a00:15d0:b0:687:3f06:5939 with SMTP id o16-20020a056a0015d000b006873f065939mr8626740pfu.32.1692691051736;
        Tue, 22 Aug 2023 00:57:31 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id c3-20020aa78c03000000b00640dbbd7830sm7551763pfd.18.2023.08.22.00.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 00:57:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        kernel test robot <lkp@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: Move of_skipped_node_table within #ifdef CONFIG_OF_ADDRESS
Date:   Tue, 22 Aug 2023 13:27:22 +0530
Message-Id: <73dea4f4b389359a8beadbc77b00eb26853f9ab5.1692691032.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `struct of_skipped_node_table` is used only when CONFIG_OF_ADDRESS
is defined, move it within the #ifdef/#endif to avoid warnings on
configurations where CONFIG_OF_ADDRESS isn't defined.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308212037.YopffWSU-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 051e29b7ad2b..3f7bdf7bc2f8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -31,11 +31,6 @@ const struct of_device_id of_default_bus_match_table[] = {
 	{} /* Empty terminated list */
 };
 
-static const struct of_device_id of_skipped_node_table[] = {
-	{ .compatible = "operating-points-v2", },
-	{} /* Empty terminated list */
-};
-
 /**
  * of_find_device_by_node - Find the platform_device associated with a node
  * @np: Pointer to device tree node
@@ -55,6 +50,11 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 EXPORT_SYMBOL(of_find_device_by_node);
 
 #ifdef CONFIG_OF_ADDRESS
+static const struct of_device_id of_skipped_node_table[] = {
+	{ .compatible = "operating-points-v2", },
+	{} /* Empty terminated list */
+};
+
 /*
  * The following routines scan a subtree and registers a device for
  * each applicable node.
-- 
2.31.1.272.g89b43f80a514

