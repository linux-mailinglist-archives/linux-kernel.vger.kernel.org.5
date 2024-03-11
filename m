Return-Path: <linux-kernel+bounces-98651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 467DF877D50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB171F20F27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A72DF84;
	Mon, 11 Mar 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jdwn2ad8"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67492BAF8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150605; cv=none; b=Dz1TLZOaf0jwclaKxTNWmAG0whBMkNsyJ+wr5KPDn+1ecEJi9T5pFda/RYp2nJ8mIL3HhYYM59jrzWmsjzbWEFbB2nArhSBwgThnMwh00xlZgAIdTJCTSn97YQaEU0Fe4I5fSqvbikXzrGw76j3sC0ibvrwRfqchu7+yeOajUBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150605; c=relaxed/simple;
	bh=uvJ2hakYbHneCq8YNG7tuA44/YBDsJTeR/dxao+/8HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R/GIgRuMaiysuKI/u7KYCJCKzccloxT6aLWCwCyRV8m5cSINnJBH8Ko/rdyybsg/Xy7/RPJmwlpKHZNsCtaMzI2yoe5PxuxSvT/dblFqP1NSYNJh0EtKCyAdAJfD4OAtdohKvr/I/cImnjrjePrTeBv3eC6y18kWWdSPDVDWKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jdwn2ad8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cec8bc5c66so2940631a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710150603; x=1710755403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nKgRIKf+zajKM49T+JUxDbdLW2EfnvvMithLFK/Yc=;
        b=Jdwn2ad8Yjvze3A/IsjvHJzhvSbO1gi9QO23jsfDhj2r9A+5kvu3/nu7UlL+mMgNRr
         o9aagpGNLo0caS1btUv5dxPFRAwhK3etIZPjHQZucQRvtmdJxRp7rGN8JwmttVmvJdvP
         iAVlxg5z1fMOEnBOsIXBau2LHW7FmpBbZeh2VDZywnr2AZVqWe7qFKybaeWy9l2RklQB
         BjPRHVExc3+YhznWIJyIosgOsLSa8gi583oo24vSp6xaEoJ5uNB/y27N1yAKNVSUoK/r
         CUbKNBrKcRLBd+oUVul8GFhk+PvCzDiY8WkwXr9kXq4SEDJbhypRgykOVMu3UU3hQQ+g
         IkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710150603; x=1710755403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U9nKgRIKf+zajKM49T+JUxDbdLW2EfnvvMithLFK/Yc=;
        b=mzRiJUpeHOOskiutqCvN/tX9YDR8xcmB3RcV8zJ3B7iJ0stu9as9SDCA69R5zDamgk
         hFFLXDfAzHZde1g5P2WrAQjJM2sIEcc9aD18S+GPl1KU1gHotY5C1zeuC98N5d67YLB2
         Hk0ftOsH9s+OAsfZmz85K4ayqiGHbmB4mWQVuTXaAARKNG74z6JJajPnFKnyfHtEOKqu
         3PkKweHjuf7E87ffFoP4nJP07CInJZOiEnNHjzw6DgNLYLxLqkIYpeldbz+GrgytyEnW
         6nU3MWPogLTgy9v+kDTNE3e/jfQOKBaawbSZkMyGTN32RFbP+DAYkPP7LUchriEm3dY/
         197g==
X-Gm-Message-State: AOJu0YwSRODyN9WZudQSaOu+EhULxXk3bE0Qv3qRlYgOFuMolpxag4QV
	TjCh9WdBO6M4XQ4t3dUd2A2Rt/hxR7sKkC5rcfhcmkXb+t8lATzGpVVrsYLlGId7figVE8dHBN3
	yJ42QSo5RjWuV8g==
X-Google-Smtp-Source: AGHT+IE5C8YFsWfQeFn6ZmMrCYM8EsZdK0R7B2x7aijsSo9T46qxw3LGysRAMLa17HQzOWxQTbFW0fvfbLQGTOw=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a63:de0b:0:b0:5dc:aa2a:7790 with SMTP id
 f11-20020a63de0b000000b005dcaa2a7790mr17226pgg.2.1710150602720; Mon, 11 Mar
 2024 02:50:02 -0700 (PDT)
Date: Mon, 11 Mar 2024 09:49:47 +0000
In-Reply-To: <20240311094947.3738200-1-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311094947.3738200-1-howardyen@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240311094947.3738200-3-howardyen@google.com>
Subject: [PATCH v5 2/2] usb: host: xhci-plat: add support for multi memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

The reason why it needs multiple regions is that in my system there is
an always-on subsystem which includes a small size memory, and several
functions need to run and occupy the memory from the small memory if
they need to run on the always-on subsystem. These functions must
allocate the memory from the small memory region, so that they can get
benefit from the always-on subsystem. So the small memory is split for
multiple functions which are satisfied with their generic use cases.
But in specific use cases, like USB3 devices which support the stream
trasnsfer or multiple devices connect to the host, they required more
memory than their pre-allocated memory region, so I tried to propose
this patch to give it the ability to get the memory from the other
larger memory to solve the issue.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-plat.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..7892d3eb26d2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/usb/phy.h>
 #include <linux/slab.h>
@@ -149,7 +150,7 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd, *usb3_hcd;
-	int			ret;
+	int			i, count, ret;
 	int			irq;
 	struct xhci_plat_priv	*priv = NULL;
 	bool			of_match;
@@ -194,6 +195,19 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 
 	xhci->allow_single_roothub = 1;
 
+	count = of_property_count_u32_elems(sysdev->of_node, "memory-region");
+
+	for (i = 0; i < count; i++) {
+		ret = of_reserved_mem_device_init_by_idx(sysdev, sysdev->of_node, i);
+		if (ret) {
+			dev_err(sysdev, "Could not get reserved memory\n");
+			if (i > 0)
+				of_reserved_mem_device_release(sysdev);
+
+			return ret;
+		}
+	}
+
 	/*
 	 * Not all platforms have clks so it is not an error if the
 	 * clock do not exist.
@@ -431,6 +445,9 @@ void xhci_plat_remove(struct platform_device *dev)
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
 	reset_control_assert(xhci->reset);
+
+	of_reserved_mem_device_release(hcd->self.sysdev);
+
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
-- 
2.44.0.278.ge034bb2e1d-goog


