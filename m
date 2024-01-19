Return-Path: <linux-kernel+bounces-31200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9769E832A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A34283055
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45F537EA;
	Fri, 19 Jan 2024 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ch5Y9qgp"
Received: from smtp118.iad3a.emailsrvr.com (smtp118.iad3a.emailsrvr.com [173.203.187.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589D52F7C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705670816; cv=none; b=JhmbCjUbuH1CEnm7IoJx1IGmOOuVTTB3Z/KRZPvD22mP3nPAZcyYCADONTLCj+CBbpi3GvDKsNU50WzYzG27ylPwM2yF5wQtA4C8ktYNqgFGUcUTq/u1ngCYbE7catZjQ9848ghb1vEvZI/3gqm18Wb2s5LA8vCqfNxr/stKo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705670816; c=relaxed/simple;
	bh=hms2Pc59mwmGOO0shb+ByW7baurBdVjmSsISiE/x0vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QO4ybf3+LuZeuMsRuEg15tokyJBugyFF02+9UiUdh5hQ+mCkAntnN5+RRdYMc7AokByrHMOxxLCkEuLOitw3XaJbKbfIcsnaJSx1S8cJ1Hf6gV/0YhiEN7MeL7xzgKEZAVvhpnvpkkrn/IwPcJXkBNq0ptlr7U3bjuW8TuO7Lqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=ch5Y9qgp; arc=none smtp.client-ip=173.203.187.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1705670448;
	bh=hms2Pc59mwmGOO0shb+ByW7baurBdVjmSsISiE/x0vI=;
	h=From:To:Subject:Date:From;
	b=ch5Y9qgpTdsd7hELH4GDukJUUDun5PtvAJiwu1ql5+eIW+ggdJPn0c24qc3AAn+Yi
	 Mu8xlEs56hrC94c+7vIRuHgWLQAr5oWc3qLm0wSEAtEJ0VZMe/Km0nAwjBESptYceW
	 So6Fn7BvQuC3T46ZSGP8ZHUuCGEvK5csUbJFQ0yw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C261D24F6F;
	Fri, 19 Jan 2024 08:20:47 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: Matt Hsiao <matt.hsiao@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 1/2] misc: hpilo: fix inconsistent device numbers
Date: Fri, 19 Jan 2024 13:20:17 +0000
Message-ID: <20240119132032.106053-2-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119132032.106053-1-abbotti@mev.co.uk>
References: <20240119132032.106053-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5ab2b5c7-4f68-4b27-8b47-1878e9f7d96c-2-1

Each iLO device is allocated `max_ccb` minor device numbers (one for
each channel).  When `ilo_probe()` calls `device_create()` in a loop,
the minor device numbers passed to `device_create()` start at 0.  For
consistency with the call to `cdev_add()`, and for consistency with the
calls to `device_destroy()` from `ilo_remove()`, the minor device
numbers passed to `device_create()` should start at the value in the
variable `start`.  Fix it.

This is a logical bug rather than an actual bug, because the number of
supported devices is `MAX_ILO_DEV` which is defined as `1`.

Fixes: 89bcb05d9bbf ("HP iLO driver")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/misc/hpilo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index f1b74d3f8958..3428a0bd5550 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -842,7 +842,7 @@ static int ilo_probe(struct pci_dev *pdev,
 	for (minor = 0 ; minor < max_ccb; minor++) {
 		struct device *dev;
 		dev = device_create(&ilo_class, &pdev->dev,
-				    MKDEV(ilo_major, minor), NULL,
+				    MKDEV(ilo_major, start + minor), NULL,
 				    "hpilo!d%dccb%d", devnum, minor);
 		if (IS_ERR(dev))
 			dev_err(&pdev->dev, "Could not create files\n");
-- 
2.43.0


