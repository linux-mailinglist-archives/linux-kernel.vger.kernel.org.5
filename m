Return-Path: <linux-kernel+bounces-114109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F45F888F44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3BC28F158
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF2323C41C;
	Sun, 24 Mar 2024 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/ls2nYx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAB1E7DEF;
	Sun, 24 Mar 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321412; cv=none; b=UDlnoD6Gsa7qkao+jDdcBosjgWbRTdG44L8T9lWsW3JxO9BpqJfcUbugl4VN5g4aSK08f83PLmxOCjJ5KqPvGrdqC0A/jUTkVNwqe2G/mTYJhEj3baLxNCybhs8/kDb72ELZtbAC/Fmvdb1hWVobNOE2XPhHK+bqCm1iRvIUL48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321412; c=relaxed/simple;
	bh=j+locyNu/3KvesEXSJJRLSODxG0kaNpjtj13KX0SZx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO94xJ8bB/8oXmRnmwR59DxrS8J4l4X9HAH6xbQr7Ocf2C74NNix93x7BJXay5lv89DIQFrTZS80ygWh7xF266nC6i4RQI8z2jgOVzqw2kKypIQ5gSBCzcUCC6AF2LHAQzku1+GsDTjysL2F4uLONOYLM3gHd7J83r2OStFn4+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/ls2nYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A08BC43399;
	Sun, 24 Mar 2024 23:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321411;
	bh=j+locyNu/3KvesEXSJJRLSODxG0kaNpjtj13KX0SZx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/ls2nYxzdZV4A4vn6apwStTi5YSeEjzCc9oBSX6V/JC3mdEMO+7v5TD0F+7KQkFm
	 7poNSOlTe/lgxxUHvMBWTjBsOtp9SWlvdx3Az9hghz0QeGWhp/xxzQFXsQY1oR0eZ9
	 CmrzX2jOq04bNroPdnxCt21DkzdgRrvkaxniIzLxfzLuuoz8PKnLMsvZFkGqobH4+6
	 QfdFlI+aBDoOq6ZIZnbCXrsvvUKfnV84P5pdzlEM13tH36CrnaeXf4gvcenWKBl3JS
	 syIeM4+tHG2GcSGC36x6f1BlxmEBGTPn8WtgLtbtDQ9nypFHRxIH0i43cyzp6xaSH4
	 9naQ1vAdqVTNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 135/638] inet_diag: annotate data-races around inet_diag_table[]
Date: Sun, 24 Mar 2024 18:52:52 -0400
Message-ID: <20240324230116.1348576-136-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e50e10ae5d81ddb41547114bfdc5edc04422f082 ]

inet_diag_lock_handler() reads inet_diag_table[proto] locklessly.

Use READ_ONCE()/WRITE_ONCE() annotations to avoid potential issues.

Fixes: d523a328fb02 ("[INET]: Fix inet_diag dead-lock regression")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_diag.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413e..132b10e23758b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -57,7 +57,7 @@ static const struct inet_diag_handler *inet_diag_lock_handler(int proto)
 		return ERR_PTR(-ENOENT);
 	}
 
-	if (!inet_diag_table[proto])
+	if (!READ_ONCE(inet_diag_table[proto]))
 		sock_load_diag_module(AF_INET, proto);
 
 	mutex_lock(&inet_diag_table_mutex);
@@ -1419,7 +1419,7 @@ int inet_diag_register(const struct inet_diag_handler *h)
 	mutex_lock(&inet_diag_table_mutex);
 	err = -EEXIST;
 	if (!inet_diag_table[type]) {
-		inet_diag_table[type] = h;
+		WRITE_ONCE(inet_diag_table[type], h);
 		err = 0;
 	}
 	mutex_unlock(&inet_diag_table_mutex);
@@ -1436,7 +1436,7 @@ void inet_diag_unregister(const struct inet_diag_handler *h)
 		return;
 
 	mutex_lock(&inet_diag_table_mutex);
-	inet_diag_table[type] = NULL;
+	WRITE_ONCE(inet_diag_table[type], NULL);
 	mutex_unlock(&inet_diag_table_mutex);
 }
 EXPORT_SYMBOL_GPL(inet_diag_unregister);
-- 
2.43.0


