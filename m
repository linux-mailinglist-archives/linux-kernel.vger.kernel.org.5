Return-Path: <linux-kernel+bounces-4487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DE817E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D72847D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6072E7CCF8;
	Mon, 18 Dec 2023 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UgAB/xN/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46236760AA;
	Mon, 18 Dec 2023 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1702942017; x=1703546817; i=wahrenst@gmx.net;
	bh=cYR9qTrSs0kBfcCSPgAjLce3B7Tv3qIVZ0tJ3320QaY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=UgAB/xN/MJRHVGeZP0R0zzwoJiSnMXjIgnTIA6KvdvRb+ZNphi2gUvmURwYGXGsN
	 VtMHi/TvG9iGLHhPwuA9hKYL0v9Wk9GXW8vsFvpgOmwaqQXqbfOk+w80E7xBbdD3g
	 rJOx4W5vCVoxLmodmQADBMECrUsi4pNiXq8HlbklgKPRya6iZnWmAvfI+iqwn9Ime
	 p5frpkmzkJTb+RpPpBl0EyzwO7r5fhCx9dzJfBZl+E5eQ5g3TboTfiZVU4l3zWzK6
	 XVB0FagGJJI01vxpOX4RJJm68+cNtPn7Vbe5HOvKIU3EV3II+W57oVJvziP0Zu76K
	 UF7CByc0o0bdjdkjhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KPg-1r6x2x0uzy-010KNV; Tue, 19
 Dec 2023 00:26:57 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 00/12 net-next] qca_spi: collection of improvements
Date: Tue, 19 Dec 2023 00:26:27 +0100
Message-Id: <20231218232639.33327-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0Kxk7zKJh7T/KZtc3b7G5Y7c97ZUP3k25r+TFLGe8g747nxjSz
 UUo+Mpv+nAX7gigr7DL5NI372tjiYJxuFoKds+I3HglaQcVIWYAdEOEf3RER45m+8yFfU8C
 Zri+60YgkQtgLMB2i3YXI4geNKHj5o68SlLKoyci/oJSNrATuYttZYKOsa0SYJrMlDv4kus
 kZHw1t5gdN+Twm2/e1Pug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mtLIgBZjJh0=;hlhCpjU6Cpt+H8adwAzuwZgpucZ
 HsUREEUg7vwQwwe0TbW6RB6mm1wfLYOxQI/C6jwJXGKZu6B69uGrhKn+tWEzTM6ZxDzRlotml
 xTxeookMq4I7ZX+FNw6qKYX6SdpgNqZdvIyyc5iFWhjvsl0+p8pTAg5V6QkP4MYQCO7DHdIUr
 BU/DGKvekF9WO0eQOgvtW6/cnj/J1DV8eZIRnxmcdYTSJw2yx16hs32wq20lxT6pbuUoiC3LN
 N8izs5JYQCpyMtoGNbpYEZC8kIpg3V18zpdR0Hlm9F2/gjmK0LyeTWImgBqgQSLueZjoCg+MV
 Ytguo3tzXi6MtyffX2Az4WCmSSiU78tuCjE8cLVdZ5ygVf0S9DYkvJjKGXQ/dm3M6iURHSy3d
 +0HrXSCABBo3khf2Uyn9L8rg+Uzl65NTyXI2tdZMJFKNdWKlAX8JAPKWRlSIJ1WMyJgcu9TDo
 w/3x+3jIRksk0gx3TT2vlyy0+WM0OvaFLLxIPwVbVGyNLmovvD9OgiPDm3jQIFVpCVMVdx8SM
 /FX2VVDrY8ezUoFM5y5UKkl6wfKHOqddl+l2IO2TmWCB2+/FsxznK/yKCgZ8+w07rr+BaHM8s
 UBjBKkx4JujvqgUP1q0hLGmD4GN6BMsAplNvBAtah15l7oAGDPTMUpH71lXjER84ZUpOrbcgV
 vUk9FwHHpxqHzbKpeLZFd1OWDPVgpZVKzm3bwMupdgZItuJ7RgNckYFGqsI79rlAICBBCeuMc
 d1eM7KlRDYGRZnmnAnC8Tj49QSQH6DRzYp+IyLBCnxBR2hwZU+lxzI69gCgt/GjzNjhv0dgNd
 9nQ54PhBR5dSXBiVr0b4SNyc1eyH/p1cX7C+7uxwVTTd8vLFu917GQDYTuKjDu0X72U5Dy0e4
 O4P7Hy5agDZFKxLYPuPiuBkyumnjxJiUKdSgu9Y+RQtotu9/cZVf2r0eXI6WnPqme2ky/c4mo
 hgUjt9wkru13mCq1W/qbV2xJiIs=

This series contains a wild collection of improvements for the
qca_spi driver. This is a follow-up series to the recent bugfixes [1].

Patch 1 & 2 in this series is the initially intended rework of
netdev_open/close. Patch 3 & 9 are minor functional improvements and
the rest is clean-up.

Changes in V2:
- rebase on net-next-20231218
- improve cover letter

[1] - https://lore.kernel.org/netdev/20231206141222.52029-1-wahrenst@gmx.n=
et/T/#u

Stefan Wahren (12):
  qca_spi: Improve SPI thread creation
  qca_spi: Improve SPI IRQ handling
  qca_spi: Avoid skb_copy_expand in TX path
  qca_7k_common: Drop unnecessary function description
  qca_7k_common: Drop unused len from qcafrm_handle
  qca_spi: Add QCASPI prefix to ring defines
  qca_spi: Introduce QCASPI_RX_MAX_FRAMES
  qca_spi: Improve calculation of RX buffer size
  qca_spi: Log expected signature in error case
  qca_spi: Adjust log of SPI_REG_RDBUF_BYTE_AVA
  qca_7k: Replace BSD boilerplate with SPDX
  qca_7k: Replace old mail address

 drivers/net/ethernet/qualcomm/qca_7k.c        | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k.h        | 16 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 17 +---
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 29 +------
 drivers/net/ethernet/qualcomm/qca_debug.c     | 21 +----
 drivers/net/ethernet/qualcomm/qca_debug.h     | 15 +---
 drivers/net/ethernet/qualcomm/qca_spi.c       | 86 +++++++++----------
 drivers/net/ethernet/qualcomm/qca_spi.h       | 22 ++---
 drivers/net/ethernet/qualcomm/qca_uart.c      | 17 +---
 9 files changed, 57 insertions(+), 183 deletions(-)

=2D-
2.34.1


