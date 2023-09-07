Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4840879787D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbjIGQrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjIGQqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:46:38 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418401FD5;
        Thu,  7 Sep 2023 09:46:10 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qeHce-0052RD-DX; Thu, 07 Sep 2023 17:12:48 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qeHcd-000HUl-2N;
        Thu, 07 Sep 2023 17:12:47 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: [PATCH v9 0/6] designware pwm driver updates
Date:   Thu,  7 Sep 2023 17:12:36 +0100
Message-Id: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is an update for the DesignWare PWM driver to add support for
OF (and split the PCI bits out if aynone else wants them). This is mostly
the same as the v8 series, but with code moved around and module-namespace
added, plus review comments processed.

We no longer have access to the hardware to test any further modifications.

I've not added the tested-by tags as there have been alterations to this
series.

Note, the dt binding seems to have already been applied.

The lengthy changelog:

v9:
  - fix multi-line comment issue
  - changed rounding in calc-rate code
  - changed email addresses to codethink one
  - fix spelling mistake(s)
  - add clk_rate_exclusive_get() to lock clock rate for now
v8:
 - updated reviewed tags
 - fix module name for pci version
 - fix config symbol bug in makefile
 - remove pci compile-test (mostly not used for pci)
 - push the compile-test into the platform/of driver
v7:
 - fixup kconfig from previous pcie changes
 - re-order kconfig to make dwc core be selected by PCI driver
 - move clk variable to patch it is used in
v6:
 - fix removal ordering of DWC_PERIOD_NS
v5:
 - fixed kconfig string error
 - merged pwm-nr into main of code
 - split of code from pci code
 - updated pwm-nr capping
 - fix duplicate error reporting in of-code
 - fix return in of-probe
 - remove unecessary remove function as devm_ functions sort this
 - fixed ordering of properties
 - added missing reg item
 - fixed missing split of the two clock sources.
 - get bus clock in of code
v4:
 - split pci and of into new modules
 - fixup review comments
 - fix typos in dt-bindings
v3:
- change the compatible name
- squash down pwm count patch
- fixup patch naming
v2:
- fix #pwm-cells count to be 3
- fix indetation 
- merge the two clock patches
- add HAS_IOMEM as a config dependency

Ben Dooks (6):
  pwm: dwc: split pci out of core driver
  pwm: dwc: make timer clock configurable
  pwm: dwc: add PWM bit unset in get_state call
  pwm: dwc: use clock rate in hz to avoid rounding issues
  pwm: dwc: round rate divisions up
  pwm: dwc: add of/platform support

 drivers/pwm/Kconfig        |  24 ++++-
 drivers/pwm/Makefile       |   2 +
 drivers/pwm/pwm-dwc-core.c | 197 ++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc-of.c   |  93 +++++++++++++++++
 drivers/pwm/pwm-dwc.c      | 198 +------------------------------------
 drivers/pwm/pwm-dwc.h      |  61 ++++++++++++
 6 files changed, 380 insertions(+), 195 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-core.c
 create mode 100644 drivers/pwm/pwm-dwc-of.c
 create mode 100644 drivers/pwm/pwm-dwc.h

-- 
2.40.1

