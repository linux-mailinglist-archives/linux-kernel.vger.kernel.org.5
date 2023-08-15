Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B411677C4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjHOAsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjHOAsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D81723
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F4B564A88
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09758C433CB;
        Tue, 15 Aug 2023 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692060501;
        bh=yrWuUhf9P1ssyMUb7IbxFKryWboz4RPeuI0NifoMGno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyMUGocdqRQxXPgXekFfbwRBL0IWCSwI3QN3Boyyyo1kLtTDDptYC8VOqP0XGVVFR
         FdcESXIRYthB5KoHSAXxdzlHlsS7iHD6WYlHfuMv9u5T5npBs7AYxSLwGFmB7qKB0k
         JPN8ZVNjTRb0jXe+F/OsGHkU1MpbTMYEP7QY4D3hddo5d5jaIclct4EKo+H2oIOWTa
         aDkyjYMAje8hWAY5fNTVJvZH03L3VBRkVCt6gmkjL6gR3F2V5ls/OG8qRThAWZ/0CK
         jvmM8czZDJyX8wuO/4QdBaOFkxXssvZkz4h4jM1R82K7C8twmy/muW0ZxuZiq5xRxD
         9pyacHtJt9wwg==
From:   Vineet Gupta <vgupta@kernel.org>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 07/20] ARC: boot log: eliminate struct cpuinfo_arc #3: don't export
Date:   Mon, 14 Aug 2023 17:48:00 -0700
Message-Id: <20230815004813.555115-8-vgupta@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815004813.555115-1-vgupta@kernel.org>
References: <20230815004813.555115-1-vgupta@kernel.org>
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

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/arcregs.h | 2 --
 arch/arc/kernel/mcip.c         | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arc/include/asm/arcregs.h b/arch/arc/include/asm/arcregs.h
index cb1ad1bb4ece..160ee3fab1bd 100644
--- a/arch/arc/include/asm/arcregs.h
+++ b/arch/arc/include/asm/arcregs.h
@@ -384,8 +384,6 @@ struct cpuinfo_arc {
 	struct bcr_mpy extn_mpy;
 };
 
-extern struct cpuinfo_arc cpuinfo_arc700[];
-
 static inline int is_isa_arcv2(void)
 {
 	return IS_ENABLED(CONFIG_ISA_ARCV2);
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index f9fdb557c263..55373ca0d28b 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -165,8 +165,6 @@ static void mcip_probe_n_setup(void)
 		IS_AVAIL1(mp.idu, "IDU "),
 		IS_AVAIL1(mp.dbg, "DEBUG "),
 		IS_AVAIL1(mp.gfrc, "GFRC"));
-
-	cpuinfo_arc700[0].extn.gfrc = mp.gfrc;
 }
 
 struct plat_smp_ops plat_smp_ops = {
-- 
2.34.1

