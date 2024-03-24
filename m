Return-Path: <linux-kernel+bounces-114161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E69748888C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85FCF1F27174
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3809D246E06;
	Sun, 24 Mar 2024 23:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtiZA/QL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F84204FAA;
	Sun, 24 Mar 2024 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321475; cv=none; b=GSGWEW6azvu+HqUANcaz/nOtv6+5gt+F7IUm35CpbrEESKed7gXhB/ugSVOy/V4zwxD3QK26kQ5LAF2Ez5XbJtSlAmxJe0CWnHIf2RAE1an8LX8Jvxg93jD3itU52miC1I4rorOUwKMECvP1w9W1942QahSMn2w25BYLbYDO3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321475; c=relaxed/simple;
	bh=16ZbOH+aD2Acv/vWezeIe7AruriuvaPWKR+oVUm46m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojZ8E02zksO2Y+9vfIK0xWQRC3u5PG+RxIVKrVfvLAit+RPGE2fCX2waaJTuJ1pyjnNzWoHl9+4qz6bVoO8SLxnVMoEY6f9YbgEcVcrdi0HP8eqrVEvO7WgsgLX3n9k7GloUKEzppJsbjupNc0hdC3duCXEdKOJi2AmhUxORJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtiZA/QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F89C433C7;
	Sun, 24 Mar 2024 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321474;
	bh=16ZbOH+aD2Acv/vWezeIe7AruriuvaPWKR+oVUm46m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtiZA/QLBIf6oT36LZiCuih9qgw8lxmF1mBw+5fN95mkQdi9UJtmGsWZGYU9lom1P
	 65/1pMxH2BCm6NvsG18PLsgl53zQ8rE3FLtstzRgG8j5gmHwam9LQ0adIqr3cVXX/B
	 tqXnNlzJa+0qQ5OZb/Bbnrw6UDlHEWmzsPXxbmPe3473uOI7262wmVhLnrFrxJQkJY
	 CTf+wCi6f3ZFj1Vbi8VFkthm5tUi5qJwi4l6T7IN2SlPo/+7A0IdrqcQZgxP8H8lzH
	 Pm1W0paD2r6+MUDhBX1NfUD1k2a+xAqKOqMewI7u+n8dHfGg3BzxNu4jbZoPp6+8l0
	 FsJ+yFdfSSGBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 199/638] s390/pai: fix attr_event_free upper limit for pai device drivers
Date: Sun, 24 Mar 2024 18:53:56 -0400
Message-ID: <20240324230116.1348576-200-sashal@kernel.org>
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

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 225d09d6e5f3870560665a1829d2db79330b4c58 ]

When the device drivers are initialized, a sysfs directory
is created. This contains many attributes which are allocated with
kzalloc(). Should it fail, the memory for the attributes already
created is freed in attr_event_free(). Its second parameter is number
of attribute elements to delete. This parameter is off by one.
When i. e. the 10th attribute fails to get created, attributes
numbered 0 to 9 should be deleted. Currently only attributes
numbered 0 to 8 are deleted.

Fixes: 39d62336f5c1 ("s390/pai: add support for cryptography counters")
Reported-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai_crypto.c | 2 +-
 arch/s390/kernel/perf_pai_ext.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index fe7d1774ded18..4a4e914c283c8 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -646,7 +646,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paicrypt_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
diff --git a/arch/s390/kernel/perf_pai_ext.c b/arch/s390/kernel/perf_pai_ext.c
index c57c1a203256f..b5febe22d0546 100644
--- a/arch/s390/kernel/perf_pai_ext.c
+++ b/arch/s390/kernel/perf_pai_ext.c
@@ -607,7 +607,7 @@ static int __init attr_event_init(void)
 	for (i = 0; i < ARRAY_SIZE(paiext_ctrnames); i++) {
 		ret = attr_event_init_one(attrs, i);
 		if (ret) {
-			attr_event_free(attrs, i - 1);
+			attr_event_free(attrs, i);
 			return ret;
 		}
 	}
-- 
2.43.0


