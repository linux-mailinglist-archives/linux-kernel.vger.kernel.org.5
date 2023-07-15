Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61988754A0A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGOQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:11:54 -0400
X-Greylist: delayed 23213 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 15 Jul 2023 09:11:52 PDT
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30FDE6;
        Sat, 15 Jul 2023 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689437510;
        bh=s8ks3eeSwdZP/kAw1Tm5QXkjwLsrga9OXBVdd5sCVWM=;
        h=From:To:Cc:Subject:Date;
        b=MTuirVGLwssBMzA09M5cE5xzd0vZo/2Il3LDpBS5UWBghYl3MSgHT8/Id5Yh57iJc
         aKj8q2WGRqrk3Vt0yw94kHSyS3+0BR0xxEgLU5KZomwxHvSklpP0211fudcLKS5azf
         Mq2tWvRpcP/dStMC2Tct0FAgd46KizdRfnauEOJI=
Received: from KernelDevBox.byted.org ([180.184.51.134])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 2F092871; Sun, 16 Jul 2023 00:11:48 +0800
X-QQ-mid: xmsmtpt1689437508thdkej1ho
Message-ID: <tencent_59C6505725F46EF26BE7B6E8C0363C2A1509@qq.com>
X-QQ-XMAILINFO: OIRGbLfEqjt/FC1bMx7byz9CDecV/+cSbj+TnCoJoHDoaOAYGVQWbUG6F5IaEr
         tAERtQujzzG/mm0X3qoEoqgxjV6PbIe5r62sofdurWH6LBdgV7dJURO4m68o1EQV/DQOo3F56un4
         3BrrOH3yMS6/4xbgSck5FO1jHFsKrlwLRJYK2lY7ls/bFrWLsydnyaZiLrO5E0/EBjm+WfL6yvlN
         fZok+ezeA7MXJGl/0U+1lkXVZsPqf6GQqNw3XoaqOuZCY4jc7eEC+TqCYkhwugA5JIzC8BYTKCHt
         aUPk4AOk1rrAbsJuR00v9btkiNA7Qvk4hCCQu02ooCdLUP3toxirbV/2Ie+O+SSob9VF6s1fvRUa
         DKnJxfivL1zedysTQ+hAWvtk9gF6lTXM7N1qXiWLqt5UwC21kPGA4DoCZ/8YlG22MEwk5/BgzdBw
         zF2snQ0piBZEvOHb62yZkMZBeVik2IlFIBg7FUfn/buBdRSJvLytzO/od6FpMqYI+tQkfeK+PKoW
         DF38Xlp/ktEYrww423SjS46Ps0C5Gh25mTzYHLLj9bJq9HqC/EiT4Vfd9Ta6OFLSDG9E9ofh52uS
         ibk2mPFMc203KdKMVHmOz2uu/ZICmwpSfkUcKhzMSvan/nNXSNOGidOnaXw2EWaEGrh/W0ryekeO
         Jk6wfXTHItBP03Wo2phWTEKPw0iq2P3E6ELdnaUSDncFPfgH/ZQiU++ED3UYgVN3pSAJYYMRKmiO
         uInJW/ypGXLFmUZ3Vf7PzoYXaRmF4N/HG47Tl80RyqcYVUOMhtTIIjri2ypdU9IqnMjxI4TgGpKx
         +LLM2qoa3UMzbOaXdZNdgbQ9aeW+e7+3lEEgI4LiHkjb9+wA6gGdpGlCeQW5p+7sLF9aNM9LbWvg
         XRiWBfu7J/GkyFjR2ZqiAJCUqs06i8rGhItmkuaZ7bkB51vw9d4FmVvoJ44eby+wf3MwqoO/l9vo
         jkSZx9VR5Jqt8APG/xiRj9cQ0S1gYsl8YVOL2YIalvlqC/jVELfg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] md: raid1: fix potential OOB in raid1_remove_disk()
Date:   Sun, 16 Jul 2023 00:11:47 +0800
X-OQ-MSGID: <20230715161147.2333373-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If rddev->raid_disk is greater than mddev->raid_disks, there will be
an out-of-bounds in raid1_remove_disk(). We have already found
similar reports as follows:

1) commit d17f744e883b ("md-raid10: fix KASAN warning")
2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk")

Fix this bug by checking whether the "number" variable is
valid.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/md/raid1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb045..3e294dc408fa 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+
+	if (unlikely(number >= mddev->raid_disks))
+		goto abort;
+
 	struct raid1_info *p = conf->mirrors + number;
 
 	if (rdev != p->rdev)
-- 
2.30.2

