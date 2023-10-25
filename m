Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190617D699D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjJYK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjJYK5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:57:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C4BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:57:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so820552566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698231450; x=1698836250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5GXEjEuiD6mlb1HkOp16QUm9TOrY8LB9EQXmZOtIkI=;
        b=YuxgknuUxuP9OHDk7r9JN9qjmH88pRkWJE+kM7sw2fuxlwVz2neSpTifhYGZcL2Lys
         oAcTrTrwkpNdGwgdlHbcGeroMx/BiIFmrRh95AjkQcIfNywhaBCiHUeoyY1tGkyr5tvr
         yM9CdSyXfFX06wcbYS0TLrD6ROjdbbsGWuxMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231450; x=1698836250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5GXEjEuiD6mlb1HkOp16QUm9TOrY8LB9EQXmZOtIkI=;
        b=O7NmCbydT4abOGKWK5mcMSqubx6EldJRGD0nVTvFBj/yT0YAfn/KCMbLFzZ4mKKmh8
         sWS5fRRmcTZkXAP/wrpwrboFPEwMmpkY4P9na9ELImcNvSevx7GWDXCI/KYjzHbl0qCX
         Ctk1yar7W6RufHCieGYZBEo88ZQlHOJKJ8HSDqWxfAoIIdYY7KH3d3Zo7hpd0airAE2F
         1JyWDN62C3qwg00PJhCGT0WRpB2n8PyioW6sHVPbdnok9LfPD290nhDe65tboKBwPRAT
         UtIp3Tn4trseKpSlWcOnqUc8r7U2S3jtYT4JPmMN12pLGIKoT2YVoy2wRdJV4OT5HLgg
         vWOA==
X-Gm-Message-State: AOJu0YwUGh1hpIwB9+Dgl7tGVGPDVt+Fe1rfK2F4QJCZxIdN6/fXFO6n
        4fl+aTIIYTJRjbPUylrtTb9h45GByOTd7cVheJtmOA==
X-Google-Smtp-Source: AGHT+IFWIo3GvRRy1FheTbUdue0eXLi2jgouUjHp4q4cAKPEdiMrloqNFOv3nhESsGUp5NdMknfTjA==
X-Received: by 2002:a17:907:c21:b0:9bf:80f0:7813 with SMTP id ga33-20020a1709070c2100b009bf80f07813mr12624049ejc.16.1698231449769;
        Wed, 25 Oct 2023 03:57:29 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-50-51-252.retail.telecomitalia.it. [82.50.51.252])
        by smtp.gmail.com with ESMTPSA id xa17-20020a170907b9d100b009b913aa7cdasm9741317ejc.92.2023.10.25.03.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:57:29 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH] pktcdvd: fix error checking for debugfs_create_dir()
Date:   Wed, 25 Oct 2023 12:57:12 +0200
Message-ID: <20231025105725.2033975-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of debugfs_create_dir() should be checked using the
IS_ERR() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a1428538bda5..6a9decb04ac1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -497,7 +497,7 @@ static void pkt_debugfs_dev_new(struct pktcdvd_device *pd)
 	if (!pkt_debugfs_root)
 		return;
 	pd->dfs_d_root = debugfs_create_dir(pd->disk->disk_name, pkt_debugfs_root);
-	if (!pd->dfs_d_root)
+	if (IS_ERR(pd->dfs_d_root))
 		return;
 
 	pd->dfs_f_info = debugfs_create_file("info", 0444, pd->dfs_d_root,
@@ -517,6 +517,8 @@ static void pkt_debugfs_dev_remove(struct pktcdvd_device *pd)
 static void pkt_debugfs_init(void)
 {
 	pkt_debugfs_root = debugfs_create_dir(DRIVER_NAME, NULL);
+	if (IS_ERR(pkt_debugfs_root))
+		pkt_debugfs_root = NULL;
 }
 
 static void pkt_debugfs_cleanup(void)
-- 
2.42.0

