Return-Path: <linux-kernel+bounces-155058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9501A8AE4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65821C22BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86E143C75;
	Tue, 23 Apr 2024 11:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIaDogNI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE928143C5C;
	Tue, 23 Apr 2024 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872480; cv=none; b=rllCGjUhN2L4fMcqsO79JoeTPnlFDjJiDnFhzv1ECLoDuSz1lxZFv15cdiTDK070Wy1ksapS2ggsJ8zcxYrEf+56OKq51kt/ZIzvMmvdLH7k25pYg9pvhtWnw/tZYnL0WHG/Ye6d5rl+g11TQCXeUAwuWyyzAycwHiVsy+7bTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872480; c=relaxed/simple;
	bh=Z7K1TEC6YbRp8oemypKgCaK2krbYRjdQKpWmHKQYgS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeeKrr7WBW2+45h4etEgntXtTnpyldL/sbaV9dSfxNKNCWlJddLT+11MgmnDRVHB87/02tCEmNM7rJ0sDPGXCb1Q+e69d33fQ3X9VutjobP1JerW145fOlykpnZnGPug0FQZbYQS8aHN74sdgjDMpE5VbWipvDhJlUc7GXjR1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIaDogNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97594C32782;
	Tue, 23 Apr 2024 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872480;
	bh=Z7K1TEC6YbRp8oemypKgCaK2krbYRjdQKpWmHKQYgS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TIaDogNI7GxWUXuKY8ZrzkrTsLCvtYoT/MtZ79bGrGxRXessjAz3J1GCiOkj1Mnos
	 3cIoD9INv5e7+MuhXqv6h9R2d/YlszdIHjdhOSnfGnKkVX6kALuVISyUnUoOSXWvwu
	 acNPRzKc7zFHkzoBGP62NUmYzjBCLPjlbeespeUOcAzskMSmFZjoXoxI4rHRX3HFSt
	 DeiA2HrHf5tIgpKA5SsmGuTd2mZZBqBmFQ4i1CAEiFQ37LfVB8EEIFbDSNYKUnDXuV
	 9cGl3r5QIIiC5J0hJ5WbhQrJws31BuKjmt7nDmZi0lOcb3McQaNMf2EZ7Ufwaminvo
	 ndY4wdqlkpL6A==
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
Subject: [PATCH AUTOSEL 5.15 4/9] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:26 -0400
Message-ID: <20240423110233.1659071-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 16a0fae1e32eb..2df948e16eb71 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -104,7 +104,7 @@ static inline int to_reg(int gpio, enum ctrl_register type)
 	unsigned int reg = type == CTRL_IN ? GPIO_IN_CTRL_BASE : GPIO_OUT_CTRL_BASE;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	return reg + gpio;
 }
-- 
2.43.0


