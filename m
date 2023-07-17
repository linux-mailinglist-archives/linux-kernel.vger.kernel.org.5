Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFBF7561B9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGQLjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0B210D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:39:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DD861035
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1033BC433C8;
        Mon, 17 Jul 2023 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689593943;
        bh=/LUotkDu9wlzE45PdbGWcJCQ5L4CSNfElYxk8TO6vCI=;
        h=From:To:Cc:Subject:Date:From;
        b=P+ySTB5didfyzzXsiG/y99ElIssPISga7PDv7MqVY93RvJF1k3/dyNe9n926RaSkz
         6q7hPmTY3LkbS4G3LglQ4MvLYgXiTERvur3lLm0tN1pq2kJwySym/MI5jVMNKJCITq
         vW0J/2ZDr63MbyWwtYdd57d05oGaaSWwOq3xJyBgBw88LpXCZhZAft6eb9Iuix+Iur
         84iyJAsnfi3NTVYyk5+XuaQ/uviXFDXinBToZZ7lH34xtEq2UF//48hUrkygZ1z2yM
         z7ULgoz0JsnIXwIzZzg4Vn1DIqVVKE5FXaCNarMZ/1WgmTgINNjqLYr1/1fOEzeL7z
         F3eqDFxUDpgAw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qLMZA-00DiO6-QQ;
        Mon, 17 Jul 2023 12:39:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Kunkun Jiang <jiangkunkun@huawei.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        wanghaibin.wang@huawei.com, Zenghui Yu <yuzenghui@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip fixes for 6.5, take ]1
Date:   Mon, 17 Jul 2023 12:38:57 +0100
Message-Id: <20230717113857.304919-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, florian.fainelli@broadcom.com, jonas.gorski@gmail.com, jiangkunkun@huawei.com, lpieralisi@kernel.org, philmd@linaro.org, sebastian.reichel@collabora.com, wanghaibin.wang@huawei.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's a small set of irqchip fixes for 6.5. Two workarounds for
broken HW, and pair of bug fixes.

Please pull,

	M.

The following changes since commit a82f3119d543406ed5b242deabf83cdecb9fe523:

  Merge branch irq/misc-6.5 into irq/irqchip-next (2023-06-21 13:53:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-6.5-1

for you to fetch changes up to 6fe5c68ee6a1aae0ef291a56001e7888de547fa2:

  irqchip/gic-v3: Workaround for GIC-700 erratum 2941627 (2023-07-11 09:04:31 +0100)

----------------------------------------------------------------
irqchip fixes for 6.5, take #1

- Work around an erratum on GIC700, where a race between a CPU
  handling a wake-up interrupt, a change of affinity, and another
  CPU going to sleep can result in a lack of wake-up event on the
  next interrupt.

- Fix the locking required on a VPE for GICv4

- Enable Rockchip 3588001 erratum workaround for RK3588S

- Fix the irq-bcm6345-l1 assumtions of the boot CPU always be
  the first CPU in the system

----------------------------------------------------------------
Jonas Gorski (1):
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Workaround for GIC-700 erratum 2941627

Marc Zyngier (1):
      irqchip/gic-v4.1: Properly lock VPEs when doing a directLPI invalidation

Sebastian Reichel (1):
      irqchip/gic-v3: Enable Rockchip 3588001 erratum workaround for RK3588S

 Documentation/arm64/silicon-errata.rst |  3 ++
 drivers/irqchip/irq-bcm6345-l1.c       | 14 +++---
 drivers/irqchip/irq-gic-v3-its.c       | 78 +++++++++++++++++++++-------------
 drivers/irqchip/irq-gic-v3.c           | 62 ++++++++++++++++++++++++++-
 4 files changed, 117 insertions(+), 40 deletions(-)
