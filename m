Return-Path: <linux-kernel+bounces-92933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029987284B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340411C28702
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D6129A69;
	Tue,  5 Mar 2024 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="okQU4tE7"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB0128803;
	Tue,  5 Mar 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669103; cv=none; b=fEqVr0MgMSffICT5uxC1P8i9ZTBsGK6dt1xUeYGhOjKa77zfg9eRgFIhiMW11svADgf2xJxHx1v2bNRuBoy64Rjp1bBcJ+HYiPkACPFGPg0U7RxCTA1dpUtHYoXiTN6mq4cUoepY7kc9rK2sFo77qs+s2fgHYFfHq27PnFAYcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669103; c=relaxed/simple;
	bh=4ba42Wlq7wAPDz19Zr/lvoTX6DwYkROpDWgreiti2Nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwzYBKG5qLMxxPhMLayAn/ts4AvOXUoz0ese85Djn/WeIQiHw4k+A1w5Oqs4pnKTgs9CONzmJZdX79zaDS1VXi6hI8JwgAzms7ubOU1DFB8IzJHZwccJu7ERkCOpfDnNLmU5JXkti3fFgAG1UaxIFSYpReJWK084iQSwRbhmWFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=okQU4tE7; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dca160163dso58287055ad.3;
        Tue, 05 Mar 2024 12:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669101; x=1710273901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrrbUMhHczCyjD/DBtegr8A8vdfUoKb3zKrEZrt1Qc0=;
        b=fdolkRe+z/A5D/bA+cEeSXNXLBFt2jkL5FyAi8NE+FC/R5fqj/J35SqSMwxttgHK9L
         WyccMnOzt+O5v1ENOQwvkinkoCD35cVys46hxakTlpBG+HfFULSurPXUDFYUEve2iZpU
         6g46sErYk/4gptm7fUZ7b0DoXaglxSh0ZIxTV6VUR1vdgaZ23dZ9JSUfOYgHsoB+MMb2
         TPk+eWVCQrRDYH17D5t16G4ioNoJnhQf62eJnTIgaZ4UvK4qaf9zKePMH4efJyg0wnC0
         +AnamwHqVcHSgt4D00kNgF5vg9CnsYWvT5ccCczRdlW2Qr3qWK/jT2HdtZpEjrr07hW4
         SsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFF3YxyHrGtFQ1je4kEPQduhIJIvlC5ZgsBpUR6jEfFwY+6sAOrSztVEVYXUfNDXaIjwISCq1hXM0jgrkjCauKKGgB3eK609vnzOSYM72rsEi2xyRV5a7RgThrYll2XhUlMwaj
X-Gm-Message-State: AOJu0Yx63sPVV0P0FeKPO80HaHz6fGrJ+9h4JUdnLCDLaDfbLFJwAzxE
	XlxyY6zwIxYPOGCJO/tOQmJtrQfbxM3IDpqB0enQYMAHP25lm7hNs/7Zk7vDBLz8ig==
X-Google-Smtp-Source: AGHT+IHyaQ8F497E/lnTJnoF7gQ2vG2hQFFEeH3C+6ZJZJp89EuRC5te6pDMn+ysniT/1HCBgrvdhA==
X-Received: by 2002:a17:903:120a:b0:1db:8fd6:915e with SMTP id l10-20020a170903120a00b001db8fd6915emr3385900plh.33.1709669101028;
        Tue, 05 Mar 2024 12:05:01 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b001dbb86b88e5sm10957178plg.124.2024.03.05.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:05:00 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FrrbUMhHczCyjD/DBtegr8A8vdfUoKb3zKrEZrt1Qc0=;
	b=okQU4tE73XWwM1opCHMUPY5ob6aSnOSk1zKYL/rONepCfpbV7oWgl1ySxMJrACTKUehkEb
	ro+Y55U+70nL+ImCLq5m7YXQfLq4Xo1NhMfdKdvDHqBtLcAeO6zNZ4Zi0UYcIQN4DOIBw1
	fyxhvsFqt/5p4P2+h3dPXvufaP5F4BGF0qEOWv0kKLorbghRr8NygqymxkpU44BWfPKOEq
	5VOOdlG3M1MU+NQOd4KDRnQMMbz5c1K+gnwFVRs4ggdnUfd9FdVMNfYpP/ZVNBYdGx3W4D
	g69c+IKvQ4c/NvF2L/fnscIpjVnUAbhL3ArbyJKDmb1Wu396QD51SSqOrjiq9w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:04:47 -0300
Subject: [PATCH 1/2] isdn: mISDN: make elements_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-isdn-v1-1-6f0edca75b61@marliere.net>
References: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
In-Reply-To: <20240305-class_cleanup-isdn-v1-0-6f0edca75b61@marliere.net>
To: Karsten Keil <isdn@linux-pingi.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=4ba42Wlq7wAPDz19Zr/lvoTX6DwYkROpDWgreiti2Nw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl53rkv12Wxf5sojwpP37cfb0lKgWMHmyYSQIGR
 fXMwZBNqpuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed65AAKCRDJC4p8Y4ZY
 pip2D/0XBnxYFcbKHG0qJuX4YaJGERsPlu+vCLOmXgYZbMeuk86bTvU1nL1A6WErcTxfUHq7/MN
 GwcZ5qsIQpz4cFLuvBKFBVmbXdB3g7hMEXkwO4c+tP3xV6tXHlPXM27ACRagCjgNw/5UeVJvzLG
 qeCQRh3yz2rmHSYF8F68j1cRcewb8EPfrjzzCyYaldPcxUrKo1pzQXsM4kq9cFjLASvrexNY0Xc
 qG5dIr1KUvq/q3gHDSVBjOAib3vMdoBECju5Zel3qwjfA36TDwcIZrkzi+ezYISuNAdXnUB9lTt
 h+uUKx26NTKrqMmGDPpWzJYz/4+NxTdNxk4w0zMfSRPbuxIF6K4RCH4aH2NWZ5ilY/+pGYEbzdQ
 T7Dg9QjJJgj+4ZVlPhvlJMieevBTqX46/uv4+bPAZpr5y5NHPFXJyH2NpC4/mlAnBBBQqmI+IpS
 YHwOhGJg8k9gK5sze77vZL/gkMJ82umwmFEtqFPbmaHV/dGliYWo8Mz1McoOB7DUI7LiCYUkBuO
 1NOOoPR9E/wwdGbNJTQ3eOsikOpuvNkdbdbKgqe5Vl4+Xith4toWOtEsCISVytn2d80lbWBTOfp
 VFmO8lfFxUqwYXohrJ2SLT+q89RgrOOsEpHp8t7LtiyIaGxVqm58kmgk87DcvRc3TxA5x3V+8FK
 QOBYOA+uuoAfGKA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the elements_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/isdn/mISDN/dsp_pipeline.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/isdn/mISDN/dsp_pipeline.c b/drivers/isdn/mISDN/dsp_pipeline.c
index 09b72f14d4b7..b4ed0bb8ddfb 100644
--- a/drivers/isdn/mISDN/dsp_pipeline.c
+++ b/drivers/isdn/mISDN/dsp_pipeline.c
@@ -31,7 +31,9 @@ struct dsp_element_entry {
 static LIST_HEAD(dsp_elements);
 
 /* sysfs */
-static struct class *elements_class;
+static const struct class elements_class = {
+	.name = "dsp_pipeline",
+};
 
 static ssize_t
 attr_show_args(struct device *dev, struct device_attribute *attr, char *buf)
@@ -80,7 +82,7 @@ int mISDN_dsp_element_register(struct mISDN_dsp_element *elem)
 	INIT_LIST_HEAD(&entry->list);
 	entry->elem = elem;
 
-	entry->dev.class = elements_class;
+	entry->dev.class = &elements_class;
 	entry->dev.release = mISDN_dsp_dev_release;
 	dev_set_drvdata(&entry->dev, elem);
 	dev_set_name(&entry->dev, "%s", elem->name);
@@ -131,9 +133,11 @@ EXPORT_SYMBOL(mISDN_dsp_element_unregister);
 
 int dsp_pipeline_module_init(void)
 {
-	elements_class = class_create("dsp_pipeline");
-	if (IS_ERR(elements_class))
-		return PTR_ERR(elements_class);
+	int err;
+
+	err = class_register(&elements_class);
+	if (err)
+		return err;
 
 	dsp_hwec_init();
 
@@ -146,7 +150,7 @@ void dsp_pipeline_module_exit(void)
 
 	dsp_hwec_exit();
 
-	class_destroy(elements_class);
+	class_unregister(&elements_class);
 
 	list_for_each_entry_safe(entry, n, &dsp_elements, list) {
 		list_del(&entry->list);

-- 
2.43.0


