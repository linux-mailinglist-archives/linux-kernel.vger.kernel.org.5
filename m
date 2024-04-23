Return-Path: <linux-kernel+bounces-155067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF98AE4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D96286CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C825C146D52;
	Tue, 23 Apr 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCYKKL6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B6B12C480;
	Tue, 23 Apr 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872497; cv=none; b=hYj/eQXYYfc92HZEpSPoxgYOr1RTcouduXR8TYTrhVh1KP0d45T796AGIPUtKf+/Ba0bAxuRrDZb29FZYD7+jlm5XW3a5pzPDw7epioX05IHRIuszmEVZ55LwMBKO3Zf+jHkCDNwNi4k7wK8fJgpyZLdxTfxmzYAbeK4W3PofZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872497; c=relaxed/simple;
	bh=tvahXeSj5iqGpTmCa3obYsfhdHJ8XUvIS8czKs6OQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BiJ2X4VJWplwE7NcKVFcBywA8ORcIJ9lzvBFc6CqOUMVaDmTltMTPA8ESJAMwlVZyF9OlDKDZHkVyRG3idmUDe+R3PKcWcr+VydSvzBcHN683nW4kfnhOcfCDGS9i6aYWYL6V0B/f8sqpFamGtGR+1s6b6dQre4PHxd4RBFJWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCYKKL6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FECC32783;
	Tue, 23 Apr 2024 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872496;
	bh=tvahXeSj5iqGpTmCa3obYsfhdHJ8XUvIS8czKs6OQdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WCYKKL6xfKtcRVOffhFQ1I3r6DdbZwKGpo4HbMKXNpsor+yHD4hUzWjFCKU2vA6ZU
	 MJjRXYS4WoPi5VoU3TN7A8ZhPmaYWIBx+D8hnHXwYG/pvqolW0Zv3Ke6mJ2qLQGaYT
	 2B9uYIue8sbl7/jnjvkxGgxkITRn6fZtRgEDj0D28K9Dm6+JEzMPgTFX9CfG+8wvjJ
	 mv8MN8xPC31cWfOOZtZ6yBVY2bQg7ATWBNTQp8I/c9X1YfqF7JEK4/ce8ZiTgSUR49
	 qiAMEur2HQOiKvZ71lWVevbg1ofLPOg58Ayob02ndUMk6vPhPY6kEejBSIydDbnij4
	 Z1hoFhE7ZeJZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 4/9] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:42 -0400
Message-ID: <20240423110249.1659263-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0c3b532ad3fbf82884a2e7e83e37c7dcdd4d1d99 ]

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
index b5fbba5a783af..e3755bc636267 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -102,7 +102,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 	unsigned int reg;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	if (reg_type == CTRL_IN)
 		reg = GPIO_IN_CTRL_BASE + gpio;
-- 
2.43.0


