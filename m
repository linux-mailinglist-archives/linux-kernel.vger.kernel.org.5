Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59527F25DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjKUGlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjKUGlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:41:35 -0500
X-Greylist: delayed 485 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Nov 2023 22:41:30 PST
Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B1FA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:41:30 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.systec-electronic.com (Postfix) with ESMTP id A9D739400107;
        Tue, 21 Nov 2023 07:33:22 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id yc6_DwKpK_Bn; Tue, 21 Nov 2023 07:33:22 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.systec-electronic.com (Postfix) with ESMTP id 83F6F940010B;
        Tue, 21 Nov 2023 07:33:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 83F6F940010B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
        t=1700548402; bh=mgX9GL3OUwNF+uuEyJdqsllHlz0qHvBmd0GzVj3Goa4=;
        h=From:To:Date:Message-ID:MIME-Version;
        b=RiJ9t7u/b1gjr9u86R0YYFApUiwg/Mu6eUTNM1swnadj2YaMOKkpW2qaN30egX6mn
         Hy6rC7yrm1v5tZ2fsdUb3DvAYi9rpCdkyVWdCKCfBRQonVfhnRNi3tHFd6H6x6OW3a
         15eKLFIwO83JGzkS6dkAzF39cVQAD6jmQZZ/VsERBRJFLmd2+FErNGe7vog1uw+5Qf
         edUwwhqF/rz1UtPFWhOi/WkJ7rKuG6/Y9nlPTcY8ZF8QCwse/0gA/dKaHrbfnCRYhP
         ccPwnv2HzuAHuyLnOoNjUHNo1Trn0GrVbKO286OY5EseJ8kId+E118XmsfEO0DAXQK
         G7dI9KdvFhpSQ==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id RsHodCmhZR8i; Tue, 21 Nov 2023 07:33:22 +0100 (CET)
Received: from ws-565760.systec.local (unknown [212.185.67.148])
        by mail.systec-electronic.com (Postfix) with ESMTPSA id 4D9079400107;
        Tue, 21 Nov 2023 07:33:22 +0100 (CET)
From:   Andre Werner <andre.werner@systec-electronic.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andre Werner <andre.werner@systec-electronic.com>
Subject: [PATCH] mfd: tps65086: Enable register view in debugfs
Date:   Tue, 21 Nov 2023 07:32:59 +0100
Message-ID: <20231121063259.13991-1-andre.werner@systec-electronic.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously there was no output for the regmap's registers
in debugfs due to missing "max_register" property in regmap
configuration.

Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
---
 drivers/mfd/tps65086.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 152179ee11ca..fdce81b33f60 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -36,6 +36,7 @@ static const struct regmap_config tps65086_regmap_confi=
g =3D {
 	.val_bits =3D 8,
 	.cache_type =3D REGCACHE_MAPLE,
 	.volatile_table =3D &tps65086_volatile_table,
+	.max_register =3D TPS65086_OC_STATUS,
 };
=20
 static const struct regmap_irq tps65086_irqs[] =3D {
--=20
2.42.1

