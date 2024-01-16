Return-Path: <linux-kernel+bounces-27872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2382F706
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD61F25A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814164CFD;
	Tue, 16 Jan 2024 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzwhis2d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179967E66;
	Tue, 16 Jan 2024 19:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434408; cv=none; b=dzZ9I8LpXoJ3ptW2YRsbweQyYC3sAX4MkB5BfXa3cMpNhVFGSNu2/5H2017+STKVUBKMpRvzs9pTnxjeQJvSF5oclhk1ZvnW8vlk287iiyI1HjEp2O1JxxgDRLgePkhSsaRHQuaNe+YYf870a8yI9AnR281Ij/a9/0sjqT4c1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434408; c=relaxed/simple;
	bh=+uc5dm6FdgtmXDioMFgkPdTlCQCatlLrmqOaGPqkTQI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=nRf13NpcrJ/LnJPQhlsPpoawywOE/7Yas63DmxOSLqSsTqS0JxV5ehgySv/J0YNQYlFuejkuA/N6IEpwHih1Qh3MBjuHo26BPAB6zHy28lXj2V4s36rgjfOLXspByKE2PltY6P2IEbfJkSBjhmsgbyXTRtP3NTd/tIuwrU7T4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzwhis2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D81C43399;
	Tue, 16 Jan 2024 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434407;
	bh=+uc5dm6FdgtmXDioMFgkPdTlCQCatlLrmqOaGPqkTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qzwhis2dE6gBaDxQUL3obxREAWS6982hwaXEJ6ZiF2XjnbyKsWsbAgoGV7Rkm7olT
	 aqu1yTh7wzS6cI3STPfy1i0rNpkkTBsix+8mUH8+/JS5FFM3GgD97Qy1zSiedX+b3N
	 i5/LqCKA2v89/zJZgszuFeI0mCvFOcaCYryIc7JModrTOamk55koN3rxbr7fn6sbne
	 N34vw3m2OOGykuJy+va2BnALE20KTQtYQoiwP8gmqn079LxbcgfBVgOZlYPU5JSHtO
	 zer/glQ8qqN1iPJ7S6WFjmCKWS6Boa44+QV5u9K5mvX7Ngnx22WXNdiVtPlqD0OlYD
	 VBWglET+7keJw==
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
Subject: [PATCH AUTOSEL 6.7 099/108] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 16 Jan 2024 14:40:05 -0500
Message-ID: <20240116194225.250921-99-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index baeebee41cd9..60298975d5c4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6526,7 +6526,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
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


