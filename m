Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB083787BE4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbjHXXQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244102AbjHXXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:16:44 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE53C1BD8;
        Thu, 24 Aug 2023 16:16:33 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-411f5dd7912so1752091cf.3;
        Thu, 24 Aug 2023 16:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692918993; x=1693523793;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwYEG6LDZeYZEz4nJF4sLmiV7XAaDp0hMayPMcMAPoY=;
        b=U3DADakTWFVqLJ/Qm8fJMc4K7Bp+Y2y5d0Kak0y6EznFUvFg0oMS/Mq9j7Ax86A+sk
         EhgcS+MuxgEAuIY+btx2CoxuGUl3HJ42GWT+tuBKrFNSPGxl/Bx3EV+0R0K3Sf7NTycg
         KNKPN4IW42K7xl+7FmiP3F/sZCnPTBhuNts7aZgoG1/oyje6lulxmhVpz0+j52LdeQZu
         +volZsrWpkAQBVNn4HFn1zsC8XpKXrUNA91N/+MTccaR8eMpgu08c6VeaS/PSJSINXIi
         4aOzNgVP1Ot+i4lvt9Ib0HykuEqv4TbNCFJcPtRNE0EqdGcu1qjYdSRarQbjQhQCXJ+O
         jXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918993; x=1693523793;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwYEG6LDZeYZEz4nJF4sLmiV7XAaDp0hMayPMcMAPoY=;
        b=ajfhoqUYqEj7HAT4f65OcWYGtM+3sKfa43Wu91TqapI4GukbbpwTIUE1XXYPgQvvZl
         bURjsvOFgjgXby8bXh7tZeAPet4jBWJ/XkkXdFqjrtTA27ObMQ8+kXJpLWfJzrPUomDf
         KxPUujJbTLPhAWVN2luScsFffPDRs+ajKo14GP26MCLRW5N+ckmI6uGy1yxMhKmIR+lR
         QsYtKHXVVIxVSjO7T27fC7hpZYJzQp8daR3yK+6jFDDNArunDy5/YaMT+n6Swne9/eW9
         QInSb1OhEqv0ekpnBWCa63SdlbkVpE0c2WVipA4y+obaIwo4/3sHqMRw7LHjbn5vf+Vo
         iZXg==
X-Gm-Message-State: AOJu0YzRIDBt4daYbJmD5W9ZsJCAme3bVPoQ3P9goA9zUXjDr3jQsFK/
        y7hCRqQijptfq5pJYWG9v17KdqKK4dmP+rPk
X-Google-Smtp-Source: AGHT+IGB+hJ2GhXbKsbDYhTpNakLTpH6zYFeumCU9LHE6UxCU37meDEE9+N8OCLVnnwtaqpBzoZ3qw==
X-Received: by 2002:a05:622a:13:b0:412:217:3d3d with SMTP id x19-20020a05622a001300b0041202173d3dmr4086554qtw.68.1692918992980;
        Thu, 24 Aug 2023 16:16:32 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id eo9-20020a05622a544900b004054b435f8csm151322qtb.65.2023.08.24.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:16:32 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/2] gpio: pca953x: add support for TCA9538
Date:   Thu, 24 Aug 2023 19:16:24 -0400
Message-Id: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjk52QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyMT3ZLkREtTYwtdk5SkNIsUS+M0w6REJaDqgqLUtMwKsEnRsbW1APT
 WVU9ZAAAA
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692918991; l=617;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=scvdto5C4eFjmVE9YDbdg1AXIpzLa9wYd8YkecsvFsM=;
 b=rQm4YAcFv70cq7EjPRrWvxdHWs2dOqFezleNy3Ngfgwst9MEl1AW1XD9EwTjIH16/xreb/ZFp
 4X5PUpbDM4pD65aINcuCdkRLhfK4yTx2dwOF+QD/fWy6G9fdDq1I5yx
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCA9538 is an 8 bit version of the already supported TCA9539.
This chip also has interrupt support.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
Liam Beguin (2):
      gpio: pca953x: add support for TCA9538
      dt-bindings: gpio: pca95xx: document new tca9538 chip

 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 1 +
 drivers/gpio/gpio-pca953x.c                              | 2 ++
 2 files changed, 3 insertions(+)
---
base-commit: a5e505a99ca748583dbe558b691be1b26f05d678
change-id: 20230824-tca9538-4dbf8d93f1ba

Best regards,
-- 
Liam Beguin <liambeguin@gmail.com>

