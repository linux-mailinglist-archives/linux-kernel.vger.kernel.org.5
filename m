Return-Path: <linux-kernel+bounces-138433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4B89F129
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795B91F25068
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1215ADA9;
	Wed, 10 Apr 2024 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ff2lkR55"
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86D15A4A0;
	Wed, 10 Apr 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749663; cv=none; b=dnLVZWNa5gWCL8FHUxJWmYp/epCapdaxfwiLLWyzI/m392JyS85JIQ0as19dciNGWTd1P3TpHus7mlrd3Pr1AGr4j8VYtkZKspycuc0QQFuASoaDhhsjwlErc0JkYbGrZqu3BmdHnityJCAMTRoqqGdrc3EFcpHTqyyk7p84mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749663; c=relaxed/simple;
	bh=TIUzW46FH8L5pXXfEfJMVqXA2/iDwWUpGRPrS/YtqKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gs0SuXzBLkIrdckbl6tLbIQ4nmjboBeIt8OXfE36wpqk7H4XVn83ILiZZ7XXCvjsNIWB9At9ju7bqFZkE7UXt3TLVxdqP4EldDsCfWXARyPItCpB6Z+k+Sc1uTgTWP2CJCeJJnOm+mrdZKwYbYIwpXQFACcoITyLYTg3o2rLSPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ff2lkR55; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0C201600A2;
	Wed, 10 Apr 2024 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1712749658;
	bh=TIUzW46FH8L5pXXfEfJMVqXA2/iDwWUpGRPrS/YtqKk=;
	h=From:To:Cc:Subject:Date:From;
	b=Ff2lkR552DLeYpk+ho+vXk9phPhnrn+mZrI5MmM+GAzjB9CpSli9jlwjL/i0+QrtH
	 I74p7CIgGGHu9DfDfBltt9MAjyKJdm/Brgd6RJXMQfBMkoak0ETYByCHyd8VYuPvB2
	 b5GtTHU07aMjXVLeB3xXFZtlP67x06Upm931jtDzkrF4pRJyy+b6spqg4s6Ar0AVPZ
	 18f2oKuG0BYukUf26wCmmeG+FVLRSPQbw05KaIvpQLfFzfdbgbQ5r5/6DH5R78m0cZ
	 DtApwU0Sr14n7NnYjgMoeeNumbf3M9o480gMIBFu/Oaj1N6IkbgbPqbnzJeStZts1I
	 mtsjxuurhOTDg==
Received: by x201s (Postfix, from userid 1000)
	id 7C24C2010E6; Wed, 10 Apr 2024 11:47:31 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Subject: [PATCH net-next] flow_offload: fix flow_offload_has_one_action() kdoc
Date: Wed, 10 Apr 2024 11:47:17 +0000
Message-ID: <20240410114718.15145-1-ast@fiberby.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

include/net/flow_offload.h:351: warning:
  No description found for return value of 'flow_offload_has_one_action'

Fixes: ab79af32b0a5 ("mlxsw: use intermediate representation for matchall offload")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 314087a5e1818..7726b4a97050e 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -345,7 +345,7 @@ static inline bool flow_action_has_entries(const struct flow_action *action)
  * flow_offload_has_one_action() - check if exactly one action is present
  * @action: tc filter flow offload action
  *
- * Returns true if exactly one action is present.
+ * Return: true if exactly one action is present.
  */
 static inline bool flow_offload_has_one_action(const struct flow_action *action)
 {
-- 
2.43.0


