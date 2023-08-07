Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35693772574
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjHGNXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjHGNWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5962699
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05E506192E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96F2C433C9;
        Mon,  7 Aug 2023 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691414544;
        bh=1kWfbb4GxKzXNt/tXBE/oL4mhC+QvFa1x0qd8EeG3pM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Blgwb6rR4No2dDMf2JYx8EX4KxN7c0zJtPp1vrhzZZGyFdPHzduM011m3r9uDXhZ7
         18dYm9kfPPPz0QgNSyylgsCyu9o97pDRav+C6ZfNuZ4zng9Nf461UM3jMVFIK/wXHo
         DRAI9bWqkXLbYJHx4YVFr9lNC7vy3d4NDduUrvUZG6c/dO0rLc9pmE3s0EnzXutqeX
         z/XCaGnbJoN8FjM7ligughXuiik7AaOYGLeAKhMQvW0e1tKY8mbvQmnOiFrp3SY9Mr
         RQAdzP5CyPI1gJr5kIibx8oLI/BSWCyko2Cb8d1fEgcOo7aV+jvrn2qvm/+YU14mzk
         I+35D0/M3gLDA==
From:   Michael Walle <mwalle@kernel.org>
Date:   Mon, 07 Aug 2023 15:21:09 +0200
Subject: [PATCH 15/41] mtd: spi-nor: add SNOR_ID() and SNOR_OTP()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230807-mtd-flash-info-db-rework-v1-15-3d3d5bef4ba4@kernel.org>
References: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-0-3d3d5bef4ba4@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all the preparation, it is now time to introduce the new macros to
specify flashes in our database: SNOR_ID() and SNOR_OTP(). An flash_info
entry might now look like:
    {
        .id = SNOR_ID(0xef, 0x60, 0x16),
        .otp = SNOR_OTP(256, 3, 0x1000, 0x1000),
        .flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
    }

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/mtd/spi-nor/core.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index e26a17d11c14..d0e83bfb847c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -559,6 +559,20 @@ struct flash_info {
 	const struct spi_nor_fixups *fixups;
 };
 
+#define SNOR_ID(...)							\
+	(&(const struct spi_nor_id){					\
+		.bytes = (const u8[]){ __VA_ARGS__ },			\
+		.len = sizeof((u8[]){ __VA_ARGS__ }),			\
+	})
+
+#define SNOR_OTP(_len, _n_regions, _base, _offset)			\
+	(&(const struct spi_nor_otp_organization){			\
+		.len = (_len),						\
+		.base = (_base),					\
+		.offset = (_offset),					\
+		.n_regions = (_n_regions),				\
+	})
+
 #define SPI_NOR_ID_2ITEMS(_id) ((_id) >> 8) & 0xff, (_id) & 0xff
 #define SPI_NOR_ID_3ITEMS(_id) ((_id) >> 16) & 0xff, SPI_NOR_ID_2ITEMS(_id)
 

-- 
2.39.2

