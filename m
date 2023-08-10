Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99335777A76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjHJOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjHJOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51B1B4;
        Thu, 10 Aug 2023 07:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A951165D8B;
        Thu, 10 Aug 2023 14:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38266C433C7;
        Thu, 10 Aug 2023 14:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677308;
        bh=I6IRExNYqo8UBCebkpvu5GaQ8IK18y0eKaizpHUnkOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ucGTS2xqPZOWGCOiL4qxDpX0/atupBXJSJsS5X0BeogQKCNK8mvO/s4zrFaS4mdV0
         4tRS00rUtYhZhqPBbVEq1nsrbkQ1lt/oByUyVv8gIa93XrULsHAJ3F29gm/xewTMwR
         BgZW94H8UYDjdvEN0+i9td4FcSHiSTouaX1nEmc/+6yQVdHlByuG/ymqJLmZFCX7Nn
         +2Bbbn3jlVg+XriGkRnzx2yjy0H0humi2wKvisIDQndBVATh9ziQdP56sdpDmsiQLB
         Gwnn9FXohCKRlMe5ku8CdWsDG2Wg8n5zTbQZHGafcNW1LhhT13CEgUolsiV3XJJ+M0
         KjgcMyLswfCGw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>, linux-block@vger.kernel.org
Subject: [PATCH 05/17] swim3: mark swim3_init() static
Date:   Thu, 10 Aug 2023 16:19:23 +0200
Message-Id: <20230810141947.1236730-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

This is the module init function, which by definition is used only
locally, so mark it static to avoid a warning:

drivers/block/swim3.c:1280:5: error: no previous prototype for 'swim3_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/swim3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index dc43a63b34694..c2bc85826358e 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1277,7 +1277,7 @@ static struct macio_driver swim3_driver =
 };
 
 
-int swim3_init(void)
+static int swim3_init(void)
 {
 	macio_register_driver(&swim3_driver);
 	return 0;
-- 
2.39.2

