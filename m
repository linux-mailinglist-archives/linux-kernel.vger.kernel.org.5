Return-Path: <linux-kernel+bounces-115206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C1889353
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 592BF299F66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F31030D4CD;
	Mon, 25 Mar 2024 01:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dls6411u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CC7294499;
	Sun, 24 Mar 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324284; cv=none; b=dZnITW1pD8ILHM8k2zJMjFp0uJKzki7IiAAqQ573/X4yxPIBWxC7098M8F+Nens/TFdZM9d6iFDUg1h1dj0YNRVcqkWplzBhKxeQ+Bj2cjmc7bUSVrTPAzh4gJlxTuT5ePXpFnQW1qIcG1nIcSj2JjS1H+ouVa/ma3kWKPqlYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324284; c=relaxed/simple;
	bh=atV4Yx4MhmIzRCUgPE+jW/ilVM46Ib2MxgB5BaFEVnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8S+HRXvbEWaWwwHhmjGl+jObLS2JYWJnkih6Ikimz7H5ue2F1relga4wTEqgTAnktP6BAprdfexNCbd3UyTvBDTqWvCR8kB6Y3UQr2SO1/J/vX8SdU9I9bOGtcMEZNJMeUe4oCvNVVJ/s88qVFDlWJGEHBmGsw455WU30f/gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dls6411u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F89C433C7;
	Sun, 24 Mar 2024 23:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324283;
	bh=atV4Yx4MhmIzRCUgPE+jW/ilVM46Ib2MxgB5BaFEVnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dls6411uLjHRGn3Xrj8983+LUV2LwIuLOwymqri0hTya6gMai7bqqkcIogd+QB0T9
	 uKSdxpU2mjYOGGTuCZFeHkd+dwc+KXalvtCehyj5r1jlb6sRCNy9lhEniK4ssGN/5Y
	 p4ozn1bttkNDi8F3RwCnJsR8mhcHeS+JX3J4KSfJb5aoV6p+3qi5muLIrpKQNazq0z
	 oySGv94mIKDoEigvuNBeWEAXAI9KLzZAqp/nojhC4LkvwCp/skou27ZwDmFHPoP59E
	 Mux7H4w3fhw5AuuzhWjoiItiIpdobT8sGmEK3qRZGEF1XGGDfXOCLsS/r2rdYIGpo9
	 gwRAFAiCOcw8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/148] udp: fix incorrect parameter validation in the udp_lib_getsockopt() function
Date: Sun, 24 Mar 2024 19:48:44 -0400
Message-ID: <20240324235012.1356413-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index a6048cc7fc35f..6e4b26c6f97c2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2579,11 +2579,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
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
 		val = READ_ONCE(up->corkflag);
-- 
2.43.0


