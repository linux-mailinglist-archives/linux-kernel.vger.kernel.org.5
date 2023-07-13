Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66389751F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjGMKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjGMKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:47:46 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C6B212B;
        Thu, 13 Jul 2023 03:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689245257; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QPM9I1dPces+vEz188Jld78QmEaoaP5YWZ+07xq+2lMpzEnBybfQaByEzg+ZfJq1Usl0x6/xNfVMlvGFahFreHfuFsZTxDrrGomXwgULUFyhpXpV4a39DarUCmnKo/IRGzcpbyBQKxArnL8YmNXLMQJ1vpFjWwxu6Zk74cooz5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1689245257; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sUb+XBeJjVlNbYVY/GHuUMJPh6CEvtIvrz26lQkXa7o=; 
        b=V03yhIePcddoOLoToHekeeE1333uaqGJnS1GaLwoUU4maQoxuwO/gsT6g/X5saYNiU8VVAKAm5xErc4aHcANeSH2ldnq7xs7hb7GraxlMJfzOb6hB6KsmWNmx7nFvuiOO3eQ6n+2EKBNs1tzSyykKTaER7tVxPdcVdZWnRFaQ3c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689245257;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=sUb+XBeJjVlNbYVY/GHuUMJPh6CEvtIvrz26lQkXa7o=;
        b=HoFGWSDRfHjdG8MrDfzHIB9vva7qf6RmYUdnpCUQw4JF8IrGIAOt/aW5KlKm23H6
        2swOjDaOXH7loBscAxFXV0JGC7LthzZMJP7GUlmdfvhdNoB5+bwB6rvXsDv5ibaJ9zM
        sDYieBbtxJI8wk9owmkTxVbEOLP0VZnCC0R9cgQ8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1689245255684909.136685335917; Thu, 13 Jul 2023 03:47:35 -0700 (PDT)
Date:   Thu, 13 Jul 2023 18:47:35 +0800
From:   Li Chen <me@linux.beauty>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "devicetree" <devicetree@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <1894edd07ee.b7245352142935.3234373322799059936@linux.beauty>
In-Reply-To: <1894ed7a1a9.f5e49d5d141371.2744760538860302017@linux.beauty>
References: <1894ed7a1a9.f5e49d5d141371.2744760538860302017@linux.beauty>
Subject: [PATCH V2] of: property: fw_devlink: fixup return value check of
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

This commit addresses an issue where enabling fw_devlink=on was causing
a PCIe malfunction, resulting in endpoints missing.
After thorough investigation, it was determined that the root cause was
an incorrect usage of strcmp_suffix in parse_gpios.

Fixes: d473d32c2fba ("of: property: fw_devlink: do not link ".*,nr-gpios"")
Signed-off-by: Li Chen <lchen@ambarella.com>
Cc: stable@vger.kernel.org
---
changes:
v1->v2: add Cc stable

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


