Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BFC7690F5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGaJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaJAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E3283;
        Mon, 31 Jul 2023 02:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97D160F2A;
        Mon, 31 Jul 2023 09:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D068C433CB;
        Mon, 31 Jul 2023 09:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794008;
        bh=HRgq8PnvNhpR3/55CfJPsOVwTF/5PMq6rz6tiVpFMTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoZMXKWU9tJV0tkUTimjGAOnp/MFr3ph4Zf4a8PGkLvW6F0Oxnaua4udM0PgNYt7m
         dGIaSrax3BqYQ1bexEKE+N3UU8KRFm3ggetszu7MqISTcb1BaEEXVNaaaxGeAfIJ2F
         fPQJRFKLoXBcyD4LsJACB25PTHxCi+K/MqrR82ZPbeYlGsuh9/3wb35CV8ZNF2bEZT
         1G7/NSK8WwG49sA3hcrjt6KSvwGGX+pH/3FP6UsRtx8N4R5CPX1Q1L9NNFJeimIOax
         0cL+weqnv4CPLSxs2zR+KqomYmuGrw+o91lp/dLDNd9PPLFMoXoGa5kkH8r1wZCjfz
         ET+6PKS68AYNA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/7] tty: synclink_gt: drop global slgt_driver_name array
Date:   Mon, 31 Jul 2023 10:59:57 +0200
Message-ID: <20230731090002.15680-3-jirislaby@kernel.org>
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

It's used on one place, so put the containing string there directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 00efed2c139e..c2ab7ecf0900 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -88,7 +88,6 @@
  * module identification
  */
 static char *driver_name     = "SyncLink GT";
-static char *slgt_driver_name = "synclink_gt";
 static char *tty_dev_prefix  = "ttySLG";
 MODULE_LICENSE("GPL");
 #define MAX_DEVICES 32
@@ -3683,7 +3682,7 @@ static int __init slgt_init(void)
 
 	/* Initialize the tty_driver structure */
 
-	serial_driver->driver_name = slgt_driver_name;
+	serial_driver->driver_name = "synclink_gt";
 	serial_driver->name = tty_dev_prefix;
 	serial_driver->major = ttymajor;
 	serial_driver->minor_start = 64;
-- 
2.41.0

