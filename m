Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014180EDFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346677AbjLLNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjLLNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:47:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D058100;
        Tue, 12 Dec 2023 05:47:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42004143D;
        Tue, 12 Dec 2023 05:48:43 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0E613F738;
        Tue, 12 Dec 2023 05:47:55 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH v2 0/8] Add callback for cooling list update to speed-up IPA
Date:   Tue, 12 Dec 2023 13:48:36 +0000
Message-Id: <20231212134844.1213381-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch set a new callback for thermal governors and implementation for
Intelligent Power Allocator.

The goal is to move some heavy operarions like the memory allocations and heavy
computations (multiplications) out of throttle() callback hot path.

The new callback is generic enough to handle other imporants update events.
It re-uses existing thermal_notify_event definitions.

In addition there are some small clean-ups for IPA code.

changes:
v2:
- change callback name to update_tz() and add parameter (Rafael)
- added new event to trigger this callback - instance 'weight' update

Regards,
Lukasz

Lukasz Luba (8):
  thermal: core: Add governor callback for thermal zone change
  thermal: gov_power_allocator: Refactor check_power_actors()
  thermal: gov_power_allocator: Move memory allocation out of throttle()
  thermal: gov_power_allocator: Simplify checks for valid power actor
  thermal: gov_power_allocator: Refactor checks in divvy_up_power()
  thermal/sysfs: Update instance->weight under tz lock
  thermal/sysfs: Update governors when the 'weight' has changed
  thermal: gov_power_allocator: Support new update callback of weights

 drivers/thermal/gov_power_allocator.c | 216 ++++++++++++++++++--------
 drivers/thermal/thermal_core.c        |  13 ++
 drivers/thermal/thermal_sysfs.c       |  15 ++
 include/linux/thermal.h               |   6 +
 4 files changed, 182 insertions(+), 68 deletions(-)

-- 
2.25.1

