Return-Path: <linux-kernel+bounces-19505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F9826DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C1DB223EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356C44387;
	Mon,  8 Jan 2024 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db3kakRG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429144373;
	Mon,  8 Jan 2024 12:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FD4C433C7;
	Mon,  8 Jan 2024 12:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716910;
	bh=0pMd2NkwNypVAaJM69uyrT+5T8QfS6QQ5RO+ZUtRpXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Db3kakRGAwSdt/FNxpSsXNmSuivh5BEfLvgZGP5d2puphSjMxbxep1aVv1bI8VfJ+
	 NP8jT80GvL5Q3+tCuRgWXzbd/b+IwLh3QHovRYSNDUH2Mt1sETL/PsfINLFOvSVNFy
	 LWdUYqv6sOhbZ/GBX/CQjvXMNahAgDiHhGpjolGg82FVW5dMtunojXBtkpG+Wkqf9e
	 2jrW4FZgbn4wP6dBsGQS4MIzRt76Hl72wNo819xd1hU77fkP+EpEGqVwaP198WIWu/
	 2szOxDeMcdWHpGd7vH3+28zdd0oh1HZMQCigCiGzZGkFNlb2A/XwebOYoTRULr/VZ8
	 RSkcdcbxEYXlA==
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
Subject: [PATCH AUTOSEL 6.1 3/5] net: qrtr: ns: Return 0 if server port is not present
Date: Mon,  8 Jan 2024 07:28:14 -0500
Message-ID: <20240108122823.2090312-3-sashal@kernel.org>
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
index 3e40a1ba48f79..4a13b9f7abb44 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -569,7 +569,9 @@ static int ctrl_cmd_del_server(struct sockaddr_qrtr *from,
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


