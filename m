Return-Path: <linux-kernel+bounces-19498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A37826DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7241C22454
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840A40C1E;
	Mon,  8 Jan 2024 12:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHz57BZz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA440C15;
	Mon,  8 Jan 2024 12:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BDDC433CC;
	Mon,  8 Jan 2024 12:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704716874;
	bh=vCaKEA2Sm/10Plfu11TW70i3phqa0ki6DcDUxsqRki8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OHz57BZzGNdkT3O/obgVuDy0/SNEFh6ism8+0Eil6f2JPsV76I7uBQRyu0/3LiejL
	 bg5Gn9sNpepkCkaXaQEsdMFuS3jCgh3Qb5ng/wgXlpz0vk2z79Go50GBahCvuIZzzW
	 yJp/48FaINcleyg7hoSDzvYZWZyl5DdUq1fcXhfMflvI1z9qH+NxoovcoUoRVCJANz
	 VpaA6OT9K8bm6W+AROjcPwEdnksJUdpF/KMxABQ5eOSBjrk+pg4bY/CY8Tr3VSF1Ym
	 vz8M9/hzMkiJQ0dGdahBLkna1TMd2U/SUEkrpxXT/RGtFWxXsPRiVpIBOcB3Z/5DZu
	 Ljl5yfHkE6eFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: wangkeqi <wangkeqiwang@didiglobal.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 4/8] connector: Fix proc_event_num_listeners count not cleared
Date: Mon,  8 Jan 2024 07:27:20 -0500
Message-ID: <20240108122745.2090122-4-sashal@kernel.org>
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

From: wangkeqi <wangkeqiwang@didiglobal.com>

[ Upstream commit c46bfba1337d301661dbb23cfd905d4cb51f27ca ]

When we register a cn_proc listening event, the proc_event_num_listener
variable will be incremented by one, but if PROC_CN_MCAST_IGNORE is
not called, the count will not decrease.
This will cause the proc_*_connector function to take the wrong path.
It will reappear when the forkstat tool exits via ctrl + c.
We solve this problem by determining whether
there are still listeners to clear proc_event_num_listener.

Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/connector/cn_proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 44b19e6961763..3d5e6d705fc6e 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -108,8 +108,9 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data);
+	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data) == -ESRCH)
+		atomic_set(&proc_event_num_listeners, 0);
 
 	local_unlock(&local_event.lock);
 }
-- 
2.43.0


