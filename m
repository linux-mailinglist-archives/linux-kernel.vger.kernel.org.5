Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EB17A863B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjITOLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjITOLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:11:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB21AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:11:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so3327168f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1695219073; x=1695823873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hwi8Aua8Y+P9FZKHN1BFMedplZvBD6+gBTVYLrMGWT8=;
        b=FKJiiU1nuHY/TlAjYGLSG0DzZoIg9sLpdBsWDEUosCjL8GhAfdzqhG3iiFvYIzyR2J
         aueaa2el9vyBZ5jzHUaizFxKml1Z4QVp5L1js783GTU1n2Lnois+UOomoqVDHOxS/oB9
         401Z683OuBlQvzgBiWVa6yoq9rj7zEH8sSG/YS7S8QX1OMyhPqQJhcSgJMQIVNT+bqdL
         xq4IS3y7uPpXFU/uJsGtGRgqReHPvV/3YjVHsTJyGHRvSH1rGjgoQcB+Ov1jSaaNulc1
         CSksd12V06JcN16hIL2qvOxu6mKHXfUNUmVnsdBTJD4t/LqVSs3l1V+sz8WNo9ZgNyog
         CRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695219073; x=1695823873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwi8Aua8Y+P9FZKHN1BFMedplZvBD6+gBTVYLrMGWT8=;
        b=EqwkVX8acDkki87qkVG/f3YZDAxSz8+41Efa3KG6zC3k9Ewh2+0fCU3wnOcddGq5FC
         DCnKia5wI9xNoiyTqFbRKv3YXERXUKXu/fKkhM7XiF9eb0huVq5HTL3zHCSdg6lMQFZU
         O25p7FOxe1IrOUPeTG3tbr8n9pauYLXL6FBrpWW+6rZIsTm+MAYvEHq/Wq3o9tZfOm1X
         GhZDLZ54VO5pzqpiViE65twwBLeSBhsehRj4q1pUEP8ZEFWRrtvN7y0Z90RaJN/tVMyY
         VHFKp4Pim8UnlVVwp5Kjz2r6j3bmBOjNulCrK59Yu+0bXbuMNhf4a0yl2GKPysvVAH1s
         G5cA==
X-Gm-Message-State: AOJu0YzSdPtPqNc9Y/dLJhw2HnK01/qWX9SVRpIub/+RHjDYmFaNZbCF
        rZSpBbi1GWEcOUBp1QQ91UlT09LsP2ZHTFx0X1uSQw==
X-Google-Smtp-Source: AGHT+IHTJNOjPaxtCMEhcXl924Qdc/tQizDwoWDkol3TLylbsbucUit0glZlNiGcAG4UP+pOmxG/Xg==
X-Received: by 2002:a5d:60c5:0:b0:31f:dc60:13b5 with SMTP id x5-20020a5d60c5000000b0031fdc6013b5mr2391311wrt.25.1695218654230;
        Wed, 20 Sep 2023 07:04:14 -0700 (PDT)
Received: from capella.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906341a00b00993470682e5sm9397761ejb.32.2023.09.20.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:04:13 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: si5351: add option to adjust PLL without glitches
Date:   Wed, 20 Sep 2023 15:09:52 +0200
Message-ID: <20230920140343.2329225-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alvin Šipraga <alsi@bang-olufsen.dk>

This series intends to address a problem I had when using the Si5351A as
a runtime adjustable audio bit clock. The basic issue is that the driver
in its current form unconditionally resets the PLL whenever adjusting
its rate. But this reset causes an unwanted ~1.4 ms LOW signal glitch in
the clock output.

As a remedy, a new property is added to control the reset behaviour of
the PLLs more precisely. In the process I also converted the bindings to
YAML.

Alvin Šipraga (3):
  dt-bindings: clock: si5351: convert to yaml
  dt-bindings: clock: si5351: add PLL reset mode property
  clk: si5351: allow PLLs to be adjusted without reset

 .../bindings/clock/silabs,si5351.txt          | 126 --------
 .../bindings/clock/silabs,si5351.yaml         | 270 ++++++++++++++++++
 drivers/clk/clk-si5351.c                      |  47 ++-
 include/linux/platform_data/si5351.h          |   2 +
 4 files changed, 316 insertions(+), 129 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.txt
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5351.yaml

-- 
2.41.0

