Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AE7B7C61
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbjJDJjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjJDJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:39:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E278A7;
        Wed,  4 Oct 2023 02:39:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8B7C433C7;
        Wed,  4 Oct 2023 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696412376;
        bh=Mo9aBSue9VgCsnzG+WTcEHnQB+oqgaq0bf1pV4lpD7s=;
        h=From:To:Cc:Subject:Date:From;
        b=j8Tr0MiZaTgG2SgRnZTV7+1OuMwIoz8poMpoC5wZM+h+1Wp4gQhB4uJc1OrJl+iy5
         BCr2XqZ4FzC8o71iWEgHlY+LnM2NJ/B65xYXFLwZsaDurmNYivr+ESxvNYTCt15on0
         22gtaA35KcSe0zY1WSNEAfOGavpt0Kybof/3PViaXe0KKQARS5XTjO1z5mY/WacIb+
         F8GNHTNlNPExRwrVtO6lMtuzaZJbGKeVcsNCD2lwMUFId/wUEIMzEkM+Zliflf57vk
         uYdwjXA3ljT6I2G0oxpzTqdY2qODHtv0meyVUVbnKQpVKvTyuY0s90QZe19scZvsuP
         5AZ15FkVv8lGA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/2] pwm: add driver for T-THEAD TH1520 SoC
Date:   Wed,  4 Oct 2023 17:27:29 +0800
Message-Id: <20231004092731.1362-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used to
control the LCD backlight, fan and so on. Add the PWM driver support
for it.

Since the clk part isn't mainlined, so SoC dts(i) changes are not
included in this series. However, it can be tested by using fixed-clock.

since v1:
 - update commit msg and yaml filename to address Conor's comment
 - use devm_clk_get_enabled() and devm_pwmchip_add()
 - implement .get_state()
 - properly handle overflow
 - introduce thead_pwm_from_chip() inline function
 - document Limitations
 - address pm_runtime_get/put pingpong comment

Jisheng Zhang (2):
  dt-bindings: pwm: Add T-HEAD PWM controller
  pwm: add T-HEAD PWM driver

 .../bindings/pwm/thead,th1520-pwm.yaml        |  44 +++
 MAINTAINERS                                   |   1 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-thead.c                       | 274 ++++++++++++++++++
 5 files changed, 331 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
 create mode 100644 drivers/pwm/pwm-thead.c

-- 
2.40.1

