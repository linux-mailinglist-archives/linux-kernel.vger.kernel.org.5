Return-Path: <linux-kernel+bounces-80099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1F862ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE83B20EFF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1F15E89;
	Sun, 25 Feb 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICAhHYMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925014F62;
	Sun, 25 Feb 2024 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871263; cv=none; b=NLbmsoUOrIEZo/QR1aKKc76EmC0AQm6OYzgYukF9iohH/EoYejEp+KO+Ha9E6g5piCUb1n8GMA4rXDkl5724x2dHhe+0/v0+oJQ9yYDlEQxWVETYSTMwyVkslq24GZaBNVX+37qBvkzOOGxFBOinlLJDrZkHLgaiNfcyNfcDHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871263; c=relaxed/simple;
	bh=JrxvOnnekqmZH3ajB2UIPWqOc4Gn4lKhT3b0ty+A5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvYh1AIEtKpQ2M96CL9WsWhrkAc2Odn5l+luXWzwbTjWr4Q5dCxT0QI06qc4QLBR5UHluotnyw03v8578vrv0amNY8z8yTKfFL632Poztj7KR96dMeXQFQ/3fdQNyfLme9mA/SNH2tlKqKe/XDA+XI3HHL7Oy2YWs8BfU0JZycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICAhHYMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5430CC43394;
	Sun, 25 Feb 2024 14:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871262;
	bh=JrxvOnnekqmZH3ajB2UIPWqOc4Gn4lKhT3b0ty+A5S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICAhHYMDXJlaFwdl0M9SxF2WSfiL+8mnR/YOiI670MrkWnJY7o5CdDZ8EyAfWy8Yw
	 zJ7Qyvnvsiiw6YrMRN9e5rVbq9TFAmAWcOCH84LPhQtqHrC3IOgg5F5AAFcnTcNvQB
	 WvXiIC1wkr/40zKn8zihJf3wEhhwxje2gjXvAogBPkSCuhcTDSyEA/M5xkrcw4SrDO
	 sNAhlIrAaD5ItV5GP34OJQD1Hg3dP4d/NVw0HDi0DMM/RD/iY8DIMHmGjSyPhuobX4
	 iuyEu9+QMvwIxDKdjLtK42XAsISWGfn60HEI8Jn9N5Y+nZ/f1fwwurTEfALt1JwOSM
	 G7lvr6gZ51kyQ==
From: Jonathan Cameron <jic23@kernel.org>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v2 2/4] of: Introduce for_each_*_child_of_node_scoped() to automate of_node_put() handling
Date: Sun, 25 Feb 2024 14:27:12 +0000
Message-ID: <20240225142714.286440-3-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240225142714.286440-1-jic23@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
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

Note that, in the vast majority of cases, the _available_ form should be
used and as code is converted to these scoped handers, we should confirm
that any cases that do not check for available have a good reason not
to.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 50e882ee91da..024dda54b9c7 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1430,10 +1430,23 @@ static inline int of_property_read_s32(const struct device_node *np,
 #define for_each_child_of_node(parent, child) \
 	for (child = of_get_next_child(parent, NULL); child != NULL; \
 	     child = of_get_next_child(parent, child))
+
+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_child(parent, child))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
 
+#define for_each_available_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_available_child(parent, NULL);			\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+
 #define for_each_of_cpu_node(cpu) \
 	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
 	     cpu = of_get_next_cpu_node(cpu))
-- 
2.44.0


