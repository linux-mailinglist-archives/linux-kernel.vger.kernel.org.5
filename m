Return-Path: <linux-kernel+bounces-57163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF084D4A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1CFB2507D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF2158D72;
	Wed,  7 Feb 2024 21:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2YqPLok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C901586D7;
	Wed,  7 Feb 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341135; cv=none; b=H3yAN4tZMKec5sJABTw1wBbh1YTmHclGKcr9Xzrp2/zztyvEWb71SHbVmmjyJFcOCX6fZFoZCNWPGxrI80TKzQtKZsmQtf6bx115pXb5tKsec5xS7Zd40peyDCL/mXR9VaFgIcIAABbJwymc7QnjVYU/4BSXC5Ft0mlSzqowODo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341135; c=relaxed/simple;
	bh=Mp9Egq9jUiCzq+Q31fSaaXWLTJCV0WI3GtGR8muqObA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbflAgDni5mC4zyhbvVI38jmR24UoSkNMo0n6ayLVFIwoDQOVYoLShVQS3pM6X96E7zGfWbHgknV7haG0fEsG7vMsaqdh2yqWGYiO6BRxse092ecX+nSY6DNPQkFL2ci28Yvxsu2fRrsGLtoHujllx6GZjKsqiIiB0L0PiEZQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2YqPLok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CEEC43390;
	Wed,  7 Feb 2024 21:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341135;
	bh=Mp9Egq9jUiCzq+Q31fSaaXWLTJCV0WI3GtGR8muqObA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k2YqPLokVSJsg5tMvvOFG9swO631agMNQe3Bpm++P+XWZGxa6aINIJDVVwiQ37UQt
	 bzIdZ/0vbabzxoOC2GBx9kPTJCMYlUKM3qG0v0MyxaiUPBwu3brBkbkkKw+TjTKgIB
	 xxqbhFMyJzqm9q93JRiBXEldjd3ISxzSFk/uvq3rhB/PwpUaOoYxkYTex2kTwTxcUP
	 tVsK9ds3HIsoDmbgTZCqYvryKtQx0HjTUVpMMhUIkSALWsHD5sJ/nl126R1DGMtsjK
	 jJA+JobAC0Y3pC7PVOI8YkV09XlIFyc8/sHrrsoT8X8JEBoNEkbe+YGgRwA6/wqhGt
	 lqqhaicf8zd0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/29] netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new
Date: Wed,  7 Feb 2024 16:24:40 -0500
Message-ID: <20240207212505.3169-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 6e348067ee4bc5905e35faa3a8fafa91c9124bc7 ]

The annotation says in sctp_new(): "If it is a shutdown ack OOTB packet, we
expect a return shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8)".
However, it does not check SCTP_CID_SHUTDOWN_ACK before setting vtag[REPLY]
in the conntrack entry(ct).

Because of that, if the ct in Router disappears for some reason in [1]
with the packet sequence like below:

   Client > Server: sctp (1) [INIT] [init tag: 3201533963]
   Server > Client: sctp (1) [INIT ACK] [init tag: 972498433]
   Client > Server: sctp (1) [COOKIE ECHO]
   Server > Client: sctp (1) [COOKIE ACK]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057809]
   Server > Client: sctp (1) [SACK] [cum ack 3075057809]
   Server > Client: sctp (1) [HB REQ]
   (the ct in Router disappears somehow)  <-------- [1]
   Client > Server: sctp (1) [HB ACK]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [HB REQ]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [HB REQ]
   Client > Server: sctp (1) [ABORT]

when processing HB ACK packet in Router it calls sctp_new() to initialize
the new ct with vtag[REPLY] set to HB_ACK packet's vtag.

Later when sending DATA from Client, all the SACKs from Server will get
dropped in Router, as the SACK packet's vtag does not match vtag[REPLY]
in the ct. The worst thing is the vtag in this ct will never get fixed
by the upcoming packets from Server.

This patch fixes it by checking SCTP_CID_SHUTDOWN_ACK before setting
vtag[REPLY] in the ct in sctp_new() as the annotation says. With this
fix, it will leave vtag[REPLY] in ct to 0 in the case above, and the
next HB REQ/ACK from Server is able to fix the vtag as its value is 0
in nf_conntrack_sctp_packet().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index c94a9971d790..7ffd698497f2 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -299,7 +299,7 @@ sctp_new(struct nf_conn *ct, const struct sk_buff *skb,
 			pr_debug("Setting vtag %x for secondary conntrack\n",
 				 sh->vtag);
 			ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] = sh->vtag;
-		} else {
+		} else if (sch->type == SCTP_CID_SHUTDOWN_ACK) {
 		/* If it is a shutdown ack OOTB packet, we expect a return
 		   shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8) */
 			pr_debug("Setting vtag %x for new conn OOTB\n",
-- 
2.43.0


