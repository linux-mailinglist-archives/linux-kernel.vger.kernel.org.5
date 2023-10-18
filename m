Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594BE7CD17E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJRAzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJRAzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:55:49 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9692;
        Tue, 17 Oct 2023 17:55:48 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a7dd65052aso85686407b3.0;
        Tue, 17 Oct 2023 17:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697590547; x=1698195347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBsdVbQfZnd0UbagwL4VN2FSW+PYWVlXpxtElHlS/LI=;
        b=cR+u8GJ+jUtI+lDTbLL5LkooRSK8VIyiCaYpwn3+0F8YNbVPKJcbDg26wKofskAr51
         KT9bKbXxB3O5aBGcpZL7hoieqdKSEWWCPbA932HBZ5AIxiODkcBAXctp7dP7uH4fZ5Ar
         qadiNyimyaI8ToBmucMbPXX6PbR/DVufXIRMU22CEyQJb7/BFuSXJvU7iVccU4lED/ne
         KjB28+Hw6nURMuAoW7vy/g6BO85pI7x1EHC9L2y7YtX3fZ/UK+qNktQCa5j/EptbgJmx
         G3Gp4V6k5ymwu+CDmu4Sl1UFUCiUh/fKBmv3uk+kH6aXLZVmM/6EItS9VIbWxnemCPaw
         sWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697590547; x=1698195347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBsdVbQfZnd0UbagwL4VN2FSW+PYWVlXpxtElHlS/LI=;
        b=HK5PlOuOFclwKTERdkN8giwuWiWDzvMZATX1HWwsISMbjDAgC+hC2Squzuu4xm9rKs
         Eb+XTL+n7VpuOY61MrQkV6IOVllSjPIWLZf5f01fpH5U6u9oOcDeMUzFtETazRO+7B16
         BwJxaBd47vbmT/+EOLzrWLghlISq9GsoqUtCiCzm+zcLAreWtwFBEzzFPoGGqo8f5xmh
         YvZ7bT5GrmxsOlIfCqHNICJjyTT8Z2R5vGucoMJWoz9y3zfYtV9l7yT7cu1jmNEIPM1E
         wilIFDm/KM5tOqoc0ha2xANHtGNeSx6osT1nHF6OYzUC7C//lFcOMIHV5vsWqLjvv8HC
         RVFw==
X-Gm-Message-State: AOJu0YwK+y8BrwmqWRVFul52uTfRf6MdfTG+4zrbTNk+GlMiHtXvuTjY
        k7Rk3ZX1H9/DgVz9dluFc7w=
X-Google-Smtp-Source: AGHT+IEDzZCyUkIkQ55ygoudggAt4gMoCY+HI4SZTLbqxGuB8pzQ4sjzkhQriIESTr8MIe6flYXL4w==
X-Received: by 2002:a05:690c:f96:b0:5a8:286d:339e with SMTP id df22-20020a05690c0f9600b005a8286d339emr4506682ywb.4.1697590547035;
        Tue, 17 Oct 2023 17:55:47 -0700 (PDT)
Received: from lanran-u22.. ([169.235.25.167])
        by smtp.googlemail.com with ESMTPSA id u5-20020a17090add4500b002777001ee76sm135919pjv.18.2023.10.17.17.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 17:55:45 -0700 (PDT)
From:   Haonan Li <lihaonan1105@gmail.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Haonan Li <lihaonan1105@gmail.com>
Subject: Re: [PATCH] pata_lagacy: Handle failed ATA timing computation in opti82c46x_set_piomode
Date:   Wed, 18 Oct 2023 00:52:21 +0000
Message-Id: <20231018005220.2551586-1-lihaonan1105@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1a0c4378-29b2-43b4-982b-0d92dfb8ed4f@kernel.org>
References: <1a0c4378-29b2-43b4-982b-0d92dfb8ed4f@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function opti82c46x_set_piomode utilizes the ata_timing_compute()
to determine the appropriate ATA timings for a given device. However,
in certain conditions where the ata_timing_find_mode() function does
not find a valid mode, ata_timing_compute() returns an error (-EINVAL),
leaving the tp struct uninitialized.

This patch checks the return value of ata_timing_compute() and print
err message. This avoids any potential use of uninitialized `tp`
struct in the opti82c46x_set_piomode function.

Signed-off-by: Haonan Li <lihaonan1105@gmail.com>
---
 drivers/ata/pata_legacy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 448a511cbc17..3c7163f97aaf 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -579,12 +579,19 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	clock = 1000000000 / khz[sysclk];
 
 	/* Get the timing data in cycles */
-	ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000);
+	if (ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000)) {
+		dev_err(ap->dev, "adev: unknown mode %d\n", adev->pio_mode);
+		return;
+	}
 
 	/* Setup timing is shared */
 	if (pair) {
 		struct ata_timing tp;
-		ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000);
+
+		if (ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000)) {
+			dev_err(ap->dev, "pair: unknown mode %d\n", pair->pio_mode);
+			return;
+		}
 
 		ata_timing_merge(&t, &tp, &t, ATA_TIMING_SETUP);
 	}
-- 
2.34.1

