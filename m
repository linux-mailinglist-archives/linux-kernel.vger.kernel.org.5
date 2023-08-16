Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7403E77DFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbjHPK7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbjHPK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969002D6B;
        Wed, 16 Aug 2023 03:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6B3A6658C;
        Wed, 16 Aug 2023 10:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BFC433C9;
        Wed, 16 Aug 2023 10:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183507;
        bh=4M+311SCFHjZNmmXmuQ/Cv4yRF1MEJ3AD4kmj9Cg3lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVCFNLPov+BxKElL+WEweAvekMzsgVZVuehO78//6u4KJGclRdgkTwas8CstpYjaU
         5EoZLkbzfs6KkbGnHWsLBlc0rLayV3Vj3ybynQGEZf6neTdMEOI30JpAM2pmEs1zOC
         83e1l7YVl3FhtScIUoWf60zJzqFx3MNSK8gBlQIX5+0PKsPagL9Qn7PxFjGbDEtXdN
         yxK9+8LyPMgYt4io0Ry58xAcRJtXy+v8ypS5NkPUhPgeG4mXrRC/Zg8Hz5WsUNWYsI
         oyN6TiVhmZ2H2b10XFqJn7vgmPfvDK3futPsDZwhUZv62rZ9K53juVRV1rVfzPMFO+
         PIovGvTkiqfZQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 1/4] n_tty: drop fp from n_tty_receive_buf_real_raw()
Date:   Wed, 16 Aug 2023 12:58:05 +0200
Message-ID: <20230816105822.3685-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'fp' parameter of n_tty_receive_buf_real_raw() is unused, so drop
it.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 552e8a741562..1599012f20c8 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1502,7 +1502,7 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned cha
 
 static void
 n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
-			   const char *fp, int count)
+			   int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
@@ -1597,7 +1597,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 	size_t la_count = min_t(size_t, ldata->lookahead_count, count);
 
 	if (ldata->real_raw)
-		n_tty_receive_buf_real_raw(tty, cp, fp, count);
+		n_tty_receive_buf_real_raw(tty, cp, count);
 	else if (ldata->raw || (L_EXTPROC(tty) && !preops))
 		n_tty_receive_buf_raw(tty, cp, fp, count);
 	else if (tty->closing && !L_EXTPROC(tty)) {
-- 
2.41.0

