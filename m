Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9027F28C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbjKUJXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjKUJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:23:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74870198
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:23:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1A6C433C8;
        Tue, 21 Nov 2023 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558595;
        bh=1ot3xOBoOP7h0U8F/4uFP8Qnn04pPCBCsYAQSIl1nS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMaaAFxtaDDQ56o7fXs0QGyJcFgyPvsmGh4mwdScBGVHv6QbGWvjUyLtBXJ/f+KuA
         ES0RVOIH2egtSF87/OHQecYS33l9Spw874MqkkK61gISBS5zFMgvG9tTjmiWBAvPTB
         ATJPBITN4yxZB9bPfXrJfbnzHQp0FdmotvxpyqJW/ocA/UfrLslKHaIQbbAdaby4zp
         QwjGZqMr4CZ0qPCu/+NaBP2kBb4DFEHQZBwpcBaIN2IJ8SaG75NZWm/MJfKYBLjObi
         uCBIjbzCMh+ZNi5Z6jiBQQRevsVtxJ8GWrV4auGzSjcn5+SL6YORjtdCp56fcZ1ApB
         ockXOFliS6RKQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/17] tty: ehv_bytecha: use memcpy_and_pad() in local_ev_byte_channel_send()
Date:   Tue, 21 Nov 2023 10:22:48 +0100
Message-ID: <20231121092258.9334-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121092258.9334-1-jirislaby@kernel.org>
References: <20231121092258.9334-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a helper for memcpy(buffer)+memset(the_rest). Use it for
simplicity.

And add a comment why we are doing the copy in the first place.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/ehv_bytechan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index a067628e01c8..cc9f4338da60 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -143,9 +143,12 @@ static unsigned int local_ev_byte_channel_send(unsigned int handle,
 	char buffer[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int c = *count;
 
+	/*
+	 * ev_byte_channel_send() expects at least EV_BYTE_CHANNEL_MAX_BYTES
+	 * (16 B) in the buffer. Fake it using a local buffer if needed.
+	 */
 	if (c < sizeof(buffer)) {
-		memcpy(buffer, p, c);
-		memset(&buffer[c], 0, sizeof(buffer) - c);
+		memcpy_and_pad(buffer, sizeof(buffer), p, c, 0);
 		p = buffer;
 	}
 	return ev_byte_channel_send(handle, count, p);
-- 
2.42.1

