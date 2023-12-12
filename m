Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0621E80FA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbjLLWSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377760AbjLLWSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:18:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09714BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702419526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=niWso/AgTSlNDKs+hLJfqSanWTgF91oEfLP5s9hKVlo=;
        b=ZgtQM8mSySScnanpslZXhtJJ3hfJKVfFEAz7Chqirh4BAWsx0TneYgUVA6I8f7HgX8BIPs
        /f9P0Iz/viliQb9vDlp/XvYcUTCcaWQ0B25kB20iF+vvZdQ3XKMA88TmsDCAGpGxFnTaXx
        IZx0uEkuVfayf66KCfucdJaGWqzclVs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-PGNFMIjaNoaFWeR6KP790w-1; Tue, 12 Dec 2023 17:18:44 -0500
X-MC-Unique: PGNFMIjaNoaFWeR6KP790w-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-67ab0fa577fso83888196d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 14:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419524; x=1703024324;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niWso/AgTSlNDKs+hLJfqSanWTgF91oEfLP5s9hKVlo=;
        b=M7BqvIJEnkFy7/FGdNbpqV/seYVoRt4tAPdNca2HNThywtZEoFaK5CTay/X9LU8qxB
         /Ca/1K31FDI+0CkHYch8wN/9jV+J7zd1kZlrjCoMlpXDrXTXWAz4baa9Yzg3q/EyWJ6Q
         gvGRL1HljuNLSgyqoRRQvHRXNEkNvZsJf8cSq2Lc4c9g7Id/oHUpcbU2L2ed5dvF7EPA
         gWpK+ct4v8Ap9cPlIDKExSJNPjf+7HDLDsgwzRuMU6mmvZ0g0zY+FQb4fdH5hbCqyTRf
         9ocrJDJGx0pXlUWbNLoJjHOf5X54kL3OTRvXe9IDljyQHcPuwg0eiEXYXG6k6Q8XpNmS
         x1mg==
X-Gm-Message-State: AOJu0YxxRIyaJFvxOysCQRTcVftA9aIi7YkU5xZO9l5okBjRmYOKFEzh
        OgPtQpVwLbL7+1z36Jys8bITvLe5PGRA58jXD6zL/VpEccPTo6Ou5H52Lk2nRtUNUBfRq4S97bT
        usZI0iAYt4j14plwTo2HYKR7D
X-Received: by 2002:a0c:c210:0:b0:67e:f58a:d6b0 with SMTP id l16-20020a0cc210000000b0067ef58ad6b0mr226803qvh.27.1702419524251;
        Tue, 12 Dec 2023 14:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXwgdCMDLzfi+fVcHm7+1qcErjuVF1ZgVVAksnjigHixsYAtg0Q68ahZCHFpj/G+kad1CZTA==
X-Received: by 2002:a0c:c210:0:b0:67e:f58a:d6b0 with SMTP id l16-20020a0cc210000000b0067ef58ad6b0mr226790qvh.27.1702419524008;
        Tue, 12 Dec 2023 14:18:44 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id uw2-20020a05620a4d8200b0077f103c8ad6sm4050578qkn.82.2023.12.12.14.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:18:43 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Tue, 12 Dec 2023 16:18:33 -0600
Subject: [PATCH net v2] net: stmmac: Handle disabled MDIO busses from
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-b4-stmmac-handle-mdio-enodev-v2-1-600171acf79f@redhat.com>
X-B4-Tracking: v=1; b=H4sIADjceGUC/42NQQrDIBBFrxJm3SnRBCtd9R4lC+tMGqFqUZGW4
 N0rOUGX7z94f4fMyXGG67BD4uqyi6GDPA1gNxOejI46gxzlJKQQ+JgxF++Nxa7pxejJReQQiSt
 qKZQmVtoqAz3xTry6z5G/Q+ACSx83l0tM3+OyikP9V68CBV4mK0c7z6smdUtMmylnGz0srbUfm
 X3voM4AAAA=
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many hardware configurations have the MDIO bus disabled, and are instead
using some other MDIO bus to talk to the MAC's phy.

of_mdiobus_register() returns -ENODEV in this case. Let's handle it
gracefully instead of failing to probe the MAC.

Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Changes in v2:
- Improve error handling code (Serge)
- Fix malformed Fixes tag (Simon)
- Link to v1: https://lore.kernel.org/r/20231211-b4-stmmac-handle-mdio-enodev-v1-1-73c20c44f8d6@redhat.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index fa9e7e7040b9..0542cfd1817e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -591,7 +591,11 @@ int stmmac_mdio_register(struct net_device *ndev)
 	new_bus->parent = priv->device;
 
 	err = of_mdiobus_register(new_bus, mdio_node);
-	if (err != 0) {
+	if (err == -ENODEV) {
+		err = 0;
+		dev_info(dev, "MDIO bus is disabled\n");
+		goto bus_register_fail;
+	} else if (err) {
 		dev_err_probe(dev, err, "Cannot register the MDIO bus\n");
 		goto bus_register_fail;
 	}

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231211-b4-stmmac-handle-mdio-enodev-82168de68c6a

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>

