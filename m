Return-Path: <linux-kernel+bounces-115450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0B889BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC582A688F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5D216194;
	Mon, 25 Mar 2024 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsK0BcCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355E146D49;
	Sun, 24 Mar 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320816; cv=none; b=U1o65CuTCO/71y5D+gNCcDGIp0wyCyk3q0pGOWTyYsv5jDfqLg0F0p104WkGKdfwn8/w2lxUYM3fUmDPyrLYOAq5ITqlWovCIQ9Y3NJDAgvMzEmYT+Nwot9A6FuMl5p8mrGKmHuyRvda47urZNNJrf6myRtYJ6qoL3FxoUo3DsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320816; c=relaxed/simple;
	bh=v11nOk9WMIawSUi2NTo75pwxYN0u6dGKGLF3hwTXg3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZzGmHiRvRLR86mAXymS/H3G0SOSF+ygR2hynArtUPjKveypJ00ARJCyk2P2o9XS1kk9vagLS/E6RePgxXabSzR6+aPGBx2qVRPo2re0u4caRM1wwtEQijZ3ogiMyP7PLZN71tPASVEAXsQQZpiQ/5bqKbBCIjm9yU6YWseNgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsK0BcCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD6AC43143;
	Sun, 24 Mar 2024 22:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320816;
	bh=v11nOk9WMIawSUi2NTo75pwxYN0u6dGKGLF3hwTXg3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsK0BcCHblUep+n9Ds8LFMp0WTIfpJk8YdRNvfd2dgnBlxHYPHVxsqyb/6nCbudLX
	 2cLW3yc+5s0rZuqnAvIXLneJdHbMXodykLq2BFhxP6FkcA9rCYU4c5gNwJWtMAlOr2
	 3p6LQyq03tXi/1zwf6YEJpxG0pbWxiUG07ZShnTbYF+ia6OvT9vAI9R3HxX5z8sQUS
	 +fnSQHKR54id2VgoTHkDjTwpg2dz0yq+GQaTGQNAeYojy9ax2uUI+jxLyhMxtwvf+p
	 ioDaJy7LecKaCRIZp6QOfXKI2JTFoBjdqIdZsGK+Vjfc/pzXm4r1/wvtYQ7JiNRKhd
	 6Im3EAz0MVeKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 381/713] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 18:41:47 -0400
Message-ID: <20240324224720.1345309-382-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

[ Upstream commit 4bb3ba7b74fceec6f558745b25a43c6521cf5506 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e474b201900f9..17231c0f88302 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2792,11 +2792,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case UDP_CORK:
 		val = udp_test_bit(CORK, sk);
-- 
2.43.0


