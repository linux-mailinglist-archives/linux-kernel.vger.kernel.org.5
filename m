Return-Path: <linux-kernel+bounces-138264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A9489EEF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0801C21495
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2BF15921B;
	Wed, 10 Apr 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ni7csRqO"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961C155389;
	Wed, 10 Apr 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741582; cv=none; b=hKQxjuGZ3DpSB1yGQBlhU3x0GS+hqboEK5L4j62QlGLFMRe3kU43G4+1MDsflGVpuS01qqYfLfLt9CaLHIJwrlglOVd8wkJ/58DKfA/ZeXAPjgjuZf55tXn9EOICRkefXBzwOLMzctlL4YnajPVFCTLGK096zfjpCI1gW451U0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741582; c=relaxed/simple;
	bh=GT4plfdJZt39vVnqpYEPKRuMEYhANrU28JfgNwwGJys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZh8Zkfd2hUCFdjRQHTUrlW+h4MiN8Dpgi02kkaiOoNICrabUN7jW5dWxufIM9qJOo8DZg5U820GmLWSH3s7oVhRA3n+/0kCc18vBAYrgid0SJDyfqghcdKXyfPsGdHjTPRN2TsUOXKhAU5xjGhrVMLBlWBz7X+n4iMHMIYTEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ni7csRqO; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E3EBB600AF;
	Wed, 10 Apr 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712741573;
	bh=GT4plfdJZt39vVnqpYEPKRuMEYhANrU28JfgNwwGJys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ni7csRqODiV1tTRkAlCPkK5OzuQ85mHFohlaufJJEYUjYvlzJ1lqDQnOPYyt09PJT
	 18Hdkle/tBFD8EFNt6vG43PchFqjaTP2a4+3EZlYvTVAwdZXiS+uR7OHQwe8ezoMRa
	 p5ZH2MQRBn36cLIyJRsK5PvkH9+F4At68wT4HTf+zg/rRM32AOdoBgUdeurF5I8TRb
	 w5Z3ufhbsyeLtL5fzW26Tzjqm/vKcYIp8wuriytdP56LJXznkcWZhBoNHC4WtHXf40
	 h2g0+dorGGpdE6hfZNrmV3QEmCSgrTCBe8EbteB+t5NlCw33YhPFDM98GDHcS21/4N
	 g2M5z7AFkYAKQ==
Received: by x201s (Postfix, from userid 1000)
	id 62CF020BDE2; Wed, 10 Apr 2024 09:32:40 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	Yanguo Li <yanguo.li@corigine.com>,
	oss-drivers@corigine.com,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v2 2/4] nfp: flower: fix check for unsupported control flags
Date: Wed, 10 Apr 2024 09:32:23 +0000
Message-ID: <20240410093235.5334-3-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410093235.5334-1-ast@fiberby.net>
References: <20240410093235.5334-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use flow_rule_is_supp_control_flags()

Check the mask, not the key, for unsupported control flags.

Only compile-tested, no access to HW

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 0aceef9fe5826..8e0a890381b60 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -527,10 +527,10 @@ nfp_flower_calculate_key_layers(struct nfp_app *app,
 		struct flow_match_control ctl;
 
 		flow_rule_match_control(rule, &ctl);
-		if (ctl.key->flags & ~NFP_FLOWER_SUPPORTED_CTLFLAGS) {
-			NL_SET_ERR_MSG_MOD(extack, "unsupported offload: match on unknown control flag");
+
+		if (!flow_rule_is_supp_control_flags(NFP_FLOWER_SUPPORTED_CTLFLAGS,
+						     ctl.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 	}
 
 	ret_key_ls->key_layer = key_layer;
-- 
2.43.0


