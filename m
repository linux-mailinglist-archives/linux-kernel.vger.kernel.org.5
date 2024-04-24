Return-Path: <linux-kernel+bounces-156843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E98B0906
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6438AB222AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764415B107;
	Wed, 24 Apr 2024 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="v1QXhCID"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D521DFCE;
	Wed, 24 Apr 2024 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961014; cv=none; b=JezGgvgQjG6Uq2gUmMAeBXsVubMjn92Qx03pQApvsiA3cxfPVBi8j/uTZhIFeLNpdW0+wboA1a+G9yx8Ybx/UB2M0660JPHqja6YjMld79MDDSaCyalU0P/Jbo9STTLD4P+VeGWdE4UrkoFea3hmPVg7lBIo4XrS2/j2r48hhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961014; c=relaxed/simple;
	bh=WlV+NTBBGpvEW9L0XHBhxoYKJ2JFhI+MtCnUapFUQWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2zts6bIuZ4fP0A+dmVTmMWOpOKCV/ql7q4JuWlNqNNs8b9R2R5xWJQk4PaSGIBGpc2ENAdGMwkwgQu+kdPEnB/bNqX3t02Ek0YmxURm6NKsoby1z2Fzzd1iA6/dLYipZa4AAZlXhNQLYUTd5h5RHQWvWAQbaigs2AVVGSY6jxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=v1QXhCID; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EADC6600A9;
	Wed, 24 Apr 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1713961004;
	bh=WlV+NTBBGpvEW9L0XHBhxoYKJ2JFhI+MtCnUapFUQWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v1QXhCIDY2KnFl/dei+LcGMEwoFvimRsuaWY7k3kE764ngjCGqQC6ZrMzAQlyasaI
	 YE1ZQtVFrqv073RftLcwTS18e4eKOp9jkd4DqwZVA1BCbSmgtgPXFW6Uxk3ra7ni5R
	 YB6j/KvmUi16jsjcmrJ8kyLvUjGMWaBC7jirh415UghbITDAqFsZDobw0DT1KJ02Vp
	 4fvWd7649uxLRQzCzffWJkGH8YZ5DBVOVArfwuPd4vJG9y4WnFVYQmGLYwDZ5A+Sru
	 46jaREVy7eaaG3rvy0A35/7zQBIfe2jdufsL20F39UfPQq2YsqjtuMA5y+5FSHIJld
	 VPj9quz9PvDvw==
Received: by x201s (Postfix, from userid 1000)
	id 3536621BB47; Wed, 24 Apr 2024 12:16:37 +0000 (UTC)
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
Subject: [PATCH net-next v2 3/4] net: sparx5: flower: remove goto in sparx5_tc_flower_handler_control_usage()
Date: Wed, 24 Apr 2024 12:16:24 +0000
Message-ID: <20240424121632.459022-4-ast@fiberby.net>
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

Remove goto, as it's only used once, and the error message is
specific to that context.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 .../net/ethernet/microchip/sparx5/sparx5_tc_flower.c   | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
index d0dca65f8e76..22f6c778afb0 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
@@ -191,17 +191,15 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
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
-	NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
-	return err;
 }
 
 static int
-- 
2.43.0


