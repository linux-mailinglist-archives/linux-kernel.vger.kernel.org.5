Return-Path: <linux-kernel+bounces-155077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894C38AE50A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0FF1C22BCD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56F149C6A;
	Tue, 23 Apr 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o39pQtoe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A1149C56;
	Tue, 23 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872514; cv=none; b=trI03JAOw3Fj0GCMmFQl9XEF+ZOZv+lXDm1NbpCge1dZoQr8ft6zX8Yf2/c8/4QhhTCI0XKRRuhlTixRjfxZB8f1N8uAACRHAs2/9KlT9vPdOisAN/xzGzWx5Z9rFtY4N6Um9gBkY4vt7jZjSF3AXpehQxes4cSty4C+32RWTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872514; c=relaxed/simple;
	bh=SiukaLuq2psfqut4fXWa4EyUxhGROvB4lZ1QAXnBiHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auQjGPssEglDUlwKbeUpf0xRunxvnoWMBtAaA62pDcXJrJH4g1q8MheC+dofG0wu6qI2U8O7tgPL612hmv30N+2flXRIcWJ1ibcjDXQOcAULYHMiawn7m6R2dli7IFA5rwNquJA5Urix8mJxoKVlBtVnpGH1YptaHwgkePqKaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o39pQtoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A206AC32782;
	Tue, 23 Apr 2024 11:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872513;
	bh=SiukaLuq2psfqut4fXWa4EyUxhGROvB4lZ1QAXnBiHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o39pQtoeY93g2bFqJ7ybrr3xKwKQQyEPv+KBdu+dyxL49zvn5fgWS0RsL0JJ/FIZ8
	 CWiIjrOMq467RfSDzabbgtHNhFCoFWU+bzxUL2TVeDPEthGXO51vh6OXXViVf1bFAv
	 Ca08egEBpywfa3a+//4PHTvcUzpy3CJuwdnb8+hTgnaZkjN/OzlvClR1HZadDcEIes
	 LccgJxEVlZYftfHo1krZEMLwFBQrK6gmUJ0/xnTdYVLsbE5H1FKHWL3zKLX0FUlrVF
	 uxrUcuFgtwZE8WCIKIq2hHiUp6JbhMby/ivistR+AoVEnZiDBGoN8lZ2vVJ6fy2M8M
	 vIscJ12l0/LyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/8] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:03:00 -0400
Message-ID: <20240423110304.1659456-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110304.1659456-1-sashal@kernel.org>
References: <20240423110304.1659456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.274
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
index 14d1f4c933b69..8b9c1833bf7d4 100644
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


