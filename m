Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58B7DB172
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjJ2Xf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjJ2XEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267277DAC;
        Sun, 29 Oct 2023 16:02:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3797BC43142;
        Sun, 29 Oct 2023 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620430;
        bh=KhUtB54uK4qyUqCY+EQcFSAiBc0dZk73E2hxASm8tAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8zR0Xe13/SYC8OHSYmbTAIELQLigLJr4CjUCCBk2cOuh+/WzG+Xap8J26kcnZqzx
         iDliwr35ZVfJHA2dnKQz9LdaF4gCSi6cRddqs+XIKZ/oxVVzW3JFrtC0Go69WmNx2c
         Qyv4HC+uU28Ur+z3e46QN/pFkq7oJxbdqO6C5ZE5s9+I3d0lETQbeeBFO6dHVR983R
         4k8bch2KArCRfGkK0n0RzxYSkbVRLKGGegm2JCSqO520XbQF25JdvJetBxgfU1sr2T
         URZD5kpbv0c0gd+ftQTsXyD/0mDpeaVfmNUm6U7Si7Ddd3KhHiXz5Q4bfzk3ik+uSe
         wzUc1ztgR/h5w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jorge Maidana <jorgem.linux@gmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        spock@gentoo.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 09/16] fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()
Date:   Sun, 29 Oct 2023 18:59:55 -0400
Message-ID: <20231029230014.792490-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230014.792490-1-sashal@kernel.org>
References: <20231029230014.792490-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Maidana <jorgem.linux@gmail.com>

[ Upstream commit 1022e7e2f40574c74ed32c3811b03d26b0b81daf ]

Delete the v86d netlink only after all the VBE tasks have been
completed.

Fixes initial state restore on module unload:
uvesafb: VBE state restore call failed (eax=0x4f04, err=-19)

Signed-off-by: Jorge Maidana <jorgem.linux@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 661f12742e4f0..d999a7cdb5409 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1933,10 +1933,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
-- 
2.42.0

