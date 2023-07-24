Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0AA75E671
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGXBUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGXBUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7E1BB;
        Sun, 23 Jul 2023 18:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F61760F05;
        Mon, 24 Jul 2023 01:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123EC433C7;
        Mon, 24 Jul 2023 01:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161517;
        bh=Gm7xMPFN6RJVQ+Wp6OwKlm6mqZ19x2ksKi4VSKNYyFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8haTTgwnKbs/GeUkvRYMRYmlPVTzngCPso7ejazfr2JnadFzn0xRFZFv/i1TyAp1
         en+X50i/+MMCgZyGp1JEnWwyGK5n2Jw5YMyw+7KLCW4nu1RNn0UfLLw31a8IFi+Dm1
         tvqtiimp1HejkbgabEUvayUA0xHbEFY4QhxjZtpPMm4Os7Cg0TQMZZHpdi5mWNN5Cq
         NqDKAbHcS790z3MLVkTphlgTwlSxoaYiEsf6OnW0kCBuWUfUtlYvX4DWzsMMsbGeOw
         KT6EuP2iU/wvYpVXQOmf2KVsmuzRy3Rkq0U9Og3aAtTVhub865ez9UHmiNHsvvakvq
         Jxt1fnAidxapg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>, obitton@habana.ai,
        ttayar@habana.ai, kelbaz@habana.ai, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 32/58] accel/habanalabs: fix mem leak in capture user mappings
Date:   Sun, 23 Jul 2023 21:13:00 -0400
Message-Id: <20230724011338.2298062-32-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724011338.2298062-1-sashal@kernel.org>
References: <20230724011338.2298062-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

[ Upstream commit 314a7ffd7c196b27eedd50cb7553029e17789b55 ]

This commit fixes a memory leak caused when clearing the user_mappings
info when a new context is opened immediately after user_mapping is
captured and a hard reset is performed.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/habanalabs_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 1ec97da3dddb8..70fb2df9a93b8 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -13,6 +13,7 @@
 
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/vmalloc.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/habanalabs.h>
@@ -218,6 +219,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 
 	hl_debugfs_add_file(hpriv);
 
+	vfree(hdev->captured_err_info.page_fault_info.user_mappings);
 	memset(&hdev->captured_err_info, 0, sizeof(hdev->captured_err_info));
 	atomic_set(&hdev->captured_err_info.cs_timeout.write_enable, 1);
 	hdev->captured_err_info.undef_opcode.write_enable = true;
-- 
2.39.2

