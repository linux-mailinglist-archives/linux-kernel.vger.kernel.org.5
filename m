Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0C75DAE8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjGVHyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 03:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGVHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 03:54:12 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E142715;
        Sat, 22 Jul 2023 00:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1690012449;
        bh=WudfsQrb7fYoExuk3p2L4EzuP2QiuNE7sYpPMjsBwbg=;
        h=From:To:Cc:Subject:Date;
        b=JKTJ51N8XQTfH4R+TQ4W7bL+9wGiQcCRfBjNYatBswziAQ824x7ab6KecETdRtt9/
         hSZfJvmzArmPL59S2sM5CQfS66GuI6vTQqA3SoQufTAujff363UOScs/kzI3ki31q/
         fUlaLTX4ZkXZxXvmokurSqG6R1fD40Exs5kKDSPc=
Received: from localhost.localdomain ([220.243.131.5])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id D81AF2DC; Sat, 22 Jul 2023 15:54:01 +0800
X-QQ-mid: xmsmtpt1690012441tzvuelqpp
Message-ID: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com>
X-QQ-XMAILINFO: NkaTxwcgdNx6R4hM3qsGEhwYqZX72z8eb2D4dF/ixdZi527l2a9F/fwgvvFPw3
         zgyWQM9/ghVRfeq+EZHGdUJOGXAdlf5jB5mUiHdFOkZiUN0H5BABF0yvaT681kiJ6FECB2HmNEqt
         rO2m0bnXNWxsSmLPr3pGDx8Xm9WZvW7WrLhdnBgKiLPWhIb8p3+ummNc/T8A+x2TOumc8HVpXwrV
         fWzIFZ/qFQknz0WG/IMYoWf/N44VuAriIq9f3Z7C759/DP+aFEHQPeteFVEmG5cDCX60bzwA1v2v
         uJnzqbWgfmCP9JrpyJsXFt1SyRpivISUq0gwOv13J1q4drV6NFLljNrtHdyzHJYsOU2bPedcL/LG
         JYGKTiNHOxVDkeg/aC4MYq8vz3dLweYbPRZm+NQ3onT24CP22UgqTYxvg2UsAkvyo0KqZD85ySXR
         CSaIu/EoLD44+Zi/xcGtLAVPfzSsIBdbDmKmmcADH8Zx18GtU8X5SQROQR50NWkii7u7y56QQIuF
         QqVQTZfOfXihxpkOm40RKTh9t4lF2dw2i6BUbf60ppSSzkj5W3jR/+PvJW0fYKLmyi0z6FekTSXX
         jMrrd96xaoK18qy/iAyz9sZJYTjvU1K+lbLqhjcfMsWyCscNLD4OHV0knIWvFdXibM68Bj3/HVWt
         +5+MMN2t3velWD4SXhft079+1Z+KcEFgOdGXFX6S7yr/ZTlY5w+omIn0Wc0bJ/x+bRcudCZSrtTx
         Vo99pgxOEvP8yQelHea5B8umf9Kmz+jAKE+ekITchAl57yyYrbYfJ35CaEPJVWW+4VOsvFdJouBU
         avAHyE6nkz3bugPGCOsJnuxzNVLIiiBr+RnxLl1Iq7B+tiJy0xsTii4Vf4h29JZee5ra4nQbkF1n
         MufVOMGthWzioKv3NMz4anAHUgVlWqC4JzbapoeMT4SGfLJB9n9VkBxCBVWb+TFpC9uwpQV/g+tg
         mASw7rCLqojIQGdg+Ah1qKb4t9Pje3jTUdqXULg4MxddUrExexdgs60NmbDySc6yE+VBwnuJQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     song@kernel.org, yukuai1@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
Date:   Sat, 22 Jul 2023 15:53:53 +0800
X-OQ-MSGID: <20230722075353.7159-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
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
Changes in v2:
 - Using conf->raid_disks instead of mddev->raid_disks.

 drivers/md/raid1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index dd25832eb045..80aeee63dfb7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+
+	if (unlikely(number >= conf->raid_disks))
+		goto abort;
+
 	struct raid1_info *p = conf->mirrors + number;
 
 	if (rdev != p->rdev)
-- 
2.41.0

