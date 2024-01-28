Return-Path: <linux-kernel+bounces-41678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94C83F647
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523E31C217CB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EA42E65B;
	Sun, 28 Jan 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfMWcqXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37B32E644;
	Sun, 28 Jan 2024 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457972; cv=none; b=mDe7Fm+MLDygoinMqoVydFBKYTa6dheuWwcmjK1vTmPM9UGgATITtsI1WXReLppsRNDloZALV+Eaep2NFBokCIeGWZZdkN19iTPOlRUGwCkLvHDqgxnJDzhSw18MxpUX4qdPKsYJq3NzFMUb+2AJ24qdjmsHcO1L2/pwzCQUkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457972; c=relaxed/simple;
	bh=1UnqaSq6US/sXw4AotStqr/RUKhvvYzhNHwicWeq4pM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M3N3Bz+2ouBQ++XLHf2K7A0Sx7SLmii5qKHjPOC19xRIGB4wHf47vTnzKkWU8ZrUrHQKKayRLGLYFsbCxd/fpxXINihazidr3/J10Ui+a6uFDyMBwO55O85Bl3N5C7ozb7SdcW3/aelpDDn1AKKUh/KLlXZ7m4L8+8yeeWf26i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qfMWcqXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA3CC43394;
	Sun, 28 Jan 2024 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706457972;
	bh=1UnqaSq6US/sXw4AotStqr/RUKhvvYzhNHwicWeq4pM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qfMWcqXQJuyNNX7HTwLclM8TLDtUP6uRfAE1TNMORFXG8gztAiXwty3tUBRAD6G2w
	 1UEZwjtVgOM+bZFNxdcukilsqEA6dzQ+Qq70YCR/Ze57qbGW10O/CkLpgbP65ElTaC
	 dDwM85Z+swUBxO5/RquDc23ErRWPiFKm3njXeRm8YNbQcN4Foi7Bg275xOCzOE+/me
	 MX3NURYzHj/GYCcWB5bRqzifBc80oe7k84cb5kX8pdLuXgaR+KdC8Yq9yX2WIY1QvA
	 lzaJUBfoTwrHZKwVCAOVVELKTozQl8zKw2kV4rKZWvgZ9NS9zM1Cnda79ZcqPjLOLZ
	 V3O5iVUHsBbBQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/5] of: Introduce for_each_child_of_node_scoped() to automate of_node_put() handling
Date: Sun, 28 Jan 2024 16:05:39 +0000
Message-ID: <20240128160542.178315-3-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128160542.178315-1-jic23@kernel.org>
References: <20240128160542.178315-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To avoid issues with out of order cleanup, or ambiguity about when the
auto freed data is first instantiated, do it within the for loop definition.

The disadvantage is that the struct device_node *child variable creation
is not immediately obvious where this is used.
However, in many cases, if there is another definition of
struct device_node *child; the compiler / static analysers will notify us
that it is unused, or uninitialized.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50e882ee91da..f822226eac6d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1434,6 +1434,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.43.0


