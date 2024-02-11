Return-Path: <linux-kernel+bounces-60885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD105850A98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5041F22831
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3F5CDFE;
	Sun, 11 Feb 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXS9pOT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8189B2837D;
	Sun, 11 Feb 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707673389; cv=none; b=VpJLCyI0fbLjZOxBWoHq3+WVNtpVGCnXubfWIVV/CXKZpMn1lcO2UXLCnzQ5uTWNn95m3mw1Rqka4LiUOSYjxBDK6O8ZdJf87MlWvjB4hLRBn1Y4RPnrIsXl189v44tuSrgDKIBdX5zAHCK9gFRLN5vuzX/45OOjYPo5tWviCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707673389; c=relaxed/simple;
	bh=ozx5VYs6gCeBet+H6hdug10X/WXACSIPRnOQiwAk13s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZENJaUAmkmchLYJz9h3ap3Lwk1tdqXY0U88DsIzFDA3ZuTjStWjIKJK6z94DErgCC+Edxylat8fiDQMw1SYj5njIjv9voOpR3gZ9QR61qnwo9Im9ffMT7bizLwcmBdYTuQCkvdCEofylx5KJ39XY5tbkUzpaM9c64Td5OkKqBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXS9pOT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6766DC433F1;
	Sun, 11 Feb 2024 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707673389;
	bh=ozx5VYs6gCeBet+H6hdug10X/WXACSIPRnOQiwAk13s=;
	h=From:To:Cc:Subject:Date:From;
	b=GXS9pOT4FIBWQFj5n7lrHKn4ZV9hmz3hr5SFQlQ4KJSjSeE8mceyYFV+mzW5YyFvs
	 0sDeVSlzjLNsj44dCl9xmDi/EwVQKFs/zOv70Km08wkGpPe64wwzYJc8brFkmD9kMS
	 +snlEX/AaCR1sFMKcipCHh044Uzy8m0fVawPFZOYiCcBMmxoQ8e/o0P121TXHWYIXT
	 LMxp5ncgNF3O1O2/7yDStM6qHDqkJN6afA8qqxSWoudf12jGsBynuz2tc04EgR71ko
	 jeCyT3ioHtzhBtt77wvOCvs9eljk2ikIueUbye+04K30z5+ddwk4cYZVMdFrAC5Yto
	 9OfKGjF1uYjjA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/8] of: automate of_node_put() - new approach to loops.
Date: Sun, 11 Feb 2024 17:42:28 +0000
Message-ID: <20240211174237.182947-1-jic23@kernel.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Since RFC:
- Provide a for_each_available_child_of_node_scoped() variant and
  use that whenever we aren't specifically trying to include disabled
  nodes.
- Fix the for_each_child_of_node_scoped() to not use a mix of
  _available_ and other calls.
- Include a few more examples.  The last one is there to show that
  not all uses of the __free(device_node) call are due to the loops.

Thanks to Julia Lawal who also posted coccinelle for both types (loop and
non loop cases)

https://lore.kernel.org/all/alpine.DEB.2.22.394.2401312234250.3245@hadrien/
https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/

The cover letter of the RFC includes information on the various approaches
considered.
https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/

Whilst these macros profduce nice reductions in complexity the loops
still have the unfortunate side effect of hiding the local declaration
of a struct device_node * which is then used inside the loop.

Julia suggested making that a little more visible via
 #define for_each_child_of_node_scoped(parent, struct device_node *, child)
but in discussion we both expressed that this doesn't really make things
all that clear either so I haven't adopted this suggestion.

If the responses to this series are positive I can put the first few
patches on an immutable branch, allowing rapid adoption in other trees
if people want to move quickly. If not we can wait for next cycle and
just take this infrastructure through the IIO tree ready for the 6.9
merge cycle.

I'll be optimistic that we are converging and send out an equivalent
series for fwnode_handle / property.h to replace the previous proposal:
https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/


Jonathan Cameron (8):
  of: Add cleanup.h based auto release via __free(device_node) markings.
  of: Introduce for_each_*_child_of_node_scoped() to automate
    of_node_put() handling
  of: unittest: Use for_each_child_of_node_scoped()
  iio: adc: fsl-imx25-gcq: Use for_each_available_child_node_scoped()
  iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
  iio: adc: ad7124: Use for_each_available_child_of_node_scoped()
  iio: adc: ad7292: Use for_each_available_child_of_node_scoped()
  iio: adc: adi-axi-adc: Use __free(device_node) and guard(mutex)

 drivers/iio/adc/ad7124.c        | 20 ++++++--------------
 drivers/iio/adc/ad7292.c        |  7 ++-----
 drivers/iio/adc/adi-axi-adc.c   | 16 ++++------------
 drivers/iio/adc/fsl-imx25-gcq.c | 13 +++----------
 drivers/iio/adc/rcar-gyroadc.c  | 21 ++++++---------------
 drivers/of/unittest.c           | 11 +++--------
 include/linux/of.h              | 15 +++++++++++++++
 7 files changed, 39 insertions(+), 64 deletions(-)

-- 
2.43.1


