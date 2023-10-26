Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3636D7D852B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjJZOst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjJZOsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:48:43 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633C1B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 07:48:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1es-0005Zo-2A; Thu, 26 Oct 2023 16:48:26 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-004Qq2-HJ; Thu, 26 Oct 2023 16:48:25 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qw1er-00H3XP-1X;
        Thu, 26 Oct 2023 16:48:25 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 0/5] regulator: add under-voltage support (part 2)
Date:   Thu, 26 Oct 2023 16:48:19 +0200
Message-Id: <20231026144824.4065145-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add under-voltage and emergency shutdown for system critical
regulators

changes v4:
- rebase against latest regulator/for-next
- drop mainlined patches
- rename regulator-uv-survival-time-ms to regulator-uv-less-critical-window-ms
  to fit it to actual use case
- avoid some of words in commit messages
- us switch case to parse critical events

changes v3:
- add system-critical-regulator property
- add regulator-uv-survival-time-ms property
- implement default policy for system critical uv events

changes v2:
- drop event forwarding support
- use emergency shutdown directly instead of generating under-voltage
  error event.
- fix devicetree patch
- drop interrupt-names support

Oleksij Rempel (5):
  regulator: dt-bindings: Add system-critical-regulator property
  regulator: Introduce handling for system-critical under-voltage events
  regulator: dt-bindings: Allow system-critical marking for
    fixed-regulator
  regulator: dt-bindings: Add 'regulator-uv-less-critical-window-ms'
    property
  regulator: Implement uv_survival_time for handling under-voltage
    events

 .../bindings/regulator/fixed-regulator.yaml   |  2 +
 .../bindings/regulator/regulator.yaml         | 13 +++++++
 drivers/regulator/core.c                      | 38 +++++++++++++++++++
 drivers/regulator/of_regulator.c              |  9 +++++
 include/linux/regulator/machine.h             | 18 +++++++++
 5 files changed, 80 insertions(+)

-- 
2.39.2

