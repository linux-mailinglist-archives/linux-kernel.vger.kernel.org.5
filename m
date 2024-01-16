Return-Path: <linux-kernel+bounces-27883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871E82F735
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1381C246F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F877F13;
	Tue, 16 Jan 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPgKkpRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D237764E;
	Tue, 16 Jan 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434423; cv=none; b=uf7dc4lMuStYJYDm0QnkJhKeMyVw3R71+MbWkcEmlm/2uwd/BRvNxjEf4umx/HwwOnKefacN6mQkMioFUJqlm+xMYKN91SECVTdT0roUJpnwv0KY0dJIt+kBNfVof0uQE4/NJUghHR6u+2m9aFiNkvJf+bpoU54T2tOwed4zRww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434423; c=relaxed/simple;
	bh=XwWy4btrdrFDaQdryPSsdCI1nnvmIWTXvP6El7XQBd4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ZQU6ECRnLAKlxU12kKzv87lGdOiesvj0dX4/hmn+0DFV6JwkelWfuqQrhJF7I45XqaKkyzjJgd7fQ3McXbekpMVGRwNW8+e/Wj0qZbezzVNbkjSthoP+6waQ5jiEe4kQHVqcst0x81C3gpbY7etFRZGh3EjB2CWqk+8xuRzhcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPgKkpRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC96C433F1;
	Tue, 16 Jan 2024 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434423;
	bh=XwWy4btrdrFDaQdryPSsdCI1nnvmIWTXvP6El7XQBd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPgKkpRL4FF62p42D0YP0Hs/OSvxl25yzZ9x2xEhGtnVA6xusJM4TCGAxpaRRNt3O
	 Ep2Aji5ek5e67EV4RNY3njmoTVooH4q+nnBhAJbdXQLukqrcN23VfeCqzoAA3Sudvo
	 VnSaOVQIHenQLtIDQqN/MSBtajaFaGl1OJZQMceH8/0xy+kEgBQav1++/nwyuBgDQf
	 HAF3zHnsCZBRXQ8Y+PvW+Yt/J132RZFmGTZW7wGd0gTXWm32o3JPTy1zUlPaW30L3O
	 Cb7cbCiMwSBvoSe2Dh4NnPzh0NsDi1iwyZsxS/MzmnUzlG5eROZSJ4gnxgpH39XvZK
	 ZkPg/fQqb+iBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dhowells@redhat.com,
	syoshida@redhat.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 106/108] net: kcm: fix direct access to bv_len
Date: Tue, 16 Jan 2024 14:40:12 -0500
Message-ID: <20240116194225.250921-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit b15a4cfe100b9acd097d3ae7052448bd1cdc2a3b ]

Minor fix for kcm: code wanting to access the fields inside an skb
frag should use the skb_frag_*() helpers, instead of accessing the
fields directly.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Link: https://lore.kernel.org/r/20240102205959.794513-1-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 65d1f6755f98..1184d40167b8 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -634,7 +634,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 
 		msize = 0;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			msize += skb_shinfo(skb)->frags[i].bv_len;
+			msize += skb_frag_size(&skb_shinfo(skb)->frags[i]);
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
 			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
-- 
2.43.0


