Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692E98127AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjLNGGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjLNGGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:06:00 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F363184;
        Wed, 13 Dec 2023 22:06:06 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b9d8bfe845so6025544b6e.0;
        Wed, 13 Dec 2023 22:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702533965; x=1703138765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+a1qRWDVd0Qb5hRWtU/dvzuvUYCuGeu7I5OT61KOFhY=;
        b=d86Sm3UpMPZ/Da6Drp3V0F21cz/H4088sFxK6UBJkVsBkfHjbjkzWssC+CShXQ8KVG
         gKtAHseMiNVHLgm4Wm7mckSuAKxUp6fVs2xxzDMrit1XfccW0ZGXto7FTw1FZAXm4mg0
         IRIuTlYepmFJR1dXxn5btk2+GsSCngGPEcH6KE8RS+YxntmubLVgp/SUohGoc+eSL0Eb
         qVURf8ttP+8cDiK1vnOrAFXsTIPyayLsYlx8IEFEDUppE6SQUqBkJ6qfVBgOrWF8WyZQ
         3WCjRNVAR67LWNPQmHlfUPe+SvEOjSxC1dV3gnGBeRHAuc03hXlPX8fqtLrzClhlVQVI
         AVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702533965; x=1703138765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a1qRWDVd0Qb5hRWtU/dvzuvUYCuGeu7I5OT61KOFhY=;
        b=LOrBzWWJG6EsjLixY7crFJzGHGyTmsrUzoX91lHJYkzXwTCuVrEVa20pPIEJ3f9rYl
         Ox43dFCVtNz0rK47xDsxQUrt1t2lRp6gKxwOFHLqntgzhHjQSQO0siJaABqPwA6Pz/IL
         0X62MhuAY5ql1xMUlPuLPMOhRkgRUwEWl2iv4jT7RCFtZFrGibQ/wxDYPomlhdTdfUtV
         ZC/oUYsSbkf/ssMQgBOFdD7ehwXdabBfJbDoY3VG3AechNsPf24wLUWhkYabwN3RGUoy
         jYuR/PkSmCCchTdSNOXuV4tEVABtMPz7GlgnTPa71Tl0Zn8h/ZyEI3xHa0IKGvYmDXKL
         OpYw==
X-Gm-Message-State: AOJu0YwkrT0KdvmGHfsglmLHgwgo8QBvLo3WjJJ/okFPFq5i0th8/ZzL
        hTL6QzvZjeqIyFhj3hv2z2U=
X-Google-Smtp-Source: AGHT+IFbaAyOzerQ6q5xZNU7IYgsZgt6jyZmlCbtsMrwPH9BcSP+mtRo1VqmZLD0YGK1Hpa6evCQJQ==
X-Received: by 2002:a05:6808:2f0e:b0:3ba:845:93d8 with SMTP id gu14-20020a0568082f0e00b003ba084593d8mr9365106oib.83.1702533965502;
        Wed, 13 Dec 2023 22:06:05 -0800 (PST)
Received: from cosmo-ubuntu-2204.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a2d8b00b0028ae812da81sm2373327pjd.8.2023.12.13.22.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 22:06:04 -0800 (PST)
From:   Cosmo Chou <chou.cosmo@gmail.com>
To:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jdelvare@suse.com, corbet@lwn.net, broonie@kernel.org,
        naresh.solanki@9elements.com, vincent@vtremblay.dev,
        patrick.rudolph@9elements.com, luca.ceresoli@bootlin.com,
        bhelgaas@google.com, festevam@denx.de,
        alexander.stein@ew.tq-group.com, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        forbidden405@foxmail.com, sre@kernel.org, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        chou.cosmo@gmail.com, cosmo.chou@quantatw.com
Subject: [PATCH v2 0/3] hwmon: Add driver for Astera Labs PT5161L retimer
Date:   Thu, 14 Dec 2023 14:05:49 +0800
Message-Id: <20231214060552.2852761-1-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This driver implements support for temperature monitoring of Astera Labs
PT5161L series PCIe retimer chips.

LINK: [v1] https://lore.kernel.org/all/20231205074723.3546295-1-chou.cosmo@gmail.com/

v2:
  - Add "asteralabs,pt5161l" to trivial-devices.yaml
  - Change naming PT516XX/pt516xx to PT5161L/pt5161l
  - Separated debugfs files for health status
  - Revise the style of comments
  - Remove unused defines
  - Remove including unused header files
  - Remove unnecessary debugging messages
  - Revise the data parsing for a big-endian system
  - Use read_block_data instead of accessing wide registers
  - Remove the debugfs files when the device is unloaded
  - Add acpi_match_table

Cosmo Chou (3):
  dt-bindings: vendor-prefixes: add asteralabs
  dt-bindings: trivial-devices: add Astera Labs PT5161L
  hwmon: Add driver for Astera Labs PT5161L retimer

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/pt5161l.rst               |  42 ++
 MAINTAINERS                                   |   7 +
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/pt5161l.c                       | 558 ++++++++++++++++++
 8 files changed, 623 insertions(+)
 create mode 100644 Documentation/hwmon/pt5161l.rst
 create mode 100644 drivers/hwmon/pt5161l.c

-- 
2.34.1

