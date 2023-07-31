Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA427690FE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGaJAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGaJAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4EE125;
        Mon, 31 Jul 2023 02:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF6B160FA0;
        Mon, 31 Jul 2023 09:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C3C433CB;
        Mon, 31 Jul 2023 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794014;
        bh=bqTVXbRunEpODgYOcmi3I5Ad7VnQnc4RQhFgP2aeJGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BP/VyGV5WZSSospGjdgCqfrdB69q2pOjibbP5kmw7UpdGI7w81E8/mtnPCOis6d5q
         /PSgBubVNxETXQ5EIMx0DRJ4hZld7g1+q6GGhonpo8F3/PFjpHQBi1cxtTwLzA5ehA
         fr0g6parwBSRuZ136O1NIElrVekImwZqZ4XOx2pG3ic1eaIwwZL6y6sAGye2wgtnj4
         lX6MTPVX2EL+KUnFh8pIDFayjGWRPQznVqkzNVwlz8BvJRSY4LpjpJFn5Qp7hsKtmQ
         DlbKdDeQyRTwV9yGCZJnXVpgCeyG+3yCFaW16AzTHB/vYmBPbSu67Y5nObV8w5srIB
         +untWsPNXDXkA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 6/7] tty: synclink_gt: make default_params const
Date:   Mon, 31 Jul 2023 11:00:01 +0200
Message-ID: <20230731090002.15680-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

default_params are only read, so move them from .data to .rodata using
'const'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 381b2e22fa96..fe53e9c2c9b4 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -322,7 +322,7 @@ struct slgt_info {
 
 };
 
-static MGSL_PARAMS default_params = {
+static const MGSL_PARAMS default_params = {
 	.mode            = MGSL_MODE_HDLC,
 	.loopback        = 0,
 	.flags           = HDLC_FLAG_UNDERRUN_ABORT15,
-- 
2.41.0

