Return-Path: <linux-kernel+bounces-28958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57783052A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BEF1F25412
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA93B1DFF7;
	Wed, 17 Jan 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AnuJeXJr"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5F1DFE2;
	Wed, 17 Jan 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494416; cv=none; b=cm5TaNsXXZ2NvkQmC5XSZRsjAwinYOEiE2bYCFNcm6oc97+myDqoqUoqonGcvAIjoL+H3TR24zN3afS6zOYAFd1kELpvpXsw90S8p4F/ZFDIc5mrOvIgPYlGoeVMh9oUyK3sGg7HEx/yDQTuUj4a1vNA9CgWfArz5cpO72BlIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494416; c=relaxed/simple;
	bh=jKj25He18n4jFRUrfK3U0YJkmURbZGCWIaQo843xvqA=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:X-Spam; b=nowmiBAFoQ+8hVm9fEWrMcwLCOgmzYDyimuBKwMLw4NL0QhwSp7iaq/Wp/NI9eKCeWSi6i3N9sdMJZdgvC2d79s4+SSIxCccVr2doaOlpyrp9nSR4d2rnir9BXVg/XqlOMPjH2f6h8pwxkiML42vaCsXT7swGdGRL5MkJO9nmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=AnuJeXJr; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705494412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/sDVLzlV6tVM1+jlnCP4YrSpFonZ8VEXETbEWgRMsuA=;
	b=AnuJeXJrsxDBX4u2PXAQELZ/ATdNATOI3nnJtTFJP8NZyE+fPe7/7Wl72Pf0pufRWaFvP1
	sNzzWBdCHYltlr90nl6m+MVGb9eTfWZS+78j7Mt7MuOAR0Qk1audmOo2VqSZdf8a89jbTb
	IWdLbuxuhZnhf1RqMzfVvZA6GZH3DTg=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 0/4] usb: gadget: functionfs: DMABUF import interface
Date: Wed, 17 Jan 2024 13:26:42 +0100
Message-ID: <20240117122646.41616-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Hi,

This is the v4 of my patchset that adds a new DMABUF import interface to
FunctionFS. It addresses the points that Daniel raised on the v3 - see
changelog below.

This interface is being used at Analog Devices, to transfer data from
high-speed transceivers to USB in a zero-copy fashion, using also the
DMABUF import interface to the IIO subsystem which is being upstreamed
in parallel [1]. The two are used by the Libiio software [2].

On a ZCU102 board with a FMComms3 daughter board, using the combination
of these two new interfaces yields a drastic improvement of the
throughput, from about 127 MiB/s using IIO's buffer read/write interface
+ read/write to the FunctionFS endpoints, to about 274 MiB/s when
passing around DMABUFs, for a lower CPU usage (0.85 load avg. before,
vs. 0.65 after).

Right now, *technically* there are no users of this interface, as
Analog Devices wants to wait until both interfaces are accepted upstream
to merge the DMABUF code in Libiio into the main branch, and Jonathan
wants to wait and see if this patchset is accepted to greenlight the
DMABUF interface in IIO as well. I think this isn't really a problem;
once everybody is happy with its part of the cake, we can merge them all
at once.

This is obviously for 5.9, and based on next-20240117.

Changelog:

- [3/4]:
  - Protect the dmabufs list with a mutex
  - Use incremental sequence number for the dma_fences
  - Unref attachments and DMABUFs in workers
  - Remove dead code in ffs_dma_resv_lock()
  - Fix non-block actually blocking
  - Use dma_fence_begin/end_signalling()
  - Add comment about cache-management and dma_buf_unmap_attachment()
  - Make sure dma_buf_map_attachment() is called with the dma-resv locked

Cheers,
-Paul

[1] https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e68e3f.camel@gmail.com/T/
[2] https://github.com/analogdevicesinc/libiio/tree/pcercuei/dev-new-dmabuf-api

Paul Cercueil (4):
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Factorize wait-for-endpoint code
  usb: gadget: functionfs: Add DMABUF import interface
  Documentation: usb: Document FunctionFS DMABUF API

 Documentation/usb/functionfs.rst    |  36 ++
 drivers/usb/gadget/function/f_fs.c  | 500 ++++++++++++++++++++++++++--
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  41 +++
 5 files changed, 565 insertions(+), 21 deletions(-)

-- 
2.43.0


