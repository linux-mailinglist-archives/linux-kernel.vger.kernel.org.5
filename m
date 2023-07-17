Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20747568C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjGQQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjGQQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:13:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF5F31B6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:13:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21131C15;
        Mon, 17 Jul 2023 09:14:02 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E78DF3F738;
        Mon, 17 Jul 2023 09:13:16 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        aidapala@qti.qualcomm.com, souvik.chakravarty@arm.com,
        satyakim@qti.qualcomm.com, atouzni@qti.qualcomm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/2] Introduce SCMI v3.2 PERF Indexing support
Date:   Mon, 17 Jul 2023 17:12:44 +0100
Message-ID: <20230717161246.1761777-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.41.0
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

this small series adds support for the upcoming optional support for
Performance domains Level Indexing mode.

PERF Protocol Level Indexing mode was introduced in SCMI V3.2 [1] as an
optional way to describe Performance levels using a non-linear scale.

SCMI platform can now optionally declare a Performance domain as
supporting Level Indexing and report when queried a level-index and an
indicative frequency that do not need to fit into a linear-scale.

Platform will then expect such level-indexed domain to be accessed
strictly via such indexes.

The core SCMI PERF protocol has been modified to support such indexing
transparently so that the SCMI driver using the protocol (like cpufreq)
do not need to be changed, nor are aware of such mode.

Based on v6.5-rc2.

Any feedback, welcome.

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/den0056/latest/

---
Cristian Marussi (2):
  firmware: arm_scmi: Harden PERF domain info access
  firmware: arm_scmi: Add v3.2 PERF Level Indexing mode support

 drivers/firmware/arm_scmi/perf.c | 430 +++++++++++++++++++++++++------
 1 file changed, 348 insertions(+), 82 deletions(-)

-- 
2.41.0
