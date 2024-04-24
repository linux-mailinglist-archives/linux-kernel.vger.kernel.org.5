Return-Path: <linux-kernel+bounces-156845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A148B090C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C6B2888BA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BF15B151;
	Wed, 24 Apr 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="QRL/cT1D"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D115ADA3;
	Wed, 24 Apr 2024 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961015; cv=none; b=lOaSxusZvsKqo2vEjhe5g6GOzroVUuwuV+qUYdyodgWzby5T/7gQTveM/I3aor+vnOe1NApyJzjuWCmdoKUlSsVHpgICwg3q+zGp7eWF3lTr0QNul7fdseOLKywfmKwdFLRLPHtWRWGSm81qHaJA7B9KQsZ4dbsMhDu0UCaNksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961015; c=relaxed/simple;
	bh=91wyp1eeivW05Y3gFARMloAF3/ELD8zgoJNeRnv7tR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m03g4otD7ySQlczfNa/YOElBlepgrXBUUNpCiOf/pM6T46BPjJqRgqJU6nDh6rSMpDByZBLq/4K12iO827ALQoMFhg040WMsyMysHrK4c4VTqeW9PBnu0PKb6E2wIRbzzQyWHjsElEs5MHqf8plsb9djmqA6IgEG9xNdSTO9PUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=QRL/cT1D; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8DF91600E4;
	Wed, 24 Apr 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713961004;
	bh=91wyp1eeivW05Y3gFARMloAF3/ELD8zgoJNeRnv7tR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRL/cT1D/u7NOwtzRt8mSpgkT5STeLsVR9xUhgixdR0y8iBj2FwOWOpq+DbENLRsx
	 Hwtd0Mb6W1ui7yx+jZ1B1MN/ZQmWHHx/oHKTChWwTSmRVo8FXV1+4sEo3by227QIze
	 4WgarA7W34eqrKyzFZAlzT3vPOzq3hdmvEmTC9cI3SS+qJAx/s5QDB898cCdiAkDia
	 /ZUdfwaf4Kh2P9EYt4H+d3xKM0CxvwMKyNOToqM4LqltzwmEbw88eCMORe1pdUnnbp
	 +PJZPTT/7mjBkzTFMUa2biKSJBJZfn8Sqco1XWy9D804soSeD14Gq7T/Bg2RjW4FBg
	 GvNP/TLw2CJmw==
Received: by x201s (Postfix, from userid 1000)
	id 082F6205A1A; Wed, 24 Apr 2024 12:16:36 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/4] net: sparx5: flower: only do lookup if fragment flags are set
Date: Wed, 24 Apr 2024 12:16:22 +0000
Message-ID: <20240424121632.459022-2-ast@fiberby.net>
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

The fragment lookup should only be performed, when
at least one of the fragment flags are set.

This change was deliberately not included in commit
68aba00483c7 ("net: sparx5: flower: fix fragment flags handling")
as it's only needed for future proffing the code, since
"mask" is currently only set in conjunction with the
fragment flags.
(The 3rd flag FLOW_DIS_ENCAPSULATION is only used with "key")

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 663571fe7b2d..ca9e69d39439 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -165,7 +165,7 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 
 	flow_rule_match_control(st->frule, &mt);
 
-	if (mt.mask->flags) {
+	if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
 		u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
 		u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
 		u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
-- 
2.43.0


