Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4377760B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjHJKj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjHJKjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:39:43 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BA2D79
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c93638322so156198366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 03:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691663968; x=1692268768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zJ9MOKpVeig316su6xi1KnGB5hanzaH9oU2jA9id/34=;
        b=uQGbz65ij55MLDc2dLHsp6jUPyqPbIZtaosibRnlQmAfQnaP+7/6FNScNMWwQNAsAm
         RhKorlMSJJ1/+82nKt4ONcCT8SjpLPVpNu0nsMUSqwQAEF5wpDtQqv+c3LE45yeX1pdA
         HlJPKyIuMcGFiPAMuj13IX21xOpf4QSbO6Oop20Yk1ZbVBseuEKwWQ5nCtFyi6iv4YXV
         oNYUgO1VPo2bKkmw/uH76fO4cG0kuAWdl+1FkW61427k1kTLM9ZpuMaamJYOjYftZ+3n
         pvEgWZH0aSduZQCPV8FMObftKWMQ9tD2iwiIgGWEl2ObU58LrGGY9vz+XTCt2ZEqXrJi
         6IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663968; x=1692268768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJ9MOKpVeig316su6xi1KnGB5hanzaH9oU2jA9id/34=;
        b=J7XM2qeOw+7PgpdUMKJilxZWoXV+ADTKyl2m65F2mS+cOWcsiOSSlrwO1Ev5Iuqj4i
         PbNYDHDg3Re4UBPR7CPgQuVEhkjlWzp5zE7CwsphfAa5aoRnbKPL0UwjvRj1eLPFfiyy
         LGcOaUPLcWF0cYt1JHsHhGDLAj9dHmM+zq/gyGKe20PxQ2YFjBEi9kDcXhO7uzIvCBu3
         YjjJw42gJrGQhGCeOo5q1DDDl3OGicvvApLHsTWAK11zrbqchjJdmuvb6xq6WtWF0D6h
         ODal3esZY3gZzQewCBEaXn1eL0DXgFMMD6GWTZ6X3BDclQT/dAUD+AdDjs1tpWvo1sc2
         JOOw==
X-Gm-Message-State: AOJu0Yztqtix9psyJ6vXBJrg9BFLKO6s7MTCbp+/96WBbGHJe16q5zS1
        jkL6ndtenXbklJrBNX6fk6Z9Uw==
X-Google-Smtp-Source: AGHT+IEK8P3dqAX5gIvsT8nsM2TfsbTvTxWqFzlAZ0erTN8BR+5qocrc6+mwqlnlgS+pS7P2w1dhFg==
X-Received: by 2002:a17:906:53:b0:99b:4d3d:c9b7 with SMTP id 19-20020a170906005300b0099b4d3dc9b7mr2246114ejg.31.1691663967813;
        Thu, 10 Aug 2023 03:39:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id mc5-20020a170906eb4500b00999bb1e01dfsm749244ejb.52.2023.08.10.03.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 03:39:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Iyappan Subramanian <iyappan@os.amperecomputing.com>,
        Keyur Chudgar <keyur@os.amperecomputing.com>,
        Quan Nguyen <quan@os.amperecomputing.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/2] net/xgene: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 12:39:22 +0200
Message-Id: <20230810103923.151226-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'enet_id' is an enum, thus cast of pointer on 64-bit compile test with
W=1 causes:

  xgene_enet_main.c:2044:20: error: cast to smaller integer type 'enum xgene_enet_id' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 41d96f4b23d8..4d4140b7c450 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -2041,7 +2041,7 @@ static int xgene_enet_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(xgene_enet_of_match, &pdev->dev);
 	if (of_id) {
-		pdata->enet_id = (enum xgene_enet_id)of_id->data;
+		pdata->enet_id = (uintptr_t)of_id->data;
 	}
 #ifdef CONFIG_ACPI
 	else {
-- 
2.34.1

