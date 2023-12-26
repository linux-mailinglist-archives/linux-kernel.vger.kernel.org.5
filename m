Return-Path: <linux-kernel+bounces-11209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5598681E33A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6A9B220C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CAB44C73;
	Tue, 26 Dec 2023 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR79X7Sc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B5F1C33;
	Tue, 26 Dec 2023 00:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F387C433C7;
	Tue, 26 Dec 2023 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550067;
	bh=0xOMQas6XvgFz5Pu+/mdxzBJqDkk6y+uLtpB4kKVZmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VR79X7ScQwRNDOnyOVOei1YWh2FfNw3n5hK/+6llG8ZymzcIxUTQtoHtch1bo7Y/n
	 kQP1rjRIctUDGBUm9dHwlJnFs5TRD68GWwMWEKD15nwBP9hkaFTE7QTELu7n1lneuX
	 3PlQtQC+iH/UZWf/aI4RTBJcG3gYMNcCttSe/F4BTyKvw8hTtpDCFicroFJi88N2Up
	 ktl1qOufAUhWEcUbeQN4JdkYcCPJDcMV1wCn6BaeReFlqslkzk7hJRmHiu3iat327g
	 X6ZyKkiHUAnenlu3QKwWZlrZwuicFRZN1v886yHRwtcoY16F+CEy/GizuV5PqihElE
	 G1CobvT8QZACw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andriy.shevchenko@linux.intel.com,
	petr.tesarik.ext@huawei.com,
	rafael@kernel.org,
	hdegoede@redhat.com,
	james@equiv.tech,
	broonie@kernel.org,
	james.clark@arm.com,
	masahiroy@kernel.org
Subject: [PATCH AUTOSEL 6.6 16/39] driver core: Add a guard() definition for the device_lock()
Date: Mon, 25 Dec 2023 19:19:06 -0500
Message-ID: <20231226002021.4776-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Dan Williams <dan.j.williams@intel.com>

[ Upstream commit 134c6eaa6087d78c0e289931ca15ae7a5007670d ]

At present there are ~200 usages of device_lock() in the kernel. Some of
those usages lead to "goto unlock;" patterns which have proven to be
error prone. Define a "device" guard() definition to allow for those to
be cleaned up and prevent new ones from appearing.

Link: http://lore.kernel.org/r/657897453dda8_269bd29492@dwillia2-mobl3.amr.corp.intel.com.notmuch
Link: http://lore.kernel.org/r/6577b0c2a02df_a04c5294bb@dwillia2-xfh.jf.intel.com.notmuch
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Link: https://lore.kernel.org/r/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 56d93a1ffb7b6..99496a0a5ddb3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1007,6 +1007,8 @@ static inline void device_unlock(struct device *dev)
 	mutex_unlock(&dev->mutex);
 }
 
+DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
+
 static inline void device_lock_assert(struct device *dev)
 {
 	lockdep_assert_held(&dev->mutex);
-- 
2.43.0


