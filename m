Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574687F5340
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344660AbjKVWSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjKVWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4DD50
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:18:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02699C433C9;
        Wed, 22 Nov 2023 22:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700691506;
        bh=z8B55/ejcoe2WW+RVahNts4dxuwsQAuxIT3oPjNu21M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=laW49S+9ECP9y1T3wKde/cIOj+JYD94ZcV2pI72RtAoICnQozqPsFxDWdxqSrefDs
         ZjJqCBW5+z6y6DzbG/csYQ6qH+PKfJG30uVSgEA5HoqOs885iuMwXWhUKNjPsAwbdw
         XxvuGpQBeGw7woppvooV/6F5QcCuM+r8430xkQV5fEQ3z29cskCKuvxCiK6dt3ldAO
         qaVCT/uPkCtPeBI2ntkUjI5j8N8ms+wmJIo8CjN8FD9esa5RfFYHm3KKeJJfq4DzBB
         ppL8aFHiNtClGNGSAJOItlB/hWNweuQwonVMF7Ot9M2RAfSPlcInsxxZjHopGYk+fw
         Q2mrXvH3TOBDQ==
From:   deller@kernel.org
To:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-modules@vger.kernel.org,
        linux-arch@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 4/4] modules: Add missing entry for __ex_table
Date:   Wed, 22 Nov 2023 23:18:14 +0100
Message-ID: <20231122221814.139916-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122221814.139916-1-deller@kernel.org>
References: <20231122221814.139916-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

The entry for __ex_table was missing, which may make __ex_table
become 1- or 2-byte aligned in modules.
Add the entry to ensure it gets 32-bit aligned.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v6.0+
---
 scripts/module.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index b00415a9ff27..488f61b156b2 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -26,6 +26,7 @@ SECTIONS {
 	.altinstructions	0 : ALIGN(8) { KEEP(*(.altinstructions)) }
 	__bug_table		0 : ALIGN(8) { KEEP(*(__bug_table)) }
 	__jump_table		0 : ALIGN(8) { KEEP(*(__jump_table)) }
+	__ex_table		0 : ALIGN(4) { KEEP(*(__ex_table)) }
 
 	__patchable_function_entries : { *(__patchable_function_entries) }
 
-- 
2.41.0

