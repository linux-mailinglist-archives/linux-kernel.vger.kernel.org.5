Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AE77DFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbjHPLAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbjHPK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CD9212E;
        Wed, 16 Aug 2023 03:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F69665B1;
        Wed, 16 Aug 2023 10:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4ACC433CB;
        Wed, 16 Aug 2023 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183508;
        bh=0GR92p/xHgh+SB0Vh4UXvbMnYubrfRc1ALFS0imA2uM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLkSkS/fhOMC4hGJzXLPaGi3o47W4lyKfMAXYtp6gI8Z9o3uZPmOm/5ZaxWAr+t/P
         SXqVyjJTXMmbQnfdVsdEY6CIZUtybOno7Mr9WP5Ygjg0vFhXufd1h/6+0YQP3TaQgF
         9cLkhnNKTXOxP+sxp/VohC/x5k6KpNpwG6b4NqdUDUQ3HZQ+Y9oXnBwA811/jWiFdD
         mg9NhCfyKj+OCOc9mTzGt/Pxq748aExUIre5P1zT0YCJki9PBFZ0hEQlJCCwdazpYm
         Eu3VXFD2jgMvWMLvkr+WSX8iQP3qqvQrbf0h2ywcDd9BbWfHmXN3Y06m6IoTabC7J5
         AZcewPJgkdkGg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/14] tty: n_tty: make flow of n_tty_receive_buf_common() a bool
Date:   Wed, 16 Aug 2023 12:58:06 +0200
Message-ID: <20230816105822.3685-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'flow' parameter of n_tty_receive_buf_common() is meant to be a
boolean value. So use bool and alter call sites accordingly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f44f38bb412e..8b2bacb3e40d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1665,7 +1665,7 @@ static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
  */
 static size_t
 n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-			 int count, int flow)
+			 int count, bool flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t rcvd = 0;
@@ -1748,13 +1748,13 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 static void n_tty_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const u8 *fp, size_t count)
 {
-	n_tty_receive_buf_common(tty, cp, fp, count, 0);
+	n_tty_receive_buf_common(tty, cp, fp, count, false);
 }
 
 static size_t n_tty_receive_buf2(struct tty_struct *tty, const u8 *cp,
 				 const u8 *fp, size_t count)
 {
-	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
+	return n_tty_receive_buf_common(tty, cp, fp, count, true);
 }
 
 /**
-- 
2.41.0

