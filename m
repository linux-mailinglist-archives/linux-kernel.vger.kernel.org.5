Return-Path: <linux-kernel+bounces-116106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A658889951
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF2C1F325BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FAA28DFA7;
	Mon, 25 Mar 2024 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8PQoBTw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E178178313;
	Sun, 24 Mar 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323606; cv=none; b=Q8vXHE1J1HrgYw9N8yy+56GWTVkSKbNClf6xBl4saDRVKcFOr7908VCYm8gDkcPwXKl56QhwCI/01FfUH7JAP205OUFRCN85kUj8nlZ2N66W4mCnME2D5dq1cjvNk2sWO8UUQV4gkHfmuC5fK6Q+/ZKeCAFIzvl7vJoSArkIbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323606; c=relaxed/simple;
	bh=ATmspV2YRL0zGBJBt/KTvjwdHW4rqFDudFRNPbL94fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3Wz6FaYiJF+NZDaso+Tb8fHB6ZfuJgDy9CCMo7/PyXhrG8+eEc4l77H1Y/cE8eQtTUxT/0m3EB9RIcC8gR1yxF4v+1yRMDwWXX/ilfPqPbp+vXmdcN9gCjM0SH9KrjfsrzZ/25JUFS+w6wGgRc4OKNOCWA+S+Cs4b+taAx5Z/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8PQoBTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46629C43390;
	Sun, 24 Mar 2024 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323606;
	bh=ATmspV2YRL0zGBJBt/KTvjwdHW4rqFDudFRNPbL94fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8PQoBTw4HrfXQwbOdqrojqRwHDRFAzcRaxAZHAEKHFuiAEFtoJfIAv6xOkFCgE1m
	 s2REp1Fk+zckLjIHz94YCAvRol6/ZKo8ayKv/NxBlpqNF7DJipfN5nSPkSOilH+5ud
	 xxb9vmfxOF5o/+03ZHtcBRqvciJpHEP+LyxmtCoWcHMvQjlnb3syBMW5SZI/hCNuuv
	 8baJ0B1zNE1p95skUadN44suAWdPVQMGZY0pqIg6nPYz98zgxzSPOcFD3zTn1wPx8e
	 v7Mt7zT5XLDtuyelMs6cAq76qwgB8rbvK60ZToxmsEpKNvMH0+dWkYocAToZl4v5QF
	 cIAO+PDMuiwGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 312/317] net: dsa: mt7530: fix handling of 802.1X PAE frames
Date: Sun, 24 Mar 2024 19:34:52 -0400
Message-ID: <20240324233458.1352854-313-sashal@kernel.org>
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

[ Upstream commit e94b590abfff2cdbf0bdaa7d9904364c8d480af5 ]

802.1X PAE frames are link-local frames, therefore they must be trapped to
the CPU port. Currently, the MT753X switches treat 802.1X PAE frames as
regular multicast frames, therefore flooding them to user ports. To fix
this, set 802.1X PAE frames to be trapped to the CPU port(s).

Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e8bf353577f3 ("net: dsa: mt7530: fix link-local frames that ingress vlan filtering ports")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mt7530.c | 4 ++++
 drivers/net/dsa/mt7530.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 252e8eaa92767..30570b9dc88f2 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1000,6 +1000,10 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
 		   MT753X_BPDU_CPU_ONLY);
 
+	/* Trap 802.1X PAE frames to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_PAE_PORT_FW_MASK,
+		   MT753X_PAE_PORT_FW(MT753X_BPDU_CPU_ONLY));
+
 	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
 	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
 		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 8cee462d5f1cb..2c895f35383e2 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -65,6 +65,8 @@ enum mt753x_id {
 /* Registers for BPDU and PAE frame control*/
 #define MT753X_BPC			0x24
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
+#define  MT753X_PAE_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_PAE_PORT_FW(x)		FIELD_PREP(MT753X_PAE_PORT_FW_MASK, x)
 
 /* Register for :03 and :0E MAC DA frame control */
 #define MT753X_RGAC2			0x2c
-- 
2.43.0


