Return-Path: <linux-kernel+bounces-71911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C871C85AC67
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C811C22642
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9800056B70;
	Mon, 19 Feb 2024 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="OHp0+xoN"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3E56B6C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372132; cv=none; b=O7jc+dI0OH6/0jcEOTAhG1M2rxPnt5sxasX1xkIk0cUHZfuPffFhggiKrBbMOlAeLOMHLAT43k+6+nG0p4xy84mGiAFnpibLVb7gRkfwiQZZYKv9nSWg0oihBv2EocS8+JohMmcVlAsxg1Q+P1/7mBA3lxdi0ww/a/rzs+A4pZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372132; c=relaxed/simple;
	bh=NMqAs0MjnufjzieP2aA0KfC0+NvfSYAdC36Vekj6kDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eFZzq5LDM63q9MT8olmF+tw8X9yEhl3DAqF8zu0G7YAFKtTRuxlCQjTEkxFoPhPo9O8hWbihMFyV62F+rRqZ6aH7gPCBQvFcL4uW9T7/96S3ZxWU1Xi7qFvAYSNM3+g2KLHIqbOzimUvzCXJEgY6kID4pZoif2axOvrGVGMI8a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=OHp0+xoN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3479286a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372131; x=1708976931;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpPLVhfeHrdVMlFPITmrnXxqzPQFObmVpUnLSpO4uvg=;
        b=NoLe+4aomcZHK7zfAN//1Ix/tj89hyVF4JhVT5U06iQEkylhVmOtHODWGnXoJyRhJe
         r27uu8CpNmKWxws2Vflm4t6Z2Bo7+zC8fDSUPS93ULPS8KWAC0yb8zbWAyNtt9Ofyc3F
         vgil8h0dZfgwz5joradcWcyDDEeB9HGU0XBzxQJIJ2fNByq17Vqy80uRG3cYlJ32GcZc
         oMtDnDR1PcWKo97k2rLJMVovlde1RCTZXDQ0JDdA5KA2lj2oj7Zxv+a+UDM6qWWruEL2
         vK90UcscuyAiw8hyqnzbPQ5YGHkgYIU30/VOwl3qTSM6CR9cIQYX4uTvs2VEXU1iokGl
         dYvg==
X-Gm-Message-State: AOJu0YxE/3PxLv+NMObWenD0P9CixV4gX8hDLw/RlCG/mzr7wEPbzZyU
	HYbW6BxhMs5T/+Tm2nJ3NrIUJ1Okb3tm098s+Hb+Sk24AGgkozKWtqTv8maGUPAbWg==
X-Google-Smtp-Source: AGHT+IGbig8bdQR8Pb6ym/ttIM8aBTIN8GInXUFkMvmbpkvSKYReLvqacpqwjGoiarU7iK3uNmdoHA==
X-Received: by 2002:a17:903:11c3:b0:1d9:a4a5:7a6c with SMTP id q3-20020a17090311c300b001d9a4a57a6cmr19098246plh.57.1708372130514;
        Mon, 19 Feb 2024 11:48:50 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id mq6-20020a170902fd4600b001d96a0cddccsm4781942plb.296.2024.02.19.11.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:48:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708372129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpPLVhfeHrdVMlFPITmrnXxqzPQFObmVpUnLSpO4uvg=;
	b=OHp0+xoN7r2aADn+PdxCxTJNnch//6IqhQCsYi9huI5KCB5sPHI6DiXeU99l6AOdbF9GNB
	mj+XQXCEbi5KwvIC4cKvr25X3Dl9xYIfinEpXaB4siruU6shKetVdCOtfNTQiDWZ6oyEiK
	zSEWmp5EosfaB8tFw8jcrni2l1CCK4sLGDkDAt3NmiiYuI54qpiNy6HNNUlbMA7SGD4nB3
	lD4jzbFgFZTXla5MOPQDJel7RTa3dRSpAYfagUZPWFyRn0wW4MHmOzqKWDxwMN6opp06Up
	v1FuOhXdGlcWUO8L7+8lsnIdKmoDW+DXBzWRQy2Phx6UbPjAf18GfLiykXfu+g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 16:49:30 -0300
Subject: [PATCH] siox: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-siox-v1-1-eb32ca2b0113@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMmw02UC/x2MQQqAIBAAvyJ7TlAL0r4SEaFbLYSJUgjR31s6D
 szMAwUzYYFBPJDxpkJnZNCNAL8vcUNJgRmMMp0y2snAksfZH7jEK0n2q7TGOoVd29uggMuUcaX
 6X8fpfT+v9IwrZQAAAA==
To: Thorsten Scherer <t.scherer@eckelmann.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=NMqAs0MjnufjzieP2aA0KfC0+NvfSYAdC36Vekj6kDo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl07DPeCLeYDytCH05eYgcc6D2V+l0OriDggsG2
 R6TEHHfKjeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdOwzwAKCRDJC4p8Y4ZY
 pmASEAClish8Lsqj9rCSEq/7T1o2DaKpNAps7zxxvfKfwDeN7NgrHXWfy7vzRw4Hv9KP6+Irof8
 2d30qEy16r5jdMUizSd9LuNmzGxUWz6GK2bhxio21tNMG4HIN0ZV0EgQDoxPWmLAlbffs3hlbwb
 mDU0KS2mmyygDxfAa5nQBvJeJcGoaxsIIQdW6ebzD+U81/SolYkdsS34vhngi9iJ1ZSjinLWLGT
 0Vy+ophnuXYdw12kD8xxEZIxBOK+g9JFdaTNJY/xmnlKeZxx9gH92qJI+DpOk8ybEpwN8UnJB8V
 CNIBfhyZ49XoExKkGJTRUMyXVH1REdiav/jYJ4Rr94QIdh5wiqHLdI4zHeXTeaRRNiV44H4Vpdm
 yn6uwwtTrXg4rhi++6882UAS6HC2NoKVKmIQ39IEsjjdyAkygdxAq1EcauQ9Kcutq2WUbT9/LD8
 M1TF6FYSy8hNRh7CCkRCC1xL9aHq5Cp4fuwWwFXHePiWajWrhFw1CXkPlhir8Z+ukZFxAMSN0At
 eWoq83ZgjAwt1uEFc2KsRfRiOtTeWTEg1M4jRB2olywH4NWbVhUMOXyKNrNDBdQJEHETGZAIEyx
 sujOayzJflaD4sjG7DxxJlnyMIzYnZKea9erh3g3sd6T06f3sfQ901UeJYw5wXf+UuoFF1z5EDr
 D6MABwYUh119OJQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
siox_device_type and siox_master_type variables to be constant structures
as well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/siox/siox-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 561408583b2b..8eca20c2ea9c 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -498,7 +498,7 @@ static void siox_device_release(struct device *dev)
 	kfree(sdevice);
 }
 
-static struct device_type siox_device_type = {
+static const struct device_type siox_device_type = {
 	.groups = siox_device_groups,
 	.release = siox_device_release,
 };
@@ -676,7 +676,7 @@ static void siox_master_release(struct device *dev)
 	kfree(smaster);
 }
 
-static struct device_type siox_master_type = {
+static const struct device_type siox_master_type = {
 	.groups = siox_master_groups,
 	.release = siox_master_release,
 };

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240219-device_cleanup-siox-82890e4378d0

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


