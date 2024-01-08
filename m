Return-Path: <linux-kernel+bounces-19504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AC826DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D4BB22533
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F321E433C2;
	Mon,  8 Jan 2024 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ipy6BWUA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EB4315C;
	Mon,  8 Jan 2024 12:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2792C433C8;
	Mon,  8 Jan 2024 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716908;
	bh=+G5b9k2kYr/Ssctr7RTuveDSyQpoCR8qAoBv4tm6mnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ipy6BWUASE56rTRd92nafCpWn4bQA4KP8fWUcs9G+ouu4LVo+MjesB0JUUyAryO98
	 uHUudKIuLw0HWy37CmfsBZ9n9XED+PmNMkK1PfE8R/Hid0gJfcoMHQyt21lq7fJQm2
	 JS5cLRSRO+2qaJvgWywPMWjIAM+4qbskpC/wdAxOh+p3v8ZwGz2a2DnPDuw4/T3QIs
	 nIOlllS2ev+EU+AOG1x/RWz26I/2a2yqFV/Lt7SZYiek4sDxs6iEJ4ZHlqn5bhykGW
	 FAbHQYwl1AsDKqoK47n2x7ReFkr8CmuWzEZ+Jc4R03hSs88QgSA8kXcBvWzDUcsFm4
	 bVy6sDUer7ZdQ==
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
Subject: [PATCH AUTOSEL 6.1 2/5] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Mon,  8 Jan 2024 07:28:13 -0500
Message-ID: <20240108122823.2090312-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122823.2090312-1-sashal@kernel.org>
References: <20240108122823.2090312-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.71
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
index 645677f84dba2..819157bbb5a2c 100644
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


