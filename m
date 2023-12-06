Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CC1806DF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbjLFLaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377688AbjLFLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0556A137;
        Wed,  6 Dec 2023 03:30:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4333EC15;
        Wed,  6 Dec 2023 03:31:30 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECD243F5A1;
        Wed,  6 Dec 2023 03:30:42 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 0/5] Add callback for cooling list update to speed-up IPA
Date:   Wed,  6 Dec 2023 11:31:33 +0000
Message-Id: <20231206113138.3576492-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The patch set a new callback for thermal governors and implementation for
Intelligent Power Allocator.

The goal is to move the memory allocations and heavy computations
(multiplications) out of throttle() callback hot path.

In addition there are some small clean-ups for IPA code.

Regards,
Lukasz

Lukasz Luba (5):
  thermal: core: Add callback for governors with cooling instances
    change
  thermal: gov_power_allocator: Refactor check_power_actors()
  thermal: gov_power_allocator: Move memory allocation out of throttle()
  thermal: gov_power_allocator: Simplify checks for valid power actor
  thermal: gov_power_allocator: Refactor checks in divvy_up_power()

 drivers/thermal/gov_power_allocator.c | 202 +++++++++++++++++---------
 drivers/thermal/thermal_core.c        |  14 ++
 include/linux/thermal.h               |   4 +
 3 files changed, 154 insertions(+), 66 deletions(-)

-- 
2.25.1

