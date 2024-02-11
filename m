Return-Path: <linux-kernel+bounces-60640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9689C8507E8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26C01C20D6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D17C171DD;
	Sun, 11 Feb 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dOVQIbsf"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9C1427B;
	Sun, 11 Feb 2024 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707631916; cv=none; b=ch6Qbv9Eo2tkPcavvaaral7DvI97nWJaD4+evKto6Okt2bNQOYW301Kq0yCSZ0OHzLni/DvDUdVfhQx0DMmElzJ5ytXm/AUNyArfYblmItd/dZ5gEHRW5ALTt/4LtKCqxl5dIOt+okSfr7eyOFI0EGwy9V6CaM+tmlaGTFa8X7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707631916; c=relaxed/simple;
	bh=uiHv33UvQzWWqzhY4G02ngJ3pu97xmmsLDicdgZbIVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlTqgN8T/3yFitsA6ns22mGGoxkqMHox1HKS0gswcbR2MFgKLpBYbruJA9VCX0h56cIVv2nZQI+3E9pqHCqvGEFy7z06JxLWSUJ8JsXggKKz/Sk3KuOdp4VWjnNIfO15AtQC5mZ9bBF/Opg6bkoAQxlR168+HG+A6mDwD13GEFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dOVQIbsf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=uDkJxhoZtG6KpR3Q/PoQfQNM2zj8tnJOgXtpsXtp2n8=; b=dOVQIbsfuKhD008h30Ze3q7kk4
	VHdw8OQANyWUb27RDNMHu97gGYfQTLO0fh8/nU1mTCzJ5Rvkw9rWCsHQ102DC5Grw7RNCxEBokCNp
	BVkGxz86Jk1lmUWm+zmJjORHQjhZ2ygjxgKaVPXoap98ciF6nsyg726Ns6K5B21v2RIegcC03htOY
	EDDOxp2ItkamD2IjbBvouevULExDuLIEUmPtJAm1rLcXKRBXoD/RK0SfNtn52ogzeQ59SH1UPRp7/
	8aDWg+NgKLOWus5NE+Kp2yCuK5uk67WUYZi4WhpLotKzh2VBKVmGdaRnuVXqNR9U3ZStvpvoZCOP8
	WBrJ7fjQ==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ34D-00000002OlB-1uSn;
	Sun, 11 Feb 2024 06:11:53 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Roger Quadros <rogerq@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH] net: ti: icssg-prueth: add dependency for PTP
Date: Sat, 10 Feb 2024 22:11:52 -0800
Message-ID: <20240211061152.14696-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_PTP_1588_CLOCK=m and CONFIG_TI_ICSSG_PRUETH=y, there are
kconfig dependency warnings and build errors referencing PTP functions.

Fix these by making TI_ICSSG_PRUETH depend on PTP_1588_CLOCK_OPTIONAL.

Fixes these build errors and warnings:

WARNING: unmet direct dependencies detected for TI_ICSS_IEP
  Depends on [m]: NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PTP_1588_CLOCK_OPTIONAL [=m] && TI_PRUSS [=y]
  Selected by [y]:
  - TI_ICSSG_PRUETH [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_TI [=y] && PRU_REMOTEPROC [=y] && ARCH_K3 [=y] && OF [=y] && TI_K3_UDMA_GLUE_LAYER [=y]

aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
icss_iep.c:(.text+0x1d4): undefined reference to `ptp_clock_index'
aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_exit':
icss_iep.c:(.text+0xde8): undefined reference to `ptp_clock_unregister'
aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_init':
icss_iep.c:(.text+0x176c): undefined reference to `ptp_clock_register'

Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Md Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
v2: removed Rev-by: from Roger Quadros (patch has changed)
    added Rev-by: from MD Danish Anwar

 drivers/net/ethernet/ti/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -189,6 +189,7 @@ config TI_ICSSG_PRUETH
 	select TI_K3_CPPI_DESC_POOL
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.

