Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29247AC872
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjIXNRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjIXNQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:16:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6291722;
        Sun, 24 Sep 2023 06:16:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95AAC433CC;
        Sun, 24 Sep 2023 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561373;
        bh=wzC0IvBGBmYXZpg63RysFjH26qUDZbbrD9/9buPvbDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uq8OUzAa62Bw2+04qDqWqlNrZ4KU58Fmg003FduNcuQFU+zz0VkGqvsiR9MZjdbyw
         o6SCfAlWs5mh1NtALgRgq+CVjeps4HaalSR+B3ZdD1aZ60ykyPJlWQDB2cMtvY2mMZ
         9gdP33qTPGWkPesR8rNLHqtwk/Z8BAePT8HX6Tq8WmuEzEzsE092f4gAy/zBejQ36B
         8X8OeW8ae0vYTtVicBgQ/aMEr8Wzbx01zzoNtZ3HOOMSUKRFCyfLS6xTQkPADZjGZ8
         WP7slYnpyf8atXU1dTg/Nvtf3UN+LMxAYeUaNFseU3rgHCwg+CbWIYbS6dGEDOxVwB
         NigudDP/7JwgQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 19/41] ata: sata_mv: Fix incorrect string length computation in mv_dump_mem()
Date:   Sun, 24 Sep 2023 09:15:07 -0400
Message-Id: <20230924131529.1275335-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e97eb65dd464e7f118a16a26337322d07eb653e2 ]

snprintf() returns the "number of characters which *would* be generated for
the given input", not the size *really* generated.

In order to avoid too large values for 'o' (and potential negative values
for "sizeof(linebuf) o") use scnprintf() instead of snprintf().

Note that given the "w < 4" in the for loop, the buffer can NOT
overflow, but using the *right* function is always better.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/sata_mv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index d404e631d1527..68e660e4cc410 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1255,8 +1255,8 @@ static void mv_dump_mem(struct device *dev, void __iomem *start, unsigned bytes)
 
 	for (b = 0; b < bytes; ) {
 		for (w = 0, o = 0; b < bytes && w < 4; w++) {
-			o += snprintf(linebuf + o, sizeof(linebuf) - o,
-				      "%08x ", readl(start + b));
+			o += scnprintf(linebuf + o, sizeof(linebuf) - o,
+				       "%08x ", readl(start + b));
 			b += sizeof(u32);
 		}
 		dev_dbg(dev, "%s: %p: %s\n",
-- 
2.40.1

