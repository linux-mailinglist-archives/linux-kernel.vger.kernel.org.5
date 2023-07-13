Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF36751F21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjGMKlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjGMKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:41:50 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5471BFA;
        Thu, 13 Jul 2023 03:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689244904; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HWGAHfq2NA0fA/S8+tFTf3PF3oHtqnKv6qYKTziQL6WfHGDgwfo6FWYHzCve15UCS1vMARGO0tiYKZBAzLey3lc+NZ78Z5hc5Tt0w66wd770MMBujs5XgWhkFCufdvgPd8+DYwjSqUmkATWhDpHBHrwAu9H2p8PPXELy8jMYQeA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1689244904; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=lEvsxzz+qJghQc8kzyg734nbqEHR6EFKqv5AJo4kZ2M=; 
        b=eZeTPbCSWVujqjEwRZ4mKFVhgZGWpNPaerQlwncM2gObQP7K3bbRiwgh53gBVdPbxWH2prQG7mLg5EjEzhzujFJSefxgAZU8vytnz7Rj++Q64fAaFfSZu/5+HP09FtKhaEdZAa4nXp8GcG2zISbc2KGgRzN09YH/BNriJA34y1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689244904;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=lEvsxzz+qJghQc8kzyg734nbqEHR6EFKqv5AJo4kZ2M=;
        b=Zzr/IXD5lIGPVJUexUifXLTNgDhLmOoj/T+3Ub2XCvGUDK7opaP8gSjFThySbeMI
        R5fJj2Oqo73uPBfuIL7OQq5WrWdhPGOQ5r3ZT8jOSSrvjIXmTp85BlkT1UtTpnBs7Um
        QHVZWnNa253PfEaKH0Hj7MsqXvgFYNoblIDfKHuM=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1689244901917389.12497445346855; Thu, 13 Jul 2023 03:41:41 -0700 (PDT)
Date:   Thu, 13 Jul 2023 18:41:41 +0800
From:   Li Chen <me@linux.beauty>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1894ed7a1a9.f5e49d5d141371.2744760538860302017@linux.beauty>
In-Reply-To: 
Subject: [PATCH] of: property: fw_devlink: fixup return value check of
  strcmp_suffix in parse_gpios
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

This commit addresses an issue where enabling fw_devlink=on was causing
a PCIe malfunction, resulting in endpoints missing.
After thorough investigation, it was determined that the root cause was
an incorrect usage of strcmp_suffix in parse_gpios.

Fixes: d473d32c2fba ("of: property: fw_devlink: do not link ".*,nr-gpios"")
Signed-off-by: Li Chen <lchen@ambarella.com>
---
 drivers/of/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index ddc75cd50825..261eb8f3be08 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1272,7 +1272,7 @@ DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 static struct device_node *parse_gpios(struct device_node *np,
 				       const char *prop_name, int index)
 {
-	if (!strcmp_suffix(prop_name, ",nr-gpios"))
+	if (strcmp_suffix(prop_name, ",nr-gpios"))
 		return NULL;
 
 	return parse_suffix_prop_cells(np, prop_name, index, "-gpios",
-- 
2.34.1


