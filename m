Return-Path: <linux-kernel+bounces-49779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B7846F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00F9B2C135
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C751468E3;
	Fri,  2 Feb 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZC0VIPY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6461145B31;
	Fri,  2 Feb 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874030; cv=none; b=uBezmYQnZO77RR3lCMa//KeJ4BsAaNEP1h47s+BUTwI3siTAsYjcWnBuxYq9CmMkNdmqYofkQiJe67mYFX9XyWUI8O/h/t771KSE9Fy/3ZXF+CjqVM1JGXo3uzHGoTgDatFGoJjXWarDnQgAYD7f+jJ9RGCDBUuE6S9aYSsLFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874030; c=relaxed/simple;
	bh=Jxc4BXAT6dxBPjnLFX0FeEQI0zrczQYYN04opb4NwR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brHJ6fykaoHM2pcv3j9NSRBxRtv2kknwlQ2cdGFLC0jjc0N2x3qr1qMjd7rYkFveXB92kFgqBhPA3c3WB6VBKI1jfb80VhQvyE6+In7XaF4Ad3TX+NvqctsN8YSaBTI2MdjXx19iyRC0kHrQqdiH8x1lJkBPVEagdWnylw6Gj00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZC0VIPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDDEC43390;
	Fri,  2 Feb 2024 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874030;
	bh=Jxc4BXAT6dxBPjnLFX0FeEQI0zrczQYYN04opb4NwR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eZC0VIPYmTttoPG1KCdP4MgZADpjHYBHdO1WmQLiDiUKpA0zC4WHTtfgjebCDwvKQ
	 xikGyFVOqC7uU5JhR1Y49wTfWSlfOcIgAUJtycROLcm16vcxj1+lpzxegRkmmiK3DX
	 PiKclq9lcZSox/ugQAVpb8AOkcmEIGAqfYofh2TCCJ2KAXvCePgHunx4SvK3VhH6xH
	 wawNV0gILpWY+UqGlBvdstd+2csVmiyNCM0YIzp43v47Jq8M/zGb74ei/EYu2LZNUS
	 sBP8G9oN82AkS4nwrvb/zGVrmWcpRL3I7ZUXfuIOv4jI5/ta2Na0CfUsXjejyLYTKi
	 /qO6ZlZu2VBdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Feb 2024 12:40:11 +0100
Subject: [PATCH net-next 5/5] mptcp: annotate lockless accesses around
 read-mostly fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-5-031d6680afdc@kernel.org>
References: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
In-Reply-To: <20240202-upstream-net-next-20240202-mptcp-annotate-lockless-access-v1-0-031d6680afdc@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mcjDNT7BXUOg/gwV+eNe8UHcg0uqImaUFo1VPMNJ1B8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlvNSff8n+XmNCRtXgslij21RTQ7ZYYjUF0CJma
 R3m/ECc3fmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbzUnwAKCRD2t4JPQmmg
 c1LmEADl/BohaAL8uYm11SJ5Smbiq5+ZyWk01aKz/XPWg7ewbVlsU/R/RBjdM/O+rR1SbjbH6rG
 BrMYDgz4uiVDoh3h5B1ZEBm8g/EEkNzMc39hlXM4foIrHMyzi/0cPK5rElMzEV21Quq5r75c1RF
 nKLWmxprNunbJpLP0B30NwHEqXbYkatUJlHXRhpOEt4NZtcdvo60lMr1sMvrV7V+J4UsK61rMEH
 +TprDzAk+dcVmQUFUWQDpvsiX6Skm9LsDlsb2rXgFaAkB+gzlygsJdJnVydi70VMQ6SkSq56bgj
 m5R+sTKA22TuUvkDD+ycEscoPCUU0+qtwfdheP1ckZuD+6GZsHo3P2LbUbN+HSN50w13Va9D9QJ
 mb2SFl9x45Ep0FMmhohUaO49TQH4fnkdyVWTr5noJnMSKXqve1tWxT59lezdeir583uDhQFmBjL
 PW/z1wVxk0TbpGEDTRMoSOn6AkFPZ1a6ib6lRiisQl/MgeK4mVA04OUuH47RK2+Kf9DJkApPvCF
 gf5BCWV4npKtKkiM2hSv2eT/xCcAK7iaW5uEx9gL4daulhummlWTUqKnvTXP2PJPHgkK9UwIzLm
 zTa2yjXfu+JicdMuy9fLpTxzIhS0VFItjUmwwev6s3cD9a/3M+rfr5WvigXCVC4/4yCy7E8xDBx
 qYDLFPju75tNCUA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The following MPTCP socket fields:

 - can_ack
 - fully_established
 - rcv_data_fin
 - snd_data_fin_enable
 - rcv_fastclose
 - use_64bit_ack

are accessed without any lock, add the appropriate annotation.

The schema is safe as each field can change its value at most
once in the whole mptcp socket life cycle.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/sockopt.c  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4478ddd3b5fa..ad39f54b3a81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3149,16 +3149,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->cb_flags = 0;
 	msk->push_pending = 0;
 	msk->recovery = false;
-	msk->can_ack = false;
-	msk->fully_established = false;
-	msk->rcv_data_fin = false;
-	msk->snd_data_fin_enable = false;
-	msk->rcv_fastclose = false;
-	msk->use_64bit_ack = false;
-	msk->bytes_consumed = 0;
+	WRITE_ONCE(msk->can_ack, false);
+	WRITE_ONCE(msk->fully_established, false);
+	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->snd_data_fin_enable, false);
+	WRITE_ONCE(msk->rcv_fastclose, false);
+	WRITE_ONCE(msk->use_64bit_ack, false);
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->bytes_consumed = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c40f1428e602..da37e4541a5d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -942,7 +942,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
-	info->mptcpi_csum_enabled = msk->csum_enabled;
+	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
 	info->mptcpi_write_seq = msk->write_seq;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;

-- 
2.43.0


