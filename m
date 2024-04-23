Return-Path: <linux-kernel+bounces-155085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14DA8AE51F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5EFB22335
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629B14AD3E;
	Tue, 23 Apr 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9v0FWni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED314AD22;
	Tue, 23 Apr 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872527; cv=none; b=R2nowGIq1OYwRSBpl19DuvLX9Ue90TTpiJGWK3Ir6xF3qumJB0JU0HIDg+DjNsKbUjVeUlWT1m2ymzRslW+8VzMzOsim0k4TSZk1s+qo5KoGhhSo0fOhT/OKCCx+4BgRllT2/9EywlAzt0X9rNStMLcGhWsMSBFaxcjFbDdwKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872527; c=relaxed/simple;
	bh=VPgfesJpUVtk9HJb+OT4n5OG4cnGiA6ah0GxO0RQjFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlGF971/O91y8hqt2rXvUORQzlYESkMK/jcAporsZfyi7qGGE4UdxeCRE3Qz+xvgKkG6DXA+qReXmTNzTMc8N0eruf+7YQa6DSW8xjXgiatRi8awt5zWFpFRw+uwrX/0nPjVdlfS6iH/iUhoB0QVfqA3KHvWzDfvJ0ivry5zrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9v0FWni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A811C32782;
	Tue, 23 Apr 2024 11:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872527;
	bh=VPgfesJpUVtk9HJb+OT4n5OG4cnGiA6ah0GxO0RQjFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u9v0FWniNHXU2ffTC5qm0p1fIF8c9Winl3//HtlQx8jGvuTHQIgv+QsnKL5+tswNw
	 kda5FFH0JgBgPGWB1G8pSvHjQl7yVjA/xTwnN6vvSNykzo5hyhd81bGWFc/6BsvQ1w
	 1CnZ9kCFbGbuQLMtuBlMQIJnPcOLHgUyWFsebeM8i+wAhnnwfNW3SDCPBE1E6y8On8
	 GG8gUj7uAhorKG1c68c2CZlcUxb/ffcEZ9BTYf6oeWnyq47ZnK+eIMOljQIOaeEYhS
	 Hr5mHDiU6PKYn0nWg9iiP9qEGJ62Dg2OYQNi88k1tHf+orXeWHgW06njnp2p4WdZKK
	 2o7aKqtizT7FQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/7] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:03:15 -0400
Message-ID: <20240423110318.1659628-5-sashal@kernel.org>
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
index 58531d8b8c6e4..02da5113c0f2e 100644
--- a/drivers/gpio/gpio-crystalcove.c
+++ b/drivers/gpio/gpio-crystalcove.c
@@ -99,7 +99,7 @@ static inline int to_reg(int gpio, enum ctrl_register reg_type)
 		case 0x5e:
 			return GPIOPANELCTL;
 		default:
-			return -EOPNOTSUPP;
+			return -ENOTSUPP;
 		}
 	}
 
-- 
2.43.0


