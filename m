Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289EC802CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjLDIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:12:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD02BB;
        Mon,  4 Dec 2023 00:12:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce3534bf44so948968b3a.1;
        Mon, 04 Dec 2023 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701677553; x=1702282353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ymWLoqyw32xpzTYM5b2NyGhQqjmhcr5ZGIFgQKSGQLM=;
        b=iEqPAk8vYJPqh6M6lcFPOOzHn73K5EC5Gdk+O9UajqXiWFsgiXt54mvaBejTPwApqL
         fo5ybK1MV+xstcfK28IxqXcNbFh/hnSoVvrks4vY9Omg5lA6QrdmF4bbpCStFGnpln8n
         5GexXRHQj0WSxUx+QC2Tg8Iz91Tc73sd2qcSeaLC4SC9sRI8KCK/7mxcQkWJZKgBQK1M
         qlydwbiL+2gkWfTGDH5px0tNfdCr/L5ZYZXIZIkdsvHn81EKAUk9SjyuOXo/MX5cBPoq
         XYEB2NJZKMgzFY10L5QNVyJPAKKZZZl1a3kvXEF5FUvfhBM7EcHLpxpQKZPv1KFj2khE
         541A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677553; x=1702282353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymWLoqyw32xpzTYM5b2NyGhQqjmhcr5ZGIFgQKSGQLM=;
        b=bbpwmgeSARfCYGMOrqcqYYLRjPM5iFm6Oc8SN8iuDSvJoHnWcYlHRdAx5gx/1OsQbt
         s/Va5S5Wpg33U5dTLUHioWiVLADCMtZu8tynyxTcAPEEb9xE3icxVlvvxtiR+SjNoITk
         Pa0RgStWT+ZB2oYZJ6wLFuPXnWrud4aD/zCRrFemw5JsZeQFChHI7hutRswGJYbriIc5
         YhW0ttIm6nv09enhnXndmhDmPwTEBcqXeyK5zMXsdBRpJJp2TuQEO/F4TCxAhpKSiWQe
         NuM6TF6XkZYkS9MJoRTAvfyTvEyxZ+UjVlaUPyOF7tPYXWWwxEq36G6CAcnJL2stsr9g
         MtmQ==
X-Gm-Message-State: AOJu0Yxh4B/p4nxeP+2yosDzsc9egUWoY5MWlrTejRw+6vTQS8GG+puB
        pqZOS1Cy/CWbw9iwFaM/Qi4=
X-Google-Smtp-Source: AGHT+IEMs4Z8uB/HV8st+VyBKhE7bpWBjxW30G9ABzHC9MZi6oSmOD56Mqwmb34xjcj1Y0FnFaYUjA==
X-Received: by 2002:a05:6a21:9983:b0:187:449d:a4cd with SMTP id ve3-20020a056a21998300b00187449da4cdmr3959920pzb.27.1701677553254;
        Mon, 04 Dec 2023 00:12:33 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id u30-20020a056a00099e00b006cba5c61a01sm7059864pfg.159.2023.12.04.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:12:32 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] Add Facebook Minerva Harma (AST2600) BMC
Date:   Mon,  4 Dec 2023 16:10:27 +0800
Message-Id: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
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

v4:https://lore.kernel.org/all/20231204054131.1845775-3-peter.yin@quantatw.com/
v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc@gmail.com/
v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org/
v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc@gmail.com/

Change log
v4 -> v5
  - Rename document and file from minerva-harma to harma. 

v3 -> v4
  - Add SGPIO line name.

v2 -> v3:
  - Fixed led schema.
  - Fixed i2c mux schema.
  - Add BMC_READY and SGPIO_READY.

v1 -> v2:
  - Add Power sensors.
  - Modify ehci number.
  - Add Led.
  - Modify SGPIO line-name.
v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Harma board
  ARM: dts: aspeed: Harma: Add Facebook Harma (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 595 ++++++++++++++++++
 3 files changed, 597 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

-- 
2.25.1

