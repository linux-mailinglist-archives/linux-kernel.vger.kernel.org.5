Return-Path: <linux-kernel+bounces-155076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8668AE506
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99972842FC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE931494DF;
	Tue, 23 Apr 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N42EJowG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2C1494D4;
	Tue, 23 Apr 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872512; cv=none; b=JnEmlDeSlg2p4MA4mNVL1oS/dloaWy/XU/b8NLNY8niSNBR6X2BrS8upTN7LRYsk35o+ABHTy0Yu4d2uIjVbcC5i5/nsy4e2Jpnh4Lr6mfLTddER8LwhpJ0sI2HSVB2TemP5YJJZ5Vu/4Fd01q5DqDU9mrYI8ONTjG3Cx5y1Ni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872512; c=relaxed/simple;
	bh=pxaDOkgzwwdlthLh7bpFgAGXZ8cA2W29GliWNfr6GqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAeN+MBmEM3r+alFJAsnkxBfTz5tEN9sRKwWvRuMJBo2Ttkzy42WLN+ibYcnO4GovGb0Ack3583QfXLOBoLkzp8crYJLK/iwWK+9P3mK7rSnHBjUBL4o1vdtjqXCWucBjpZzpKXgt44oRBjPMIw/c4GvIKNuUk8dmeCz6MVsVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N42EJowG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39FCAC3277B;
	Tue, 23 Apr 2024 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872512;
	bh=pxaDOkgzwwdlthLh7bpFgAGXZ8cA2W29GliWNfr6GqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N42EJowGoxXcRC/VtEN36N1fOSqHUfhqj/+klwO0UvcO5Kco21UxCeO22j2supUZG
	 +PDtLiHPpak3i3RYYITED7byICPYWgbvNfYIxJTG4SI+rUSVYbZPGSCJEa1640RjWn
	 qzAiimOESa8Zncyt7RzXByMBLRDprgBGehyHd1XGhsTsrNsLRFR5X6Pk2Ntm4h7wDk
	 AA5H5rE9HmoDIihSaFU1G4qYGCHtXhAaHJwFWqwZyAJz8WczX6WrTqf3dNgCpnfjHt
	 PuAZD7lcrIUWjKn6NGT+KUNJNVvd5WOfgKhGqUydlGG0Q0PN8dcTXlKMyqnyBcZMkZ
	 0PaORY5A3poWQ==
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
Subject: [PATCH AUTOSEL 5.4 4/8] gpio: wcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:59 -0400
Message-ID: <20240423110304.1659456-4-sashal@kernel.org>
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
index 444fe9e7f04ac..79946c098271a 100644
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


