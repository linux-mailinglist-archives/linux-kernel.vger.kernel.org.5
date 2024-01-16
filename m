Return-Path: <linux-kernel+bounces-28081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEDC82F9F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 022DEB26079
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA314CD1F;
	Tue, 16 Jan 2024 19:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKOSqTS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CA14CD06;
	Tue, 16 Jan 2024 19:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435056; cv=none; b=soRnPwXsJ1O9EfJZLhyKboDq5/v1h54Ebt3fhEmCfOl3cQb4pK+QRvJH6qgvXAsfR+fZ5F9fpnQ4sPMaUhv/l7FJxDCvL6my8NU4gS2UOatme8YECdqtGEfl+IQWzWd8+chb+6YL9UvNHJDqDMTdQux43adSIgjcjOprPIUzfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435056; c=relaxed/simple;
	bh=/FGNtcpXl8/jDDF8sLW9byfBF0V8Vmehgd334Qz9yyM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=tRG+g7aWAdAXj+iS7JF6BSAKa76ci3nUG7IPAx+fAyfA6REJ81/wxq98L+zsqgBxwxlxrcXErm/gvIEGZ7FyWmyeL47aBP32j9itQWS+AUeDKo8psK4f3PdZrgxIxGHxWkXh5bQ67TyD2fhnN7g+QAiJNPZ5GWX01c9U8gO3zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKOSqTS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883A0C43399;
	Tue, 16 Jan 2024 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435056;
	bh=/FGNtcpXl8/jDDF8sLW9byfBF0V8Vmehgd334Qz9yyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKOSqTS1qub3ovmfiPOgUXm5aPGsz9q43BzRw1+zPEC7YB7NJVA8jbCDEIYDl5QIn
	 00DedKy4AoF6+Xm/HyUvio6nkVKd4snq65ggD5E/4OUXF9Mku8us39EnIPNe6vcidB
	 vir8UoOJE+TQkSqNnotEE0D2CYct0v5Fs5t19XRj7az6WQ+UVlshBEZ3jH+TWiQVKY
	 8Z/+uO7JToURssTYbR1PQJIvOrR1JPkdmORMph5YyUBePNyd7UFIQjAGurCa4isZY9
	 hJ8PxQChfnQ3GOMKcOJBjfWHKGJgtUe2m0ZfGj8rVG2ydhEx1bTyuEMuMAUoUe0fZr
	 c6xzCGDqJk43A==
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
Subject: [PATCH AUTOSEL 6.1 63/68] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 16 Jan 2024 14:54:02 -0500
Message-ID: <20240116195511.255854-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index 4c5793053393..81f5974e5eb5 100644
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


