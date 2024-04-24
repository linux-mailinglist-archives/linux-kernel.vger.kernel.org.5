Return-Path: <linux-kernel+bounces-156902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0838B0A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403ADB27588
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B815B96C;
	Wed, 24 Apr 2024 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="R1EhFZAX"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660915B140;
	Wed, 24 Apr 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963250; cv=none; b=Ncxj0amFs3/Ql5s0vmfctm1vdu5+aIaa3lrlJ4WYxMH1FmtLnsroRZyvAhbzh60XyQbk27tCJpT5c2AeMLf32/+KP1sits4InXNQIGZrOU4ev/XHhGFw5dNwe7vyepz+bkFqa2DsSeKL40BRSNkHHUUrLs3Nrh9raNOpMQDly1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963250; c=relaxed/simple;
	bh=iNH+eQ6aAUewGyeXzpG70jlt31YtG/wfET46QLPSCps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4SuaQRvVjp8qZQQfAXgVqAQZ3XvAOa+RCZW3ibxdlNny2EB5k5gw6JwTW554+Wz8ArcnjfefdUQxyh9UvXZlFUpN5YYu0ENDuUhPob9V/GmipEuSS+sG3GZ2qK8jQOkrBgS3xyK/fSolqTDJZv2AmhpYugCt2EofaR7F17G1wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=R1EhFZAX; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 68053600A7;
	Wed, 24 Apr 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713963245;
	bh=iNH+eQ6aAUewGyeXzpG70jlt31YtG/wfET46QLPSCps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1EhFZAXc18kk+VpEpOy355SLzWZ1Wb7O+jcit7znsOvn6OmX0s2m+hrzRV2EnPzA
	 FAizbkk6jKeYvSTZnMH8X3X8x4GaNONO3LeBQEkYmAw4AazPPR5Yw7weApGmu4bm/L
	 +lQxnfQVSKx0klGZneU0eUtEU+LTQP5VBzMbu0sKQ6ZDHtVmWICH00pMEstmZyA+xM
	 b0mrZihUVpFMfC8EVvUpU5CN7BYF8osVfVx4fV8reClulMYBmRlgB+c/oXhcQAud+y
	 0UonDeEmlLITL89Ps8T9RH6bnKl75vuem0gruV8umM09rbLTY4G7+f52h04tTKPASJ
	 Gqs7hONU9/owA==
Received: by x201s (Postfix, from userid 1000)
	id D7E0021BB43; Wed, 24 Apr 2024 12:53:58 +0000 (UTC)
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
Subject: [PATCH net-next v2 2/3] net: lan966x: flower: rename goto in lan966x_tc_flower_handler_control_usage()
Date: Wed, 24 Apr 2024 12:53:39 +0000
Message-ID: <20240424125347.461995-3-ast@fiberby.net>
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

Rename goto label, as the error message is specific to the fragment flags.

Only compile-tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
index a63b83fa2823..8baec0cd8d95 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_tc_flower.c
@@ -60,7 +60,7 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 						    VCAP_KF_L3_FRAGMENT,
 						    VCAP_BIT_0);
 		if (err)
-			goto out;
+			goto bad_frag_out;
 	}
 
 	if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
@@ -73,14 +73,14 @@ lan966x_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
 						    VCAP_KF_L3_FRAG_OFS_GT0,
 						    VCAP_BIT_1);
 		if (err)
-			goto out;
+			goto bad_frag_out;
 	}
 
 	st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
 
 	return err;
 
-out:
+bad_frag_out:
 	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
 	return err;
 }
-- 
2.43.0


