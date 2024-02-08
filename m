Return-Path: <linux-kernel+bounces-58610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCB84E8D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E48B2E3D5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4657636B0A;
	Thu,  8 Feb 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="AVD+mekh"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224236B1A
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419855; cv=none; b=n9fWWs2FQWyKWA0mQJQp6hHJOIsNSLP7gsxkpPQ7LIBiXpImL2mAQoKgMp/5hmvcFYqy7uPkVI4Kx8VSFkXLVLLjZwv4fArRtM2M633f3v1Wbiwj0cmgqPe4p57RvmedoF8T6z9L/5Fnc6sWoOz98D5XNJSE3iZgd0CcSLbQUbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419855; c=relaxed/simple;
	bh=EgddXSy2U90pa48Ft8cLZ+tPcIMQzwitVjdCWLCIqqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kgJnasr/YbzpcDcm2ojV9rvly5YdkajGacO9fSgL+UJ0teu3ymof6ayWLtMQMm5j/+DMXdAEoRSM7+47xuR+m0Xn1CNpAxOyBPsHNgx5Op6U3XrCFNUZCGVpwf9V9qC2ezRzpEMiinoFvAv/WliFF+VeQKpMMyqcxbCptM268Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=AVD+mekh; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so1334725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419853; x=1708024653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2AfkjHO+5UGjQnXgBOfvoxftlEt+F9BzDjDnKkgQKQs=;
        b=ckMqYuyN7Ug87429ERw6K2whkfQoP8qJCk3vnkX5q7xleq6o/GRN/oxpyNfwSZ3+Ar
         LV1wtCaLLs1FytJU7zRvO4zraq82Y4wH8f8fqWGbTfc9UK8AJ+1n+xwL4zNSkhYWFw79
         2OrIxfhCVqWgcNMM5WET/RfuDIeMkco8olPUhdbJ4xrldUHzDujNS4MMbIxDfhm7NGbD
         +b17+/PIsBNC6AZbZVBj99Uyl5iRPFLRaZ8XgMrcR8pAvPX6+bNsmLKBf3qy50XT+SC9
         A0lnBvAn92lJKGhr5Gqf/lPdPgOOkLGyxScGiJI8E3yt1sI3BsBAXjNbkBjBksUw5/hH
         fUqA==
X-Gm-Message-State: AOJu0YzAdXohxqLsQ6tQX0lF+IoqKHI+k19Hg2rMUhOyidYlUXR7ycMO
	WezZP/wucAGgHjvrtrCrTeCX6+zDjSdLgOrx1tl9ib0ULP5Ic/6Mbmx3LlD+ZtDwFQ==
X-Google-Smtp-Source: AGHT+IHVvY6BCddGWVlawr5nhIpQTlOsVZZluG65zUPT6QJUG4XxIYOUKv8Ykw6+X6TVNO0BVGGl8g==
X-Received: by 2002:a17:903:22cd:b0:1d8:f071:5067 with SMTP id y13-20020a17090322cd00b001d8f0715067mr133712plg.35.1707419853467;
        Thu, 08 Feb 2024 11:17:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOZWiLIo6K269+RygjhRuSI2MGe55SK+rhuyJ4juph+nInGVJURVSJHgYqVZela8RATwykP3nlWeiZDWzItjGMibxBFkiI6in+mAwxUARskVrnCfBAhIN7AOxjftvFs7brQ3oEyKxp7Dca/ixjfZ/peaEVaKVdmBroLFp1czoDqbCEPaOf56PNN5AH0GBIy1Sxl31q8u4MDg8deWhxG3JHSw1VGzncMI4QouKQyx+qlJ8X25Ngvvc7OuUOUmh4mDBLtWWA9YDpY2RdYruKJe8ynPAoew==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b001d9eef9892asm98949pll.174.2024.02.08.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:17:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707419851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AfkjHO+5UGjQnXgBOfvoxftlEt+F9BzDjDnKkgQKQs=;
	b=AVD+mekhsUGcJz8N28x8m+etpCK5ptGysKjBNniHFjWQXpyyxrUGx0eewD666DQzgwkZmU
	EzOOQApSEjOLvvoPJ3rN1KhdUZHslqPjIaizpRXs0Jy4MFxJkXu7PqY+ZdI26MNkXF/yO2
	89Ydrot5tkdNbY06ALetelZLDCLPo7osjEqpnlhGamVt7qE5WxPJ/n7e0zffWqi4dB/QBr
	yyAd1sItnXYzfUik4Ojc7epGmhCF9/JcDddDUCMEKuz5NKfCihyd37cOpAhl8MOL+lZvw/
	LNLQr+Bu+iiUw86gJrFD2VSiq0ntieEVDS9ADAEXEo773afvPaBmVROu56qMNw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Thu, 08 Feb 2024 16:17:52 -0300
Subject: [PATCH 2/2] staging: vme: make vme_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-bus_cleanup-staging2-v1-2-cfe906133a2c@marliere.net>
References: <20240208-bus_cleanup-staging2-v1-0-cfe906133a2c@marliere.net>
In-Reply-To: <20240208-bus_cleanup-staging2-v1-0-cfe906133a2c@marliere.net>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=EgddXSy2U90pa48Ft8cLZ+tPcIMQzwitVjdCWLCIqqU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxSjld5E+tJ3o9Cy1rE0xxbu8u3IdcHmKSOgT6
 xhC4thhL12JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUo5QAKCRDJC4p8Y4ZY
 puQND/9CiQocN7N4v3fmR+TwOqn5QFDgjb0M+WwHi3mur8hOqEzwBaVQOZmmT9hmv6HSr4wD235
 d9NICNZonmfvikeG1JBP5SMNns6WI7Pok7/jHgzZjQ8jKLdbckYJR0oYTgk20nyYYoDNegdyM2r
 TG2MOyQdywaYIFgfUd2drijRZxPYMN14fnjjvOu0aYsV2BxH0LFtJcYD72CmGZccA44P6E+cvLw
 bFMnO+fU+8UP5/hrNbH6OmJtGk1dsI9JxEQwO4sLvrQSZuNpK3ZcBzFKaiCCfdAFzC+F9v8lX0B
 wB373IEUD9mD3HviJcAQnaP9UrdoTwx/Gv091goaFsbnds9LN7E7AMmf0W+ZMHAUdAdpCBNSgOS
 +5FxmaxMoH9M0K8KDIzA9zsGo+DpFuCFmrqOMdl1HJoT2TcjophAZZaPEV/3GsHWJz5pciRfpcI
 DeRoM/DtzlAawy5QbJrUjKX1AP1cDo23kzfGvU6Zc1UT8iWKklHTK60jSwgrpyltobijmeeUR3l
 rSU/It6NhWRLapmFq2f3TPeCg/9xi4IJypPBzdRHi4duQe4hG24fQJsQOWfX6EypYkLNVr+Rgk7
 9vwBnm5HwtG4XayhG+gtOblg2c4Q/8rQqwKzZK9z6CiehvW1lvReJvj5c3JIl1zr/HahWnW4Vxl
 k9oyM5hnc18L/YA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the vme_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/staging/vme_user/vme.c | 2 +-
 drivers/staging/vme_user/vme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index e9461a7a7ab8..0cd370ab1008 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1970,7 +1970,7 @@ static void vme_bus_remove(struct device *dev)
 		driver->remove(vdev);
 }
 
-struct bus_type vme_bus_type = {
+const struct bus_type vme_bus_type = {
 	.name = "vme",
 	.match = vme_bus_match,
 	.probe = vme_bus_probe,
diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index 06504dccd5ff..26aa40f78a74 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -81,7 +81,7 @@ struct vme_resource {
 	struct list_head *entry;
 };
 
-extern struct bus_type vme_bus_type;
+extern const struct bus_type vme_bus_type;
 
 /* Number of VME interrupt vectors */
 #define VME_NUM_STATUSID	256

-- 
2.43.0


