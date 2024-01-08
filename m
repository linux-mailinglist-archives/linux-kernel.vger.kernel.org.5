Return-Path: <linux-kernel+bounces-19497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735EF826DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061061F22AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3821440C02;
	Mon,  8 Jan 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZXI+cGg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF2B40BEA;
	Mon,  8 Jan 2024 12:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE886C433CB;
	Mon,  8 Jan 2024 12:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716873;
	bh=1lexW2BtbdnsU7sj5WuiLgGQQK/Pkc4qG3Tgh0ZgQE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZXI+cGgqSb9NQOvk120HQqFwqwpMFuqljiD8sGc72aCpJ7NCd16WJJRZ0SXnbt/2
	 dzASgOmGzEqArnJIY0DYq3kCUnBK/AI7A/ufyJf3OasW1Hwd5XfcAC3u5wR2Ous8gj
	 jTYqF7zN0DFGs6+hp1+9xo+67xp6TAebGlRHTrDK4qLzCfx31NmO5gR/WRaBtQt47T
	 1dbOHzLuYhL86Iw/7T77OnMHvpP214Iihtc6vX81Q1jSHLi3DAbgWbjuZkI32X4O6K
	 SZGWo2OkcbLYQgcEf9Kx6wE6eNCMuBulMueQW1570q8s9T2aHbqlsJ2bwes0o2+jF3
	 fpwFUJxfTBxuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sarannya S <quic_sarannya@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 3/8] net: qrtr: ns: Return 0 if server port is not present
Date: Mon,  8 Jan 2024 07:27:19 -0500
Message-ID: <20240108122745.2090122-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108122745.2090122-1-sashal@kernel.org>
References: <20240108122745.2090122-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.10
Content-Transfer-Encoding: 8bit

From: Sarannya S <quic_sarannya@quicinc.com>

[ Upstream commit 9bf2e9165f90dc9f416af53c902be7e33930f728 ]

When a 'DEL_CLIENT' message is received from the remote, the corresponding
server port gets deleted. A DEL_SERVER message is then announced for this
server. As part of handling the subsequent DEL_SERVER message, the name-
server attempts to delete the server port which results in a '-ENOENT' error.
The return value from server_del() is then propagated back to qrtr_ns_worker,
causing excessive error prints.
To address this, return 0 from control_cmd_del_server() without checking the
return value of server_del(), since the above scenario is not an error case
and hence server_del() doesn't have any other error return value.

Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/qrtr/ns.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b1db0b519179b..abb0c70ffc8b0 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -512,7 +512,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
 	if (!node)
 		return -ENOENT;
 
-	return server_del(node, port, true);
+	server_del(node, port, true);
+
+	return 0;
 }
 
 static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
-- 
2.43.0


