Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67349752AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjGMT3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjGMT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:29:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B592680;
        Thu, 13 Jul 2023 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1689276584;
        bh=Xho1RRU1A/ibhnVnCa6aEvzSgVmvXCiwnrryRlLF1wc=;
        h=From:Date:Subject:To:Cc:From;
        b=WLHmHuCAc9Bxhf82Qu5ylY+J6JNyIeCoo5z4Bn/bkvsjG5ZFBWa2A2zXmM1C87Rwo
         pX94ZmRRb8TKu98r0SDwx/Xzm5J3VTTVsMM0H5nvUeXecUX6+907xd9nU4iogCUZX4
         9Qg/tH+uXTjymkIeryuGu5wlwNQP8+fDyjsFpbpM=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Thu, 13 Jul 2023 21:29:35 +0200
Subject: [PATCH v3] nbd: automatically load module on genl access
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJ5QsGQC/22OQQ6CMBREr2K69hv6W7C48h6GRVu+tAkW0wJiC
 He3mrgxLt8k82ZWlih6Suy0W1mk2Sc/hAxiv2PW6dAR+DYzwwJFgSjASAimhY5CD0IfpdWVUJW
 qWG4YnQhM1MG63AlT3+fwHunql8/Epcl8jcMNRhdJf8XIOS+KEqVQB+RKAYfeh2k5P8inlKyb3
 CHQ+F5wPo1DfH7uzvhW/n82Y5ZUslRlW1uSpv51Ndu2vQAOXMeQ/QAAAA==
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689276583; l=1914;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xho1RRU1A/ibhnVnCa6aEvzSgVmvXCiwnrryRlLF1wc=;
 b=YSMNsgom1VNydhyc2/0PBTrm3KK9NElllnflH0x4429UnzwKvfEyztkNwQjdzm4Li+nhO0IvI
 KKKVR2imMcwCqsNjhBAEBOZSHDWNXgqyG3IX4zLXWcQEi+KN3cdxCW8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module alias to nbd.ko that allows the generic netlink core to
automatically load the module when netlink messages for nbd are
received.

This frees the user from manually having to load the module before using
nbd functionality via netlink.
If the system policy allows it this can even be used to load the nbd
module from containers which would otherwise not have access to the
necessary module files to do a normal "modprobe nbd".

For example this avoids the following error when using nbd-client:

$ nbd-client localhost 10809 /dev/nbd0
...
Error: Couldn't resolve the nbd netlink family, make sure the nbd module is loaded and your nbd driver supports the netlink interface.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Resend to gain some reviews
- Expand commit message
- Drop additional reviewers again
- Cc Christoph as reviewer, as he recently reviewed NBD stuff
- Link to v2: https://lore.kernel.org/r/20230223-b4-nbd-genl-v2-1-64585d9ce4b9@weissschuh.net

Changes in v2:
- Expand Cc list to get some reviews
- Add concrete commit example to commit message
- Link to v1: https://lore.kernel.org/lkml/20221110052438.2188-1-linux@weissschuh.net/
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8576d696c7a2..a346dbd73543 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2336,6 +2336,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
 	.mcgrps		= nbd_mcast_grps,
 	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
 };
+MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
 
 static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
 {

---
base-commit: eb26cbb1a754ccde5d4d74527dad5ba051808fad
change-id: 20230223-b4-nbd-genl-3a74ca638686

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

