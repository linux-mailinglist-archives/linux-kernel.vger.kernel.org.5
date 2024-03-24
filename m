Return-Path: <linux-kernel+bounces-113576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49E88856D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4881F23BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A19974C1B;
	Sun, 24 Mar 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaShrrsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012D1C8FC8;
	Sun, 24 Mar 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320379; cv=none; b=hOvjuOw44hAgwb9BeCIHSq+RakY7kwftEOKEPIR9AdiuNr8jEicPMWIBWi3Tf2lhTBcVoNp3BNV/skTaKjTyc5cEpi9a1DGAV3amqYNW3ezSt+AmgvVFATtWnomXTem0Ci5mhm/4JkHrB4Fs6CvsvUEn9lLLYyJu0a7VMC5enTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320379; c=relaxed/simple;
	bh=nuvNN4ZvtBd/GUiziz/K8W0DyuJfnso9yH/WmpRvifE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDyfXCcebSzVcjqbLBjwjGeRY8V72chbLgiSzTCSuTb0E9BXwDCdlUCj+tzNkOLM1LpYbq1ItK1SAeZoKmsJSW95BkZwbQU8TiqPCNVk0QSYZvxmlIa7zVnZ1gjIK4usLn6mfnH+GIgEO0ybE2GJd+xRXQuhgfXOYcb0FMBrABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaShrrsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A226DC433C7;
	Sun, 24 Mar 2024 22:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320379;
	bh=nuvNN4ZvtBd/GUiziz/K8W0DyuJfnso9yH/WmpRvifE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NaShrrsDlzh6FdAFyyxFRMGgn8PsHQW281zoxwUSjAtCzzyd2JL14u95MLu0AkBqq
	 UmpIfqalY8zTE4qbKWTVb1nTj3MS2P3znEO5kijAWhhIA/aTtnzeL5zcOE2BioOP+P
	 H8Rrc7DQakDsvwQMs3VBHAGCrUPlLbeP4w+3w/kjlv/Dwkc6C4sIsxCKBsE4woz2sM
	 LxNxwDSRD2E5Iy+RQjyp4nJrTi/vPL+jsE2QW7NC1pOFWPz6Z5l1M4QDQImqxwfWOu
	 cCXvLwxaLBiMyctWq+4YOBTzS4SCBUC6MVa1i3xMm8NJk9sdArDA3EXcQbXZbaUkGr
	 +ACr7KSzeWBwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tobias Brunner <tobias@strongswan.org>,
	David Ahern <dsahern@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 685/715] ipv4: raw: Fix sending packets from raw sockets via IPsec tunnels
Date: Sun, 24 Mar 2024 18:34:24 -0400
Message-ID: <20240324223455.1342824-686-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tobias Brunner <tobias@strongswan.org>

[ Upstream commit c9b3b81716c5b92132a6c1d4ac3c48a7b44082ab ]

Since the referenced commit, the xfrm_inner_extract_output() function
uses the protocol field to determine the address family.  So not setting
it for IPv4 raw sockets meant that such packets couldn't be tunneled via
IPsec anymore.

IPv6 raw sockets are not affected as they already set the protocol since
9c9c9ad5fae7 ("ipv6: set skb->protocol on tcp, raw and ip6_append_data
genereated skbs").

Fixes: f4796398f21b ("xfrm: Remove inner/outer modes from output path")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Link: https://lore.kernel.org/r/c5d9a947-eb19-4164-ac99-468ea814ce20@strongswan.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/raw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index aea89326c6979..288f1846b3518 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -350,6 +350,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 		goto error;
 	skb_reserve(skb, hlen);
 
+	skb->protocol = htons(ETH_P_IP);
 	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = sockc->mark;
 	skb->tstamp = sockc->transmit_time;
-- 
2.43.0


