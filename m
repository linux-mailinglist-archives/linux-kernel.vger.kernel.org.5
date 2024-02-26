Return-Path: <linux-kernel+bounces-80691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E676866B51
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B410CB225F7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631B1C693;
	Mon, 26 Feb 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0NFa1PTN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E321C2AC;
	Mon, 26 Feb 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933707; cv=none; b=tA3OZh9MDmDtJI/v1GEaEpjg1DLLIslMI+8yKXokQv4rha8PXU+JLUKFA+ZXCTc1y6dFPuQfU/R4O3fFm85tg/NrQElZvJhqeHT5B4i7bGUbl2w1O9CBd4XbQaHKypf8SFPU+rY2lF+B5/Z9EN6/4OmomJ+UIR4IM9F3buJRMQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933707; c=relaxed/simple;
	bh=Htm/i+rbA03FkAgGv8NIjH0Au/R4G2XTU14HHQC9uhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SKRkaBf+9q1m+BeXpZBqR8mc5Xm+gNXxH+JcoT2/iFR6w2NOWrnYMdWr45ck0+kEBd50zomjy9EB0LTohk8MckBRzegwo8Jf+Ps8bbN22mW/OwPDUf36PQquh5/qhsqBeKSPUPsdvKjfXtbblDgBZqXn1In3dshDqjUxWXUKrw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0NFa1PTN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SegtnljFVq+DqvrEpSU9MAyND0sgz3OtVm7gyrIG/Q8=; b=0NFa1PTN3ZARm60ndi7WsLxjQm
	qAzh7/cFgwzSz3fBRUkfU62R7pB9/PUfsn35byKY0SX2gLmvp4HQtys610v9v4RCPPL+9A/FYCGi2
	48I37K9xRa79K6rcmePN+/velCQuqTSVqLrLCa0Qy5uNIjfUiTrUW8nvpNg1UDPTuTN1gXLKVKaba
	x/VL4NQfoIGBQaZfUIi9GQwMiIOWrgyWZlUtgdgD8vR3BkxuRpN9wpMdrPkLDg1gaMhZ9GpXSTomN
	QRCbS3XMC1xn0dlrfbJIMDy9aOonngvYmL0+ldPZNQq0DY7zCER3uPluIUsRO+vvrmoBciQMMqKmp
	+IK+Gmpg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reVin-0000000GrmJ-0EjN;
	Mon, 26 Feb 2024 07:48:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Michal Kubecek <mkubecek@suse.cz>,
	Lennart Franzen <lennart@lfdomain.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH] net: ethernet: adi: move PHYLIB from vendor to driver symbol
Date: Sun, 25 Feb 2024 23:48:20 -0800
Message-ID: <20240226074820.29250-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a previous patch I added "select PHYLIB" at the wrong place for the
ADIN1110 driver symbol, so move it to its correct place under the
ADIN1110 kconfig symbol.

Fixes: a9f80df4f514 ("net: ethernet: adi: requires PHYLIB support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Closes: https://lore.kernel.org/lkml/77012b38-4b49-47f4-9a88-d773d52909ad@infradead.org/T/#m8ba397484738711edc0ad607b2c63ca02244e3c3
Cc: Lennart Franzen <lennart@lfdomain.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: Nuno Sa <nuno.sa@analog.com>
---
Thanks, Michal.

 drivers/net/ethernet/adi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -7,7 +7,6 @@ config NET_VENDOR_ADI
 	bool "Analog Devices devices"
 	default y
 	depends on SPI
-	select PHYLIB
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -22,6 +21,7 @@ config ADIN1110
 	tristate "Analog Devices ADIN1110 MAC-PHY"
 	depends on SPI && NET_SWITCHDEV
 	select CRC8
+	select PHYLIB
 	help
 	  Say yes here to build support for Analog Devices ADIN1110
 	  Low Power 10BASE-T1L Ethernet MAC-PHY.

