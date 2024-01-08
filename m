Return-Path: <linux-kernel+bounces-19481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49338826D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2EF1C2239E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18FF405E0;
	Mon,  8 Jan 2024 12:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="W6fod49M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A33405CC;
	Mon,  8 Jan 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1704715263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kw2xnPE5HtY1SEvsv8OuzuBAyMF2igZ6CutMKzqtu08=;
	b=W6fod49MZzGKeKASfexzXo/74JFcIFld1pbmYxXq7OXhAtPX5G7Ifl0VWUswisMuN4S04y
	5NLkk/CClNpn75kJB2PiGGoRGMhR8rj1e35NH8jmlUixSdz4bWBc396mUHcI9K7lAaVlvM
	g+LHGTNPldL6HMuN9Gh4QWWyJURIlkw=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 0/4] usb: gadget: functionfs: DMABUF import interface
Date: Mon,  8 Jan 2024 13:00:52 +0100
Message-ID: <20240108120056.22165-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Hi,

This small patchset adds three new IOCTLs that can be used to attach,
detach, or transfer from/to a DMABUF object.

This interface is being used at Analog Devices, to transfer data from
high-speed transceivers to USB in a zero-copy fashion, using also the
DMABUF import interface to the IIO subsystem which is being upstreamed
in parallel [1] (and has high chances to be accepted for 5.9, I think
Jonathan can confirm). The two are used by the Libiio software [2].

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

This is obviously for 5.9, and based on next-20240108.

Changelog:

- [3/4]:
  - Inline to_ffs_dma_fence() which was called only once.
  - Simplify ffs_dma_resv_lock()
  - Add comment explaining why we unref twice in ffs_dmabuf_detach()
  - Document uapi struct usb_ffs_dmabuf_transfer_req and IOCTLs
- [4/4]: New patch, as I figured out having documentation wouldn't hurt.

Cheers,
-Paul

[1] https://lore.kernel.org/linux-iio/219abc43b4fdd4a13b307ed2efaa0e6869e68e3f.camel@gmail.com/T/
[2] https://github.com/analogdevicesinc/libiio/tree/pcercuei/dev-new-dmabuf-api

Paul Cercueil (4):
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Factorize wait-for-endpoint code
  usb: gadget: functionfs: Add DMABUF import interface
  Documentation: usb: Document FunctionFS DMABUF API

 Documentation/usb/functionfs.rst    |  36 +++
 drivers/usb/gadget/function/f_fs.c  | 463 ++++++++++++++++++++++++++--
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  41 +++
 5 files changed, 528 insertions(+), 21 deletions(-)

-- 
2.43.0


