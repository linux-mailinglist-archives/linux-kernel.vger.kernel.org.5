Return-Path: <linux-kernel+bounces-80098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B4862AB8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3006D281ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7514A82;
	Sun, 25 Feb 2024 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIbuUKf4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576214280;
	Sun, 25 Feb 2024 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871258; cv=none; b=lozC34kN4ME3mu4ouBayGd626KnOKvMHV4Fa0TO6pt9J9KSiQpMF6LUK/6CZa+6usaDdbrE58kHngL04QJ5Lfc4YpSfW+YAVSQTE8Z54VXhMkbb5VuBoi46WRX99s3cJp1Mvyipi86e0FF7jOEqwcULPV19wdBcqjTG1RfgAu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871258; c=relaxed/simple;
	bh=HAT98xnSwLDAnpvodaMTdqxT64M67j1g0X6shQNezLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF7olYEI7dZiRzbO+QRdpI38BN+HZAemE+yOgfgHpxXcLaC2P05xst2MD8ed4VTYC5sNuJSBoxF3bCv6A9V3ZpUxVsSk4AQdrjQYFUfSpDlLS6eNRkvmyuOZmIDsrG66wc61hubUO2vng1l0FcZZyuO9wmB3ewV7/7oiGjXQsuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIbuUKf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53840C43390;
	Sun, 25 Feb 2024 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871257;
	bh=HAT98xnSwLDAnpvodaMTdqxT64M67j1g0X6shQNezLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIbuUKf4y/pyYsjG9hm5YQtRuJ+jRGEDKz0LyJSGSgCYl7GMGtEKsNgSvlyhPE7VT
	 gjg1AGMvcM9tkJTDSjtJAaRWLUDHJe7+eRIYtGe1/Ba3DzDztt0FUjxFuEnGDzHBRo
	 ckofUhmRYZQY9angGKOPvspLMtrocVDHCl4KRa9sojUOn/oYbzZYRp4JoIvPzmhTR8
	 E2Z5Rwfu+oQi26eKAo2/Iw1g/jI/MBDZfnWpFBJ3nt1LExcck6xa3oTZGSBPuAgfgb
	 UQsCsHrT1UysEFxyvUxOIZUtZo5t/vcli98lJY22HTRLk8CPVt2cv3++RInceSR4S2
	 jFYjQ75vN5zsQ==
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
Subject: [RESEND PATCH v2 1/4] of: Add cleanup.h based auto release via __free(device_node) markings.
Date: Sun, 25 Feb 2024 14:27:11 +0000
Message-ID: <20240225142714.286440-2-jic23@kernel.org>
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

The recent addition of scope based cleanup support to the kernel
provides a convenient tool to reduce the chances of leaking reference
counts where of_node_put() should have been called in an error path.

This enables
	struct device_node *child __free(device_node) = NULL;

	for_each_child_of_node(np, child) {
		if (test)
			return test;
	}

with no need for a manual call of of_node_put().
A following patch will reduce the scope of the child variable to the
for loop, to avoid an issues with ordering of autocleanup, and make it
obvious when this assigned a non NULL value.

In this simple example the gains are small but there are some very
complex error handling cases buried in these loops that will be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

Note that there are coccinelle checks in
scripts/coccinelle/iterators/for_each_child.cocci to detect a failure
to call of_node_put(). This new approach does not cause false positives.
Longer term we may want to add scripting to check this new approach is
done correctly with no double of_node_put() calls being introduced due
to the auto cleanup. It may also be useful to script finding places
this new approach is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/of.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..50e882ee91da 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -13,6 +13,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
@@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
+DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.44.0


