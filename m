Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3D7E90EB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjKLNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjKLNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:34:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3579A5B8C;
        Sun, 12 Nov 2023 05:29:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A042EC433C7;
        Sun, 12 Nov 2023 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795757;
        bh=Rzp08aZ8nm+7xUJ3NGlETYc2bZ7eb98RZEd1aCaPi/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g4OQgHqhCLftbg9ANWHXRxML6CNObSl5FrN7K1B5M60RmW/xZXKLLzE4e7MBZLW3j
         iVGIyVeShX0K2TzGn0ejxSX7BaTFDV9t8nuII8zQEHJl+6YEkoxdxEUimcYfG3Et/T
         6/RDGvghbJ2xxWcfCcrLQ/dYgZvmBC9qu4SJreICQ+NrI22jNlo0vHBXNe9ySASsDy
         RhjZq+TQ1HUjAysX5KqZnRRDTCV+rh82/bf2NA/uvLDTNE9n0ZqHgKaPQbDUC5nbHg
         MHiXMKmKwJa9P6d4N0aGTKpPmr2dthJR9Bs3E0Y8uQ3KCm1Q6c+5cr3lPpZqLnhkwW
         L5/HbALJg/k+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        hverkuil@xs4all.nl, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/5] media: vivid: avoid integer overflow
Date:   Sun, 12 Nov 2023 08:29:09 -0500
Message-ID: <20231112132913.176824-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132913.176824-1-sashal@kernel.org>
References: <20231112132913.176824-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.298
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 4567ebf8e8f9546b373e78e3b7d584cc30b62028 ]

Fixes these compiler warnings:

drivers/media/test-drivers/vivid/vivid-rds-gen.c: In function 'vivid_rds_gen_fill':
drivers/media/test-drivers/vivid/vivid-rds-gen.c:147:56: warning: '.' directive output may be truncated writing 1 byte into a region of size between 0 and 3 [-Wformat-truncation=]
  147 |         snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
      |                                                        ^
drivers/media/test-drivers/vivid/vivid-rds-gen.c:147:52: note: directive argument in the range [0, 9]
  147 |         snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
      |                                                    ^~~~~~~~~
drivers/media/test-drivers/vivid/vivid-rds-gen.c:147:9: note: 'snprintf' output between 9 and 12 bytes into a destination of size 9
  147 |         snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  148 |                  freq / 16, ((freq & 0xf) * 10) / 16);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vivid/vivid-rds-gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/vivid/vivid-rds-gen.c b/drivers/media/platform/vivid/vivid-rds-gen.c
index 39ca9a56448c0..9f6009ac5e255 100644
--- a/drivers/media/platform/vivid/vivid-rds-gen.c
+++ b/drivers/media/platform/vivid/vivid-rds-gen.c
@@ -145,7 +145,7 @@ void vivid_rds_gen_fill(struct vivid_rds_gen *rds, unsigned freq,
 	rds->ta = alt;
 	rds->ms = true;
 	snprintf(rds->psname, sizeof(rds->psname), "%6d.%1d",
-		 freq / 16, ((freq & 0xf) * 10) / 16);
+		 (freq / 16) % 1000000, (((freq & 0xf) * 10) / 16) % 10);
 	if (alt)
 		strlcpy(rds->radiotext,
 			" The Radio Data System can switch between different Radio Texts ",
-- 
2.42.0

