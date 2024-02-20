Return-Path: <linux-kernel+bounces-73611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B9885C51C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286ED1C229CB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092014AD2C;
	Tue, 20 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="DufjJbr4"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8524137C41;
	Tue, 20 Feb 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458307; cv=none; b=ZiLWIUPNvPFpsb0Jqzw/gOWaPTd0bQSjQkoHFAdOj0lQdmIdWsdBUKz87cWs2PLOSq0BLlbB3bI36N/ZdbfFeYVIFWLH8BNsU/NGHK5hsOy6Ghf5HQVY2ZazaVFpOfJbzXSvikv2dOAwuBG2eblNz1QHPY7NIACYAuOkeoudGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458307; c=relaxed/simple;
	bh=Mwj0/typD3aTrSkrgEntFoxq41yM+vCVAdUetDPy270=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PF7T06jlGZpFbNoe5NX9Q3u70jeTccB99h5QMNhEtsX0SZ2lhwXfYNHKwHqF0x3yIjhIBOn//PzNOxLgZaDIGeuIdQgt8FcnHiurxCKPilWKV9cVs9rEYTvuR9/gd8hLccd4wYdcwIn3MAJtCpxHJN9W8KcmNauuB2Gd4xiYkYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=DufjJbr4; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D9330200BE69;
	Tue, 20 Feb 2024 20:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D9330200BE69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708458298;
	bh=Pe9EOigSbPGpF/JFfAS5gTarqG/9sPOHJ5Ve/ZtXLhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DufjJbr4Mb6yBTitQ8EZjumKp4w2/Pw+Yk+/JobeoAwKGXo/7nWVlb6DlnU5NVxcz
	 YpsqLHgfBZvq8iM2Ymz5PJpUfhsFpO5Y0CQbW4NiqmkpMd7yB0j+FrM6aIiNKmz/W+
	 aqaZ55z2obxZjIcPBVnz6t8+Nc3YXnXaZA+4H4KhGYOScqEAQ+swSDR8183982q4b4
	 3HVAIcxe9AQ4+IH23UvM0z4JqXZLRqmOFEYwVmIYegtuysVgRfcC5PaJ3CAnAEfET1
	 shPYohahtlZuHvB7TkEfMqf3gb33qj9wQ+UKCpbnqsihdRZpYVvEyDaa3eMYRIWxMI
	 lEjnr94y5EzXQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 3/3] net: exthdrs: ioam6: send trace event
Date: Tue, 20 Feb 2024 20:44:44 +0100
Message-Id: <20240220194444.36127-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220194444.36127-1-justin.iurman@uliege.be>
References: <20240220194444.36127-1-justin.iurman@uliege.be>
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
 net/ipv6/exthdrs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 4952ae792450..d1f96a28e190 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -50,6 +50,7 @@
 #endif
 #include <net/rpl.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <net/ioam6.h>
 #include <net/dst_metadata.h>
 
@@ -944,6 +945,10 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 			ip6_route_input(skb);
 
 		ioam6_fill_trace_data(skb, ns, trace, true);
+
+		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
+			ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
+				    GFP_ATOMIC, (void *)trace, hdr->opt_len-2);
 		break;
 	default:
 		break;
-- 
2.34.1


