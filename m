Return-Path: <linux-kernel+bounces-155084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDAF8AE51C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80251F23E52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A912FF94;
	Tue, 23 Apr 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsqNsIRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BE014A62F;
	Tue, 23 Apr 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872526; cv=none; b=mtf6di81V35XVD7b6MD/nb7JfxkU1DuSiB8fndlnY23ikObbmP0RrPWVobvC8O27Of7uPy1xsylrMycgcc0/++zVj2axH18/7z4QZBOjCZAE83rI0tg4n+9Xa5gC64X7kxZgLDdMa6SSRUxLi/FJaan8cybEocWPfFALrIAMNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872526; c=relaxed/simple;
	bh=mWrSk3XozYzDcT0mn492u1kdzxXJSpSV1I21tLLJDBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHxnh8iUCmBn//FElkX0WEpxScmOa9hTqPdqWxRjtwzhwOk3Wa4UpYY77gECWcH4zs6TeVZFJQBu5+1B/xlUv8+PNE6kg6rbp3soDfqzOZmG0ZIPQFPEv4q/kvXWZ5pjB8XrKxXNeA3RcYCwRMS/eTk0ivPwV4vT0VnKbolYHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsqNsIRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1066C2BD11;
	Tue, 23 Apr 2024 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872526;
	bh=mWrSk3XozYzDcT0mn492u1kdzxXJSpSV1I21tLLJDBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsqNsIRbo3rm59u9U44n8gf5QGNwh44lRura1P7pEI31GoiWCo+ujJiQtU0N9jpPW
	 4qXHJ6FX9qwkC/h0zbzklwYsZAcmsLunBu/AJwA9qZHpIaNHA+VlHEFvULMgwrG1QQ
	 DgkJUCeFodxX/1iqc6u0UVnHQ/82vih7Bb00eO8ZrolTR5bAbk5KU9dnwsYt0Z7UBZ
	 t/eaSQ6Y7Dq42sHSnxIrvGYLOgovgphxSbDF4gCd1zyCPpJQQblpoDQsYdz5S5UIaU
	 dVu03X+yAandRLAYA+ubCqY3u5YKVUFff8VWNvNgNoHjSre33YT7gCRIo2sJsWPqhl
	 tjBjxCceJxT+g==
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
Subject: [PATCH AUTOSEL 4.19 4/7] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:03:14 -0400
Message-ID: <20240423110318.1659628-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110318.1659628-1-sashal@kernel.org>
References: <20240423110318.1659628-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.312
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
index dde7c6aecbb5e..b8d79f70cb965 100644
--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -110,7 +110,7 @@ static inline unsigned int to_reg(int gpio, enum ctrl_register reg_type)
 	unsigned int reg;
 
 	if (gpio >= WCOVE_GPIO_NUM)
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	if (reg_type == CTRL_IN)
 		reg = GPIO_IN_CTRL_BASE + gpio;
-- 
2.43.0


