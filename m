Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96507D0E03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjJTK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376974AbjJTK4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88E1112
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:08 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083cd39188so5266205e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799367; x=1698404167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+w3Ntloijo4n7opnoBdeJ1Rm6+n13HvynO+TOERBL8=;
        b=psbRLtrdbQGv4g3qwXgbYRnpPKpOcM0Lv2sQWrZP90ApKAsJ5SIS65RkAlHGQyAKOn
         SAtogQjnrMiw9zyKlI2HRi4lc2Jfp8In4atE7lTO3f1/ZHXuuX/8olOXg68LAG4BTuGJ
         sfJJnCY9rkZGglg3s/1ZhgYH7kWbP9RwQyebYKlZ3fllH7WG1lNIEVWDqriC5/LtXs/V
         Z+320oY9r+uu/OtrVvNr4fAcsyAsd+Ic9rfi4U/dzzIh12DOBim8OUEmzz6r62nxSGxU
         /W1Ma4qA3TThBdzyWGKwGDysbkvXJ2uS0SWQhYVWIpiDeYrWGR0Vd9+Sr+mLt2qyFT4i
         jCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799367; x=1698404167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+w3Ntloijo4n7opnoBdeJ1Rm6+n13HvynO+TOERBL8=;
        b=TiCPaud/8AcQg1b890kcYFOn16aKPCtkHCKfNxJktFjuzR8UaeL1RJ5l7L3YKMcYNz
         ryRHjOlrc+sqc7zPcqK+szhJ/tRLGxYWLUZrUFSgOHXTBnnbeKUaSq3Bdawg6R004Ps2
         0uhcSHn+UuS9zW80wEe5OiGa1kM2O8ExtJWsoZ2oHOp8eHvmE9NemB5rozarjfL+MfrP
         0fU1cU7HmZDKOdLXykRaK7kU1LUsTKV/tJxV/SR72Ul/P2mltA2JKdUfoHbRupX3ODkE
         /fwjWIDPCo9HGyvKujHtJiaYghkxSfpP/bQeNbX+wL+n9jnc7/z+/OLrnFGYmyI7LVgw
         0g0g==
X-Gm-Message-State: AOJu0YzicLJT7zj8qDD4+qbsieaY0odNWXwioF7dLh8GvAILJ6f1E17K
        CYonASKVz1YF6zqlvWWdP8Plmw==
X-Google-Smtp-Source: AGHT+IEYaVw2/JGRLXTljG23GZOA5kUUjmqrm3VKbf/S4objvOuJ1Ge0P6Z+RsGggK9mJdNG5bGhPw==
X-Received: by 2002:a05:600c:1992:b0:406:872d:7725 with SMTP id t18-20020a05600c199200b00406872d7725mr1225544wmq.1.1697799367265;
        Fri, 20 Oct 2023 03:56:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b004065e235417sm6578937wmh.21.2023.10.20.03.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:56:06 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] dt-bindings: nvmem: u-boot,env: Add missing additionalProperties on child node schemas
Date:   Fri, 20 Oct 2023 11:55:44 +0100
Message-Id: <20231020105545.216052-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
References: <20231020105545.216052-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 36d97fb87865..9c36afc7084b 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -51,6 +51,8 @@ properties:
   ethaddr:
     type: object
     description: Ethernet interfaces base MAC address.
+    additionalProperties: false
+
     properties:
       "#nvmem-cell-cells":
         description: The first argument is a MAC address offset.
-- 
2.25.1

