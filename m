Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E547D404D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJWTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:33:29 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB11B4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 12:33:26 -0700 (PDT)
Received: from localhost.localdomain ([141.170.221.62])
        by smtp.orange.fr with ESMTPSA
        id v0fzqGEQclciav0fzqWHCB; Mon, 23 Oct 2023 21:33:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698089604;
        bh=MlLlyO5nmPmV+Of5dabISHH05s0yAgNbg1lqfnhBiDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=migciIycEHHxVSLdlbD0OWW2VjQcd388g4a4U6rPubKQtgb7HRtjFpJ689ZOdUYfJ
         M4DjVn6rYm2JxOdyf/1Iv8L43HNqSsvwlKONI+C/7GXglHEqf3PJXDuA3QavdkyrQe
         p0Ub2Cah2/euUBdqZnOBr/06U7KJDK+7wDHYJSYKqMN/EVMycRrdJPzEBvRfg6sLz0
         ToJ4IBNGuk04t0PpFcPhck9S0I+d+73KNfWr+J7PcswUyNqVpMLLYXM5F9DJ9f2cL/
         ud6XVZF0TjAnFY3ldTZLfVSVJjXUzRrKUTjGqr+mM6UaMwgZKN2dc0NXOComv7RoB8
         kDofSZJzzAWWg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 21:33:24 +0200
X-ME-IP: 141.170.221.62
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in create_of_modalias()
Date:   Mon, 23 Oct 2023 21:33:16 +0200
Message-Id: <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining size of the buffer used by snprintf() is not updated after
the first write, so subsequent write in the 'for' loop a few lines below
can write some data past the end of the 'modalias' buffer.

Correctly update the remaining size.

Note that this pattern is already correctly written in
create_pnp_modalias().

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 4deb36dccb73..7ec3142f3eda 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -215,6 +215,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 	if (len >= size)
 		return -ENOMEM;
 
+	size -= len;
+
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
 		nval = of_compatible->package.count;
-- 
2.32.0

