Return-Path: <linux-kernel+bounces-155049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217358AE4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3D82871B1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC73140E2F;
	Tue, 23 Apr 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txC59A6M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E686252;
	Tue, 23 Apr 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872466; cv=none; b=RAjg8Ga3DxL37bMR6SqOekDez3iDEi7oQ+68LVc6KwawLhAFy983vAt8YCkVvzYCWqETVvi53KCCD4atxudTR1lPFioDByf7NNl561j4r13t+abzElF+CRLvu93POEeywP3Oa7gp31CCmuk5NErmbLhgddtcrKu8oM5zTPGQ0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872466; c=relaxed/simple;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny133GsjHFnKYptXIDATjNnB+mjuJBLHNzkOzzevHJkwLdZWA2oiBWgMJ9L2AxObUyhTIkyKwEOG5w1aYXH9ttQTFmLuy5tR9YNw16pcfrbBKai7XN9We1O+0ls+/eypGftLhUKUxwwRaLhkBBpIZjt2GZDaihe7rUHNKUSLgbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txC59A6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466ECC2BD11;
	Tue, 23 Apr 2024 11:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872466;
	bh=KLImw8kVMJi9UQFAGXGwxIOjx3Huc7OW8+lDilCzSI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txC59A6MEgs3/nVmo7cRI0ukDAS0t0L3Gv94h24LavDLVaij0+dGki+OT4/CR56KQ
	 Lx+N6y+Wdovl4yq7j5LoMFrkKEEBeZ0tUlKmjbzzh1wFN80m0cYxhRBpRvvKBF285k
	 UEBdrmTgIRg16yC+HPvhghH07XfzKgvdnXXcoPVrCe5JIv6PHcWCQmZ/SvDLDUtk4b
	 8nHb3emtHKuKrfEUAWAHX7lY+M/jGBAoSHcPaFgFNs8pD5bHXK5QNVm6/o/asOo9pg
	 UeEVfjWlTrcW58MJEtccAyO/CcMgDfsCdjyM3h59QsXSlSwIxmmknzsCT7CzAqn/h4
	 34maH7Bx3Y7Kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andy@kernel.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 5/9] gpio: crystalcove: Use -ENOTSUPP consistently
Date: Tue, 23 Apr 2024 07:02:11 -0400
Message-ID: <20240423110217.1658879-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110217.1658879-1-sashal@kernel.org>
References: <20240423110217.1658879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.87
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


