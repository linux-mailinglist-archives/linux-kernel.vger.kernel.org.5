Return-Path: <linux-kernel+bounces-113160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C6B8881F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A03E1C21B7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BD173349;
	Sun, 24 Mar 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQZxqLix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9783817332C;
	Sun, 24 Mar 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319962; cv=none; b=nEjo+j3bwZM5ES/AIiraZvlGY5KXI1E6dVQyu2UFjQC8/awiz5C3T6R57d7rnActUY+bbrrMVr1T8Mn+tWGZfLjU3YGHiWvG2ArpYMxWL8/xavgfZ/Bgpa/Ouifp7Q/GRPOEFeS0gABJs2GkOcnQqfeYoo8rY/ZEewf3jmnmKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319962; c=relaxed/simple;
	bh=05gqi39uXIlBRnhdZDnAky2RW2b2mzwYsIck1TaCRx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1NxqoTM2KLvcNEwh0MNlaayU9x1OzqXXo0sgGbgKQru//BLJWLDKh8ZzsJLUpSPDyl9Wi1ohnMnitSQmYUvpN++VKJw3eVfwf372x+n24Uc2QrDdYApoMIk5oUEuTIpAzOapLFeeYD77Ij0vkbgN0gQQZH92bM5wIzReIoMcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQZxqLix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED0DC43390;
	Sun, 24 Mar 2024 22:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319962;
	bh=05gqi39uXIlBRnhdZDnAky2RW2b2mzwYsIck1TaCRx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BQZxqLixT/BEUvI6lGdCGofCH9fwhEbJfYdKAIpb1ymrQ4LYohT0IaiLKPYElzdFP
	 +UxBKhpCxzQAtPwOIDeBp8jtiYNDEjXOOWvpcPfkgLy7gpydulZNxyqPa2rO6FhOAI
	 bdvaJ58Wruj/GgWkCZarCb1QwBxMlg9lSRAo35B7FOK5wXeivOdqFE4HWB6s7XCRLC
	 ZGfmlMELqnoXS9X92mQhK5zvQX9RMJuJJXypwXDzwia3zFj2JWi/wLLf3ZjCHIFEHS
	 wK5/rBM7xHPB+DQHsvImhi87z3lqyMTqZbzRfQVi2UNSbJ+Kg7hDRGpA6j8WyGg8lh
	 Tc8yrq+FCrLDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Boyd <swboyd@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 269/715] gpiolib: Pass consumer device through to core in devm_fwnode_gpiod_get_index()
Date: Sun, 24 Mar 2024 18:27:28 -0400
Message-ID: <20240324223455.1342824-270-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stephen Boyd <swboyd@chromium.org>

[ Upstream commit 0d776cfd5e5b559fdf2e38285c2aea4b7048acbd ]

This devm API takes a consumer device as an argument to setup the devm
action, but throws it away when calling further into gpiolib. This leads
to odd debug messages like this:

 (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup

Let's pass the consumer device down, by directly calling what
fwnode_gpiod_get_index() calls but pass the device used for devm. This
changes the message to look like this instead:

 gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup

Note that callers of fwnode_gpiod_get_index() will still see the NULL
device pointer debug message, but there's not much we can do about that
because the API doesn't take a struct device.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 8eb1f71e7acc ("gpiolib: consolidate GPIO lookups")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-devres.c |  2 +-
 drivers/gpio/gpiolib.c        | 14 +++++++-------
 drivers/gpio/gpiolib.h        |  8 ++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index fe9ce6b19f15c..4987e62dcb3d1 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -158,7 +158,7 @@ struct gpio_desc *devm_fwnode_gpiod_get_index(struct device *dev,
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	desc = fwnode_gpiod_get_index(fwnode, con_id, index, flags, label);
+	desc = gpiod_find_and_request(dev, fwnode, con_id, index, flags, label, false);
 	if (IS_ERR(desc)) {
 		devres_free(dr);
 		return desc;
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 75be4a3ca7f84..3ad09d2193330 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4138,13 +4138,13 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
-static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
-						struct fwnode_handle *fwnode,
-						const char *con_id,
-						unsigned int idx,
-						enum gpiod_flags flags,
-						const char *label,
-						bool platform_lookup_allowed)
+struct gpio_desc *gpiod_find_and_request(struct device *consumer,
+					 struct fwnode_handle *fwnode,
+					 const char *con_id,
+					 unsigned int idx,
+					 enum gpiod_flags flags,
+					 const char *label,
+					 bool platform_lookup_allowed)
 {
 	unsigned long lookupflags = GPIO_LOOKUP_FLAGS_DEFAULT;
 	struct gpio_desc *desc;
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a4a2520b5f31c..c6e5fb9aa2122 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -202,6 +202,14 @@ static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
 	return ret;
 }
 
+struct gpio_desc *gpiod_find_and_request(struct device *consumer,
+					 struct fwnode_handle *fwnode,
+					 const char *con_id,
+					 unsigned int idx,
+					 enum gpiod_flags flags,
+					 const char *label,
+					 bool platform_lookup_allowed);
+
 int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
 int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
-- 
2.43.0


