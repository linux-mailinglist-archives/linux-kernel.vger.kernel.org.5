Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504407D0154
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346401AbjJSSXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJSSXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:23:47 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED2AB;
        Thu, 19 Oct 2023 11:23:45 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-581de3e691dso1786739eaf.3;
        Thu, 19 Oct 2023 11:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739824; x=1698344624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFkZbO4vMx0fKP71/OzTPXf/Ja62nWjUdlsbvXHUr7w=;
        b=O5CI4X4eNiBBFgN32tJtQ+8i+LztCvXUGJ87N2IQnzQmTT2mpI1WUhVZCXJfaPGcI2
         k/OTvMewjOoz6eHEvKhzIpIJWi2DRLGxpeBy686JZM1tVmABZnCeQ+PSAKFRClV4JYKR
         5hR5anbkI0ywGpB6Cwy4TkcMy34WatGwOyI9+frxTOiC49j/ZmygPLuCxGCB8ze6ZzIx
         hHIk/KjG5gndvkMbRhitlWgLqbWHZMt4WQqAEV1CMZbaAkKL0nFwrpxFWEgNjr/cb9bn
         XtGY/eLWKjbUCfyNIuAPX/is4+2MDsku5AAvtj9iv6e97XPgTvj9H+hDjS/1fOTLqanY
         Elgg==
X-Gm-Message-State: AOJu0Ywr0WyaXu+hNsMJzalyNEygXV2DeoMMFxBvX+qzs7SJeH0y0YyX
        DoRbOaM+jnfGDJwSezCyMQ==
X-Google-Smtp-Source: AGHT+IGb/FnylUDVtQcmpg/Pk0kEV1gtN5J3K1Nd2RU9hzJq1AKrVYC0cPmLqUzbCsi7QV4MqMtg/w==
X-Received: by 2002:a4a:b441:0:b0:581:ed9a:4fde with SMTP id h1-20020a4ab441000000b00581ed9a4fdemr3537198ooo.1.1697739824538;
        Thu, 19 Oct 2023 11:23:44 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z127-20020a4a4985000000b0057e88d4f8aesm39553ooa.27.2023.10.19.11.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:23:43 -0700 (PDT)
Received: (nullmailer pid 833096 invoked by uid 1000);
        Thu, 19 Oct 2023 18:23:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     kernel test robot <lkp@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: xgene: Fix unused xgene_enet_of_match warning for !CONFIG_OF
Date:   Thu, 19 Oct 2023 13:23:37 -0500
Message-ID: <20231019182338.832913-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0377116decd ("net: ethernet: Use device_get_match_data()") dropped
the unconditional use of xgene_enet_of_match resulting in this warning:

drivers/net/ethernet/apm/xgene/xgene_enet_main.c:2004:34: warning: unused variable 'xgene_enet_of_match' [-Wunused-const-variable]

The fix is to drop of_match_ptr() which is not necessary because DT is
always used for this driver (well, it could in theory support ACPI only,
but CONFIG_OF is always enabled for arm64).

Fixes: b0377116decd ("net: ethernet: Use device_get_match_data()")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310170627.2Kvf6ZHY-lkp@intel.com/
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 56f2b3c229af..44900026d11b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2155,7 +2155,7 @@ static void xgene_enet_shutdown(struct platform_device *pdev)
 static struct platform_driver xgene_enet_driver = {
 	.driver = {
 		   .name = "xgene-enet",
-		   .of_match_table = of_match_ptr(xgene_enet_of_match),
+		   .of_match_table = xgene_enet_of_match,
 		   .acpi_match_table = ACPI_PTR(xgene_enet_acpi_match),
 	},
 	.probe = xgene_enet_probe,
-- 
2.42.0

