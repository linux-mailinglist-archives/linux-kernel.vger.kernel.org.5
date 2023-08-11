Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E55778E39
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjHKLuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:50:12 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04FDF5;
        Fri, 11 Aug 2023 04:50:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31963263938so153669f8f.2;
        Fri, 11 Aug 2023 04:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691754610; x=1692359410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=pBN+qqjGO1QbfDKIjzNz8G7jeM/UOCH2Sh7E3KRZ3bnS8RfYXKr69Mvdcqs96FR/Ns
         UcFmc0q925DmPBGwNbSKgBrz7TcgeEnMrvu95pEYFTIenBBa1RWnZ0NLsJ+6dfNg26uL
         rc79wFU8CW2FJZh1wBPQ2TbzV6z4qZWCRJsN2MGsbR1VrekzC/Ux2SR/z0Av06rTeVJC
         f7BthkKD67wg4i4q49cpMHJOXTf0qjecn07GWIMKvN46/XVFQX6F6csetmWlEYGKbwrl
         mIoXF1EHpS5qoPflWxl2dEDNbf+Xe09zMw1TOp+7LnQlJ+quOvkhUyD7gFu3jUvJBTYP
         cNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691754610; x=1692359410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGWZmoxclOfYzjyLvlkmT9ZvCsngcDBgs2bkB2Nywss=;
        b=EQ3LWxVDhs57E6c1hKAaFt58uxrnyKQrWMrkW0MMbbkcoKAEiIe5dvDVG0xRIjoKcl
         ZxCKHGA2PDgJptX4AoS4olHSBrWJCX41yZwWNherTvleDORLFKob+S/9cEcwXwhknpNt
         lFD+i72W5GthQanVbBf6RxYZ09vfvpomUvOI4TQ+4VMb12W9aRvWDNZ4lUWxMwseo/Py
         JkiGXkTCVV/UW6VEvx00w84NOjntsW1EDp4DYt67pXqghdoVbJ4chttHYyZSK1bDEzFu
         yHFk4J1lvERKvrGMQQxHyO/qd4wLWM44voXu8zGl+wcWx6lZBvQLqEBmdHJCQQ29Er6I
         67lg==
X-Gm-Message-State: AOJu0YzWff9rmr7Qq9T0VxIg8ou2p1CJxlDll/xZSSxdRQlORnxrEv9y
        FGIusbDU4B6aROnmcF6v4jSUPAdnUDEWeA==
X-Google-Smtp-Source: AGHT+IHxOpNfP5KhsUVYz2tljOeekHXqxP/1CF/kBgRPV54BRkf4pGGrzPQbS3kxOTTtSmru2ja7cw==
X-Received: by 2002:adf:f1d2:0:b0:317:e04c:6791 with SMTP id z18-20020adff1d2000000b00317e04c6791mr1184420wro.62.1691754609805;
        Fri, 11 Aug 2023 04:50:09 -0700 (PDT)
Received: from gba-Precision-5530.kat.ac.za ([196.24.39.242])
        by smtp.gmail.com with ESMTPSA id v9-20020a5d6b09000000b0031759e6b43fsm5240070wrw.39.2023.08.11.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 04:50:09 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: musb: dsps: Fix vbus vs tps65217-charger irq conflict
Date:   Fri, 11 Aug 2023 13:48:56 +0200
Message-Id: <20230811114856.35486-1-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the tps65217-charger driver/module causes an interrupt conflict
with the vbus driver resulting in a probe failure.
The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Signed-off-by: Grant B Adams <nemith592@gmail.com>
---
 drivers/usb/musb/musb_dsps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 9119b1d51370..cbb45de5a76f 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -851,7 +851,7 @@ static int dsps_setup_optional_vbus_irq(struct platform_device *pdev,
 
 	error = devm_request_threaded_irq(glue->dev, glue->vbus_irq,
 					  NULL, dsps_vbus_threaded_irq,
-					  IRQF_ONESHOT,
+					  IRQF_SHARED,
 					  "vbus", glue);
 	if (error) {
 		glue->vbus_irq = 0;
-- 
2.34.1

