Return-Path: <linux-kernel+bounces-130332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F148976E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7399228D21C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C616079D;
	Wed,  3 Apr 2024 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPGxvakt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD561160789;
	Wed,  3 Apr 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164765; cv=none; b=FwP13c6WGqORLx+sJEaW51pj+kNp03lUO1trFQ1L5EuYWcC5wDC4nGI/9o2r6y7gH+rBn9gJb7ypKLvLrEHoy5rLlsStl5rLneo96DAX8OOpRsxznbu6X++afuMMZreWsF4OhJl0zdnD2QZnWkcrX5A2ce9CbKhPNJHBUi2dydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164765; c=relaxed/simple;
	bh=NCJ8IS7NPVyCm1lypAesS/hfyJL1Jy9uI5JdYtWPIWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hilko7oEu8s5JNOaCzjZjX+68Ta35yGzZfOjMkgZGBpWYkJSPQEPdHWCnbfDkQjriUp6fAurZiFVQnJclW4oO3sckEcwu23ZGFJQ9J/cG6fkQqjXcmG0kJywPzm7Ggt8trX3MVauxyeOFjaOvOPRw+Ng/OhU5Zqgb73vnX2Nhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPGxvakt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9613FC43390;
	Wed,  3 Apr 2024 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164765;
	bh=NCJ8IS7NPVyCm1lypAesS/hfyJL1Jy9uI5JdYtWPIWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iPGxvakt1mduLYPjHrbDqlxekipBwBMHFZDeG8Qq2gSMtHbzFKUs0Unlo+VDCX9oh
	 XfdbLFMENbHnl3l/SN3PDrASJBI8p+iSrvgYm/iEYDnHIiS+UM3R/pyOwMIgfwn3hw
	 s6+RrkDCGco8xeiTWEd2TvqqVICRgMegqTRt1rWMlm0eeNENMuYfDlRKQaHlnUNnN+
	 pgIbUpBInMoKTsOnA1gEZL36dNPDHMYn8Nmy80muDOtRhS82BiZPBNLEC3TXYK6je4
	 nHPS85yJnbymqkGH7ExTlolgYs6szU3rjbpiHXhZvTkzSPb3BPv7dxIOdzn/MSD+Rc
	 q3YN/Z9gSzT3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marco Felsch <m.felsch@pengutronix.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	rdbabiera@google.com,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 07/15] usb: typec: tcpci: add generic tcpci fallback compatible
Date: Wed,  3 Apr 2024 13:18:51 -0400
Message-ID: <20240403171909.345570-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 8774ea7a553e2aec323170d49365b59af0a2b7e0 ]

The driver already support the tcpci binding for the i2c_device_id so
add the support for the of_device_id too.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240222210903.208901-3-m.felsch@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 816945913ed0d..f649769912e53 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -875,6 +875,7 @@ MODULE_DEVICE_TABLE(i2c, tcpci_id);
 #ifdef CONFIG_OF
 static const struct of_device_id tcpci_of_match[] = {
 	{ .compatible = "nxp,ptn5110", },
+	{ .compatible = "tcpci", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tcpci_of_match);
-- 
2.43.0


