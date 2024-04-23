Return-Path: <linux-kernel+bounces-155015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4928AE462
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB621C22B91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2912E1D4;
	Tue, 23 Apr 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnxRIOwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240312C524;
	Tue, 23 Apr 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872412; cv=none; b=HVByx2SyCfC3KEkZ5x80XNf2IFsJB+icJLN7WB/8+/C+cYHQlGZJ5epJPZvfHDFu0mxulagFpAHYIomKD7aj0Xr1bHy3ZtEgD8nMX85dH6Dv68bfzHs9JNmB2RBXN3j3jnsjWHkLj0hrDzI4ukM98ylFX23sopd1xxeXilaa/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872412; c=relaxed/simple;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lyc6/xdNiJwFWldKzYfUpqa1ufiXU6mul7KTtN/AwYlnh7TwRkB0j39eenYgbOhE+6hMuka68SZHiYU8u7m7P54an4g/VRwAxWEIsQfPVGlR+E9sxyCwS2tkqcw8Yt+ZT3Tk8mGBp6X0UpwrT/qTRA60z0X3Pfl493wej15p1Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnxRIOwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E006C32786;
	Tue, 23 Apr 2024 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872412;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnxRIOwOjNH2mzzcyphvdqkPzw5LZEFroKqCqfimQTOD6Lf1polwcNoeoxU2yPd82
	 GcryVjlD6tZNAZHha3zJhCnb9O/GrxjL9V5cJHjEH9x2m7KeNfE0KpfsZDGn0t70An
	 VmMfR1WOndWTXX7oqLYHkKuL4ccKlqA3g3GFnvMS9hwChR5eGa3THsjIri4GfCEF1C
	 T0H5uVFIGRXnG4WtIOhxKjK6jEq3H2aADMHX/vr5NRd+uwsf1jP0JQ7EEBFO+z3jfj
	 9sDuzYgRlkR9lHqPjAIKyM9mA5U0hILq70EvnPp4YDrFXzj7VS+JGF7OWaboe3PgLb
	 drd/KMSyYQ35w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/18] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:01:03 -0400
Message-ID: <20240423110118.1652940-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 1ee62cd58582b..25db014494a4d 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -92,7 +92,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
-- 
2.43.0


