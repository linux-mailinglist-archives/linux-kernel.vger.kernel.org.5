Return-Path: <linux-kernel+bounces-71428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1885A51A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E285281967
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD36B1C;
	Mon, 19 Feb 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="yYKfUoTU"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC30364AC;
	Mon, 19 Feb 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350526; cv=none; b=RQZJRyaTTFsHfNAZqEeBv7dBFCEL9tIOML8nQI7VeMZgtCX402xucMMPH9nAlfKVmFFnj8FuCwd0Xz1kcH3ATvKbLQKrys1rUGxRUK+USqigkQPjr2L0NwqbggT9Kev8BrvIKF7bySbMLLuAfvqG3p9fs1NCiWKID+Fv2lk3B0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350526; c=relaxed/simple;
	bh=pSf/6yBlnsj3efx67HWLfiYU1L7RVALqEg3khS/oWgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgDB6wAQFifO9/9jdthN19OsCg0ntKXAZEiTR/c9FIPURlxYWUrrSutsKrVvNT/obCDB/rGbs+fk0n6rIXenZAFJ2/GggijTm3790nrlF2qpCrpEyAg7CbgvXdvXBJTnZXrEYYaC4RSxuSX5jzNE2eGBRGvDNHNhdnNa0lKL16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=yYKfUoTU; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 68FA1200EEA2;
	Mon, 19 Feb 2024 14:48:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 68FA1200EEA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350522;
	bh=k3BbLM+W3IY++z5FItf1PQyWOHVjGz95oS2lZDTR3f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yYKfUoTUzmsVCectPHw4LnIoT1WpSIG0UBRrWDrhPeeZlOaPgh9OeeewqA6xrPtX9
	 9GoHDb+2JLL6/HJ7AOXmsji3k0gstpmELeYP9guCOXHc1xX62F2GnsRRNL2Q/ylpZf
	 Q4/T0bu10qDMmyp7t+plWHOWl6OwUPXeWiewLyei0rrH48gAa7+M1uh6QISn+034Qv
	 H23KcBiMBZx1MdJRDFvPauyCX2r5DL8Rorw8fJTgl3hlxRZ8HBUSOQa/avspAE8hM0
	 KYjF7yiG6rj8iPsIPp0vnfF1YD05efSEe2qHuoHWXQmapc9ynZmyqil6loTdD74scz
	 tVmlmrBbt2oig==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH 1/2] Fix write to cloned skb in ipv6_hop_ioam()
Date: Mon, 19 Feb 2024 14:48:20 +0100
Message-Id: <20240219134821.14009-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219134821.14009-1-justin.iurman@uliege.be>
References: <20240219134821.14009-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioam6_fill_trace_data() writes inside the skb payload without ensuring
it's writeable (e.g., not cloned). This function is called both from the
input and output path. The output path (ioam6_iptunnel) already does the
check. This commit provides a fix for the input path, inside
ipv6_hop_ioam(). It also updates ip6_parse_tlv() to refresh the network
header pointer ("nh") when returning from ipv6_hop_ioam().

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 net/ipv6/exthdrs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4952ae792450..02e9ffb63af1 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -177,6 +177,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_IOAM:
 					if (!ipv6_hop_ioam(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_JUMBO:
 					if (!ipv6_hop_jumbo(skb, off))
@@ -943,6 +945,14 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		if (!skb_valid_dst(skb))
 			ip6_route_input(skb);
 
+		/* About to mangle packet header */
+		if (skb_ensure_writable(skb, optoff + 2 + hdr->opt_len))
+			goto drop;
+
+		/* Trace pointer may have changed */
+		trace = (struct ioam6_trace_hdr *)(skb_network_header(skb)
+						   + optoff + sizeof(*hdr));
+
 		ioam6_fill_trace_data(skb, ns, trace, true);
 		break;
 	default:
-- 
2.34.1


