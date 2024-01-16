Return-Path: <linux-kernel+bounces-28132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D1782FA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951EB2890FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E664735EEB;
	Tue, 16 Jan 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxHmjMKF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3348F63D2E;
	Tue, 16 Jan 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435206; cv=none; b=ttOluk3B25KnzZDaONSf3l4kAbS2GSsmWUdvO1MUvHjmEWD60rLo9kXC5TdVaznH2shMyYzaXtQzTVDfx0oGwXNqaugta26SxqxZAQliKagOJTRYOPseSgFGBJMYHHC1wa0r1WIq+z/+CB+jpJ2QsS/cc96LraDgLBiZv9p7OWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435206; c=relaxed/simple;
	bh=Q6t0rEUijPTx1Th9dajt8tEX4Z69jc5LtHqBY7UsTjs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=u3S9RJDE6JUiDBNYAjIckvxwcO6WQxfKdTMMmrfxJMUiCnB5EUaACFyV33ble0ubhzQOEgjSuCj2C8epQpdxf3ynTdXUnsYRH2/gHxvdg4bYFiCygVkyrXHxnu6AHS9OWHXCZTv3qF6T++1mD85JuSD8mYl1xpM6OlKPv0OH+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxHmjMKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B4CC43399;
	Tue, 16 Jan 2024 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435205;
	bh=Q6t0rEUijPTx1Th9dajt8tEX4Z69jc5LtHqBY7UsTjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SxHmjMKFVOYYaX1n4HCdl3N73hXJRTTL1W9bb3+72ti6R5GiFZan0LLYjqzJwX0/P
	 jqKJuWdP2YXqvg9rbh5h97e0PbX3K11uSHr8TalJCpEz5+Kpihw8bE78PPy328qAGR
	 d7kcM9oxOAgXZfBRzV84vkcmtd7E57rF48dvO6qW7vl9Fe0eqPUEReV9vRtjArYbjy
	 zqUqWQfcG8HaDatUy/kY02fx3LR8SOiZyXy7fnu66C2vnBpDA+yN2gg9/elZLBduUX
	 be/UqX5HBD/vWYt2TSkDB3ICxjjBB+H1oz4vpk6dndye8zK9om8EmWD61JU9nXB+6m
	 6z2OZJGOZx+JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 44/47] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 16 Jan 2024 14:57:47 -0500
Message-ID: <20240116195834.257313-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis@collabora.com>

[ Upstream commit 96a3398b467ab8aada3df2f3a79f4b7835d068b8 ]

In case of an incomplete command or a command with a null identifier 2
reject packets will be sent, one with the identifier and one with 0.
Consuming the data of the command will prevent it.
This allows to send a reject packet for each corrupted command in a
multi-command packet.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9f3596de90a7..850b6aab7377 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6527,7 +6527,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
 		if (len > skb->len || !cmd->ident) {
 			BT_DBG("corrupted command");
 			l2cap_sig_send_rej(conn, cmd->ident);
-			break;
+			skb_pull(skb, len > skb->len ? skb->len : len);
+			continue;
 		}
 
 		err = l2cap_bredr_sig_cmd(conn, cmd, len, skb->data);
-- 
2.43.0


