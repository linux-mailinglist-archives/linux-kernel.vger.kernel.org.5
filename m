Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927157CB9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjJQFXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQFXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:23:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8326FA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:23:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EE751FB;
        Mon, 16 Oct 2023 22:24:12 -0700 (PDT)
Received: from u200865.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CD13F5A1;
        Mon, 16 Oct 2023 22:23:31 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/3] arm64: cpufeatures: Display enabled cores
Date:   Tue, 17 Oct 2023 00:23:19 -0500
Message-ID: <20231017052322.1211099-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMU feature can be enabled on a subset of the cores in a system.
Because of that, it prints a message for each core as it is detected.
This becomes tedious when there are hundreds of cores. Instead, for
CPU features which can be enabled on a subset of the present cores,
lets wait until update_cpu_capabilities() and print the subset of cores
the feature was enabled on.

Since the infrastructure now exists to display the subset of cores
where a feature is enabled, lets also enable it for the Dirty Bit Management
and 32-bit EL0. The 32-bit EL0 patch is only lightly tested as the AEM/TFA
model firmware doesn't like mismatched AARCH32 support. Its also the least
ugly version of the three or so options I considered.

v1->v2:
	Add DBM and 32-bit EL0 code so they now display the core subset
	Add Ionela Voinescu review/testing tags
	Small comment tweak in the first patch

Jeremy Linton (3):
  arm64: cpufeature: Display the set of cores with a feature
  arm64: cpufeature: Change DBM to display enabled cores
  arm64: cpufeature: Change 32-bit EL0 to display enabled cores

 arch/arm64/include/asm/cpufeature.h |  2 +
 arch/arm64/kernel/cpufeature.c      | 70 ++++++++++++++---------------
 2 files changed, 36 insertions(+), 36 deletions(-)

-- 
2.41.0

