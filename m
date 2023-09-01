Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EA1790328
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350839AbjIAVq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 17:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbjIAVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 17:42:51 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1E1BF6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 14:20:53 -0700 (PDT)
Received: from [77.64.243.219] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qcBZ5-0004Wd-2w; Fri, 01 Sep 2023 23:20:27 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/2] leds: Add a driver for KTD202x
Date:   Fri, 01 Sep 2023 23:19:57 +0200
Message-Id: <20230901-ktd202x-v2-0-3cb8b0ca02ed@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH1V8mQC/2WNyw6CMBBFf4V0bU1becWV/2EImbZT26iAHSQo4
 d8tbN3dc3OSszDCGJDYOVtYxClQ6LsE6pAx46G7IQ82MVNCnUQpa34fbdozL/JSK6isyoVmydZ
 AyHWEzvjN169n0boHkG8jQtyMIaIL8966Nol9oLGPnz09ye39r0ySC+6MrJVDB9ZWFxjC+CXjj
 /hmzbquP1zDyV3CAAAA
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the Kinetic KTD2026 and KTD2027.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- Make binding description filename match compatible
- Address comments by Lee Jones
  - Extend driver description in Kconfig
  - Add copyright + link to datasheet
  - Add unit to definition/variable names, where needed
  - Define magic numbers
  - Remove forward declaration of 'struct ktd202x'
  - Remove superfluous comments
  - Get rid of struct ktd202x_info
  - Join ktd202x_chip_init() with ktd202x_chip_enable()
  - Return the error on ktd202x_chip_disable()
  - Remove unreachable case from chip_in_use()
  - Rename ktd202x_brightness_set() argument from num_colors to num_channels
  - Forward errors received in ktd202x_brightness_set()
  - Remove variable for 'num_channels = 1'
  - Add some explanations to blink time calculation
  - Remove unneeded lcdev from ktd202x_blink_*_set()
  - Add define for max brightness and replace deprecated LED_FULL by it
  - Move setting led_classdev.brightness to ktd202x_brightness_*_set()
  - Move mutex_lock inside ktd202x_blink_set()
  - Add comment that 'color' property is optional (allow EINVAL)
  - Replace escaped double quotes by single quotes
  - Avoid overloading variable 'color'
  - Do not lock during probe
  - Remove usage of 'of_match_ptr'
- Document interrupt and pull-up supply, like done for aw2013[1]
- Fix error in num_steps calculation
- Link to v1: https://lore.kernel.org/r/20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu

[1] https://lore.kernel.org/linux-leds/20230815-aw2013-vio-v3-0-2505296b0856@gerhold.net/

---
André Apitzsch (2):
      dt-bindings: leds: Add Kinetic KTD2026/2027 LED
      leds: add ktd202x driver

 .../devicetree/bindings/leds/kinetic,ktd202x.yaml  | 171 ++++++
 drivers/leds/rgb/Kconfig                           |  13 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-ktd202x.c                    | 625 +++++++++++++++++++++
 4 files changed, 810 insertions(+)
---
base-commit: a47fc304d2b678db1a5d760a7d644dac9b067752
change-id: 20230618-ktd202x-546b2a7d240b

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

