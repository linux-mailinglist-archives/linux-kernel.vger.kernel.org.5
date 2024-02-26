Return-Path: <linux-kernel+bounces-81460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F45C867638
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD66A1F27694
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E2127B5D;
	Mon, 26 Feb 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="227SmRAF"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9D68562F;
	Mon, 26 Feb 2024 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953277; cv=none; b=YdGfQnZq8WAOyobuC6hWMZ3TWJZimsPx6JEEXCYJOOUqUyEs9wKTWCCbyX2Gob5hn+9yDrIBeZiVuMnTPeoB5cASZ4T4a99dmTq54FEMk1PUUE+k9VLK2ZOn0VAfklKdXn+9onmLS5S/8aEMoRmwHSeVtq+P0N26kVRBmu+lZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953277; c=relaxed/simple;
	bh=4NXsgau3XXoMd95i2zOqL+DzcwfteHD/zed72UuBEEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZoS+qiqKsMdsbu4xF0GdhzpZRT6dFOueE/vACND6C/M62RzTgCLifOBOhULuvr1eK60v6PDdrweswM7CDmTJxVYs488t7nvGWf1PKON0SNCt65GWuLXWvo6GKgfPOQTzhB6/GzsUvldO0bt8U8eBx87FdSrHKeSQwe+iEDompU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=227SmRAF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D5765200F80B;
	Mon, 26 Feb 2024 14:14:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D5765200F80B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708953274;
	bh=xQqygCkowYJ0wbpEt85TCJ7aXSvzWcfLImX4V5j/zn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=227SmRAF4jHqwHwxtSJS94Gs7S22S4mmG7HJ5Hod42N5LnNWtznnqE7AXWDrCLtUJ
	 i/bXjZ91HN/oPzABcL8QJQiQR8Rj0N1tghKAwxbgeLU0k4DODr6XYVshzhXK5ezqgm
	 /zyFhDxRoiefcJ7TXVjvS+hJ6uz4bIFKpoe7twKfL6sYcZFtMZ5O0PedE/lLmuKtyN
	 lBnBgWo+aiZNRjnOaBdZ5BehKzyxSv3ewBfXReTZMlSJiZLZ9ZfArN8VISONeMniZJ
	 5Ght9LyV9D5f8knLOk4FUWZTiSjERw+IyVxb3KTk6U6WiJ6HY4o8fD2LolYCCkm9aR
	 8Jgorqo2I/HcA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next v5 3/3] net: exthdrs: ioam6: send trace event
Date: Mon, 26 Feb 2024 14:14:12 +0100
Message-Id: <20240226131412.10214-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226131412.10214-1-justin.iurman@uliege.be>
References: <20240226131412.10214-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we're processing an IOAM Pre-allocated Trace Option-Type (the only
one supported currently), then send the trace as an ioam6 event to the
netlink multicast group. This way, user space apps will be able to
collect IOAM data.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 02e9ffb63af1..727792907d6c 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -50,6 +50,7 @@
 #endif
 #include <net/rpl.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <net/ioam6.h>
 #include <net/dst_metadata.h>
 
@@ -954,6 +955,9 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 						   + optoff + sizeof(*hdr));
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
+
+		ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
+			    GFP_ATOMIC, (void *)trace, hdr->opt_len - 2);
 		break;
 	default:
 		break;
-- 
2.34.1


