Return-Path: <linux-kernel+bounces-120435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DB288D752
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F07929649B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C1225634;
	Wed, 27 Mar 2024 07:33:44 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E163BF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711524824; cv=none; b=pV3/migO3RzJCHCTDJcx22+fjH7z5owCAtQnpBtbR4oWqN2eI8FMrGcZeoXuSbXubX2G9UX7eK33i2GFaRHo0Z5kmSvO+ZCBMoDeZQbg1O/Udzi+ntlhaLiv9Af4+IqaiddhCveKDKpFLRC1LAZhRkEpGf+A2dI2ZKgSPL7M1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711524824; c=relaxed/simple;
	bh=uoumoqKQqUyiOY+Ng8vrdUIak7rvCh/zc7q2HaEm42c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6hTHvbMKqyIPNve0iRfditf7wwfJFJnBN3iNwxJ+KMqdIw4lgP9Hpb5yu0HcV7JuITGez/MoVw+fRYGjXEk8/bEHCAB96tHeAEbWMMs+lOnUyyZvIQ7AQ0phlA3Hq1TMcf83hiaJE6bgFuh4L1la8asT503fPq33BL+Bifqxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpNmk-0002G9-0c; Wed, 27 Mar 2024 08:33:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpNmi-008lQm-V6; Wed, 27 Mar 2024 08:33:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rpNmi-00CGTR-2q;
	Wed, 27 Mar 2024 08:33:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: Provide !COMMON_CLK dummy for devm_clk_rate_exclusive_get()
Date: Wed, 27 Mar 2024 08:33:10 +0100
Message-ID: <20240327073310.520950-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202403270305.ydvX9xq1-lkp@intel.com>
References: <202403270305.ydvX9xq1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uoumoqKQqUyiOY+Ng8vrdUIak7rvCh/zc7q2HaEm42c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmA8u229hyJ+VZupW+Wqz6Kt09ZniAFiJKYE7tO tJHAz9zMGGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZgPLtgAKCRCPgPtYfRL+ TmyrB/9CIWuBmGV0INTpNhI5M1a+p6YFNukW/EFxLvDNmgoxSvmh+YnlSbcuFMbHkw7Wpt3zGF8 5bbNZ4TWafQWfhTYa7J7DBuzGolbJv+/NdIyvA5TkV9UYo2t+WHOOSLqwF6FF9L/eOB0e9bV8SO OREgEK3zwKqQQxV51uozyWa2jwKN5wZmgRJBxE1og6/IQFHwiHDaqk/zW+arBWKh9PFtlM+6bcO qMdYeKH5qrdr1kMZ1a75Y4ah8FSGVMxaRbjze5bVlT8tEQAgnZXiTcN1N3bdP8ucmIX7zJpu0+K LaHu2fB4KLc244zcCy16mu+Tyrbzq4VToTqz7vwNgJ5l7cke
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

To be able to compile drivers using devm_clk_rate_exclusive_get() also
on platforms without the common clk framework, add a dummy
implementation that does the same as clk_rate_exclusive_get() in that
case (i.e. nothing).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202403270305.ydvX9xq1-lkp@intel.com/
Fixes: b0cde62e4c54 ("clk: Add a devm variant of clk_rate_exclusive_get()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/clk.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 00623f4de5e1..0fa56d672532 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -286,6 +286,11 @@ static inline int clk_rate_exclusive_get(struct clk *clk)
 	return 0;
 }
 
+static inline int devm_clk_rate_exclusive_get(struct device *dev, struct clk *clk)
+{
+	return 0;
+}
+
 static inline void clk_rate_exclusive_put(struct clk *clk) {}
 
 #endif

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.43.0


