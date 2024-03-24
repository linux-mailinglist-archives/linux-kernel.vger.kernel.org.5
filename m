Return-Path: <linux-kernel+bounces-114990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AB3888CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3240B308F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DC1311A9;
	Mon, 25 Mar 2024 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfwApZ/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C617AFBD;
	Sun, 24 Mar 2024 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323735; cv=none; b=ZKJtXN0+FPzqHb6mF+HvGmxd2Yn05+/8rjF6iUS0jGeui3DKBD+fT3vV35er5ueF43NN+7ykYFtHyNv2zydc3tLND6+Zwr1mNJv5K438zWRlKxUMUFINOP+dTMe/6AhrNIUYschlrJI4X93hqUf/BxLvvY49Dm/T0JCqgvVX2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323735; c=relaxed/simple;
	bh=y0C9wDt/PoG/I56N8RTFN9zd2/fgM9X7VUPWELxLLUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqO1jP8yftwXcHDSfi9KF1yVGw7f1RNRuR88r8V2u+kWaHMpoycnBqCwX2uIDW5gwnz5Dh3VVjiiVxO6sy8pjEKaGrFHgXuJ48CyhrCV2AXzalzA53ugk8xvtvsYckoFCLReOc4yF+v8S0XFuor1Ufv5mVmgLm+8ZvQDftRXURI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfwApZ/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BD5C433B2;
	Sun, 24 Mar 2024 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323734;
	bh=y0C9wDt/PoG/I56N8RTFN9zd2/fgM9X7VUPWELxLLUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gfwApZ/VL56svfYv2gbYbeMWdI7b3x+6uey2rvjok4bXSOssuSU/ddVhCmCpTv8YQ
	 sn/7vl2YJbI6nGK+4xRiBVz95SpcPeEo7v2K1VF+lyKOqEKEU9S+NFdkRAnDd75+jD
	 kTBq0w6cOVHSjSQkFKfueopFLoF7Yf90SP7lLkxFFCAPZBYORBcbi4rUGkAVo2Pfvn
	 5HegUzmk83BP8L4DyXZBJ9tA/naNvCM8BIaHPOhd2B9d6R9iZWhlccNS86vuxHoChO
	 E7+6/XHny36LQOaGaNi7VZsKuYKbrfRmlpc6345t4mCdYVjBs6vlDwBZH9TnO9DWKo
	 +/kFsiefo56qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 108/238] net: kcm: fix incorrect parameter validation in the kcm_getsockopt) function
Date: Sun, 24 Mar 2024 19:38:16 -0400
Message-ID: <20240324234027.1354210-109-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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

[ Upstream commit 3ed5f415133f9b7518fbe55ba9ae9a3f5e700929 ]

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 39b3c7fbf9f66..7420b4f19b45e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1275,10 +1275,11 @@ static int kcm_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
-	len = min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
 
+	len = min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val = kcm->rx_disabled;
-- 
2.43.0


