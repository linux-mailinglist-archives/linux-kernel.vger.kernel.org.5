Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424AD76EBEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbjHCOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjHCOHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:07:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E5198C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:07:06 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so10325655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691071624; x=1691676424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsVd2fV3PA4EdIC1bmEF6WqQH4zyZJO6nSo1h8aq0xI=;
        b=cx7M2lq8nRGQLStLg++95LrzEdbrHvRF3eQzkND5FRgpBY9rz8Q19Gbez0puuQEXPL
         aUV5YdlNBDPjigUzLE868SqkUfrHShLl2RzpK0LLSGsTiupjGX1MUJEZyUNO00kfx5SB
         nwCP5zcbZZZrEUNiQsZZ9KXe/n8qXNQnuWhL1jjLu2zFeFN4k+GYP1lHzbS8+4zX0H3c
         5H4ver9HIYeX3ugd0PPmjB9Lq7GIUcmImGRglMvMI0kLi4SKIfXAY8wc4qj/XhWiIBAp
         dfm4p6iaRO5Y27y48vJh9uVZ0APV48ZUNgG4q9pOwMw53foN6C+GMMgC3T2LOg8Ec0YR
         XShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071624; x=1691676424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsVd2fV3PA4EdIC1bmEF6WqQH4zyZJO6nSo1h8aq0xI=;
        b=SFg6qaVLCSpyXUqhEEy7glPJCWrKX73Elg7r4NzTdNCtX1mxLobNTRwEArtKfjahVl
         tP8avkmVLaGpTO05pOV7biRgY8KRTypqGcyya07t3SJKhy9dIfzE33T1EbMFvO4ibsog
         xG2rppe++tMXOCLXkwQi5dFU7vKxdat/DKmqjOkpXoZegIsqj9544b00NKapXPTzwKQ5
         +XMUberV4Ymv2a1jhlqOO82AbISwvb5jVROOhBLlvFO7Oqgypl3hTenM0m0SCRdttrTZ
         uaniK6wUWPuFySB27WlAQSeWEfgXsb+ZtFDxqY3pRj87wAK42WeqEyH9JOX6f+CEJLmE
         2UuQ==
X-Gm-Message-State: ABy/qLa0u2xsrOWXqBXYwv1SCkh9mlL1jknbTubRVzFUiFj4TznEdKUu
        kozw5/XPdOFNtyZo8RuHnrrvOA==
X-Google-Smtp-Source: APBJJlEudfEkjB88rU8TlZeFV2wHcBU6iI5jDWRn+yce99ONhxxK+rONWu7v5yV3mkDtuhuaaLLX/A==
X-Received: by 2002:a5d:595b:0:b0:316:f3cf:6f12 with SMTP id e27-20020a5d595b000000b00316f3cf6f12mr7043606wri.48.1691071624574;
        Thu, 03 Aug 2023 07:07:04 -0700 (PDT)
Received: from localhost ([147.161.155.117])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b002c70ce264bfsm21841029wrs.76.2023.08.03.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:07:04 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 2/3] ublk: move check for empty address field on command submission
Date:   Thu,  3 Aug 2023 16:07:00 +0200
Message-ID: <20230803140701.18515-3-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803140701.18515-1-nmi@metaspace.dk>
References: <20230803140701.18515-1-nmi@metaspace.dk>
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

In preparation for zoned storage support, move the check for empty `addr`
field into the command handler case statement. Note that the check makes no
sense for `UBLK_IO_NEED_GET_DATA` because the `addr` field must always be
set for this command.

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 drivers/block/ublk_drv.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index db3523e281a6..5a1ee17636ac 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1419,11 +1419,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			^ (_IOC_NR(cmd_op) == UBLK_IO_NEED_GET_DATA))
 		goto out;
 
-	if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
@@ -1452,6 +1447,12 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 				goto out;
 		}
 
+		/* User copy requires addr to be unset */
+		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_mark_io_ready(ub, ubq);
 		break;
@@ -1470,6 +1471,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 						req_op(req) == REQ_OP_READ))
 				goto out;
 		}
+
+		/* User copy requires addr to be unset */
+		if (ublk_support_user_copy(ubq) && ub_cmd->addr) {
+			ret = -EINVAL;
+			goto out;
+		}
+
 		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
 		ublk_commit_completion(ub, ub_cmd);
 		break;
-- 
2.41.0

