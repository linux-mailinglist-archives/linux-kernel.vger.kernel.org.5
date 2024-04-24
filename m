Return-Path: <linux-kernel+bounces-156847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF68B0910
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F801283BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542515B96B;
	Wed, 24 Apr 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jFGpnxzp"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11C15ADA6;
	Wed, 24 Apr 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961015; cv=none; b=LmX507xOPLnbslKwVQSI+r8Nzbp2EQEcWFTVF1oX5/jcX3U7eRHdIkZjAbFYpmFkwSKJssiJWgrBz6MpTb6yC9zOvWGsUu9FyylJNIgZy/GuRclhjfenBnVXq/9rcOy0j3axQsAQRL7mWBhku3eWDfD9yFCQT2FdCD7/VHjQgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961015; c=relaxed/simple;
	bh=uPBYsIyiiEFEvZqPZEpLvz84HGap+VSrek84RUNYIOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2kb/sWz2LOwzfUBVDie/SwYu/CNf1mG2qkbfyBPjVaBYcrnBtNGmhK/IsDoxXInJYlOOAqVUDMLiGJbhGbhnoGdjKGzHdNUUhCJXElgOjTa8b4+9AV24EA6mDYR78/h41qKkmFhyiMPSjtte39l7Dnkh99nCHQQGEjx9odcRM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jFGpnxzp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EF0FE600AF;
	Wed, 24 Apr 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713961004;
	bh=uPBYsIyiiEFEvZqPZEpLvz84HGap+VSrek84RUNYIOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFGpnxzpZ4ybBphl4wFEMJrlSed+bG0cdeadajBxD7ZBLhs7vLTKmMzGTdleRpfJU
	 1dRVxtIS4+A1mQO+Fnlz519CEDA4E2zcOn4Ya6y+VDiVtGYOkJBUyO2QN4itQbeYRp
	 r2qgodXDyAO0zvjw3a/6JZyA31iaQjnGW4/yCK8rVADCXaa/mYEFHYKNC/PePVPtxr
	 VxuBx2laNbvQ1AusJr9x7yeaJDEUOKtzZNvT8JvappY0Zv+ye1RCHoLAjV1N5iaPRx
	 0bwm7lEa86UqZNxkBspS6+Ctp9FGkdELK8jqwfNQjZA6Pyq3CzwDb40PTljIKNUbXD
	 +7zRYMu/K/JvQ==
Received: by x201s (Postfix, from userid 1000)
	id 7E77821BB45; Wed, 24 Apr 2024 12:16:36 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 2/4] net: sparx5: flower: add extack to sparx5_tc_flower_handler_control_usage()
Date: Wed, 24 Apr 2024 12:16:23 +0000
Message-ID: <20240424121632.459022-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424121632.459022-1-ast@fiberby.net>
References: <20240424121632.459022-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and aid future users.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index ca9e69d39439..d0dca65f8e76 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -159,6 +159,7 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
 static int
 sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 {
+	struct netlink_ext_ack *extack = st->fco->common.extack;
 	struct flow_match_control mt;
 	u32 value, mask;
 	int err = 0;
@@ -178,7 +179,7 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 		u8 vdt = sparx5_vcap_frag_map[is_frag_idx][first_frag_idx];
 
 		if (vdt == FRAG_INVAL) {
-			NL_SET_ERR_MSG_MOD(st->fco->common.extack,
+			NL_SET_ERR_MSG_MOD(extack,
 					   "Match on invalid fragment flag combination");
 			return -EINVAL;
 		}
@@ -199,7 +200,7 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 	return err;
 
 out:
-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
+	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
 	return err;
 }
 
-- 
2.43.0


