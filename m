Return-Path: <linux-kernel+bounces-5732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64589818ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212A3287E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9539AC0;
	Tue, 19 Dec 2023 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="d3w5td7+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D6E374F8;
	Tue, 19 Dec 2023 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=siddh.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siddh.me
ARC-Seal: i=1; a=rsa-sha256; t=1703008193; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=O2lZZ9HwWZENrMMyZrM1Yzod/hHiK+jK7pDwdayn2m/RELjnaOQnoMBhLc8IgMYKPkp/gIlHxPLgIOZ4KmPkAVR/7tlVNneEy+hM1iKd8T4Osi57whn1bSuVC1f4zoc2OMSZ/G0LiBqOEJAOtx4j8NAvNsFbnsoupDURhzgLP5M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1703008193; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=872tkGPm7VUCxpgjJMERmpcep5wm35gG4ZP3R1Drljw=; 
	b=RAmho9NtBqc8m36Qeb4liQdXtQa96J7exICe0g9G/LAGohQmSHMOq7impzN3sDPMcWQd2iuImnttjpLMgK27s0kTYvj34zoU7mZAl/gvF+mCIki+Z1umMeUvUmt0BcPiigMScbdTp0tfAwvGT47vijAHTqokNzmm7BXo/KMS1F4=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1703008193;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=872tkGPm7VUCxpgjJMERmpcep5wm35gG4ZP3R1Drljw=;
	b=d3w5td7+zQt54GRVeCfbgqH/oeI7Y0/Kqr/EfxRXvdCSbwbJTYN0z51jFOGuQ3DI
	H+WpJKUkaIMo73xARw10HHgeCqQmna40+cEq7eCkGrH2l7dlq5pCdlaD4A3kptOOgna
	5H5BRWJ2kwXXZN9Y9+zP8LcVOSbkCXJBYdTXw+9M=
Received: from kampyooter.. (122.170.167.40 [122.170.167.40]) by mx.zoho.in
	with SMTPS id 1703008191467810.3177351858395; Tue, 19 Dec 2023 23:19:51 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suman Ghosh <sumang@marvell.com>
Subject: [PATCH net-next v7 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Tue, 19 Dec 2023 23:19:44 +0530
Message-ID: <0490c52b68c27730d9916ff22c917b4838c32af4.1702925869.git.code@siddh.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702925869.git.code@siddh.me>
References: <cover.1702925869.git.code@siddh.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..819157bbb5a2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
-- 
2.43.0


