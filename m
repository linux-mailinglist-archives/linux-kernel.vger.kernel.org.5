Return-Path: <linux-kernel+bounces-123240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0A4890505
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561CF298D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320B813664E;
	Thu, 28 Mar 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojg0VOK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B211311BD;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=TBSZA5LT6XO4DfiQCyoewETyULKXA+HcREHjTeNQy6jkSmGU1BuMj//cpE9qvwYk8uv4S7enFu0DzHPSsxBA+w8TvFLXUrYpsED8tL+idvCrB2Q5BEiQeuzG4eqNAhSC5QgEFPs6Wdr47SZ0zCf9PhZ/+gjtl7y3x8VndeKdNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=s+jTi4eJig4V+cSHfB9rBekx4dnzA9Bu1DuFXptHNpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXDnblZEEajlydt9oVbAQddNb4sCA8jQfQEfUe1eVGY5TfkXdp3EWLVhFpj+wveSqJWt7ult27s9k1+TLOcsJbZR8xHILkHqUuhOqkZpEP0Z6c6hAevj9YVBXYsQaL4v+qC0/jdVdtGmBxzZfWeshvxNLDhsP752DUYcSkbLcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojg0VOK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5F01C43601;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=s+jTi4eJig4V+cSHfB9rBekx4dnzA9Bu1DuFXptHNpQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ojg0VOK36dkUZTGUyrfCFZ6o73o3F6pypuXPK2ObWRc0fH/rpi1y36tOSTcn/Fyqy
	 /SeglpK3POw9slfvWRO1Y4KuexmMvlMUq9jnALfXV2+R6PFWHhqTHzt6cBMpJKb6vv
	 3V/6E+0xA6D0uuvegjM5e44VoDvPxg3ooRInokOPWw5dqncyFJXy9eJ5YpgB21l0qM
	 Jzh70QLyN/UWj6zG432Z0lc/dItSB4L3I66mwEJrKmIvCbGPH8zbhdjfGSIh5FA4h7
	 C4TXvCwHD0BxUMZXqSZg+NCeMUCAnYUh557SdW4aA4If25U586V31eyPjP30e6YOsw
	 5e0Xr1gWu7oLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CA5CD11DD;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:01 +0100
Subject: [PATCH v4 1/6] printk: add new dev_errp_probe() helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-1-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=860;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vXOLsOw6+C77AIWiu90FWpD8kygNarvvpJ/k/VruOcs=;
 b=64nglCnPkvcJectWPXgIGHdCtTNeyHylZlWDbeBrURS5fXiWuIaps6bEP0qGZsmALZb8I1CI0
 vZgLbagCniUC49mYmTeUqCiM6uaPJg7sZbVwEMLKpfJnk2m5TgGd2VF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

This is similar to dev_err_probe() but for cases where an ERR_PTR() is
to be returned simplifying patterns like:

	dev_err_probe(dev, ret, ...);
	return ERR_PTR(ret)

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 include/linux/dev_printk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6bfe70decc9f..64484d092a77 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -276,4 +276,9 @@ do {									\
 
 __printf(3, 4) int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* Simple helper for dev_err_probe() when ERR_PTR() is to be returned. */
+#define dev_errp_probe(dev, ___err, fmt, ...)	({		\
+	ERR_PTR(dev_err_probe(dev, ___err, fmt, ##__VA_ARGS__));	\
+})
+
 #endif /* _DEVICE_PRINTK_H_ */

-- 
2.44.0



