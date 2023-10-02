Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F07B5842
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjJBQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238336AbjJBQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:49:42 -0400
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E86A9;
        Mon,  2 Oct 2023 09:49:39 -0700 (PDT)
Received: from [92.206.139.21] (helo=note-book.lan)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qnM6w-0005X7-TD; Mon, 02 Oct 2023 18:49:34 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v6 0/2] leds: Add a driver for KTD202x
Date:   Mon, 02 Oct 2023 18:48:26 +0200
Message-Id: <20231002-ktd202x-v6-0-26be8eefeb88@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFr0GmUC/2XPy27DIBAF0F+JWJeK4WWnq/5HFUXDq6A2TgqOl
 TbyvxeyqK16x0VzuMOdFJ+TL+RldyfZT6mk81CDftoRG3F49zS5mglnXDANPf0YXT3fqJLacOw
 cl8yQOm2weGoyDja2efN1UsfwiSUes8fcJi7Zh3R7dL0dao6pjOf8/aieoN1uWyagjAYLPQ8+o
 HPdK17S+FNsfPZX0l6Z+CL3DBbJqxTW9IZZZNy7rRRrqRcpquyCNXuwWjmBWylXkotFyipBho7
 LoJ0UZivVnwS23la1fyopERxTwP5tO8/zL41gmGGqAQAA
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding description and the corresponding driver for
the Kinetic KTD2026 and KTD2027.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v6:
- Remove un-needed inits
- Narrow scope of variables
- Release of_node references on early exit
- Pass child node to dev_err() in ktd202x_setup_led_rgb()
- Link to v5: https://lore.kernel.org/r/20231001-ktd202x-v5-0-f544a1d0510d@apitzsch.eu

Changes in v5:
- Restructure brightness_set() + add comments to it to be easier understandable
- Add some line breaks + remove little line-wraps to improve readability
- Move parts of add_led() to setup_led_{rgb,single}()
- Move mutex_init() to the end of probe to omit gotos
- Fix grammar
- Set initial intensity to max brightness to avoid LED staying off when
  brightness is changed after switching to timer trigger, because of zero
  intensity
- Link to v4: https://lore.kernel.org/r/20230923-ktd202x-v4-0-14f724f6d43b@apitzsch.eu

Changes in v4:
- Annotate struct ktd202x with __counted_by
- Link to v3: https://lore.kernel.org/r/20230906-ktd202x-v3-0-7fcb91c65d3a@apitzsch.eu

Changes in v3:
- Add r-b to bindings patch
- Replace .probe_new by .probe
- Link to v2: https://lore.kernel.org/r/20230901-ktd202x-v2-0-3cb8b0ca02ed@apitzsch.eu

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
base-commit: 165adeea3617ea22dc49f8880474ebf3a98b696d
change-id: 20230618-ktd202x-546b2a7d240b

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

