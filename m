Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8079787E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbjIGQrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbjIGQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:46:34 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D619A7;
        Thu,  7 Sep 2023 09:46:06 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-58df8cab1f2so12095257b3.3;
        Thu, 07 Sep 2023 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694104776; x=1694709576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrZo7tIMdoMbzOPcfOzJ/GpkMVwTtgFYIxMTU1F66OU=;
        b=aIfZDV/rPwVV6HHXZUumWOXEACZH+d2GCmX+jRM8rlWz/6nLFo3q7Sz4RTNMyjYO2E
         srkRyONJincQ5Nzdvy2B07zzmA9nlhRayC5vGWqLMaWyViGp3/hELAUgH5bbUEy4TiVp
         MhSO8oquoRNxm6k5y/1ze3K4gCT+xrFg2XosxYMRAlKyj6iJZvJv58NwGYNNcf5DEog8
         u+wRPOSzgndD2QyRWgL/6+wMRCdc/ZD6GQ6neoefBlMkWR4s5nX9a9ejF7g/yIaMT5Ed
         ynWu6Gh54nigkFcgj11OtC3o8KvHzU/KurSRsfgoMJJbwH0u1xesUbDgnP75lwdx2vpT
         ScXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694104776; x=1694709576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrZo7tIMdoMbzOPcfOzJ/GpkMVwTtgFYIxMTU1F66OU=;
        b=gxh2IAb1BG7ZKZDihl/J3fI0vuSMj+6g7WZ/EuBvYN6FYIqwHn3y9ya9RZQ+2IFsew
         BHOuySsIgBG0dzon07n+NSLB/jqjhbGPuC02QISB76aGl4gkWSJGUeTjY+eCkLjG6fYe
         BvXCYfmx+3VcjP0aQhcVOqkx38MfqGMUKMeyp3atabfNpnaXL8mXS8MXcMGHxxg5J9wb
         RQuNlrTTxdQ49AnN0LRNiPVl5PmDKe0KJyYYJdXakq6wiOEg4Fsf0p542/4gRESCQ0o8
         cLR8F3MQ0WhpixlbddHvHvwxKj8JnNUv7+tuvCHd9fJYArPwWjkuJpqtIsrVS0XFpHkm
         yPag==
X-Gm-Message-State: AOJu0YwI2B2I6Dn8J0E009sykPE731uVnnxjXZlkw5zsLnPnnAl52JqP
        ZVxiCLdWCMuN5rnaSbMAWuPHuFONhU9ekA==
X-Google-Smtp-Source: AGHT+IFNTrp0LllA/7YkJ8morIKFGIvz86ztT5BNjS92sj48mhb3ZjgnpTVnuat3lT8rvjyvzAuCDQ==
X-Received: by 2002:a05:6808:192a:b0:3a8:6a4b:9e34 with SMTP id bf42-20020a056808192a00b003a86a4b9e34mr25886326oib.47.1694069544085;
        Wed, 06 Sep 2023 23:52:24 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id f8-20020a17090ace0800b0026b55e28035sm800439pju.52.2023.09.06.23.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 23:52:23 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     peter.yin@quantatw.com, Peter Yin <peteryin.openbmc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Thu,  7 Sep 2023 14:45:13 +0800
Message-Id: <20230907064514.1764010-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907064514.1764010-1-peteryin.openbmc@gmail.com>
References: <20230907064514.1764010-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Meta Minerva.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 68f717670f78..32582ee56264 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-bmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

