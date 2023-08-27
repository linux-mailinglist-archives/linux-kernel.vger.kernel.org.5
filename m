Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99433789BDE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjH0HnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 03:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjH0HmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2399F4;
        Sun, 27 Aug 2023 00:42:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4849861CA0;
        Sun, 27 Aug 2023 07:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DDAC433CA;
        Sun, 27 Aug 2023 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122125;
        bh=+p9syg3SqA3BjH7qIieZYe9jsT8EkCDNx8jiBDIWh3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAkL41vzrd8VaN0o15hHBVUoY0kt0D8Zknktll3ivnV+8XR0nQYHcO3Fy5VtRs7yn
         Y7Wpnuq10sIkTfk3FwuzwQ7NG9wx0LwMjbOEe32AombRHMOAHp+vZoAp1JzHAMvg8h
         Cb4HVu1qPiMIauUO5FYDUPcqybQCYwX5InB6KfbbvHaJxxjoY3x6WrUBpIAV+LCPI7
         AuDvES9z185/sRUZe8Rq+JQ6tjURYtaakBoZIH7hEjeMxvthFH6uvuwGfKvKcBBSuL
         hsETnpoOoBPCpJ+uAJ2m0Y1QKYYdG3ARVnIAwXOEASR2+zLjmYw8IxWs6L4wXzAzjM
         trDepYd+j+JAw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 10/14] tty: n_tty: simplify chars_in_buffer()
Date:   Sun, 27 Aug 2023 09:41:43 +0200
Message-ID: <20230827074147.2287-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
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

The 'if' in chars_in_buffer() is misleadingly inverted. And since the
only difference is the head used for computation, cache the head using
ternary operator. And use that in return directly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 369f5dd9cc4b..e722065b2db4 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -219,13 +219,9 @@ static void n_tty_kick_worker(const struct tty_struct *tty)
 static ssize_t chars_in_buffer(const struct tty_struct *tty)
 {
 	const struct n_tty_data *ldata = tty->disc_data;
-	ssize_t n = 0;
+	size_t head = ldata->icanon ? ldata->canon_head : ldata->commit_head;
 
-	if (!ldata->icanon)
-		n = ldata->commit_head - ldata->read_tail;
-	else
-		n = ldata->canon_head - ldata->read_tail;
-	return n;
+	return head - ldata->read_tail;
 }
 
 /**
-- 
2.42.0

