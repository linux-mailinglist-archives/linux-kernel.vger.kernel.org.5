Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7AF7D4E60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjJXK5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjJXK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:57:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E3DA128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:57:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0CCC2F4;
        Tue, 24 Oct 2023 03:57:59 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D0E03F64C;
        Tue, 24 Oct 2023 03:57:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] firmware: arm_ffa: Declare ffa_bus_type structure in the header
Date:   Tue, 24 Oct 2023 11:57:15 +0100
Message-ID: <20231024105715.2369638-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.42.0
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

smatch reports:
drivers/firmware/arm_ffa/bus.c:108:17: warning:
	symbol 'ffa_bus_type' was not declared. Should it be static?

ffa_bus_type is exported to be useful in the FF-A driver. So this
warning is not correct. However, declaring the ffa_bus_type structure
in the header like many other bus_types do already removes this warning.
So let us just do the same and get rid of the warning.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arm_ffa.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 1abedb5b2e48..3d0fde57ba90 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -209,6 +209,8 @@ bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
 #define module_ffa_driver(__ffa_driver)	\
 	module_driver(__ffa_driver, ffa_register, ffa_unregister)
 
+extern struct bus_type ffa_bus_type;
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
-- 
2.42.0

