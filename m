Return-Path: <linux-kernel+bounces-41676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B314683F640
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666811F21D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6E28DC0;
	Sun, 28 Jan 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOv/TVYA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183725776;
	Sun, 28 Jan 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457965; cv=none; b=EKqCsP6iItmanFBSftCGIT2XC2drT3WrHW0xGGJewoBjrSqTMPpYOzs7NqsWXfdEmUL0nVZcNce/LrvXnR5p7XDU6FbT3PsgyK8Zawslb9BU9A1o4x/ACKuSlabRLr7mHkwyE1zr0m5IuPzGGHVzfF/0kF48K5aRJ6Sm3xjhuug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457965; c=relaxed/simple;
	bh=3GDzuUKiMwdZAP8iDkQepKQ+kMUfYyqlwDoA8vWWVqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scedoscDIuae0NgE/hWWYgRcGvZ3w8IQLfbhoU4ZwgEqdGTv09Y6nn51NAexT/I7m1iuYFuQDo4Y5KKaiCz+1FmrLMRkPziDtBi6fXEeo0Z/5fCJlbkOqE7jiegUQ7PL7ndtppQshUdwZiSpgM2uKNL0hldDfRyNTTD49zr8Ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOv/TVYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D413CC433F1;
	Sun, 28 Jan 2024 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706457965;
	bh=3GDzuUKiMwdZAP8iDkQepKQ+kMUfYyqlwDoA8vWWVqo=;
	h=From:To:Cc:Subject:Date:From;
	b=LOv/TVYABm88A+zQBBmx1irbneC/mGqL4WC9pEyJImhvZG7SdFg0XKCYdxTWg7f/l
	 NK0C/RZf6ZDUzzBdJfGv8qrPtKuu/mNjzJxcUTdoqN2UxNsHNgYUxU2Pwa4pcxIWCv
	 5x+ALNMsWFx4RMkQtLDBxhKQoso6KviBhemWpbLDI5Z94GgSwTCB1TU+DJrJRStlnV
	 KWwtT2zN7v06qPxAAhoMSiUXg3UGfaFBEvbfo/9UGmBUVdQPHfEFvQbhDtf+YfGdaZ
	 mQ4LkAFDi+0+pJjk9pcDkNtzmOZY0Qvt62Qdwgi290qvfhCENYCcUSwNhLS5I+kcWd
	 IuPs8vaPp5Eqw==
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
Subject: [RFC PATCH 0/5] of: automate of_node_put() - new approach to loops.
Date: Sun, 28 Jan 2024 16:05:37 +0000
Message-ID: <20240128160542.178315-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

+CC includes peopleinterested in property.h equivalents to minimize
duplication of discussion.  Outcome of this discussion will affect:
https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
[PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.

In discussion of previous approach with Rob Herring we talked about various
ways to avoid a disconnect between the declaration of the __free(device_node)
and the first non NULL assignment. Making this connection clear is useful for 2
reasons:
1) Avoids out of order cleanup with respect to other cleanup.h usage.
2) Avoids disconnect between how cleanup is to be done and how the reference
   was acquired in the first place.

https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/

The options we discussed are:

1) Ignore this issue and merge original set.

2) Always put the declaration just before the for loop and don't set it NULL.

{
	int ret;

	ret = ... and other fun code.

	struct device_node *child __free(device_node);
	for_each_child_of_node(np, child) {
	}
}

This works but careful review is needed to ensure that this unusual pattern is
followed.  We don't set it to NULL as the loop will do that anyway if there are
no child nodes, or the loop finishes without an early break or return.

3) Introduced the pointer to auto put device_node only within the
   for loop scope.

+#define for_each_child_of_node_scoped(parent, child) \
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child(parent, NULL);				\
+	     child != NULL;						\
+	     child = of_get_next_available_child(parent, child))
+

This series is presenting option 3.  I only implemented this loop out of
all the similar ones and it is only compile tested.

Disadvantage Rob raised is that it isn't obvious this macro will instantiate
a struct device_node *child.  I can't see a way around that other than option 2
above, but all suggestions welcome.  Note that if a conversion leaves an
'external' struct device_node *child variable, in many cases the compiler
will catch that as an unused variable. We don't currently run shaddow
variable detection in normal kernel builds, but that could also be used
to catch such bugs.

All comments welcome.

Jonathan Cameron (5):
  of: Add cleanup.h based auto release via __free(device_node) markings.
  of: Introduce for_each_child_of_node_scoped() to automate
    of_node_put() handling
  of: unittest: Use __free(device_node)
  iio: adc: fsl-imx25-gcq: Use for_each_child_node_scoped()
  iio: adc: rcar-gyroadc: use for_each_child_node_scoped()

 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
 drivers/iio/adc/rcar-gyroadc.c  | 21 ++++++---------------
 drivers/of/unittest.c           | 11 +++--------
 include/linux/of.h              |  8 ++++++++
 4 files changed, 20 insertions(+), 33 deletions(-)

-- 
2.43.0


