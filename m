Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A87FED65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbjK3Kz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbjK3KzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:55:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A7E170B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:55:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218E9C433CB;
        Thu, 30 Nov 2023 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341720;
        bh=EqaFNvqa3Yaf2e/v2zXcPa+NF9mRVVDkSa+wDJv0Wc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp7SZy0NUGDmnnSAUp1ak9WDeEeL2H3QZaY62S6szF6Uimt0rETKvW06GDU2UMBqQ
         PFL/Wh7mo6eDkzK+rlw0+VmJVokekplOWxPD1oSyUuIW989CUreK3vlsl+BBCT6UbD
         uakMX3Sbkyo4F04JXRzAmTVsKSgKDPaRBj0oYqCEFDPXNpNzXUQIwlMcnAtrihM/rM
         cPdP1c/uDBJHA2H0raR/lSYh01PlIFlAw71455l9Ux6r+GSDsl3wAVCHZ5foajhuvG
         5aztBRabH35wVkn7sIFZ337MmNW9zM9JmeqqXWEsH2RapDKT9V8RETIbMUvHYZUt2D
         kkwP4OiYy0/KA==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 5/5] usb: gadget: f_tcm: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date:   Thu, 30 Nov 2023 10:54:39 +0000
Message-ID: <20231130105459.3208986-6-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231130105459.3208986-1-lee@kernel.org>
References: <20231130105459.3208986-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

This patch replaces just one use of snprintf() found in the sysfs
.show() call-back with the new sysfs_emit() helper.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/f_tcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index ff33f31bcdf64..37befd6db001a 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1504,8 +1504,8 @@ static ssize_t tcm_usbg_tpg_nexus_show(struct config_item *item, char *page)
 		ret = -ENODEV;
 		goto out;
 	}
-	ret = snprintf(page, PAGE_SIZE, "%s\n",
-			tv_nexus->tvn_se_sess->se_node_acl->initiatorname);
+	ret = sysfs_emit(page, "%s\n",
+			 tv_nexus->tvn_se_sess->se_node_acl->initiatorname);
 out:
 	mutex_unlock(&tpg->tpg_mutex);
 	return ret;
-- 
2.43.0.rc1.413.gea7ed67945-goog

