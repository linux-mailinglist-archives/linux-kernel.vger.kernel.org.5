Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAD76FF98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjHDLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHDLqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:46:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CCE127
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 04:46:13 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c1f6f3884so278068966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691149572; x=1691754372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngj/h6FVXWzaXcOU3qKFEOyCMSzua1y3RfSgTGuGcj4=;
        b=Gci5XiM2gbNQ3sH2Aw1TjX010iTrsiC/9UcDBGlVhKReHYHeXVQ3O6luHDQJe79H5T
         ipRqhTHQhdcmmWh7ySeumvysj3Dbmf/O04dTS6GIIN+7BfpLceEQKMSVuXE9zkrWfmlT
         znTpxK+OzdbsY0bt2WBs0Y2TTm+mw6rHGTnpHPaH66qjA2zmHAr1cJYNp/pOM5+SaGAY
         8HAWPUFC/NsL9SI81AKtAd5c2LE2VkUGLHVGEvQCRxJU/TJ/UK2MfVkBlsYI5qIaDW8i
         mOWKzUywKPx3MY9fQ7lsc9Z3XAHwRDgCiBTtPgH+yGSoRqZc/+X+TXMtvYWEJYogvyn/
         9aCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691149572; x=1691754372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngj/h6FVXWzaXcOU3qKFEOyCMSzua1y3RfSgTGuGcj4=;
        b=OI0GfyxCoH60HwwmbI3W7Y+dCstwFdONZCPWkGhuxhk9dtNC4AWM6z2AiLWBB8Gh4A
         2ga4+1vEP3oJvS30joh001P5LnTv0y0rplA05Xv3skkktesErwCnFfLBNYI6BTuwh4Qo
         NVPNaU9h9aGODZs9a/8lpgxfwtMFrnMX4gTmF1Y5CqK0fJzyL1s+55tr5fRp7rxVHqe4
         UGTF/UqjiHCW7zQtvrwxz5/Q/QTHMpurdS7ZoJ1o9TMatstLvu/IKH37W88C6xSYyyej
         2CBIKT2iGGnlCP7dW4Xd/TG5EVBQ37/XAphvRV9PpQWqErCiPmM4I7UxlAwpKMn0P7KC
         O+iA==
X-Gm-Message-State: AOJu0YxreMCjmV6UkQdQY4/MOdlMNWQWFCBZutH/akzhUh2rcXXucp+l
        E2+f2uxhAk//o60PqGGnQeY0YQ==
X-Google-Smtp-Source: AGHT+IHf3HUqYYDZViZxN8vB0sfZlkzyKgL8xLPzD659WQUbP5cV61iKjQUcyGDitHeIcwaDzOrffw==
X-Received: by 2002:a17:906:2ca:b0:99c:9e69:6a19 with SMTP id 10-20020a17090602ca00b0099c9e696a19mr1528787ejk.18.1691149572527;
        Fri, 04 Aug 2023 04:46:12 -0700 (PDT)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id gt7-20020a170906f20700b00988b86d6c7csm1189295ejb.132.2023.08.04.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 04:46:12 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 1/3] ublk: add helper to check if device supports user copy
Date:   Fri,  4 Aug 2023 13:46:08 +0200
Message-ID: <20230804114610.179530-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804114610.179530-1-nmi@metaspace.dk>
References: <20230804114610.179530-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 21d2e71c5514..db3523e281a6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -185,6 +185,11 @@ struct ublk_params_header {
 	__u32	types;
 };
 
+static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline void __ublk_complete_rq(struct request *req);
 static void ublk_complete_rq(struct kref *ref);
 
@@ -2038,7 +2043,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
-- 
2.41.0

