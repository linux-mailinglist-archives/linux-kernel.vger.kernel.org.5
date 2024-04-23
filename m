Return-Path: <linux-kernel+bounces-155059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC18AE4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614CCB243FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89BD14430D;
	Tue, 23 Apr 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuJRYYgn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114F91442EF;
	Tue, 23 Apr 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872482; cv=none; b=AZChfgZuW1zcguNAkbLj2ZLU6/3TKZ7oi8nOnnSwNGMyPu4ZFeAhWhr7M1xPI0japtWzmVFGs6/+A0+sLOkxhb+rbBFGFn+65cwEUUuetqy4DM9zewZS1yxYdQuAAm9WxyGFSSxftG4VyI6HRTa+CFbX517cORTd/LiOhPqje6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872482; c=relaxed/simple;
	bh=EMJjMR7YiVQtzMKntyGQES6j6kpxquejFZ3c0bc1eIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEK+rWHkY3EddmMLcYD2Sbz8uTB4uQCiOirnznyLs+OoEJU11mO32M4N1jIE7O9fPWbk3qWoQmXpCtir4KtwMkNelFajHhFhbRnpUl6va/F38t+2ey7yKn9uRbd7HnDqkig0yDdbt7WNC0ylmJoTk9ZCYM6CMQC5d+g1k9WdcZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuJRYYgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3CEC32783;
	Tue, 23 Apr 2024 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872481;
	bh=EMJjMR7YiVQtzMKntyGQES6j6kpxquejFZ3c0bc1eIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuJRYYgnJqxNQzNU37uK73ahsfmEWWREbQJkaaA2B3UrjgwbwtzM1vmMFFUDgoehw
	 oISCZ8i3SS1rGtszem/Nr/dl9RV86c7BUQv2txxONSkKN80HNLEAmWiOWGpKB9FvH+
	 cBVO8wCS5OxnaRy6B8hybw1wKs3bFwk2gBTiR0FIu/IbdtzynklFmn5qUMYKp/T4PP
	 ZJYV2KnZJ7EGg9p90tKk4MuH6bRvOU0+8Cted5F4UIxNjlOMH7ADTejD3fNt7zqdUd
	 gDcZivY+5KnC/ZKU8ipUJlBfFZhILp5Pi0inShzjY/ZPHSUAouU+vHl8vbEcRnfPLD
	 0kIfbYtPhcE3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/9] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:27 -0400
Message-ID: <20240423110233.1659071-5-sashal@kernel.org>
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

[ Upstream commit ace0ebe5c98d66889f19e0f30e2518d0c58d0e04 ]

The GPIO library expects the drivers to return -ENOTSUPP in some
cases and not using analogue POSIX code. Make the driver to follow
this.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-crystalcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-crystalcove.c b/drivers/gpio/gpio-crystalcove.c
index 5a909f3c79e87..c48a82c240873 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -91,7 +91,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
-- 
2.43.0


