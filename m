Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC075E829
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjGXBiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjGXBh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:37:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5319F3A86;
        Sun, 23 Jul 2023 18:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA66760F1A;
        Mon, 24 Jul 2023 01:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB8DC433D9;
        Mon, 24 Jul 2023 01:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162330;
        bh=VWn7I8aeOGGxbqba3PmdYM9O7ZKxNndmWAI4lNJd0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwPBp819TecWumj6uZkymau1WW2ikZymIXJzT4mvo3ofHWIk+UoJY9SkZDFNawKuA
         QijjltEbGmz0VVQVoW2LVz+rRyKLs5xzappYu0LRTldhIRa0UldzELDFLPYUhacs0Y
         DLCEVWhWNZWn9Wb4CqK6dVxymUZJe0M6YStrn3EjDzQaeS7EigQqJJuJvgdrOfguLU
         EIBtPTadQDDQQRk84b4ghxPtlFR4icoUJHmXImvVNneMiJ5mCB3uUi3CRRDyEdvCE9
         IG9X9V2Pp65qig15MrwM9As2xD310E47pgKyqsDcwk0Fufo0JIFJYRLSF/8fhiZDK0
         4WCefD41aFAGg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhengping Jiang <jiangzp@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, marcel@holtmann.org,
        gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 21/40] Bluetooth: L2CAP: Fix use-after-free
Date:   Sun, 23 Jul 2023 21:31:21 -0400
Message-Id: <20230724013140.2327815-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengping Jiang <jiangzp@google.com>

[ Upstream commit f752a0b334bb95fe9b42ecb511e0864e2768046f ]

Fix potential use-after-free in l2cap_le_command_rej.

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c5e8798e297ca..17ca13e8c044c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6374,9 +6374,14 @@ static inline int l2cap_le_command_rej(struct l2cap_conn *conn,
 	if (!chan)
 		goto done;
 
+	chan = l2cap_chan_hold_unless_zero(chan);
+	if (!chan)
+		goto done;
+
 	l2cap_chan_lock(chan);
 	l2cap_chan_del(chan, ECONNREFUSED);
 	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 done:
 	mutex_unlock(&conn->chan_lock);
-- 
2.39.2

