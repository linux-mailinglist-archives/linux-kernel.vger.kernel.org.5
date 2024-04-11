Return-Path: <linux-kernel+bounces-140741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914508A18AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB3FB2302C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5EB179AF;
	Thu, 11 Apr 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b="z3Fw6elo"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5D14F68;
	Thu, 11 Apr 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848969; cv=none; b=qptJIrzoKXmgXNFtdM7gKEP3cJbdOa57vi+cQHXeIoGklg/a8OBco4nsRFBTjcixlVKa7R7vZpkoJnHFHhROMbywuDYJl57XgXRQLD/3ucdH0WpVLi/DdJlYWr6HgMZCSmDzKXo4i0ednNv4ui7ItjNbhpTigpjkWxANmBnhkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848969; c=relaxed/simple;
	bh=V1tankF8vnXxhI5jHIfzU9REJx8/FWrFvAkiwcw9YEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obQLy22xsFAd88Gs/Oz/EBDrPyDbtUEJVOLpCTDSWVb2gtYqeFNzOycwpnsRcOv4cMgz6sAqJZLF6DAbQ8H1a9SPCXvD0c9W6QuUSGae2CpSDO/kfSS9ANEBv22rh3mFJJn3/NgmXkgfwGYhteJbSomunyWp6d66iKuVWfOgZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io; spf=pass smtp.mailfrom=sylv.io; dkim=pass (2048-bit key) header.d=sylv.io header.i=@sylv.io header.b=z3Fw6elo; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sylv.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sylv.io
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VFk371Z6vz9sWt;
	Thu, 11 Apr 2024 17:22:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
	t=1712848963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L+0SgvYfp2HlqnXUngMq1zhm8WKfYeRAmlhecspRZUk=;
	b=z3Fw6eloAdfaGNjnXghLf6bmhpVAv4w0ZEZNzGvnxkzb0/WKInEtRSvysi/qzetWBDOoqN
	tW1nZRFJx2P6USJwiczmFPx8Vf79m/A5kP329Fb6hrh2Qj/O6FXZptpXtGLvt11i6PKtBm
	i9Lmtctnrz+EdewP7hyQa+nWT0jr5il9lAcNR7dsbWoPvJMEQf/C8EwWaH4bm/7ow0VC/O
	cIS63BYNrr039hTsVXRUq9KZXHvbsadEYJ1dd+3y7AJGVeS2tKz74wsrdMGMhiptN5zGiN
	ep+7HZfRAw9SQjQtT+1wwBv6AZkem8ze2iJ7RcifhayRsdaP7tUs+goqRNhfCQ==
From: Marcello Sylvester Bauer <sylv@sylv.io>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
	Matthias Stoeckl <matthias.stoeckl@secunet.com>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 0/2] usb: gadget: dummy_hcd: Switch to hrtimers for better performance
Date: Thu, 11 Apr 2024 17:22:09 +0200
Message-ID: <cover.1712843963.git.sylv@sylv.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4VFk371Z6vz9sWt

About 10 years ago, there was a discussion about the poor performance
of dummy_hcd due to the use of jiffies instead of hrtimers [1].
There was a proposal to switch to hrtimers, but the patch never made it
into the mainline, and I cannot figure out why.

This patch set brings the idea back to the mailing list with the
intention of improving the overall performance of this driver.

[1](https://linux-usb.vger.kernel.narkive.com/Fdt5oBR8/dummy-hcd-performance-correctness)

Marcello Sylvester Bauer (2):
  usb: gadget: dummy_hcd: Switch to hrtimer transfer scheduler
  usb: gadget: dummy_hcd: Set transfer interval to 1 microframe

 drivers/usb/gadget/udc/dummy_hcd.c | 37 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 15 deletions(-)

-- 
2.44.0


