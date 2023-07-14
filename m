Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63160753325
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjGNHZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbjGNHZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:25:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29102723
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:26 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso2745517e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1689319525; x=1689924325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=3y7lQ5pB6aU5w2NYLHZyCpC3h2fedz/S7KPBC8S0fQKNsW5rbgTRd+0DQxRfoBTe9G
         9Og2eZ1tWDFoLcw2TQvfyA5iZG4NTLc0qYfQag2YCVKrsz1eTcbe98M6lvY5vcUx5Sb1
         k5MH5cszbsJ5Y0ukpV0A4qy9KfNcZBxjM1t+8DVaFTvSpll45Fs7v3LTqVBc74ixo8O3
         cWm2QoOXiDrzA5opBYb1WTZ2AbiuG7Yr0Zyl8XA00SMY8ObqTK/aoX+1XtHwFbckZwSt
         10MJiBoD8701fLM9wrZiMM+EFdh0tzDkEp7toGKqa/1iU2CB9XXDAj63hrQlkASBN0Sx
         4qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689319525; x=1689924325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLXkkNKLC2QFI1E0y4rm62aHVfDJbTTFbFsFl9CT7J4=;
        b=BiMjUyD+yJqhrB+sFmc0BrFmyG9D3EZHOWLXTuciAJRqdksZQGD0iqEsayDnTJ7F50
         tpRex/+ovDqgSRepbWT7klG42gbh8sLWgFuBDEw6jtZqdL0A2dHcVL0Zz8nTZ1Gva3Ae
         dT+cvtoSBT0kdYczf6QYbN8mQN7gFJlbiBtzKuoK3dyHLt11PTrHN99I9KL9RNwmwWVB
         rLXAUZqmKkD+hyPFeTBYmUUiP4M3vq8eqQn+w8bobp1S9H3rsCtibLqJppn8jYvpwEed
         cQi+XFvOFcpXocmMH5VLI3ugJIljKSVj1Axg+rfg5vxpypceuXsR4AsGVJbPayYa6qDD
         OYZQ==
X-Gm-Message-State: ABy/qLaTPKQFL6oEWxbOP9sS4TQnlYsoa67ithfXBbaom5t6Pb8z+Jjk
        83i6h30vm3nSLII9RQ2SHGFrfw==
X-Google-Smtp-Source: APBJJlHrQmIeIX9a7uT1IBcRZlKrq+GOTUWmTpumXS4QtWb26N7ldSxbruMcFZgevJ2Tq1iZC/JOzw==
X-Received: by 2002:a19:2d53:0:b0:4fb:7be5:4870 with SMTP id t19-20020a192d53000000b004fb7be54870mr2960808lft.46.1689319525103;
        Fri, 14 Jul 2023 00:25:25 -0700 (PDT)
Received: from localhost ([185.108.254.55])
        by smtp.gmail.com with ESMTPSA id p12-20020a05651238cc00b004fa4323ec97sm1372952lft.301.2023.07.14.00.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 00:25:24 -0700 (PDT)
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        linux-kernel@vger.kernel.org (open list),
        Damien Le Moal <dlemoal@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, gost.dev@samsung.com,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v9 1/2] ublk: add helper to check if device supports user copy
Date:   Fri, 14 Jul 2023 09:25:09 +0200
Message-ID: <20230714072510.47770-2-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714072510.47770-1-nmi@metaspace.dk>
References: <20230714072510.47770-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

This will be used by ublk zoned storage support.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..8d271901efac 100644
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
 
@@ -2037,7 +2042,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		UBLK_F_URING_CMD_COMP_IN_TASK;
 
 	/* GET_DATA isn't needed any more with USER_COPY */
-	if (ub->dev_info.flags & UBLK_F_USER_COPY)
+	if (ublk_dev_is_user_copy(ub))
 		ub->dev_info.flags &= ~UBLK_F_NEED_GET_DATA;
 
 	/* We are not ready to support zero copy */
-- 
2.41.0

