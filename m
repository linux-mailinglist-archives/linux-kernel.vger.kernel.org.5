Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7707E7AD2B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjIYIJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbjIYIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:09:10 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02C57A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:09:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.190.70.223])
        by mail-app4 (Coremail) with SMTP id cS_KCgD3SZYSQBFlpdLdAA--.23754S4;
        Mon, 25 Sep 2023 16:08:56 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: video: Fix a null-pointer-dereference in acpi_video_bus_add
Date:   Mon, 25 Sep 2023 16:08:44 +0800
Message-Id: <20230925080844.32699-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgD3SZYSQBFlpdLdAA--.23754S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw18Zw1kAr1rXrWDXrW8JFb_yoW8AFW8pa
        yIk343Ca1UXry7Wa1vvw1j9ry5t348Ar4rGr4Iga9F9Fs8Wry0qF9Fqa4UJFZrWryqga12
        vFyDXa15C3y5ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk21xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv
        6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
        C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48J
        MIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMI
        IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0HBmUNoyAhBwARsS
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_video_bus_add_notify_handler() could free video->input and
set it to NULL on failure, but this failure will be missed in its
caller acpi_video_bus_add(). As a result, when an error happens in
acpi_dev_install_notify_handler(), acpi_video_bus_add() will call
acpi_video_bus_remove_notify_handler(), where a potential null pointer
video->input is dereferenced in input_unregister_device().

Fix this by adding a return value check and adjusting the following
error handling code.

Fixes: 6f7016819766 ("ACPI: video: Install Notify() handler directly")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/acpi/acpi_video.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 948e31f7ce6e..b411948594ff 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -2057,7 +2057,9 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	    !auto_detect)
 		acpi_video_bus_register_backlight(video);
 
-	acpi_video_bus_add_notify_handler(video);
+	error = acpi_video_bus_add_notify_handler(video);
+	if (error)
+		goto err_del;
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
 						acpi_video_bus_notify);
@@ -2067,10 +2069,11 @@ static int acpi_video_bus_add(struct acpi_device *device)
 	return 0;
 
 err_remove:
+	acpi_video_bus_remove_notify_handler(video);
+err_del:
 	mutex_lock(&video_list_lock);
 	list_del(&video->entry);
 	mutex_unlock(&video_list_lock);
-	acpi_video_bus_remove_notify_handler(video);
 	acpi_video_bus_unregister_backlight(video);
 err_put_video:
 	acpi_video_bus_put_devices(video);
-- 
2.17.1

