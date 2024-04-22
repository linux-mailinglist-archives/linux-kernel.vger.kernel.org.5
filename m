Return-Path: <linux-kernel+bounces-153629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF98AD096
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7761C20E30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0F1153512;
	Mon, 22 Apr 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FqFMbByC"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D970152517;
	Mon, 22 Apr 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799678; cv=none; b=hx6qe17vzrFbFk8EeMV2lD+fQgkJJieEQXW9D50R+Ob91te73DyNUMxumq8ElTB3DeGbA+8Ux2cJWSywTmlpRmfsijy7wCus3AcS5Hi6mYTCKuIAgFBl6D7JAnWFUpOs25hpjBIPjwbGiwC/70biVpyIKvyiD5vqfKycdSDRTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799678; c=relaxed/simple;
	bh=9APMM6BKT8m/hzGAQwjzscXPGMZLLFfsalscAwK6EjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GxTJip8pmQssP1dlWAhi/LrW/v948hWEl7NdpVstOQuI/1Pqc27/eTXDPFWgDHWCibAtX1AxWpOJFPDTkFj/An5uZ4TYDq0PDNs1aX/D4U3YoGMK6Tgbsd1T80hl9g/ZJNgB/HOimMsVBPRm06J+Q/3J8Zw0Fd0frSwt4gTrIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FqFMbByC; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id C5DB0600DC;
	Mon, 22 Apr 2024 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713799672;
	bh=9APMM6BKT8m/hzGAQwjzscXPGMZLLFfsalscAwK6EjU=;
	h=From:To:Cc:Subject:Date:From;
	b=FqFMbByC0WGcpaV9hp4nkc/Xb9Sj7263RcNzHmZTpu8MsEuxV/zG9f3/GZvfLWunp
	 X0rczxqFy9BzvlFpLUUjIwOfV7Edatu6nokP7CVY0KODg5+gcQnUwsgsAE0Od4tfuf
	 KARLXtChjB+843AOee3SiS1Wboe6hh77nk4nUtMxC9oTayKc0p7jS9Aizusg9nrpgm
	 92aaT9wcHIo3yomu+hLXtdlAsVbbzG8Of10mYDIAPxEgY31bJ5+4faMWJqhhTjEbgw
	 udlf68dOcWTdrDYoP0vVksi5TqvzfouIpU6toyFNytn7J949IWQYOsuxmJD8TjVYvw
	 izOsCvPiA1fdA==
Received: by x201s (Postfix, from userid 1000)
	id 722A2208EE8; Mon, 22 Apr 2024 15:27:28 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net-next v2] net/mlx5e: flower: check for unsupported control flags
Date: Mon, 22 Apr 2024 15:27:27 +0000
Message-ID: <20240422152728.175677-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use flow_rule_is_supp_control_flags() to reject filters
with unsupported control flags.

In case any unsupported control flags are masked,
flow_rule_is_supp_control_flags() sets a NL extended
error message, and we return -EOPNOTSUPP.

Remove FLOW_DIS_FIRST_FRAG specific error message,
and treat it as any other unsupported control flag.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---

Changelog:

v2:
- remove existing FLOW_DIS_FIRST_FRAG "support" (requested by Jianbo)

v1: https://lore.kernel.org/netdev/20240417135110.99900-1-ast@fiberby.net/

 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index aeb32cb27182..30673292e15f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2801,12 +2801,6 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 		flow_rule_match_control(rule, &match);
 		addr_type = match.key->addr_type;
 
-		/* the HW doesn't support frag first/later */
-		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
-			NL_SET_ERR_MSG_MOD(extack, "Match on frag first/later is not supported");
-			return -EOPNOTSUPP;
-		}
-
 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
 			MLX5_SET(fte_match_set_lyr_2_4, headers_c, frag, 1);
 			MLX5_SET(fte_match_set_lyr_2_4, headers_v, frag,
@@ -2819,6 +2813,10 @@ static int __parse_cls_flower(struct mlx5e_priv *priv,
 			else
 				*match_level = MLX5_MATCH_L3;
 		}
+
+		if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT,
+						     match.mask->flags, extack))
+			return -EOPNOTSUPP;
 	}
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
-- 
2.43.0


