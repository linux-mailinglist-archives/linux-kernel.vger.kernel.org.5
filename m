Return-Path: <linux-kernel+bounces-71325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E3185A38D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D82B258AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D12EB14;
	Mon, 19 Feb 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="d6JFEHJA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4EF2E844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346155; cv=none; b=Abh753G8OGQJX56/UG+OzLhJ2rDJUk/0ZIF4HvAZHy8gNezQv6tVSwW4K/jcaIw0EjIO9QiTQ43fs3aSfC35oDtBYJJbKU5cqus9EED5wlW3HWC9gIfyWeqOLzMgGrjbJOyyF/90reCrSfbMUzcVU1cDNBFRAY175vHl1zWeAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346155; c=relaxed/simple;
	bh=VY5HgFYLE2N/2C3h1whk/HJkl0Tv0K861rCXBGqg1Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fXY45na0Z17xDbgHZS8bl3qAl0rB9E0af4f9XvBq+a9Cz3w3S/kwaKKDTBIGpmsBWnE/8LmnuSS9y3DMw58Q54+GhB9lGy4RH/Kp1tBd6lQ4YoSUdyFB1yBD//h+//tcRyDTnnVxsx6fKZs7CUMsBlWOtAmar8iqwACcUaz70W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=d6JFEHJA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d731314e67so29177415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346153; x=1708950953;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDJhWgkmq4prdqrSz/AMeVpuz2xjBwxbRSxkSLXonWQ=;
        b=Z9/UJie2JjXljlrW0+y0xts/24dv5ZmrYiPi5MmNVlc7UdkPLAx+n8ijrkRXJBhws8
         xB10D574/ibBLotzT2E+l2UjKwN+tjknMEq/6+Nc0MduMpMEoUCT0vvU+POcrH4+4ww7
         FR9z9Va/pKvDakL2/GaalWHE/SvR+LRftQL5ql7dwtRr7MBFDirWUv7Pva49cbhC0vG0
         MQGl/QwnJZw4RMfbFd8QhK5eKPO0xGYTc/aqMO6TzT6FPaRaEHJcy3vvfas+ztbMSqtG
         uxzef5FeWCIUTn6aW80dIz0pgGPQhV6rw4pGguEvR//o29q42EZ7YUXvOxDDsqvxGwsh
         ytgw==
X-Forwarded-Encrypted: i=1; AJvYcCVBPRBD8+9tMbI9QI6nn8tVsHwYMyt0mPSJuZyEesWHxd+1gK1it1m8ZVG5nTIbseR2EqOrBuwxHIz9Pq/ogKt/PVRAp2q/5N5yOdTn
X-Gm-Message-State: AOJu0YytDsxELMf+qvb3c32e/Ps0OzzfLWqboDy744RVHt6iPhHGCTpI
	op1ODc62slaDj20omVakuOmd73pe0fGuzVFmlcI699lCYSuTOvatmmOhtq9KULz9xg==
X-Google-Smtp-Source: AGHT+IHQz/w6mTIal3bPMzsuUMb0nNOTFDqSmXx21186jWVoIilBbyhWzS83ykOfeYx9zBdqvtT2Kg==
X-Received: by 2002:a17:902:fc48:b0:1db:ab9e:8f90 with SMTP id me8-20020a170902fc4800b001dbab9e8f90mr8594978plb.37.1708346152677;
        Mon, 19 Feb 2024 04:35:52 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001db45bae92dsm4212519pls.74.2024.02.19.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:35:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qDJhWgkmq4prdqrSz/AMeVpuz2xjBwxbRSxkSLXonWQ=;
	b=d6JFEHJAjRluzED4GrSpofATeV9Uu4rRE6WsQ0KPqTnrCgmQY24m/LKVvuFyv+lhWDt+bB
	HYDf6X5tnwc/QEClf3EZNYY/z+9KE+veKBYjXHBuWCaeR1V5QJroc1E24XouLzy9xqcsh2
	XRJf9aJndc1OOBtVj5gKJwz0+K/lS1LjKHRg4ekoxY/dscxUCOIYBAAw0/Lmwdwn2a4quL
	rJawMHVgy6PU4mIoYpkN5mwyl05L8IboUc/ZPJMdExlByBl56MrNvvyF8nZd/UbQzZgUyr
	/mdxQTsiK4gSyHBkdexaVx/v38mYUZCaCRDnXT1mdpq+aFvc/VZMpoUEHEDwIw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:36:35 -0300
Subject: [PATCH] peci: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-peci-v1-1-0727662616f7@marliere.net>
X-B4-Tracking: v=1; b=H4sIAFJL02UC/x2MQQqAIBAAvxJ7bsFMsPpKRMi21UKYKEUQ/j3pO
 DAzLySOwgmG6oXItyQ5fYGmroB25zdGWQqDVtoo3fS4FIl4poOdvwIGJkFn1s6StVa1DkoZIq/
 y/NdxyvkD2lN1PmUAAAA=
To: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=VY5HgFYLE2N/2C3h1whk/HJkl0Tv0K861rCXBGqg1Tw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl00tThQtl+cf7zlbbfl7NfHTibMvuI0pFpsfQm
 jH/MmQVwK+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNLUwAKCRDJC4p8Y4ZY
 ps7gD/0b4f3KZtx/eVFL+cOv1ECpO0uiztm726rM2dH/UXVDVE1O5aXv4ZpetIsV5l0YGFC2zrr
 Ww3b7Wwg+feYkHVGEsnLiuI/f+xp4mFcApIaMtuXYjrFA2gi7+rA5wygDE6/Qd1BdTQn2cMw8y6
 2GvJHjWcxXPmvX/aBybBM+26bVTvAh8O49QXemhjYalzjyfHP0WkpHvhMbvzDur+Oj5yVp7HB0i
 1EvMhYVrsCoecTWZlvVQ1pgX8PJKliOMK+6/Y3iXf6t7G+2bScyShcV8weFfymm57NDg552uLGg
 ahvdLgT9KfW85YPqsXfOXqAzWKLaVKB+iGdx8jiWogSw6TAsz6IlkRUm/bU93+cXX8Rwt7U+YJ4
 iYkKQQlt2j6De11kRhK3ao2zYsX+NhTNMrkUGvnkZwJRTWS7POo6REIbZpTMivGoTeScn1VYnlf
 /R9PBSxtIXg85yPh8P6EP/Tvl/spZLPHes2Ii+tpehGl53t7drDT7o65atCGbX2qpdmbjdvAoTQ
 AyZpPettpgzyHgvoTK77ViSzY4Mw1djz3vP1IwiBuNLVkyt1DoHT9yWCa2VfKKKVOvDTUtqiywa
 wzrJPY0Ssj6b5/fir4yBWpovGPwpINGQg/+K1p70cTGTyeOQtnjcppG0lMjY3ss7jy+juPD1g6W
 xcxtN0w7ZBIk9hQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
peci_controller_type and peci_device_type variables to be constant
structures as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/peci/core.c     | 2 +-
 drivers/peci/device.c   | 2 +-
 drivers/peci/internal.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 0f83a9c6093b..ab22d7d1948f 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -25,7 +25,7 @@ static void peci_controller_dev_release(struct device *dev)
 	kfree(controller);
 }
 
-struct device_type peci_controller_type = {
+const struct device_type peci_controller_type = {
 	.release	= peci_controller_dev_release,
 };
 
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
index e6b0bffb14f4..ee01f03c29b7 100644
--- a/drivers/peci/device.c
+++ b/drivers/peci/device.c
@@ -246,7 +246,7 @@ static void peci_device_release(struct device *dev)
 	kfree(device);
 }
 
-struct device_type peci_device_type = {
+const struct device_type peci_device_type = {
 	.groups		= peci_device_groups,
 	.release	= peci_device_release,
 };
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 9d75ea54504c..fddae86bf13c 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -75,7 +75,7 @@ struct peci_device_id {
 	u8 model;
 };
 
-extern struct device_type peci_device_type;
+extern const struct device_type peci_device_type;
 extern const struct attribute_group *peci_device_groups[];
 
 int peci_device_create(struct peci_controller *controller, u8 addr);
@@ -129,7 +129,7 @@ void peci_driver_unregister(struct peci_driver *driver);
 #define module_peci_driver(__peci_driver) \
 	module_driver(__peci_driver, peci_driver_register, peci_driver_unregister)
 
-extern struct device_type peci_controller_type;
+extern const struct device_type peci_controller_type;
 
 int peci_controller_scan_devices(struct peci_controller *controller);
 

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-peci-a4f87c77703a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


