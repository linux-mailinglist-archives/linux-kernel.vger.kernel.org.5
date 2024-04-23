Return-Path: <linux-kernel+bounces-154863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA68AE22B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BDAB210C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FA757EE;
	Tue, 23 Apr 2024 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="m/eVUzYp"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDD605CE;
	Tue, 23 Apr 2024 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868096; cv=none; b=eor4FLT1YwKQkFGx0CAIBkqJcB1/+uZGVXRpXvI5QX3d2sACtbF0+elWLqI6VR65+UuVP0irCeNYv+OispdeGAh+eYdUJaRyjVoA+bgca/o4nLtDVaH+MKGZEa9KVojp/b1wpuEUc2g/EgCM8UV6m5qCr+zua3yOFe4DtsKLOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868096; c=relaxed/simple;
	bh=GbgbLIqVueZ79treKLS9iJdrUpv0NyzGAiOwzj39kYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pq8sYY15/NVIbZzaDf7QULRUQiYo0VdQzlNYpAbaDg5Mi+5wxeUsrZdJf5OIKY0aT7FTubiqNzyibQ3nH8RnUZH5vwT6u5YPVsMyWvmnonQh+pBekyGcwZ4d745d13g/uL9n2mcYdxfpaR0e3TcnxOgwsr1P3/9zH5H8+2MRIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=m/eVUzYp; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 65025600A9;
	Tue, 23 Apr 2024 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713868084;
	bh=GbgbLIqVueZ79treKLS9iJdrUpv0NyzGAiOwzj39kYE=;
	h=From:To:Cc:Subject:Date:From;
	b=m/eVUzYpskwtknJ9ZxlPozVo6QZWCQ9FbQhylstWuaw96kOicAQ4lt29ijTTjFlzb
	 Tsb1C5zX0fWPEtFFf0e64LTfiK2meqbJCZDi7RFwPRUx+ONsGs4cCkYCyLwiMd2wsU
	 2TMWHgORu24xnX/c3gSLYNmwtk+trf8Qbpmimf911ZPCzaWD4/eFAezCBcexaioCPq
	 kscjMw2YI9kcOOb4q4WX7QokQbCdXR6u5+haiI6eqPE3gdv+JEhE6k4/osm2Qr/Mtj
	 fZz9bfmZvxDwLrG0Lrel8ewMXXbM2wcbG7TR3PZZe1I7aH0ys5rTeyD+hofwBFizwX
	 f0IlLltH+JjcA==
Received: by x201s (Postfix, from userid 1000)
	id C7456216B91; Tue, 23 Apr 2024 10:27:28 +0000 (UTC)
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
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 1/2] net: sparx5: flower: cleanup sparx5_tc_flower_handler_control_usage()
Date: Tue, 23 Apr 2024 10:27:26 +0000
Message-ID: <20240423102728.228765-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Define extack locally, to reduce line lengths and future users.

Only perform fragment handling, when at least one fragment flag is set.

Remove goto, as it's only used once, and the error message is specific
to that context.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c    | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 663571fe7b2d..d846edd77a01 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -159,13 +159,14 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
 static int
 sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 {
+	struct netlink_ext_ack *extack = st->fco->common.extack;
 	struct flow_match_control mt;
 	u32 value, mask;
 	int err = 0;
 
 	flow_rule_match_control(st->frule, &mt);
 
-	if (mt.mask->flags) {
+	if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
 		u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
 		u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
 		u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
@@ -190,17 +191,15 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 		err = vcap_rule_add_key_u32(st->vrule,
 					    VCAP_KF_L3_FRAGMENT_TYPE,
 					    value, mask);
-		if (err)
-			goto out;
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
+			return err;
+		}
 	}
 
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
-
-out:
-	NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
-	return err;
 }
 
 static int
-- 
2.43.0


