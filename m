Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23C77A946
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjHMQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjHMQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123B52709;
        Sun, 13 Aug 2023 09:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A8BA639E5;
        Sun, 13 Aug 2023 16:10:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02E3C433B6;
        Sun, 13 Aug 2023 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943001;
        bh=JbgolobhW7kbZvMZt0HTCiNppeSYP5KrDUBliH8hbVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYUJVl131ogS0EDvTVizAa2+Xsvlq1pCLGTvBMQm6uvJ9rWodHSLAQVzYh186BE4Z
         M4xqDETGDi6RRp8dPLHodxIcJOmW19jso9a34X8m3hZLcyLdhdlTZrhdL0MBcGv2+I
         kzFXViWblhB1WAJgKa9U8u9rx/KzVgYYMHAJP8lxy8rxPuevSdI8xccwCAUzyPHkLN
         pTSAgQlzLEKj7RP9Q0aJM0GtIClr+M3larYc9R3EodGxA/wA9E4KpEjMpxac9SsIXr
         t45QbqLOymWOImDGMwDGimqbrOMD4TbSlnFa2HTXFRMGdqRerTWYFm57kHtxZTV+iG
         aUeZRF3GKszTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Simon Horman <simon.horman@corigine.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lucho@ionkov.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, v9fs@lists.linux.dev, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/25] 9p: virtio: make sure 'offs' is initialized in zc_request
Date:   Sun, 13 Aug 2023 12:09:16 -0400
Message-Id: <20230813160936.1082758-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 4a73edab69d3a6623f03817fe950a2d9585f80e4 ]

Similarly to the previous patch: offs can be used in handle_rerrors
without initializing on small payloads; in this case handle_rerrors will
not use it because of the size check, but it doesn't hurt to make sure
it is zero to please scan-build.

This fixes the following warning:
net/9p/trans_virtio.c:539:3: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
                handle_rerror(req, in_hdr_len, offs, in_pages);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index f582351d84ecb..36b5f72e2165c 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -394,7 +394,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 
-- 
2.40.1

