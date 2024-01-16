Return-Path: <linux-kernel+bounces-28008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE1E82F8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3B328A6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1928E0A;
	Tue, 16 Jan 2024 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQxLXWWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA275C21F;
	Tue, 16 Jan 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434826; cv=none; b=JF9FfXJUEPkvtHDpuK4CnaAaBoAIfEfSBh9hyo3IIdmT81FNuOYBpK5Fz6b6B4BeTcglLcTy6pcAIKFR6SvfDDPe52ygo+7RZg428DzIh3agWfvka09ZAOl9GQt0ZE2IJxGRwaUbduFGtzLMuZgFjcwr+dnVhSrkodEG7QVaoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434826; c=relaxed/simple;
	bh=+uc5dm6FdgtmXDioMFgkPdTlCQCatlLrmqOaGPqkTQI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Ip9Q9lQalwxfa+sME+1GOd22LDwXCycUsmitaZIA1oaSxePBY7k0LQCqnRAJGOff0YT3DnS7q5HMuBSB1ynMcbt4CHUYww2L9r2gqHq7tSYeCMlbWoWS1cKrLJkHPemTWe6e7YNXKDFEuH4xI3AAiaYEWdVjUs0tRhlPyBja1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQxLXWWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42663C433F1;
	Tue, 16 Jan 2024 19:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434826;
	bh=+uc5dm6FdgtmXDioMFgkPdTlCQCatlLrmqOaGPqkTQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQxLXWWiPBCDNECS5um43iwhu2lRMWE3F8ymYdQm8YDIsb4rZdjT5Xrkoy/5Uk1Hn
	 qNjWFuNy8PeZ3nmAOPxbZFhpNireISl863EfC70Yqloc17/9b++Iwavezt3pCn7S2p
	 iRW4Kw7PvZpXiM8PMM2T6QcDl1L9VJeE3CQm1ZDTnrLsg9HSl6Mahn3kw8R8FV6gII
	 YGZhP3NixNo17JGErVUpkwKNPqb/BFiwQ4FK5SV82Z4L0TPW+tj+8QTaW+YARwgnAK
	 nbkrjbVAQM1zyG/yic9wq10F5PzmwVKAp07ryeS/jSXItV8VHrBtqAFV3n+MNpEL/U
	 2uCAaHTrHEO7w==
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
Subject: [PATCH AUTOSEL 6.6 096/104] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 16 Jan 2024 14:47:02 -0500
Message-ID: <20240116194908.253437-96-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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


