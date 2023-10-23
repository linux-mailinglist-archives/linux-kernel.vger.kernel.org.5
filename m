Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F017D3F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjJWSdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJWSdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:33:09 -0400
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA551B7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:33:05 -0700 (PDT)
Received: from localhost.localdomain ([89.207.171.96])
        by smtp.orange.fr with ESMTPSA
        id uzjXqFyhBlciauzjaqWBr8; Mon, 23 Oct 2023 20:33:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698085983;
        bh=FMjgweLhTo5SkdcoVkpbQPkyPY7V0wNxVnhTVFmu8Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=emNSBpG/a9z3B1LDISJdjQaKSpJTUuKZpDTHiYtYZlavdx3+54rvcUgu0Cn2sHtnl
         3FOcFQnp8G5lOpqX9RY0+ui+ci8ifYkIARA+gttPtI+ytelf1TlFTL80WgtS0+yRFe
         BAmDhOQYLMaQgpbMSW30h0IIfvUfSwQl1o3aEz/t5HqWgKGFN0G1nj+F03Prik93zi
         jXQ0MuoExuirfsSiR6of0Bk9z+685/GYw7SQfZM6cmnzFjt5VEKxkRk7kRUUHQRP6W
         sAntpAAf820X/JJyE8N0YeshMzhBqn5vqASJOvWRj679qL5D4SzO6V1RH4QTgrN9cT
         +VqLoqedq9CDw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 20:33:03 +0200
X-ME-IP: 89.207.171.96
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] ACPI: sysfs: Fix the check for a potential string truncation
Date:   Mon, 23 Oct 2023 20:32:54 +0200
Message-Id: <20001867d5d19c3b3e677f6020750cc232b3325b.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() does not return negative values on error.
To know if the buffer was too small, the returned value should be compared
with the length of the passed buffer. If it is bigger or equal, then the
output has been truncated.

Update the test for truncation accordingly.

Also return -ENOMEM in such a case, as already done below in the same
functions.

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/acpi/device_sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 9d8e90744cb5..4deb36dccb73 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -158,8 +158,8 @@ static int create_pnp_modalias(const struct acpi_device *acpi_dev, char *modalia
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -212,8 +212,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
-- 
2.32.0

