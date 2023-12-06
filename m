Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596668068BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjLFHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjLFHiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73E71BEA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02493C433CD;
        Wed,  6 Dec 2023 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848272;
        bh=ca5oZR3Z/IhdfX0APKb53oRCnzdx5d5CBkRj2hy/ASY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BMhtaGNOBrG38TV6foFHCSkoltzMauWUjoUeaDVHPuRG8fMUsJBWAbDf8DxOwYWts
         SEjxd9hgOVGcJd9cQQXU+EkIp9JecT14LGBqg49oZ1aQ4nrnjgX2yUkvGhjqEjOyl5
         fCEuFl8yJjhobXfbHjZ3T+hdm/l7yePI6kZpUMv8zTc09eMWEtbUZ7Ai/pWm/BZMXH
         1uL++wmUkvTq83AWv0WnTpGswnflvG8SSnZQsDxRLOpS6zW1sDrccjAw30SeZRX9p/
         xNwQT14M4vLmtx1kayXlmakvhQcYJ1PcqropU7yczRj/Xi9NYDj4unJgGD7veOaCGU
         fQ5qCACVPjksQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 15/27] tty: mips_ejtag_fdc: use u8 for character pointers
Date:   Wed,  6 Dec 2023 08:37:00 +0100
Message-ID: <20231206073712.17776-16-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mips_ejtag_fdc_encode() and mips_ejtag_fdc_put_chan() declare arrays of
pointers to characters. Switch their types from char to u8 to conform
to the current tty layer types for characters.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/mips_ejtag_fdc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 369ec71c24ef..aac80b69a069 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -213,16 +213,16 @@ struct fdc_word {
  */
 
 /* ranges >= 1 && sizes[0] >= 1 */
-static struct fdc_word mips_ejtag_fdc_encode(const char **ptrs,
+static struct fdc_word mips_ejtag_fdc_encode(const u8 **ptrs,
 					     unsigned int *sizes,
 					     unsigned int ranges)
 {
 	struct fdc_word word = { 0, 0 };
-	const char **ptrs_end = ptrs + ranges;
+	const u8 **ptrs_end = ptrs + ranges;
 
 	for (; ptrs < ptrs_end; ++ptrs) {
-		const char *ptr = *(ptrs++);
-		const char *end = ptr + *(sizes++);
+		const u8 *ptr = *(ptrs++);
+		const u8 *end = ptr + *(sizes++);
 
 		for (; ptr < end; ++ptr) {
 			word.word |= (u8)*ptr << (8*word.bytes);
@@ -417,7 +417,7 @@ static unsigned int mips_ejtag_fdc_put_chan(struct mips_ejtag_fdc_tty *priv,
 {
 	struct mips_ejtag_fdc_tty_port *dport;
 	struct tty_struct *tty;
-	const char *ptrs[2];
+	const u8 *ptrs[2];
 	unsigned int sizes[2] = { 0 };
 	struct fdc_word word = { .bytes = 0 };
 	unsigned long flags;
-- 
2.43.0

