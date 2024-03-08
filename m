Return-Path: <linux-kernel+bounces-97493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02890876B05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3381A1C21684
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4B358AC3;
	Fri,  8 Mar 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="yV9JhDMJ"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA12A8C1;
	Fri,  8 Mar 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924621; cv=none; b=kBjDOOI5PYAvyXaneKKJOxpB890GilCS+Ow9sv2mvQpVX7snhJLcJCSshfgzLtL4wnMZEjUAj+F0bdBK627b5Emt4dGbi0IHqwjLGTTAHzY0NZN1Eeuq4D0xsQvZdXzh/YfpVlpmjEH1q5jitasq3t4Cbfkmt5tbIHyuj3BKrCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924621; c=relaxed/simple;
	bh=EgsUJK/6BnModHUSzU0FiCigCwt0WTcrcO0b5uQedi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ohPq2WHHNZcPCqnWKUmfuJeIIA1SB+SYfRyIyyo3SKaS9bUgnz4ss2edHOoaHHMdlhEHmmvfoGHp7Yyo/uqVx8eiriwqhPIYP1zGbXAJMa82nSM9mt8jZ0A3mR0aPobhz3YXCWGiwPfx9NlgOWcd1YFfMpFBd6OTjbjUOwqmwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=yV9JhDMJ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 8A87F200AA23;
	Fri,  8 Mar 2024 19:54:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 8A87F200AA23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1709924046;
	bh=Zpi5vQbM5CtbsLKYrsNZUU3h+uORSBlr/2pcnVc/ldE=;
	h=From:To:Cc:Subject:Date:From;
	b=yV9JhDMJa4Q4GMun++RFBUOd/7tL6cSTWEo/QBQHtGP1MIpHnFHgRT0c1dpCairpd
	 dzDiK3RRrxbL/Cwk488PJ+WKa1Wsy7ICLIwoivm6hXdH/U5q0/WvivCMZz25wQFKmr
	 VxBHn2iqGygNXwa9FkSaYHwMXcyZkxpNNrXP/IN8c4F2Kd/R/cHVreUWuwHUBBbMrP
	 XncWEdn7MjdHwLAOrF/NEEz06YQhm26tFDt8EtwWmFLaOzGQ5VRM65NVaGFRKWgMkj
	 LMCEFZdeBgiUAmTl/SlnEgVL07NKz92KKeMSWuy8FhZKXiM1PcfMrmLE29Qw/v2XzF
	 HIQyWLtdLmt7w==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next] net: ipv6: exthdrs: get rid of ipv6_skb_net()
Date: Fri,  8 Mar 2024 19:53:43 +0100
Message-Id: <20240308185343.39272-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Get rid of ipv6_skb_net() which is only used in ipv6_hop_ioam().

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 25a5b394481b..6789623b2b0d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -883,14 +883,6 @@ void ipv6_exthdrs_exit(void)
   Hop-by-hop options.
  **********************************/
 
-/*
- * Note: we cannot rely on skb_dst(skb) before we assign it in ip6_route_input().
- */
-static inline struct net *ipv6_skb_net(struct sk_buff *skb)
-{
-	return skb_dst(skb) ? dev_net(skb_dst(skb)->dev) : dev_net(skb->dev);
-}
-
 /* Router Alert as of RFC 2711 */
 
 static bool ipv6_hop_ra(struct sk_buff *skb, int optoff)
@@ -941,7 +933,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 			goto drop;
 
 		/* Ignore if the IOAM namespace is unknown */
-		ns = ioam6_namespace(ipv6_skb_net(skb), trace->namespace_id);
+		ns = ioam6_namespace(dev_net(skb->dev), trace->namespace_id);
 		if (!ns)
 			goto ignore;
 
-- 
2.34.1


