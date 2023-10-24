Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B527D49F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjJXI0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjJXI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:26:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E912C;
        Tue, 24 Oct 2023 01:26:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9fa869a63so25463395ad.0;
        Tue, 24 Oct 2023 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698135970; x=1698740770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElAJ7T5lyM2rNfb9sdirLY+VRjlwidQbRBMl87dIYmA=;
        b=TfL8J5YevsSt2Tl53CQUZcOCAfD99JaejgqTJa1F3MXX229ryzXXcj1JLKlUmmM751
         75NX8Iw8YZcjbD88E3FiWfGW4fCG38FagVUlutT8F9EbltVZntkv3zeNv3x6CuAH/OQJ
         vLV5di2OiVEIzTqFMgp46XpLZ9Aa1FG3LBMhkMstQd1c2XzbJ+0OhLVQsdeO0J4XOLtE
         ULk6k+UDZy1yd8GKxByAdABSmZzYdRLzlT/Vo3xpQclaOqaCAEQtDO9vlXGehkvZVwKl
         a5wcIFqFmTiboqDwK/TxXq2oQUnLbllyUdcES2zVX061C1tOZzsc2zp5uHd8kC/7dWsw
         GrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698135970; x=1698740770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElAJ7T5lyM2rNfb9sdirLY+VRjlwidQbRBMl87dIYmA=;
        b=nNW/Tj4JPMLmz1JWkO2GSS/CtZRfd5Sdzo0O54JeTn1dHje2LkSy27rRPp18ZIhnSS
         rdw9VcBezla15+xjizp3Wd0eCLeoMW+t7OVbPyyqGY8DDx24Wq2ITWcJNNKQYTSBRerh
         XNXcZB+fJW2EE4zpymTfIGAiS6rNvO8y2LTc+pkS0+E/sDVOyVsxPZwPks+dB0X7THgM
         A4UGQefkbCPMqOfOeon/eQLyEnOOFEIaPcX9r6ZRR0evFNZyKjJ8OR3txgkklAV1HBxg
         Jh6TOwz6g0XBcDGZJdu3SHHVWT14EopfP3xGAuZ836sLKYlV11QEqP97cQ3RoG/WT1E+
         yJsQ==
X-Gm-Message-State: AOJu0Yz5Gb9DlLspqrG/Ncdf1Znfxx8r5OfPpdMBSLTHK7NABqOdCZbP
        /s6+Kmd6O5ivRXKrh18clJhsHL7gDSQ=
X-Google-Smtp-Source: AGHT+IE7Sdfd2gCzc6kKD7SwZlRXbF1gQ7AoSLA/Lok7KF+6ZMR9Nyn9J0rAXXPFWPaZ9osXwKzFyQ==
X-Received: by 2002:a17:903:3211:b0:1ca:4d35:b2f3 with SMTP id s17-20020a170903321100b001ca4d35b2f3mr7282603plh.67.1698135970656;
        Tue, 24 Oct 2023 01:26:10 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001b9c960ffeasm7010665plx.47.2023.10.24.01.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:26:09 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Peter Yin <peteryin.openbmc@gmail.com>
Subject: [PATCH v1 0/2] Add Facebook Minerva Harma (AST2600) BMC
Date:   Tue, 24 Oct 2023 16:24:01 +0800
Message-Id: <20231024082404.735843-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Add linux device tree entry related to Minerva Harma
specific devices connected to BMC SoC.

Change log

v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Minerva Harma board
  ARM: dts: aspeed: Minerva Harma: Add Facebook Minerva Harma (AST2600)
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-minerva-harma.dts     | 484 ++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-harma.dts

-- 
2.25.1

