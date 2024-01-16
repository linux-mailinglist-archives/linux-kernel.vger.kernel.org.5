Return-Path: <linux-kernel+bounces-28121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E982FA71
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037361C26205
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4977155A5E;
	Tue, 16 Jan 2024 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK/cJiKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65C1552FC;
	Tue, 16 Jan 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435185; cv=none; b=Zy5F86ou8Wjx67z+4hQfkBWjtnKupx5JaJiKWkNhMCwrantDPXGSxxQ5RmQqZIUtzWoHNzTEcW3L2ajpdWqy18SFwXAHyZqQF2dpKbQhZx3uxSAF2r54yQxYlMj8ttQyD9RwMy8ETYfFMX8VVPyblr0Uxo8eXbzSgrjF+oaj1N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435185; c=relaxed/simple;
	bh=XdYfm+3odQZeEhDrRV4dPG+GzbcxPv7kMkfJwdHtNT8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=pAX0DJBM/iezTqm+gnv7elnH/6Gaeq9q/uySwIBBm4piyJNESOHthF91bqByBBdkED/JNIvcaIpH9ah9gVZLT3On3jFVn5mIQbliznsX3eqpSGOEk78YTgWgoOr/2NwfqE61hKJaJY+LGrMuhZPw0GMfHA8aBak6FoYsKEL8nN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK/cJiKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD48C43390;
	Tue, 16 Jan 2024 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435184;
	bh=XdYfm+3odQZeEhDrRV4dPG+GzbcxPv7kMkfJwdHtNT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hK/cJiKJiImwbXMPvje0+JaSR9qiZCAnxn8knf+xyhH7Nd/60OqW7BGgT5whIBbW8
	 g+DatIXN7vuAKujHn42wE5wd6ddCZ3ETCTMQqedm7ISw0wqhPchIwRQLwIrzNY3OYn
	 gDdNt6qoT+hWetv58itjgdurO5NQlARjUqYVMdHRHCUc5DFlZ0UUwQJvvDcMX/Vaek
	 hTa5cldMnQE2U/q/lnlKWWRs2hRUbS22I5tEAFi/6F7M5HUyngPA7fvwmAA8qzF94I
	 Z9MDQaM192Oyb//MkyXJdH1M5FV/Ehw4Bja70TFqsjXr1FPv8SAcu6GZ29UjgxcLm8
	 pyyxavMvSp56g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Waldekranz <tobias@waldekranz.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 33/47] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
Date: Tue, 16 Jan 2024 14:57:36 -0500
Message-ID: <20240116195834.257313-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Tobias Waldekranz <tobias@waldekranz.com>

[ Upstream commit fc82a08ae795ee6b73fb6b50785f7be248bec7b5 ]

mv88e6xxx_get_stats, which collects stats from various sources,
expects all callees to return the number of stats read. If an error
occurs, 0 should be returned.

Prevent future mishaps of this kind by updating the return type to
reflect this contract.

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.h   | 4 ++--
 drivers/net/dsa/mv88e6xxx/serdes.c | 8 ++++----
 drivers/net/dsa/mv88e6xxx/serdes.h | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 8271b8aa7b71..6b7307edaf17 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -578,8 +578,8 @@ struct mv88e6xxx_ops {
 	int (*serdes_get_sset_count)(struct mv88e6xxx_chip *chip, int port);
 	int (*serdes_get_strings)(struct mv88e6xxx_chip *chip,  int port,
 				  uint8_t *data);
-	int (*serdes_get_stats)(struct mv88e6xxx_chip *chip,  int port,
-				uint64_t *data);
+	size_t (*serdes_get_stats)(struct mv88e6xxx_chip *chip, int port,
+				   uint64_t *data);
 
 	/* SERDES registers for ethtool */
 	int (*serdes_get_regs_len)(struct mv88e6xxx_chip *chip,  int port);
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 6ae7a0ed9e0b..e0e1a1b07886 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -338,8 +338,8 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	return val;
 }
 
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
@@ -787,8 +787,8 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	return reg[0] | ((u64)reg[1] << 16) | ((u64)reg[2] << 32);
 }
 
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6390_serdes_hw_stat *stat;
 	int lane;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 8dd8ed225b45..02966e520dd6 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -163,13 +163,13 @@ irqreturn_t mv88e6393x_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
 int mv88e6352_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 int mv88e6390_serdes_get_sset_count(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_strings(struct mv88e6xxx_chip *chip,
 				 int port, uint8_t *data);
-int mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data);
+size_t mv88e6390_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data);
 
 int mv88e6352_serdes_get_regs_len(struct mv88e6xxx_chip *chip, int port);
 void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p);
-- 
2.43.0


