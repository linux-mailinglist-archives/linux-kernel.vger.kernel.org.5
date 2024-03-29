Return-Path: <linux-kernel+bounces-124495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595FB8918E6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBBB1C2474E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9E13E3EF;
	Fri, 29 Mar 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxuMq072"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C913E030;
	Fri, 29 Mar 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715238; cv=none; b=hoFX0qdXgHXiCwyy2L68FjMGAw8EitEbkbYqo3EQXiwqd3RoSZFSu26Rkj1QzQzp9B28faExsRVxYniFBQHlbHRpUAxy4cbGr+uuHO7RgnUSnR0kRXWan4T29nuhYWZfv6T4GOqfUch/PSNqjW2Kh1lKZ9HuKpT7KZ1fCEOmNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715238; c=relaxed/simple;
	bh=8Smicv2jiLDaQ0/aU+KkppraUPt+ZIfrbIo7NOQkRQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhY1hRQUrJNmHsAkoTq/by1XDXIRhJgCPAC1sVa0go4D31iG/3q9qN1HRBzDMpjZl/DzEr6KeFOWLSFyix829hxG/kkXK+cwo8sZD9Gl4F9j9ilPXGMqbDJWnv0HKyEoCojfbL6vHjSS6yeR0FITWNt+D/ILIf3bKr9lBqzwJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxuMq072; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B76C433C7;
	Fri, 29 Mar 2024 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715238;
	bh=8Smicv2jiLDaQ0/aU+KkppraUPt+ZIfrbIo7NOQkRQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxuMq072BIUSCKh3f2YP1s64hA8/lqNHH09EjooEpaKZabpNm/5cgXGSoXH+sr/ws
	 iYeqcSrYg0KH8500wwtR+JfQB5g49zAzn6r6MdISnP1G5ULRgZ00nkUZB0gohbPhti
	 x9hjVVND1EKBoXnSGkjqeZkNtPm8IrzI1hHcodG5Ogb2m4a0uryCgwEYnhPoObS/3C
	 AZlxcjCO+/nt0a/u7pWj04tyNSymNUr6piblLtE7SsXTG7kS7DOnPflQWz3QcOi5u0
	 PeHVIk+uUygkL2b2nrgKGPp76zUMmSj7GCoY2XdOU85fCpAN2u2tYGNzrcB0tNJi9u
	 tPIejznfQMhIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ansuelsmth@gmail.com,
	kabel@kernel.org,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 14/68] net: dsa: qca8k: put MDIO controller OF node if unavailable
Date: Fri, 29 Mar 2024 08:25:10 -0400
Message-ID: <20240329122652.3082296-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 08932323ccf7f8c4c85db9cb12a791ed81264f66 ]

It was pointed out during the review [1] of commit e66bf63a7f67 ("net:
dsa: qca8k: skip MDIO bus creation if its OF node has status =
"disabled"") that we now leak a reference to the "mdio" OF node if it is
disabled.

This is only a concern when using dynamic OF as far as I can tell (like
probing on an overlay), since OF nodes are never freed in the regular
case. Additionally, I'm unaware of any actual device trees (in
production or elsewhere) which have status = "disabled" for the MDIO OF
node. So handling this as a simple enhancement.

[1] https://lore.kernel.org/netdev/CAJq09z4--Ug+3FAmp=EimQ8HTQYOWOuVon-PUMGB5a1N=RPv4g@mail.gmail.com/

Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 7a864329cb726..95d78b3181d1c 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -954,7 +954,7 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 	mdio = of_get_child_by_name(dev->of_node, "mdio");
 	if (mdio && !of_device_is_available(mdio))
-		goto out;
+		goto out_put_node;
 
 	bus = devm_mdiobus_alloc(dev);
 	if (!bus) {
@@ -988,7 +988,6 @@ qca8k_mdio_register(struct qca8k_priv *priv)
 
 out_put_node:
 	of_node_put(mdio);
-out:
 	return err;
 }
 
-- 
2.43.0


