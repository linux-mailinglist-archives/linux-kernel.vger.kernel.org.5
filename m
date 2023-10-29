Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0C7DAE7E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjJ2VXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2VXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:23:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86B0C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:23:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xDFLqNd5aaLS1xDFLqPqM9; Sun, 29 Oct 2023 22:23:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698614581;
        bh=cYudL/+VuVwczFaR6V/ZH5x7fhb37FxDE0rQ3yQscdQ=;
        h=From:To:Cc:Subject:Date;
        b=i4AF/4kaLpgPF5GFykgjj0Fq6GL8kJ0whYcQI40Za4SZvoG8S7/LPDoVe/T1ldEFo
         xdJ/j4JtagGl66mjtb3rsd1aN3nbGORUBHisFIFCtlfU9sVGsB/6c1peOaEqggVLZC
         BmsQQLmLRNTmtC4POzvKQ8U0UuqDCQWJA5JBz1fdacvSUeQMeccHgGrRYa5ZuK06jm
         bOCkbTHiBuItwotvdlRE8Adk7aPno13mRQi88rdW7QooKrDY7OTCX+zSBdMYbW76Fi
         zGIrAT9iuCrsODqlvM938TU4e7spCdRAtGuwIlv1uqUNNpiPSPVWhc7Hor55mNe8UY
         9DUNhvXcUmb3w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Oct 2023 22:23:01 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: Fix a memory leak
Date:   Sun, 29 Oct 2023 22:22:57 +0100
Message-Id: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All error handling path end to the error handling path, except this one.
Go to the error handling branch as well here, otherwise 'icreq' and
'icresp' will leak.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4ca..3c35c37112e6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1429,7 +1429,8 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		if (ctype != TLS_RECORD_TYPE_DATA) {
 			pr_err("queue %d: unhandled TLS record %d\n",
 			       nvme_tcp_queue_id(queue), ctype);
-			return -ENOTCONN;
+			ret = -ENOTCONN;
+			goto free_icresp;
 		}
 	}
 	ret = -EINVAL;
-- 
2.34.1

