Return-Path: <linux-kernel+bounces-78512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2591E861455
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570281C22E25
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FB81AD5;
	Fri, 23 Feb 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="0BK9JCuA"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A479CC;
	Fri, 23 Feb 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699313; cv=none; b=cZfsH2DFOWiuV23RoY+E0SGWbMjwl6QkuVYpfIe7GnBQ/R1kzb24qPhGnhK7VPdosxmB7nrCX3l3K/Bj9tvmXiR5cSQpN6J12osKXSrYEOlF5p9OsicdrAFaWLutnoEP3Lhb3Iw3C7/+RIc0uOtSmkNbSl9RYu5TCzwyToc6r2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699313; c=relaxed/simple;
	bh=ZlQwc3wckbIo6B/IZ6QBbkjJIGAEVMnxpMBxl0bFrYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OKdk+y+CSJ9deFkA9Vhxfl84XR7XsPf54wY8EhJsz3e0GFne2KbDx17Jp8CHtMRvVqO6Srj+uHe8u/xI7ZkFJJXEDeNqATOgGtKM06iGB9kUuyYSoDlsYdgFXTqysH+ay53llDwHtC1qA/mPE+6Rvv3Xfvvc6W0vZ0BbCbab+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=0BK9JCuA; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D3F1A200C984;
	Fri, 23 Feb 2024 15:41:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D3F1A200C984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708699304;
	bh=UcUfAXN6JVmIsLlMmJXJirrwKr6+ad6fgsDvkrq6I2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0BK9JCuAPXlWKMScVZcUjJqUJOZohb9t1vFW4v7P8IQ9i7ZZx1dQOo0t3Kp6uBQIn
	 Po4XV628+Idoybnu7gLedNSmhDd1fqIzjWUve/Nh+OrjzcLe0UXzIUnxo42a/GzSFw
	 Xq/xLr/nQ9JE4yTYRZqsC2QefF5ywFeLvzZEtjXJaARPQhiLoWL4j1jR3Uy4j8SxBE
	 1ToGbyr4UamAPV2lvSmRSZW6Kp61/JumgjhgQtd8Md3vTArOxC+c26KxHbNWUzKJ+b
	 LmU4CZi4HG0Gdw80sDPNuFCqPIHAgaw5V70qt209giaAtKhe/g8+wZvK9qwjzZOvEm
	 9EzWBOfhL5J1w==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v4 3/3] net: exthdrs: ioam6: send trace event
Date: Fri, 23 Feb 2024 15:41:35 +0100
Message-Id: <20240223144135.12826-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223144135.12826-1-justin.iurman@uliege.be>
References: <20240223144135.12826-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're processing an IOAM Pre-allocated Trace Option-Type (the only
one supported currently), and if we're the destination, then send the
trace as an ioam6 event to the multicast group. This way, user space
apps will be able to collect IOAM data (for a trace, it only makes sense
to send events if we're the destination).

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 02e9ffb63af1..003f35d9b42b 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -50,6 +50,7 @@
 #endif
 #include <net/rpl.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <net/ioam6.h>
 #include <net/dst_metadata.h>
 
@@ -954,6 +955,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 						   + optoff + sizeof(*hdr));
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
+
+		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+			ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
+				    GFP_ATOMIC, (void *)trace,
+				    hdr->opt_len - 2);
 		break;
 	default:
 		break;
-- 
2.34.1


