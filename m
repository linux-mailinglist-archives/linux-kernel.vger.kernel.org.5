Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE29F750EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjGLQtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGLQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:49:33 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553931994;
        Wed, 12 Jul 2023 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689180568;
        bh=TN+gHkELlE+b7fR0rsA8ykrqd1Qxd9ihZcJeUSe8JKc=;
        h=From:To:Cc:Subject:Date;
        b=ozT6paZYQObN7vfys5Y0IfELpbYRfsM5bjx+QwU/Qy7jE74sFmDefv/gTudUR2UVl
         lYKb7M4s7OsyoN945BIAGCx+bhH8HJ8iKUWT0FTXAa9UA3jcOmje4OvLxIFT45gz/T
         C1fbUxTkLi2uJ/G4xJlV8TM++J/AbB6287I95MAU=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id B8689CAB; Thu, 13 Jul 2023 00:46:06 +0800
X-QQ-mid: xmsmtpt1689180366tk232dq7r
Message-ID: <tencent_E2C71605D88087940237AA9A44CC8D436D06@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrAHz5k0LvYgpFo53uVrs3ixagjYrz1delAqK0lUOiGT7kYeLTw5
         vwsPOASdUqbt5Op4YVNUFvBGi81Oi9ornl5eYajOYw7Yfw2Xm4KNgtmhrCY6d3M2hVxIfDwHb8XW
         tNtRkbodUq3NsYvpeep1uwtO3xu1KPCHtKc8cY54+woRimhn/od0OqA+L2LKjNkAi3Wm9MpoFo0X
         VydP7sMl45lSOaE9zxcnVN15jFKYVoMlMKyBPi3ZS7q451HPutjru0hqZF+pyBlQ8f6Ux1cbCJBZ
         8EZHUO/4NqC8G8pUMndEAUVjRhIWzyvoQa0Ms1ddjThNtWcPBs+rHKG2q3qQUEq7Tk26XUG1NQkD
         Ltd1roAH3wMdTU8T14BNts+9Q2bBrzI1LNHh3Bk2jkqv7vcq9vRL/WMeBLoTfO4CtZVYciYh82nv
         vOu1s8yny1dlNOBkI2XS+KT2SHDprA2yo0W5bbsRg/MEVNhva79Yb7k7zzCsqSJ+bQvb+yPgNHIC
         J4vpRq2qbK+966Ogg0rAN/NkKeQGCchNMvRHu6pZwLMD2gmKdn0/NHqRNi2cNm9XB5r0UR81QRq1
         4jl2BP2LXaOTZ6WScRlEFhgtM5/JIhlxzxItl0vcpNIeJnSpViO8yIXG78AjNQIILvBUO1YjPmSH
         DwmsZDnsQrvtrmusl1COI7BoUnm3aAXY/SYRUg2R9HkEArnyiuKAwIfTPn1sZfhTmYDaRmoAqysM
         5WBhXX8evrxPQdoeiogt/4Ps2m5u7P1pZpsjn/GAkGqcxovSaYQNf5mF45W84kHTzQcqQj8ywp93
         8bcvEDGNsV7LJDUcYd05ytWcTTTTDaUNxwa6l00ftGnvH8qL0TVhqD1hAbydDNM4qRdngB+c8sba
         RO6pfIBVLLwJ2N9z+yvifFaKK+JVd4FH5JqIX2LzF3Kh1wwl8279wtI+B/jfTIMHx7ZC5PSzhM4n
         2B+Rq0oFZHnGTEnl648gAruKmPGCbuNZYxT8iYq0w=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] md: fix potential OOB in multipath_remove_disk()
Date:   Thu, 13 Jul 2023 00:46:05 +0800
X-OQ-MSGID: <20230712164605.3902883-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rddev->raid_disk is greater than mddev->raid_disks, there will be
an out-of-bounds in multipath_remove_disk. We have already found
similar reports as follows:

1) commit d17f744e883b ("md-raid10: fix KASAN warning")
2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")

Fix this bug by checking whether the "number" variable is
valid.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/md/md-multipath.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 92c45be203d7..7b6aadd8c1fb 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -245,7 +245,11 @@ static int multipath_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct mpconf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
-	struct multipath_info *p = conf->multipaths + number;
+	struct multipath_info *p;
+
+	if (unlikely(number >= mddev->raid_disks))
+		return 0;
+	p = conf->multipaths + number;
 
 	print_multipath_conf(conf);
 
-- 
2.30.2

