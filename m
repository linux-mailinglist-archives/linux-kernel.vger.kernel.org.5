Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F487E0144
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjKCIDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 04:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbjKCIDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 04:03:40 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE3ED42;
        Fri,  3 Nov 2023 01:03:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6c311ca94b4so1814019b3a.3;
        Fri, 03 Nov 2023 01:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698998616; x=1699603416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8JFS3vR1yJqsVQDnzz/sXYv25kxdeSbcVlJLmleJfk=;
        b=EAUUN63Gfn5kQTemUCNmFo249uruWqD5ya513tWQv2nDGPiD000FWAW7R440dFb7EN
         JPhUdbb25nZ5kB6Lj91YzIWhD2vkXaM2OxKVxNbYUe6qJJOr9andEWTKK4nWnK2YBRzG
         KKtVYvU5lQjQxJ1N2COUnMb6S4M6sheB6hQMRSpC1gx/vP8CyvqshDzXt0W8Amx7OB3D
         vHfP8hd8ZHlnKrMu2QSAKUNta2Q7tGEn1kuPzSKqdWMAy0GzVJnXUr6tf3PKtzRqCGpz
         6YHtIvFg+qaqTIzteoasRrUzuUWcYr3WCOKd4J3aerOiPfQ5X2lulTijdBvG8IIFlhCr
         Iowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998616; x=1699603416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8JFS3vR1yJqsVQDnzz/sXYv25kxdeSbcVlJLmleJfk=;
        b=OF9Clk0u2yUemWeWZLG4yxhyLHXcLivmIiKffbSu9Dk77og12kYZ+iFPhySRnCtbMu
         CJdbd4GEeA7g/jxS4c2MKrKs/v4RqfngQTnA1Wd9PEthldwuxthtARL/VFdz+4fdO1So
         plpmgm6iwMqe33Wz0fFswTp7VKvhYo8NoNrLhfeY5QzSaN4AvAVvp2KEuKpjOxXasVBd
         gs7sIOKLU9jcEvVX16qUCaijd7S9uWUFQ+qkihybSzlIOTm4pMdkxYJ8k+aUi32n3BLO
         KZh1gFuYudP04G/Il5fqTlvbnQ9r9hkZ5xFI2DK9QbKBqAy8sl0nit8QMfnc+AkcR6g7
         0ejA==
X-Gm-Message-State: AOJu0YzwmCMrPNOszsQe5C2qOdsU+sK3GlfqaFGjSGr1t5OErUcYMGPN
        Xdxb1B6S49mLEwFoebzJwlTZ9BsZzmI=
X-Google-Smtp-Source: AGHT+IGL/Gi9CrNc1vO5zv6Y/Mwu6xbm6iVSNIPzWnOQ4pcbbAZlfgqVVIesdrDclKQX280myZdioA==
X-Received: by 2002:a05:6a21:3b44:b0:180:eef7:b3bd with SMTP id zy4-20020a056a213b4400b00180eef7b3bdmr10255020pzb.28.1698998616364;
        Fri, 03 Nov 2023 01:03:36 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id l1-20020a17090a72c100b002790ded9c6dsm834378pjk.31.2023.11.03.01.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 01:03:35 -0700 (PDT)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Yin <peteryin.openbmc@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 0/2] hwmon: (pmbus) Add support for MPS Multi-phase mp5990
Date:   Fri,  3 Nov 2023 16:01:25 +0800
Message-Id: <20231103080128.1204218-1-peteryin.openbmc@gmail.com>
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

Add support for MPS Multi-phase mp5990 hsc controller

Change log:
  v1: Add support for MPS Multi-phase mp5990 HSC.
---
Peter Yin (2):
  dt-bindings: hwmon: Add mps mp5990 driver bindings
  hwmon: (pmbus) Add support for MPS Multi-phase mp5990

 .../devicetree/bindings/hwmon/mps,mp5990.yaml | 43 +++++++++
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/mp5990.rst                | 84 +++++++++++++++++
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/mp5990.c                  | 90 +++++++++++++++++++
 6 files changed, 228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/mps,mp5990.yaml
 create mode 100644 Documentation/hwmon/mp5990.rst
 create mode 100644 drivers/hwmon/pmbus/mp5990.c

-- 
2.25.1

