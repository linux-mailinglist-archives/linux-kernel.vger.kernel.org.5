Return-Path: <linux-kernel+bounces-156846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8258B0911
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECCFB23884
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809115B575;
	Wed, 24 Apr 2024 12:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="U9zkW1MA"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD415AD9E;
	Wed, 24 Apr 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961015; cv=none; b=oahlixZyowEeWPvjEOyUfA7q+x0da2mdyJs6srCc3K66HB7VL9rxMQrDoneXUTBKlR8XPwxEIMbAtnOVqhcWynTUxLcUiMhebP5Oi7//vOzV3xdyiMqO7tPcQN0Mf9Tewib/KdRA6RooUp0UF22iSnh+5gGRdmgB+3m01vYRyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961015; c=relaxed/simple;
	bh=h8eKlpA8aZZwVUqM78/5h1yz+b7OYeMXRZb+mmI+cIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhvn9sPhp3gfuOmGVTkkd9HurA0OOu7kJxSW5JMLgydddikSuRAT7ImP/VsUW7cv897Kom0L/LaXgz9TvThD9Ox1PQepcTjRdmX9K8CsKGAO980759UBHEdIT/fKme9zXGvjBPvUaINrid6Lr4o3nEOlgMuLTPNSbLUYlr9F4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=U9zkW1MA; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E8314600A7;
	Wed, 24 Apr 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713961004;
	bh=h8eKlpA8aZZwVUqM78/5h1yz+b7OYeMXRZb+mmI+cIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9zkW1MAsDL+1CvLFFtUVK7aRTXGk8uRkn6uMXraIMcQn6NzX5hl0EiM0Gl6ElnEJ
	 XDzQBzeRUo41sc1ojdtewLOsdgTN8q3EP500OlzAYqRMDiwuoURt0uASR8FV0x7bO7
	 kE0l7KC8K1o3IcaIQIYf5huZ8ooqayvxQIM8DJvJ6njFGLRQGA7Td2LY9mphGkLTNO
	 EobCx6XmWLTCPN5e4Mo+bzYapHLl+RpvcRMhBmcYh78RaGgfESuPa+j3l4toFXBwMd
	 pAA1knpezKGuE9+viyyMHF3Rk5Assmuw+g9IlZj8IaL8pCzJoQfj2bskV3poGAbjxA
	 w6nYC3DrGAzRQ==
Received: by x201s (Postfix, from userid 1000)
	id CA0D721BB49; Wed, 24 Apr 2024 12:16:37 +0000 (UTC)
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
Subject: [PATCH net-next v2 4/4] net: sparx5: flower: check for unsupported control flags
Date: Wed, 24 Apr 2024 12:16:25 +0000
Message-ID: <20240424121632.459022-5-ast@fiberby.net>
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

Use flow_rule_is_supp_control_flags() to reject filters with
unsupported control flags.

In case any unsupported control flags are masked,
flow_rule_is_supp_control_flags() sets a NL extended
error message, and we return -EOPNOTSUPP.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index 22f6c778afb0..8d67d9f24c76 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -197,6 +197,11 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 		}
 	}
 
+	if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+					     FLOW_DIS_FIRST_FRAG,
+					     mt.mask->flags, extack))
+		return -EOPNOTSUPP;
+
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
-- 
2.43.0


