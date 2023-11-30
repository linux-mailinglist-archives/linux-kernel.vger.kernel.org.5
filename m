Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF97FED61
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbjK3KzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbjK3KzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:55:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100AB10FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:55:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A841AC433CA;
        Thu, 30 Nov 2023 10:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341718;
        bh=/XOh9djbd1kRjRIJaFEo79gsQogKZILFqya3ZNX3dzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/7ElH+xTwmRE/jQTEQPLVFtUUURsQO7RbtCR9vxOg5H7Gx4ArBGSB9MkUmH5CF5E
         szynq61yJlRo4ltLpVSCDAMrZQiXgH3j9/qyA5woBqJqjsVy/uNlp5VKKajiNyCKMZ
         PmuSoGJGgyI611UCzIabzZySOnX+87zpCgULh+zKjXnF2nIZ/BvI58pKkaOUWM8ick
         mvUGbVqUhRs7VMauF6ygzEG+4Evd0+RI9YYZKy8aEaVn6ng2JizzUyalZjjxkT5LYG
         ylBtp51MF9qOLB6skfhw2WPf5GU7v6YFGgPJTTiemGSiESLpG1GExPLuPpuFzsZXvR
         FQ7MWMmPFKteQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 4/5] usb: gadget: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date:   Thu, 30 Nov 2023 10:54:38 +0000
Message-ID: <20231130105459.3208986-5-lee@kernel.org>
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
Cc: linux-usb@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 4c639e9ddedc0..b7d2a1313a684 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -812,7 +812,7 @@ static ssize_t gadget_string_s_show(struct config_item *item, char *page)
 	struct gadget_string *string = to_gadget_string(item);
 	int ret;
 
-	ret = snprintf(page, sizeof(string->string), "%s\n", string->string);
+	ret = sysfs_emit(page, "%s\n", string->string);
 	return ret;
 }
 
-- 
2.43.0.rc1.413.gea7ed67945-goog

