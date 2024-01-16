Return-Path: <linux-kernel+bounces-28179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172ED82FB38
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D40288FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439616274E;
	Tue, 16 Jan 2024 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTZrwGXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B1405E6;
	Tue, 16 Jan 2024 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435356; cv=none; b=QuWi5y738n3NMmbhPY04v7DrKUDnjHUKDTgxcTstzcDwKmEliKwHYQJk2/rI4ySH5NTYvFbWGEPtJSG0dcXKEN1k2dJdi636JvEzFD8xp6SYqvwK46x6ARQmZJgSQJjD628/HXhPpD74X4jLFhLVQGR4O4+kaPxsTfzEs+7HrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435356; c=relaxed/simple;
	bh=inm8NmCr2LVtNRp9tGC1LJb+ub1TbuC6R7m7WFdgzc0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AmH+VWnn06/ZqDn+G/ORZSvbx0XcROt26nm/JBeMR+BcFfki9FoMcP22JX2p8dxJlE5Q3IJYznz0AX213tcAosLC22LNBGOWFY/1W/X1fyRxKbnSzGW4Ec40vXkDW5XdAxNiengjNosun0IWNpYB97qo/41K0033z5fp5SWKlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTZrwGXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4A0C43390;
	Tue, 16 Jan 2024 20:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435356;
	bh=inm8NmCr2LVtNRp9tGC1LJb+ub1TbuC6R7m7WFdgzc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTZrwGXlIYKnq4nvqoSQ4fmhQejgShWJzkfpes7hCOtAOLqcZC/ds05hpcRgOtNtK
	 eODdvj0Shbd6DvSK1oeNPwr2MwqeAU5lijIlEdqfvYXUh5Ri7zDuhTKD98DZbBXCt/
	 d9tAb+QUqKxFiiVRV3fDIa8OXzU31/hVby4U5pGO+Z+h3KeUMuCH/+nW86NwqXc/zR
	 W8jOp9zXg2ydFMpeddbwBQ7NW86nxpPaWcV/P/zsJ9iB3nhf5Ew/7lOXJr1NPOcDMH
	 bdo2XVaUkLS8HBZ50h0lhd8hvrccW0dda2csNY6GoDSpEXPXWCYfgbQDEBoEw7G8Sf
	 Io401tGgLvONA==
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
Subject: [PATCH AUTOSEL 5.10 43/44] Bluetooth: L2CAP: Fix possible multiple reject send
Date: Tue, 16 Jan 2024 15:00:12 -0500
Message-ID: <20240116200044.258335-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index cf78a48085ed..a752032e12fc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6522,7 +6522,8 @@ static inline void l2cap_sig_channel(struct l2cap_conn *conn,
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


