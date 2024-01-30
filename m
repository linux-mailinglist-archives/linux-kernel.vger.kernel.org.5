Return-Path: <linux-kernel+bounces-44595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94EE8424C6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666D928A498
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371E56A022;
	Tue, 30 Jan 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Lv6jdOaQ"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9FE67E78;
	Tue, 30 Jan 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617431; cv=none; b=h6regi1/XPvrPhPPJpCOvturimTqch0OgD64dZykkyufOvGrDtKKLcnzd50ddUkoLparghLcxPt9AGlrlKpW/MHld67h4+fk01QsvjWIhWJFALVIp6YaaVJuNfYMMWLuwWJ+wQPAeA5iB7tpD3dPgHm9nWfMkv4GfU6nm2X7Qdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617431; c=relaxed/simple;
	bh=ZDNJjmcuzyAag0Kxso0ulWjGOYHJ6K6MtOrAMvsl3KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8vSA6nCya1w4nZ83U/Hbm1pkgIhacHrWuytUvtt5K/9XGkTuuX0LudEzaR3wm1r7IUZdLRVx8ObQv2cXI56m3S3+NT6jibBQWIMX4jWnNePgsLp24dT3V6K5KHYetdAkniI17IbkQAKD/RWUV3aRbOSfU+C8o/Igi6Qsexx5P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=Lv6jdOaQ; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706617427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+n8ItVGKEntF1q4atKJJA2NJbdTS+Zf0wFw3L1mGo3s=;
	b=Lv6jdOaQdchyQWN4DHxAvoCnvj0/mzDrE8k+Dr5pJcsLTiEG+reSL3O6QPCwhLeaDszKCu
	cRzpOCW4TQFqmEXaAJ1pHsu1AjJNjx6+Ip6LyAVCeCT9jhrt/vkvzf4TFcfPZVANebtntU
	EjtFP7R0OwxikAVSeQNnRvnGl431PHg=
From: Paul Cercueil <paul@crapouillou.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-usb@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v6 0/4] usb: gadget: functionfs: DMABUF import interface
Date: Tue, 30 Jan 2024 13:23:36 +0100
Message-ID: <20240130122340.54813-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is the v6 of my patchset that adds a new DMABUF import interface to
FunctionFS.

Given that the cache coherency issue that has been discussed after my
v5 is a tangential problem and not directly related to this new
interface, I decided to drop the dma_buf_begin/end_access() functions
for now - but I'm open to the idea of re-introducing them in a
subsequent patchset.

The patchset was rebased on next-20240129.

Cheers,
-Paul

---
Changelog:
* Drop v5's patches [1/6] and [2/6].
* [3/4]: 
  - Drop use of dma_buf_begin/end_access(). We now make the assumption
    that the devices attached to the DMABUFs must be coherent between
    themselves. The cache coherency issue is a tangential problem, and
    those functions can be re-introduced in a subsequent patchset.
  - Unqueue pending requests on detach. Otherwise, when closing the data
    endpoint the DMABUF will never be signaled.
  - Use list_for_each_entry_safe() in ffs_dmabuf_detach(), because there
    is a list_del() in there.
  - use pr_vdebug() instead of pr_debug()
  - Rename ffs_dmabuf_unmap_work() -> ffs_dmabuf_cleanup()

---
Paul Cercueil (4):
  usb: gadget: Support already-mapped DMA SGs
  usb: gadget: functionfs: Factorize wait-for-endpoint code
  usb: gadget: functionfs: Add DMABUF import interface
  Documentation: usb: Document FunctionFS DMABUF API

 Documentation/usb/functionfs.rst    |  36 ++
 drivers/usb/gadget/Kconfig          |   1 +
 drivers/usb/gadget/function/f_fs.c  | 513 ++++++++++++++++++++++++++--
 drivers/usb/gadget/udc/core.c       |   7 +-
 include/linux/usb/gadget.h          |   2 +
 include/uapi/linux/usb/functionfs.h |  41 +++
 6 files changed, 579 insertions(+), 21 deletions(-)

-- 
2.43.0


