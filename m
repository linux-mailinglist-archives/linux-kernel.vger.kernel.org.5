Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286307AA71E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 04:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjIVCw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVCwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 22:52:54 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85C8B192
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 19:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CNIjK
        qWBYJRXMJgT7L7SM8zG22UEzfPx+zde9DnsbOI=; b=P3OD9GfqgQpqnkjdxgyCF
        XZW69zBrwX20z8puFpc8xII0vUPke0ph8AI3nvbnV8yCCkBUwnNaAXP0M1+PunIa
        rdwKU3iM0h/y8ERfIz+UyOhlRTtLxMIvbmLcjUabCrNKrr8K7nlQeJUYQC3K2KxY
        AMaZ1pgTmx1Mks4j/qhs6U=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wCXlmJkAQ1lBhMMCw--.10183S4;
        Fri, 22 Sep 2023 10:52:32 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     mchehab+huawei@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] spmi: hisi-spmi-controller: fix potential memory leak in spmi_controller_probe()
Date:   Fri, 22 Sep 2023 10:52:16 +0800
Message-Id: <20230922025216.3604978-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXlmJkAQ1lBhMMCw--.10183S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr1rCw47ZFyDGw13Xr13urg_yoWkKwc_Cr
        48GFW7ur1kCrW2kwn5tr4rJF9Yva48Xw10k3W0qw17Ja9Yv3Z0qry7XrWDZrW8JFs8Ar13
        Gr1jvF48A3W8AjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRthFxDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivgvyC1Zci0HukAABsz
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spmi_controller_alloc() allocates a memory space for ctrl. When some
errors occur, ctrl should be handled by spmi_controller_put() and set
spmi_controller->controller = NULL because spmi_controller->controller
has a dangling pointer to the freed memory. When the failure happens,
the function returns without calling spmi_controller_put() and setting
spmi_controller->controller = NULL, which will lead to a memory leak.

When the failure happens, we can fix it by calling spmi_controller_put()
and setting spmi_controller->controller = NULL in all of the places
where we call spmi_controller_put().

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/spmi/hisi-spmi-controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 9cbd473487cb..5b3cfa7f5056 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -321,6 +321,7 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 err_put_controller:
 	spmi_controller_put(ctrl);
+	spmi_controller->controller = NULL;
 	return ret;
 }
 
-- 
2.37.2

