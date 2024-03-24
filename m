Return-Path: <linux-kernel+bounces-112920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9670F887FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3783AB214B4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E745C08;
	Sun, 24 Mar 2024 22:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWyLH/5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD66F085;
	Sun, 24 Mar 2024 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319732; cv=none; b=ulwsfM8xfkBaPZBqvDVQLV4uilv+IE9ZId4pVeeNBVcf286+CqqIRa6Q74YI7xaYehdFviumHshoUnghDZICp98xngve1xkcarmd/P8PX7emXqWnnGwksBihgmDyhD1EwvoEmHYEQllEOZOIcQnE+oJTqQrVUePzE0Lvb/KhFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319732; c=relaxed/simple;
	bh=vrxNdixPF1P+PaS8QLrMH1Ze7LzOwQIc98jq+2n817o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVhWhM4aznsurOQosjlVWgr4dhL7pbXc4GnAOzjnVsVZsim4sAVI+LsemFNp8fqdwPlmwx4in64BVcHR5pzmL1jvYbEuFgilXkjO6RPmG1VLKQJv0IaleMf1EETz4HkrRqNP81KcxJ2i6wHc6iS6kx6jrBBv4NZzN7JuMk28GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWyLH/5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB17C43399;
	Sun, 24 Mar 2024 22:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319732;
	bh=vrxNdixPF1P+PaS8QLrMH1Ze7LzOwQIc98jq+2n817o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWyLH/5uUwgENdiUOQpdaOSsTFOBTo9zurie28eTI/d+RDODvQJeYWyGyqF0yq9yi
	 I2vK+mWMB+YKF5aafShXutw33lMMdOl78e/wKnEReGA9Ys9ubmHhBffNrjiHlBqGz0
	 28LiH7a8M/M2gfjiz+PvlyYRwvGRASAkrMrFP6lfShcdSayoLxCoqAiTDVav4ZKzyz
	 SRIQnodEeShJpSScbumSg+g4x7pxhJYW2x1fIoPy2bUiv+9CmSR1T9JS58Yd+7aPmf
	 U3wPNHvgPz+PwwYrhRIY2kVpwmE/aUrrt4FLQXUir0pfpDVidGbCmY6CVAA0yEv6xh
	 SLKAvGYjw3WYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 033/715] net: test: Fix printf format specifier in skb_segment kunit test
Date: Sun, 24 Mar 2024 18:23:32 -0400
Message-ID: <20240324223455.1342824-34-sashal@kernel.org>
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

From: David Gow <davidgow@google.com>

[ Upstream commit ff3b96f2c9e5c24fca12239cd519a8a18569e687 ]

KUNIT_FAIL() accepts a printf-style format string, but previously did
not let gcc validate it with the __printf() attribute. The use of %lld
for the result of PTR_ERR() is not correct.

Instead, use %pe and pass the actual error pointer. printk() will format
it correctly (and give a symbolic name rather than a number if
available, which should make the output more readable, too).

Fixes: b3098d32ed6e ("net: add skb_segment kunit test")
Signed-off-by: David Gow <davidgow@google.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/gso_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/gso_test.c b/net/core/gso_test.c
index 4c2e77bd12f4b..358c44680d917 100644
--- a/net/core/gso_test.c
+++ b/net/core/gso_test.c
@@ -225,7 +225,7 @@ static void gso_test_func(struct kunit *test)
 
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
-		KUNIT_FAIL(test, "segs error %lld", PTR_ERR(segs));
+		KUNIT_FAIL(test, "segs error %pe", segs);
 		goto free_gso_skb;
 	} else if (!segs) {
 		KUNIT_FAIL(test, "no segments");
-- 
2.43.0


