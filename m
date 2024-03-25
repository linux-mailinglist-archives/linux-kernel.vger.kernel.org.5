Return-Path: <linux-kernel+bounces-116696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E888A2A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8362C393C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D014F9FF;
	Mon, 25 Mar 2024 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kpay/Y8u"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020A152535;
	Mon, 25 Mar 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355121; cv=none; b=f38fmEopWsyg6r97qPiQ7+felOw0JM9KydWBBc1AfJdCwqZB9nrQreEjb7o1N/MfkX7dL2U7qVy5EE6d5bzrl0i3tAto2nG37aWj3Somwxt5IsLNke3u7kel6zisdh2KsTRDMk18GtF0qlHae/xd0ve1a5zLJC55T0IH4zl7p5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355121; c=relaxed/simple;
	bh=vyv+HNgURDWV2scBdaWEEaxoLp1sb6KCPACv5B5MU+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhNSZi9kQzluzvhvPMdUcGfYWOWyKHhLY+FAUNM5dgPfmjxKMAZbyown/iWK09elMuNUM4cBtnJhvAT4YxHpjRb+hl97BgevFtorhfFfn2YuMTT8cb8qO7gKd0hNjYzAk93/m1uZOQeqe2n4pwuH6A6d8VG3EKmwuFjP2zLbumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kpay/Y8u; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 49A12240005;
	Mon, 25 Mar 2024 08:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711355116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+L8FJ/DS4fPdi9sganBNWxhh3Fg+F14KfU/MgcLGU3E=;
	b=Kpay/Y8u+j/vGmdz+GdQrFVGa4VZaXTFQX3M/5GCFdK0isycK+rtVrr2cC62f/oPlYlDdB
	JKe4c3GQ4QQO/WqfmJRlUj913pCHzLiCOZBjyekRhrxkroF9ULzJUhNw+QPC9UUFMUqWfM
	u5gviW7azfsvbv8aR/0kZnC49YdIGCo2685bWc87lnXw7V4wnAnIn18O/XBk9QMCoGb3hs
	f0h8146THg3+1wD0i/2yZ20vfEovBlWxqvqX4e5CjA3gF91xOEi1FNX/y5NB1ZfKBqxuiR
	xwuOE0mo0TQvsG23OTST549PHypDPCL5RSWyfYwt1iAYiAcAYH9kQtg3bZmEUg==
From: Herve Codina <herve.codina@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: framer: Add missing static inline qualifiers
Date: Mon, 25 Mar 2024 09:25:05 +0100
Message-ID: <20240325082505.29385-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Compilation with CONFIG_GENERIC_FRAMER disabled lead to the following
warnings:
  framer.h:184:16: warning: no previous prototype for function 'framer_get' [-Wmissing-prototypes]
  184 | struct framer *framer_get(struct device *dev, const char *con_id)
  framer.h:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  184 | struct framer *framer_get(struct device *dev, const char *con_id)
  framer.h:189:6: warning: no previous prototype for function 'framer_put' [-Wmissing-prototypes]
  189 | void framer_put(struct device *dev, struct framer *framer)
  framer.h:189:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
  189 | void framer_put(struct device *dev, struct framer *framer)

Add missing 'static inline' qualifiers for these functions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403241110.hfJqeJRu-lkp@intel.com/
Fixes: 82c944d05b1a ("net: wan: Add framer framework support")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---

The error raised by the kernel test robot is already fixed by the
commit badc9e33c795 ("net: wan: fsl_qmc_hdlc: Fix module compilation")

 include/linux/framer/framer.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/framer/framer.h b/include/linux/framer/framer.h
index 9a9b88962c29..2b85fe9e7f9a 100644
--- a/include/linux/framer/framer.h
+++ b/include/linux/framer/framer.h
@@ -181,12 +181,12 @@ static inline int framer_notifier_unregister(struct framer *framer,
 	return -ENOSYS;
 }
 
-struct framer *framer_get(struct device *dev, const char *con_id)
+static inline struct framer *framer_get(struct device *dev, const char *con_id)
 {
 	return ERR_PTR(-ENOSYS);
 }
 
-void framer_put(struct device *dev, struct framer *framer)
+static inline void framer_put(struct device *dev, struct framer *framer)
 {
 }
 
-- 
2.44.0


