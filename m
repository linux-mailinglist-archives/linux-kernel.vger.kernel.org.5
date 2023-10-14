Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A0D7C966A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 22:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjJNUzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 16:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJNUzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 16:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D88BDC
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697316859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2nXLZgcvDK84RozLr2rRfXB0efNjmc1ATzlgzSv6qVk=;
        b=NzX+X9dnh7RVYfE2977XkmPayK0pNB/otbE4ddBRL6VlHx1S2scK8lrNAoJ2tsrVeHk59v
        Rk40JhFTx/5Nu9YHO6hi54WtSFYcHxvmlREYj917XuxMqnbR7PAX4EA7P/Xxnd5y1Yj7wp
        vfR1zDVKO/75a0sRaHUJS4R+EOwCbGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-_UuwKgd7MBWYQonL0hPq_g-1; Sat, 14 Oct 2023 16:54:16 -0400
X-MC-Unique: _UuwKgd7MBWYQonL0hPq_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFD9F8001EA;
        Sat, 14 Oct 2023 20:54:15 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEDDB25C0;
        Sat, 14 Oct 2023 20:54:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs
Date:   Sat, 14 Oct 2023 22:54:14 +0200
Message-ID: <20231014205414.59415-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9e86b2ad4c11 changed the channel used for HPDET detection
(headphones vs lineout detection) from being hardcoded to
ARIZONA_ACCDET_MODE_HPL (HP left channel) to it being configurable
through arizona_pdata.hpdet_channel the DT/OF parsing added for
filling arizona_pdata on devicetree platforms ensures that
arizona_pdata.hpdet_channel gets set to ARIZONA_ACCDET_MODE_HPL
when not specified in the devicetree-node.

But on ACPI platforms where arizona_pdata is filled by
arizona_spi_acpi_probe() arizona_pdata.hpdet_channel was not
getting set, causing it to default to 0 aka ARIZONA_ACCDET_MODE_MIC.

This causes headphones to get misdetected as line-out on some models.
Fix this by setting hpdet_channel = ARIZONA_ACCDET_MODE_HPL.

Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/arizona-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 02cf4f3e91d7..de5d894ac04a 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -159,6 +159,9 @@ static int arizona_spi_acpi_probe(struct arizona *arizona)
 	arizona->pdata.micd_ranges = arizona_micd_aosp_ranges;
 	arizona->pdata.num_micd_ranges = ARRAY_SIZE(arizona_micd_aosp_ranges);
 
+	/* Use left headphone speaker for HP vs line-out detection */
+	arizona->pdata.hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
+
 	return 0;
 }
 
-- 
2.41.0

