Return-Path: <linux-kernel+bounces-114931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEE6888C06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185A528D597
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B921BE26E;
	Mon, 25 Mar 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcsdHBKb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642727F0B0;
	Sun, 24 Mar 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323605; cv=none; b=cazHFzTiKYjg7bkSc7kvlR3/4mlLIlGuDkKDD3N/Sp8SEnRoR3fPqzAqU371kcmIUSKTCiX8GhUGuSrcKA1teXMSOrSJ4ZBVyJXD/1Bup4HXteuVk0ZK08wa4udOvgO/F6mH6n3kNmFhfzmkpHGkrgxkg+lZYJHcy3ywLdA6RrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323605; c=relaxed/simple;
	bh=DMarUFrcpgU0h+phKoJ4W3E1vNnZHI8pqt2yyjTBQas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5QpfhPiqoO6GDE3zBr+Xg5KcmHQJhxdVeouk54PT4U7/0Wm782CBKTyamljnySKURdC995YR/VnUZqamvND+mmweszvaLeZjGHyCqN11gFEU09ko9jceq/XUKMIzKiDyGcCQrdVxOVggysV/yl2/qqGAzA8aiFLpqcuVVVNBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcsdHBKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D6C433A6;
	Sun, 24 Mar 2024 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323605;
	bh=DMarUFrcpgU0h+phKoJ4W3E1vNnZHI8pqt2yyjTBQas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcsdHBKbCSpNHyWT1BzRZCg+BZA3ctvkk7P+PFgYlVBRvACx5Ata0Ae7wPKeZAQoM
	 AmfMoiJIJLo/ipb/UVrRbazBZe8tVCm5oy3F2sCy0ohN7DOvvuDWnTkI7WjfKZPoKt
	 bXVDIQr0GyYEgKV5NMQEeGQEuTNEbNTomDdEbm6b3N8WNkZsDMEj3cTtDANCo6MeVv
	 0Y9nM+1o1ef6tGGy32WdOeC8uEip0RM29FymmxRX5IFybmslUTKzD7g1eShhE6A7E9
	 Qah1d7cpQ3KYhBGTkhp2R4Vls/azIwMXeFgYyo9ZwNu+ldEDu+w7bf66Xs9Msncyd9
	 mucVyrzXtRioQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 311/317] net: dsa: mt7530: fix handling of LLDP frames
Date: Sun, 24 Mar 2024 19:34:51 -0400
Message-ID: <20240324233458.1352854-312-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arınç ÜNAL <arinc.unal@arinc9.com>

[ Upstream commit 8332cf6fd7c7087dbc2067115b33979c9851bbc4 ]

LLDP frames are link-local frames, therefore they must be trapped to the
CPU port. Currently, the MT753X switches treat LLDP frames as regular
multicast frames, therefore flooding them to user ports. To fix this, set
LLDP frames to be trapped to the CPU port(s).

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e8bf353577f3 ("net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 4 ++++
 drivers/net/dsa/mt7530.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 636943035c292..252e8eaa92767 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -999,6 +999,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	/* Trap BPDUs to the CPU port(s) */
 	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
 		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
+		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
 }
 
 static int
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 91508e2feef95..8cee462d5f1cb 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -66,6 +66,11 @@ enum mt753x_id {
 #define MT753X_BPC			0x24
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
+/* Register for :03 and :0E MAC DA frame control */
+#define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+
 enum mt753x_bpdu_port_fw {
 	MT753X_BPDU_FOLLOW_MFC,
 	MT753X_BPDU_CPU_EXCLUDE = 4,
-- 
2.43.0


