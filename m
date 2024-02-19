Return-Path: <linux-kernel+bounces-71432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE185A52A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745CAB20FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA2374DD;
	Mon, 19 Feb 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="LeD7FTRu"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2C364CC;
	Mon, 19 Feb 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350783; cv=none; b=vCYMXKDm4e06e+JlGrXHGgI1ItTSrCQsuFc/QZZbKlpXpj9UcTt8ocQZ/Cl76xNXDEmpFC7/3uqPLJIgRvYzGiHk193RskXjVz5ndE8ciCIfaDC6ybGdE7RpMiHOhcANuF03w64x7T2QJzcjiSdHDnyN+ELfb8b0Yr1Ji/hQnrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350783; c=relaxed/simple;
	bh=pSf/6yBlnsj3efx67HWLfiYU1L7RVALqEg3khS/oWgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RiHqdCtICWRp7J87f+zf7Ni2tS7Q8Ht4ELtRhDxz2pdOVN2FhePDtU7Tu5NUIGSqB8mn7sJdhXLVOnI9qhDGSxkbEV5IK1X4t13SXwg1Aa9LmLWf77rv194np0ar6Dze68IWvcucNX5iJSuKFcBLGWQiUdcB82PXxsuV6iigNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=LeD7FTRu; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id BBFD72012173;
	Mon, 19 Feb 2024 14:52:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be BBFD72012173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350779;
	bh=k3BbLM+W3IY++z5FItf1PQyWOHVjGz95oS2lZDTR3f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LeD7FTRu1UZv0Ax6scZg93ZbR/A7tXJxuEboY23KBSAQfrBM+jDp59ehXrAEnxUUu
	 H9g6lQAGOji7i+pNJqLeHN1Lix50+M3LAgdetCDfQOBWWv7PXLGjApvcmJx4UqNFp1
	 cBEHDp9POX076y4L5tKQpl1PTCmBg2BkCgiD+oczKoh86wc2QKCZ+Nih2eQOO+HtQC
	 by3IZ3OJtf6dhSdOtAEEpPssrP2FO7DVFWMwO3uAeNyfMlcjZBKJPk2H+X0u2FereO
	 AQI2Jdh4zUScaqb9onAVI3bA6vaFIQzC30ySgu41JM++P0G+TTwCMskDrWOdBN3+3Z
	 9iechtlY0x5GQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net v3 1/2] Fix write to cloned skb in ipv6_hop_ioam()
Date: Mon, 19 Feb 2024 14:52:54 +0100
Message-Id: <20240219135255.15429-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219135255.15429-1-justin.iurman@uliege.be>
References: <20240219135255.15429-1-justin.iurman@uliege.be>
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


