Return-Path: <linux-kernel+bounces-155068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B528AE4F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3601F21128
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31991147C6E;
	Tue, 23 Apr 2024 11:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNvladsz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE2F1474AB;
	Tue, 23 Apr 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872498; cv=none; b=LeWj1tJdWcSEMZhoo/gfgH+etCepQP59jzQ85MpEIsgXJPfnig/S+CCkl0vxfZvPYF3/NoBoohEFiZ5Begusznd+w+sJY3Jb7DgiLFjc/wqb09QxZPl4gVASScMf8xD2frxigIH+qyFptj7SgLXxWCspp251YBbLNfZ93o0HL/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872498; c=relaxed/simple;
	bh=ejO8q9WAZAeoqK726y5FzmsPqThEhS5RzUXSsBFKlhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpyuyvgUW7KlJv0XJ4ziyOObRiJ80hI/0jTGAkt4xxYrnaSAPu8K0cGZty1uHMqLgJzBMZvwDrZG0g+mWT7E32fbbwPQQn8T6Bg+jHdfbXKsn6YxMoLWPPRb8H4yIhW2FJ14CWokwI9PP7PFTg9b+XOpN8AGkHnvuaAoK2Xtuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNvladsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C432C2BD11;
	Tue, 23 Apr 2024 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872497;
	bh=ejO8q9WAZAeoqK726y5FzmsPqThEhS5RzUXSsBFKlhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNvladszP0Tfsit8pZbIOqr0Yk7L0cGnNLuGFGiM6igz7nWAcI/RwhwpfWNH0cOWA
	 2R7+D7WkiyqQYwBFcxAFnui+HyKetm5fb6KqHl+aMShWXzoGLVWQQo4Du+EIQnxIJJ
	 Qdg4Sn2USqIeTgplS7gZYg6PYCkV9a7Pr1znshqlYiWpPF01ZEqCrAaj8vL+ILgTNn
	 8/IiekdIiigP8FkTBLZcJhl392VsstAUSg69jLqbg2tSIRizQ4cl400u5xQTJq370c
	 8ot4pjBxl+JlL/KTQTWW3EWCrkbqwhA5E5MwQHFyEpbP6tGkcL2PExbjCpabqbFbLx
	 ft1lFxgFXpITA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/9] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:43 -0400
Message-ID: <20240423110249.1659263-5-sashal@kernel.org>
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
index 2ba2257200865..0f0b4edaa4865 100644
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


