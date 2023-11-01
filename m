Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF56A7DE681
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346189AbjKATl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346179AbjKATlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:41:55 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC4FBD;
        Wed,  1 Nov 2023 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698867702;
        bh=6kOOEsQgA20o02ni+Bbcpima7j16ISpDSfIVR3lmAHo=;
        h=From:Date:Subject:To:Cc:From;
        b=RgKkttjK6JHbUkNCJEGKwSUQBo2D1LVV/CtJA/BRdiAsNkuvWgT6mc1CrYE1EBw+T
         JDfPyoDOK7LpDXTsVsBEHmLc55HZpiHWgHv1Hg09HxHobbPMFTnwWzpJyyRkzOmBCq
         H7uX0orZAkqBQSWVtQ1Rlo5aSIiV+UnbFeXwktDs=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 01 Nov 2023 20:41:38 +0100
Subject: [PATCH] rfkill: return ENOTTY on invalid ioctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPGpQmUC/x3MwQqDMAyA4VeRnBdIqqe9iuzQ1tQFSzuaMSbiu
 1s8fof/P8CkqRg8hwOa/NS0lg5+DBDfvqyCunSDIzcyE2NLm+aMWuM3o5RquyGRdyGQn3xg6OW
 nSdL/fZ1f53kBxrK472UAAAA=
To:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698867702; l=1027;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6kOOEsQgA20o02ni+Bbcpima7j16ISpDSfIVR3lmAHo=;
 b=PCouzUkWjCX8b4EyQv4Oh3mGh+icPABvcaSCwi8ZKWWfm0MN7wtPhGOZZZJDZDHZZRhHXGuo9
 tX5Sr1txgKVDl411lumTlUJq0mY1eBz57bA4bczvxT3dg+jVfF8vYW3
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unknown ioctls the correct error is
ENOTTY "Inappropriate ioctl for device".

ENOSYS as returned before should only be used to indicate that a syscall
is not available at all.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/rfkill/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 14cc8fe8584b..c3feb4f49d09 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct rfkill_data *data = file->private_data;
-	int ret = -ENOSYS;
+	int ret = -ENOTTY;
 	u32 size;
 
 	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
-		return -ENOSYS;
+		return -ENOTTY;
 
 	mutex_lock(&data->mtx);
 	switch (_IOC_NR(cmd)) {

---
base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

