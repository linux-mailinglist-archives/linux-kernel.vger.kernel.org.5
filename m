Return-Path: <linux-kernel+bounces-31247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1A832B17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AB01F2590B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4453E13;
	Fri, 19 Jan 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AZOYG5ed"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC01E48F;
	Fri, 19 Jan 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673655; cv=none; b=WYAuDDYJrEQYYnJeWKXLDpx2sZcwkE7Ee/IxsKv+3ILyRuAeKtJC4SECpCVhVWuHuzhDK00ESgHKu+NoLiZH6K98rvL6t4hWZzYOnHL0zFYZN4kwUZgrZrWMqnVyHkt2afGX/jWHgTungSgeQIEGEOFh3YGWYHkuUsHCP13LhHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673655; c=relaxed/simple;
	bh=YxMO7K0SAFW1fxIxiyYDZizLbqPwVgtTZ5V/DA1a3aA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n70C0PheOY4aZm+w+F+XeUlHH4WSs+IHr1EYWLJl72c2xaPx/9uuAl0mYPtjmcaKQMVxSx9kNoq1Ev79SAD1GRchZsWUJFUIPj+2W2LDrp68iKCYoQ09nTWrcc6CfjdRrGfqUShxzNiteuAqBHxKGifMCNPx8r5TzmUS2uDTktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=AZOYG5ed; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1705673650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FX6y2yjuW0nuJFiEqsV4ftraJscIV4V40Vy+XAQTjhI=;
	b=AZOYG5edVZIWA1BlCrUR1yaolBTzcIodYuTj1R0BojE/dH4mDiXy2R/lk6N0eIGpYjQRnM
	moRjihZ1MzvjxwroPPnCYYSyUbr+Q/3G8gPUFgTrqIdY8BEH1tinjcH5f3aUwn3o497Y5W
	cxzgdFEi3srEEHMggkSKv9wlfR3+Gjo=
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
Subject: [PATCH v5 0/6] usb: gadget: functionfs: DMABUF import interface
Date: Fri, 19 Jan 2024 15:13:56 +0100
Message-ID: <20240119141402.44262-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v5 of my patchset that adds a new DMABUF import interface to
FunctionFS.

Daniel / Sima suggested that I should cache the dma_buf_attachment while
the DMABUF is attached to the interface, instead of mapping/unmapping
the DMABUF for every transfer (also because unmapping is not possible in
the dma_fence's critical section). This meant having to add new
dma_buf_begin_access() / dma_buf_end_access() functions that the driver
can call to ensure cache coherency. These two functions are provided by
the new patch [1/6], and an implementation for udmabuf was added in
[2/6] - see the changelog below.

This patchset was successfully tested with CONFIG_LOCKDEP, no errors
were reported in dmesg while using the interface.

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

This is obviously for 5.9, and based on next-20240119.

Changelog:

- [1/6]: New patch
- [2/6]: New patch
- [5/6]:
  - Cache the dma_buf_attachment while the DMABUF is attached.
  - Use dma_buf_begin/end_access() to ensure that the DMABUF data will be
    coherent to the hardware.
  - Remove comment about cache-management and dma_buf_unmap_attachment(),
    since we now use dma_buf_begin/end_access().
  - Select DMA_SHARED_BUFFER in Kconfig entry
  - Add Christian's ACK

Cheers,
-Paul

[1] https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e68e3f.camel@gmail.com/T/
[2] https://github.com/analogdevicesinc/libiio/tree/pcercuei/dev-new-dmabuf-api

Paul Cercueil (6):
  dma-buf: Add dma_buf_{begin,end}_access()
  dma-buf: udmabuf: Implement .{begin,end}_access
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Factorize wait-for-endpoint code
  usb: gadget: functionfs: Add DMABUF import interface
  Documentation: usb: Document FunctionFS DMABUF API

 Documentation/usb/functionfs.rst    |  36 ++
 drivers/dma-buf/dma-buf.c           |  66 ++++
 drivers/dma-buf/udmabuf.c           |  27 ++
 drivers/usb/gadget/Kconfig          |   1 +
 drivers/usb/gadget/function/f_fs.c  | 502 ++++++++++++++++++++++++++--
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/dma-buf.h             |  37 ++
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  41 +++
 9 files changed, 698 insertions(+), 21 deletions(-)

-- 
2.43.0


