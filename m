Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB177941C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjHKQPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHKQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4394F2722
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:15:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7E2113E;
        Fri, 11 Aug 2023 09:16:34 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68E1D3F64C;
        Fri, 11 Aug 2023 09:15:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@linaro.org, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/6] Add SCMI v3.2 Clock new CONFIGs support
Date:   Fri, 11 Aug 2023 17:14:40 +0100
Message-ID: <20230811161446.636253-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this small series introduces support for the new Clock CONFIG features
added by SCMI v3.2 specification [1].

It does NOT add support, still, for the SCMI v3.2 Clock reparenting
features added in v3.2 too.

After a small refactoring in [1/6], support for the new CONFIG_SET message
format is added in [2/6]: this is just internal rework to support new and
legacy (pre-v3.2) message formats.

Patch [3/6] adds support for the new v3.2 CONFIG_GET command and adds a new
related Clock operation .state_get() to retrieve the enabled state of one
clock when talking to a v3.2 compliant server.

Patch [4/6] extend .state_get() support to legacy SCMI platforms implementing
pre-v3.2 SCMI stacks: in such a scenario we can use the old CLOCK_ATTRIBUTES
command to retrieve the clock state.

Patch [5/6] finally wires up this new .state_get() clock operation to the
Linux Clock framework .is_enabled() callback, AS-LONG-AS the underlying
configured SCMI stack supports atomic operations. (since .is_enabled() is
required not to sleep)
This *should* ease unused clocks management by the Linux Clock framework.

Last but not least, patch [6/6] exposes a couple more SCMI Clock operations
in order to be able to set/get OEM specific clock configuration values as
described in SCMI v3.2 specification; it is marked as RFC since, even
though trivial and tested in emulation, there are really at the moment NO
real users for these new OEM-related clock operations.

Tested on JUNO and on an SCMI emulation setup.

Based on v6.5-rc5.

Any feedback welcome,

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/den0056/e

Cristian Marussi (6):
  firmware: arm_scmi: Simplify enable/disable Clock operations
  firmware: arm_scmi: Add Clock v3.2 CONFIG_SET support
  firmware: arm_scmi: Add v3.2 Clock CONFIG_GET support
  firmware: arm_scmi: Add Clock .state_get support to pre-v3.2
  clk: scmi: Add support for .is_enabled clk_ops
  [RFC] firmware: arm_scmi: Add Clock OEM config clock operations

 drivers/clk/clk-scmi.c            |  31 ++++-
 drivers/firmware/arm_scmi/clock.c | 220 +++++++++++++++++++++++++++---
 include/linux/scmi_protocol.h     |  19 ++-
 3 files changed, 240 insertions(+), 30 deletions(-)

-- 
2.41.0
