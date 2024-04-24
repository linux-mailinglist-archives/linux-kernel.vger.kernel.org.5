Return-Path: <linux-kernel+bounces-156903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B89A8B0A21
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100DDB27683
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241815B995;
	Wed, 24 Apr 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ju5+3kQS"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B09215B14B;
	Wed, 24 Apr 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963250; cv=none; b=VWfAtSNB2MDhL/8jGr9jEAu/KnzxDWdXVzD2iG6kkJWs3DoqV+IJFshKtEYP51Jc1o+50KicIW1P3NGFGIr9AuEUXaLyjYAvXREw9W9B7c9mM3f+qRsqqW8owP4sjMKg15tgWXpO4cweIBtOwIRIphRdJWFvh6hMSDcGS5b5JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963250; c=relaxed/simple;
	bh=6KXD0oeK4Ss5GHj0EJM6H4ROKzmr2ymo8levWGdF1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o67Czv+F4A2EEAL5RIX4tHjN5ZMILA7JwUFLxHysB4T8aEqIkOJG3ZOUdCXZoim/bOlCErUYoLqPd/hxC7ONP0gSHGuvixUaCpHqAy2WiP/8GMo1P56qdOzUbv6LFr58D/FKpW+3uXYfuW3gxAnW2aXDAm04bkNVcXNQb6Ew0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ju5+3kQS; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 39932600C8;
	Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713963246;
	bh=6KXD0oeK4Ss5GHj0EJM6H4ROKzmr2ymo8levWGdF1ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ju5+3kQS/0CsVD4CUrXhaDUtmKTNmqpnNj+oESarYfiQEnjsv/yxMVpbWLWHstc2h
	 GgPmc5ZE+bcRwQImrfpjx6/yizZ4X7/aLPrjyTYLTpADbcNN5WvjKFLJoGzv0fhGGL
	 yA33nsArXJEy2p+Dw47MkOtdKqMnsgWHlAKE5gIlrIS/frEz4y27hhHSkYBjLnR6rz
	 ibiUrMLR2XbFMpdvJD/jnZD2yfJM+nxIcMVSZmBo/pUkNtn5XiV/vFEoTs/e1VOILO
	 FSq/Ng+JJ/YpoqJ0qjSelhWZJ2C/Pim6E6rNwZMfN5RY+q3WrdkSWEKMmPkLoryTSX
	 piUq9av6cigBA==
Received: by x201s (Postfix, from userid 1000)
	id E5E2221BB45; Wed, 24 Apr 2024 12:53:59 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 3/3] net: lan966x: flower: check for unsupported control flags
Date: Wed, 24 Apr 2024 12:53:40 +0000
Message-ID: <20240424125347.461995-4-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>
References: <20240424125347.461995-1-ast@fiberby.net>
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
 drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index 8baec0cd8d95..43913d6204e1 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -76,6 +76,11 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 			goto bad_frag_out;
 	}
 
+	if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
+					     FLOW_DIS_FIRST_FRAG,
+					     match.mask->flags, extack))
+		return -EOPNOTSUPP;
+
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
-- 
2.43.0


