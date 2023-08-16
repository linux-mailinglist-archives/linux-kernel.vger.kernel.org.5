Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E5777DFEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244366AbjHPLA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbjHPLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18692712;
        Wed, 16 Aug 2023 04:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75ECC665D3;
        Wed, 16 Aug 2023 10:58:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85E6C433C7;
        Wed, 16 Aug 2023 10:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183517;
        bh=fNEfGkwMMbfLXMQISVUXDfoX7yFP8+G69JbMFx6WlHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFgR9U1TOLVZbZC4rdr5k5GiznGwYldRR2j0xT9LA4Kcf8oXPSoIlGGmUmHl0vq6P
         qBrlxPv4xGNP7fXDYOGuD/J70tz4iz/dpgowv456aoFVGH9SxPnSqmQ3QFgrWp2oHo
         RYozsyNyMn/lu4dgtbyBJdteB53RWvrB8OijAZ07Uizq9Mdea71ZPDmfO9gl6gXToi
         i55FuaL4oCnQso4nexq4DZwWcHJnuQcUVKVyaaYNcKxVCHHfKQdpK0kyUlEq2VIxrx
         /jkk6vH+cxoz84oDGNpf894hrZz7lBiUUQWKp0TswPki9DbZ7sFf7FqmK8zYZWG0WC
         ocy8ucjs5p5DA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/14] tty: n_tty: use time_is_before_jiffies() in n_tty_receive_overrun()
Date:   Wed, 16 Aug 2023 12:58:12 +0200
Message-ID: <20230816105822.3685-9-jirislaby@kernel.org>
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

The jiffies tests in n_tty_receive_overrun() are simplified ratelimiting
(without locking). We could use struct ratelimit_state and the helpers,
but to me, it occurs to be too complex for this use case.

But the code currently tests both if the time passed (the first
time_after()) and if jiffies wrapped around (the second time_after()).
time_is_before_jiffies() takes care of both, provided overrun_time is
initialized at the allocation time.

So switch to time_is_before_jiffies(), the same what ratelimiting does.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index e293d87b5362..996cad23e385 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1173,8 +1173,7 @@ static void n_tty_receive_overrun(const struct tty_struct *tty)
 	struct n_tty_data *ldata = tty->disc_data;
 
 	ldata->num_overrun++;
-	if (time_after(jiffies, ldata->overrun_time + HZ) ||
-	    time_after(ldata->overrun_time, jiffies)) {
+	if (time_is_before_jiffies(ldata->overrun_time + HZ)) {
 		tty_warn(tty, "%d input overrun(s)\n", ldata->num_overrun);
 		ldata->overrun_time = jiffies;
 		ldata->num_overrun = 0;
-- 
2.41.0

