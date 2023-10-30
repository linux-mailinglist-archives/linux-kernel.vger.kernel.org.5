Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215077DBC16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjJ3Otj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3Oti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:49:38 -0400
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D43ECC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:49:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xTa5qOlxecvbdxTa5q48rW; Mon, 30 Oct 2023 15:49:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698677371;
        bh=cE6pCOkG8VB8NCmHUswVDdYmjB1x/ugVETT8yljrntY=;
        h=From:To:Cc:Subject:Date;
        b=Er2l+6NauL9234lJe7ylyNTS7h2FxAYZxIGdbUrnqT7VfXoom0z5tvfFX+wo/kwNT
         XogrjtbgxYUWy1xFHaL9wpsWjPnsRHYyd171U+cbZ7NhD0Zrkmbq0fvI/Nlm3Dm2YI
         697gvVaod9WwwGS9U5lEBC1TMbmpsMo3zofyGKqDDjjViKFNG7tiIJy0cu1vux2BOM
         OFZykYnrx5D4/UXRyAglnMe8cJohqJRv5ZwAp2qcSLqjDTVPhDgsBCUyGK2281IPvB
         5zntwOGXgeO3sKoRnUYOWvFQWIKzfmgpaWC8HEJbAIYnKBVOb/McdJpLFV/1i+MLWR
         rBQD1EiMkBQKw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 30 Oct 2023 15:49:31 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-tcp: Fix a memory leak
Date:   Mon, 30 Oct 2023 15:49:28 +0100
Message-Id: <7f132cc47e627d63ddb084f3d0fcad10956d1e35.1698677322.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v2: - move ret = -xx; to the main path   [Christoph Hellwig]
    - Add R-b tag

v1: https://lore.kernel.org/all/f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr/

Personally I prefer v1. Pick the one you prefer :)
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4ca..f97711fc9f9f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1423,13 +1423,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
 	}
+	ret = -ENOTCONN;
 	if (queue->ctrl->ctrl.opts->tls) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
 		if (ctype != TLS_RECORD_TYPE_DATA) {
 			pr_err("queue %d: unhandled TLS record %d\n",
 			       nvme_tcp_queue_id(queue), ctype);
-			return -ENOTCONN;
+			goto free_icresp;
 		}
 	}
 	ret = -EINVAL;
-- 
2.34.1

