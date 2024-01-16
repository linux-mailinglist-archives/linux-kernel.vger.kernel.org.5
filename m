Return-Path: <linux-kernel+bounces-27988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA582F8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FFD289B62
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1254125775;
	Tue, 16 Jan 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RATiBioN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43781137C4F;
	Tue, 16 Jan 2024 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434773; cv=none; b=XRDEZA0uNd0RJzf6Aqu02PwYoH1X2v0tSKbJhI6BAWYnkIp2NCj4MaoB1Txg7bIhjwng7K++Rkn11EqQEMhyN0QXSr+tJvrwhHW0IhtQfTE4xSiOzQqYwUwZLRhAlR1Wj7jHGTtLv4d/M4HZ1u+LYHoB+UDBUFKjAhCq4/nVxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434773; c=relaxed/simple;
	bh=GWno6YTcGCRMF9sb2JjBbd94P2+qY1I5giHJTO8LkTY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=RSm7OR0zjmS6y1FOaRgfIFvXd2dZAKWqv0dObI4aeRf1r4jW9fG94acQgFYMgA+Act+RNDG1l8K1lyzJj6LhaaPycfh52YM3hLgUdgIRqsFOuW2cJTMDQ94vN6hSBxTUL+IIOF0NyTTi1rtljY0XzAqXgm1wdVOFEXf48yfNQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RATiBioN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31B1C433C7;
	Tue, 16 Jan 2024 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434772;
	bh=GWno6YTcGCRMF9sb2JjBbd94P2+qY1I5giHJTO8LkTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RATiBioNvKy519T/7xYEjKFRd8WrCiu8EMT4gKtu79p1BFbZL47iGkwiY6MvX1sn/
	 bFje7NJC1QRSBexMcEzLg+5k6sQ8+utU5cfDSuYYidQI6+q8zZHyLt7BTrk7KAmD+n
	 l1SXBikDOQXh68VDM+z/+KcR2EPrT621C3QADF+tPkUDGkopAO8fdZj5mLypLwdeBO
	 Ebb0P73ADkeqXLtFytFpyb5btfDHQ0bsiPsiCQ9C70Bxzr8ESUZaZXDIU6yDvtgcvF
	 sHZlIS+9L09rt9nwp/H+TPAq2ZXqSRVF0PnFAqJLnqDityYKrZHRgggBrOS6ha5Pzt
	 CmIqAlDbDdJ7g==
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
Subject: [PATCH AUTOSEL 6.6 076/104] net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path
Date: Tue, 16 Jan 2024 14:46:42 -0500
Message-ID: <20240116194908.253437-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
 drivers/net/dsa/mv88e6xxx/chip.h   |  4 ++--
 drivers/net/dsa/mv88e6xxx/serdes.c | 10 +++++-----
 drivers/net/dsa/mv88e6xxx/serdes.h |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 44383a03ef2f..c54d305a1d83 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -601,8 +601,8 @@ struct mv88e6xxx_ops {
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
index 3b4b42651fa3..01ea53940786 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -177,8 +177,8 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	return val;
 }
 
-int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
-			       uint64_t *data)
+size_t mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
+				  uint64_t *data)
 {
 	struct mv88e6xxx_port *mv88e6xxx_port = &chip->ports[port];
 	struct mv88e6352_serdes_hw_stat *stat;
@@ -187,7 +187,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
-		return err;
+		return 0;
 
 	BUILD_BUG_ON(ARRAY_SIZE(mv88e6352_serdes_hw_stats) >
 		     ARRAY_SIZE(mv88e6xxx_port->serdes_stats));
@@ -429,8 +429,8 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
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
index aac95cab46e3..ff5c3ab31e15 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -127,13 +127,13 @@ unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
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


