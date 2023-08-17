Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2196780012
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355411AbjHQVnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355425AbjHQVnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3E82D68
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692308545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mE+FGvFznuoQJloAz1CbWUzmKetF4jOWg9oG8Wm7sqQ=;
        b=fzDiYpm2ondgOWpojeOZlZXyNCa1FdgXhaYwUKesgddY0fkvmQT2Tm3N10e8vNSdv0f2T5
        mw9x3IZSkYgjZBX2gv1sBuykfKu+txCzk2YhV5UHCIn3w0rKRNbLjMXhNE9NdXd+SNE/c5
        F9UV7X0UpLmkIk6woGjp5O8rahu3OMw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-euNps_gdPRG6AmHqI6hLGQ-1; Thu, 17 Aug 2023 17:42:23 -0400
X-MC-Unique: euNps_gdPRG6AmHqI6hLGQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-649114f84b5so2089536d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308543; x=1692913343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE+FGvFznuoQJloAz1CbWUzmKetF4jOWg9oG8Wm7sqQ=;
        b=Tl66qMxf0YS18eXEKID5+yEtY1WI9xXwezj9ZuNHN+SxjGdzitCQslI4Q7/BOSBoP+
         36xCSW0RkrePsi+Ham6O/JGKciXVRKNBdvqxiEDDzHY+P0OB2KKNAFhH8Y2iTksI4Si3
         ZC3NMzl7f420JpreSa4r9/qAgRIJcYcjmfFnAJkP1goQIwPzrSgP+bGIVTO1N3Qu98VV
         L5V4h1jEFRK853/Td4nHWh8+4FCicU6DXpB7vLfhitEOdYkE/a6X20MAe5Qx+ppAj19K
         HZFZLiOjQIIkOKa+dBhvlq+AxHhU1e745vxe4Q3H/lmFNUYMuiWN0EGdkZ8g18VCsa7+
         q/oA==
X-Gm-Message-State: AOJu0Yyo7A/3gndnTWH3sPiGGd4dXsYRNyHpMDhHJrU81D5s7IwsllU9
        eQrIsllJG/qpj4kyoTT3jcoiCW/FF7kkuwsmMZLBMa2A/n1VtSh+lzrNwRbdfWOvg/gA4cVQuj6
        DlOTmvsc+TQgDru0YEFQpeoj1
X-Received: by 2002:a0c:8cc6:0:b0:649:384f:edc with SMTP id q6-20020a0c8cc6000000b00649384f0edcmr842539qvb.2.1692308542968;
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQxlxTWCZWOGLc6QQ5U5oniNuq0Hqp5AacLbd+dKUHE7JSvkqhThXLmevZxKdTf9eo8v5pA==
X-Received: by 2002:a0c:8cc6:0:b0:649:384f:edc with SMTP id q6-20020a0c8cc6000000b00649384f0edcmr842529qvb.2.1692308542733;
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id s26-20020a0cb31a000000b006375f9fd170sm175854qve.34.2023.08.17.14.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:42:22 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bmasney@redhat.com, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] power: reset: nvmem-reboot-mode: quiet some device deferrals
Date:   Thu, 17 Aug 2023 16:41:57 -0500
Message-ID: <20230817214218.638846-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some errors are being logged that are really due to deferrals,
which is confusing to users. Use dev_err_probe() to handle when to log
at error level versus debug. This also has the added bonuses of logging
to devices_deferred and printing the error value.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/power/reset/nvmem-reboot-mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index e229308d43e2..41530b70cfc4 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -45,8 +45,8 @@ static int nvmem_reboot_mode_probe(struct platform_device *pdev)
 
 	nvmem_rbm->cell = devm_nvmem_cell_get(&pdev->dev, "reboot-mode");
 	if (IS_ERR(nvmem_rbm->cell)) {
-		dev_err(&pdev->dev, "failed to get the nvmem cell reboot-mode\n");
-		return PTR_ERR(nvmem_rbm->cell);
+		return dev_err_probe(&pdev->dev, PTR_ERR(nvmem_rbm->cell),
+				     "failed to get the nvmem cell reboot-mode\n");
 	}
 
 	ret = devm_reboot_mode_register(&pdev->dev, &nvmem_rbm->reboot);
-- 
2.41.0

