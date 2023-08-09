Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68C77602C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHINFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjHINFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:05:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2A010C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17B1162234
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDC0C433C8;
        Wed,  9 Aug 2023 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691586341;
        bh=/2+Rz/4Mvfb+BTdnPW9lmX19HjJ0G8O8R9zMJDuyBek=;
        h=From:To:Cc:Subject:Date:From;
        b=El283Dsh+ETqywhxKk2pJNZd4qRbnrQsW3Qq49zWUuI98/i7y8XBUnVuLJouYvyrC
         +XBRXtSDr4fFpupyR6h7WWO2KrqvX1yTm4UvhjIEONtQOlCpFKUsjNCQvs9IvgAi6m
         mhb2Q03/Pq/UDSIxwNDOPVurH8ccIIrkSMzBgR1Pmow9wRYzpBUd921YM2lLf70cOw
         c1B7Pxf0q/WuMMQX1C8OcGRb0LwMNrvmLPBppE7gFHz5NVKy915DFOja0gFIaBr4cz
         Hvno4r9X5XCNxgBd9HhYb82AXQUr8ptx8kfXK0WDk/3yt7cDdUphCIhFZp6XkHi2j6
         HrMVLtVHU1Afw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/speculation: add cpu_show_gds() prototype
Date:   Wed,  9 Aug 2023 15:04:59 +0200
Message-Id: <20230809130530.1913368-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The newly added function has two definitions but no prototypes:

drivers/base/cpu.c:605:16: error: no previous prototype for 'cpu_show_gds' [-Werror=missing-prototypes]

Add a declaration next to the other ones for this file to avoid the
warning.

Fixes: 8974eb588283b ("x86/speculation: Add Gather Data Sampling mitigation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/cpu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 9d43b734170d6..0abd60a7987b6 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -73,6 +73,8 @@ extern ssize_t cpu_show_retbleed(struct device *dev,
 				 struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_gds(struct device *dev,
+			    struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-- 
2.39.2

