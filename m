Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714987F579E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 06:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjKWFGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 00:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKWFGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 00:06:13 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66810E;
        Wed, 22 Nov 2023 21:06:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso324794a12.0;
        Wed, 22 Nov 2023 21:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700715980; x=1701320780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LMW4mDDc36Ycbn4eYhGyohVNo21MBd8auvFksF2JVBY=;
        b=QpgmdR90XpEjXstOiLXRpvCqn9vjeDhQSNngkHZ/zZluVKFukqnk8M7sISx8LsohEo
         paHS/Zw8H++zULHa2nO97uhKK8mk3Fc7zSZHvLTU0G/RWT0QgZGxaLSX0kv7eHY7CPLG
         owE1cUF1bSYwg+nlYzlZVOzWqEIrpV39JeF9Iiw65IFGKi84JmvCoIE3VgrP4CxWVzAq
         we0Sw7lB2xoZjE8kJDl5poj/bGZlWAjf5ic79cCr1JixNDJ6TLS6XwaIu0VtCMxLO9w5
         0ae1Eq09A+eBReAllRFn15zya85Qj6Uw4M5wRTVjhrbpqQEfNRX1Db0UCWhiJGMDSna8
         Hrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700715980; x=1701320780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMW4mDDc36Ycbn4eYhGyohVNo21MBd8auvFksF2JVBY=;
        b=ES3x2DFixJl1SkL6AfWgtKIQ4LJMjR+7jX8aeNbvTrgI4aPcPzxeNYjOwun7F4BmMX
         Fvd/oN7wljON/Ano0WwT4P9zmT3/eeuaXQ5AknQi/tgtPjC9EYW3BGLRNL7+l7Yn76SU
         AxMjhLdvUVAZoyHlLvUK7n2syaWbTKJheEIyRqNjO4OIFcLmqxNlnxmtPENqfKrIBtUP
         IK/5pbvA5j/Iid455NKq9C6HNLT32wUN85vAWoJJalIRfiEW8rmFfF83yGW2C/gvZkAz
         ZRQp6ZV8H44/UsaejINliFOvURVOcUI6zrMml4nIO31LAt0IR+M5OXwQYUhmb+Cz6pPj
         mzlw==
X-Gm-Message-State: AOJu0Yygz4I+F90BqtnF9MLPSJRWT3Okns60ETwK2GOmZbsdP3QtMv0D
        jgnADszdm0NHZ1CkgpOsS9k=
X-Google-Smtp-Source: AGHT+IFRZm7OT99klO8l5KWL9WVUjRY72ymYXHOYAATXOxuSHFJ1U6TCiYBLi1g6hUwVd2IOYW2i6Q==
X-Received: by 2002:a05:6a20:841b:b0:18b:8dfa:8946 with SMTP id c27-20020a056a20841b00b0018b8dfa8946mr1325340pzd.13.1700715979742;
        Wed, 22 Nov 2023 21:06:19 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a1a0400b0027b168cb011sm413101pjk.56.2023.11.22.21.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 21:06:19 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add Facebook Minerva Harma (AST2600) BMC
Date:   Thu, 23 Nov 2023 13:04:13 +0800
Message-Id: <20231123050415.3441429-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Add linux device tree entry related to Minerva Harma
specific devices connected to BMC SoC.

Change log
v2 -> v3:
  - Fixed led schema
  - Fixed i2c mux schema
  - Add BMC_READY and SGPIO_READY

v1 -> v2:
  - Add Power sensors
  - Modify ehci number
  - Add Led
  - Modify SGPIO line-name
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
 .../aspeed-bmc-facebook-minerva-harma.dts     | 533 ++++++++++++++++++
 3 files changed, 535 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-harma.dts

-- 
2.25.1

