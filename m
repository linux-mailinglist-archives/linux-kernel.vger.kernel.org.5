Return-Path: <linux-kernel+bounces-19518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBCF826E30
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592891F227F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9B46B96;
	Mon,  8 Jan 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+ZH52CE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506D46B91;
	Mon,  8 Jan 2024 12:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74774C433C9;
	Mon,  8 Jan 2024 12:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716969;
	bh=vM6QXaZm9tiA/pNFRwjwhyWMtcO2J1E6ww2Avca+rmM=;
	h=From:To:Cc:Subject:Date:From;
	b=h+ZH52CEHvGVJ+HPy1vv8rbFoV3Kl2zPYLIPB5lGzxrEoG8ClMAs06qmZ6Ki6LaDE
	 87QE/llLTS91NWkRHvBO6ls72FRXuRDYXUAxoVRHGZK1Wr0zvF+V+R0iyJaxq4fB3Q
	 OBLnpLfIVrWF5ib1DO0WP0u+yencg0d6LjZtf5PaTljSE5+5/Y0gSuUXyUalsV/Fwa
	 4rj8VEmvf4+V6/zE/HCSZ1wAt9AfAvQY9kISLG19FxkT4Jt43V3kMMtxkvQSCIN0AQ
	 k18nBdW14gRxT0USDOL1ROG5nLtJy2cXUQTpCl6B+c5nXD+zFOr66jwphFe5b1tG/S
	 P3YTEWKyGaSKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Siddh Raman Pant <code@siddh.me>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Suman Ghosh <sumang@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Mon,  8 Jan 2024 07:29:23 -0500
Message-ID: <20240108122926.2090989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.303
Content-Transfer-Encoding: 8bit

From: Siddh Raman Pant <code@siddh.me>

[ Upstream commit 6ec0d7527c4287369b52df3bcefd21a0c4fb2b7c ]

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 605d7448c3de1..b27bb2e2486c2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -802,6 +802,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
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


