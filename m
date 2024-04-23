Return-Path: <linux-kernel+bounces-155014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FF28AE45F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F571C22BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3346884A40;
	Tue, 23 Apr 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFnvgFeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8D684A2E;
	Tue, 23 Apr 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872411; cv=none; b=aICQbPZn821yI/6V0n/+Alwh7TbXZ4TEDc2lvpvxV9SGS/SYHUHfCtZvrpBwIVK5zPLVLpC4KCVCyEccJaGVA97R+mqwmFAdJB7i3dgCA6RJ0LiLbBfI8ePvunlQ21RBVV4iT1MVOj5chTiFvx57slwoL3nad3hIKkbm7wcGD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872411; c=relaxed/simple;
	bh=5RAUvk4sjc/qsa/C6BSAWC/Hw5N4z6bB5pl4q+E9wyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF5WrQjDaAjS06zXMNYCwzoGWSm1pIuWjaKQY27KwvDakuV7urHUFDaFCYst6U7n89yqV15WuqNU3zdVcq0bmwxvlvhjZiM3f5i3WCp9MCvvAR4R18kGEWisM6eme8IfegsJETwVLM5LaZVpcSLOHR53q2dcX8Yk/dOYvGm3Gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFnvgFeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5F9C32783;
	Tue, 23 Apr 2024 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872410;
	bh=5RAUvk4sjc/qsa/C6BSAWC/Hw5N4z6bB5pl4q+E9wyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFnvgFeqheeYei/QWgwr3IC3ll8S0KoSX7DGrIjM6HErmveDKkDYzwQDDdd+y7hQt
	 pJ0jGUCAqGJCfNbHRDx81Af2O8V6ex5n4K8lBR0j0LQPerfcNWo1WEgXXNruY8sIAF
	 SFELjNULkQUYvZz3rGmEsyzxA59qw7VGYEtLEB4pciCYMKnLsBmT+Fr9dK+YodyJ5J
	 bpP6f9QOqr2AHiteVQJD0ai74rdy8mj7QK9YzVPtJLneCwqUPToWzLfDBdaGKxkDN2
	 IEvbjpvo2+ALAVCfD5KOB5hk9jXBZw0CDfR9Mfhh6S/W/zw51AxNzOQ4GfNm5JZpkp
	 7YiYuK2bj+ZUQ==
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
Subject: [PATCH AUTOSEL 6.8 06/18] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:01:02 -0400
Message-ID: <20240423110118.1652940-6-sashal@kernel.org>
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
index c18b6b47384f1..94ca9d03c0949 100644
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


