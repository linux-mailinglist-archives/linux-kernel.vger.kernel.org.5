Return-Path: <linux-kernel+bounces-63689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B6F85334D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2AA5B242CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5BA1DFEF;
	Tue, 13 Feb 2024 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="bhA7Te6Z"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0775EE84
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835015; cv=none; b=Br5hX7T03QzCGFcGWZa1a+9CkiRUdzXcpcRV/48y/ij+Hxoy6yTTVVA6ifaYsNWs5a4GlYlnmfRsLqVypLsIrODBpGX3a3ME/baJnQs7arSDu8jEHi3zn10Ak2hCikUxvppM1Ss3aCT9MzxZYOxho6YfLCPGyd0FaqYJhO17xPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835015; c=relaxed/simple;
	bh=qnLjOeE5EE3Lqs84+4tWRYfNsexjdBi5vWoPyHGPIkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=neOWdEfK3jD14dIK3CugswZ6tVOBUnVYvIL4IdS+j44wdc/9qqq7BLWlaRl+cUnZbFrQND9I89U5R/JfWAkqFuPuXjtNLMpWOlopAbxWn9r9Y/H/pyuoa8Nrfd8w0ZkYrtUUiJ7qTGdek4TnHXZw+ugbgI6eOx0Lnyg5T+pTsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=bhA7Te6Z; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da202aa138so2939241b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835013; x=1708439813;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0wnZ9JRYyJ2vvbs1vhTSiq4Aq4+1sUBV6iHNV7yNP8=;
        b=Y+FBDp/gTtR5DzDyX1giGNcMIqHj7WIBpZOZgts5DvDJ0HKtjWEIsjPlPOYalrLHa1
         +ldaRt5QPKjX0d3EdhIis4AjkDiTB6ruHmc96aB3WiyrIkLDoMz6VAwg76/WdsXzCgl2
         BhV1UlIAOmDC3N6bNi/X6IVH9q/2/5XRoybrVP4S036xXu/UkrJdtdw9GiBWovHCp/3Z
         qfWwqYndMhGnFSevGDJYP3S2QU3VAZj3KapjjFEejGJ3XUaFtyC0NNuxBrZrigkDv9RR
         i0lpS3hEUc4/ccq4a4X1IwX68Ke6AJkwOp97qPhnq+xGUMSqplUN757Ae3YTTAPiEDTf
         x3ig==
X-Forwarded-Encrypted: i=1; AJvYcCWdcTOrJltHUKiUFy/WeG6tKQkazRqG1HQmy4FEfmCC3W0smI5vzlFoIGQnXvq/d0otyDU092BAhqgijfxfjMD80Vs1JLXtKNpus+xC
X-Gm-Message-State: AOJu0YxrlEuvmz0a5bjSlhEBqkIIxM9DXx3UdeNzuk5ev60pIUr/B8LQ
	isgvQU1XIn144js1Riv3p40DYNDUSDpCaXuLJhPwFSDVPceIMTUU
X-Google-Smtp-Source: AGHT+IEIAiPMz+QXKPIvwneVLCpGXIEShPSKQb+GU+qdsUYAQJmScKs20T+5qMlf1aFBjHrnkCO8iw==
X-Received: by 2002:a05:6a00:3020:b0:6e0:e235:e2c1 with SMTP id ay32-20020a056a00302000b006e0e235e2c1mr7458029pfb.9.1707835013104;
        Tue, 13 Feb 2024 06:36:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUsRv1NVAfXp6dXcm0Z7JFKzD36zhj1aaSZGgPkNjH9XPzxuhL17kH+uM1XQI6Mfn+EUvCd0e85IN2tYb6ooVMJgyV7HdWu5AtEGawZ0fZ4//oUlc70TzoPyjfLkGEFF0b/PHXcPJC9FQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b006e07eb192cfsm7533162pfk.59.2024.02.13.06.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:36:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l0wnZ9JRYyJ2vvbs1vhTSiq4Aq4+1sUBV6iHNV7yNP8=;
	b=bhA7Te6ZycbAnm8sfVIGe6pf0rq9sRN+PYoMSjfwfkbpbSd5ugcJtqr+qEUbjKV6Q17/2B
	rs8u7oMF8XhYb6MHVm1ewYov77aiRckLg9W9f8iFCkhbfXN6fRO3OBDguIwFZTfu3p1HnH
	WGKxMLyLpLFcnGJMNp0KALboNcKFow3aSymhPuj4LY8cMlpBFcQd2X4NKx9zsOMGgHXVbz
	WUdZNqBGu7xgVtnOenprOufwmUW51DJIbbvTZV9MawzdDLK2v0YKhU9C0bGWu4Z1wKapBC
	OX6J+JXMxtRCIsHaVWdA371V7J5zhTgoe/Q545yZTmHBI54D2qG0LFY87+F+RA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:37:31 -0300
Subject: [PATCH] i3c: Make i3c_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-i3c-v1-1-403aea18f05a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKp+y2UC/x3MQQqAIBBA0avErBN0rBZdJSImG2sgLJQiCO+et
 HyL/19IHIUT9NULkW9JcoQCU1fgNgorK1mKATU2Go1V85UmtzOF61RinfKmpY6Q2WqCUp2RvTz
 /cRhz/gB/30sAYQAAAA==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=qnLjOeE5EE3Lqs84+4tWRYfNsexjdBi5vWoPyHGPIkA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly36rVzr28ScrwvTN7Qgo3Ys2KcnZHjq5gY6Vq
 C2lYuw3lZaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZct+qwAKCRDJC4p8Y4ZY
 pkeLD/9kOBrumHvtXooKwiRt36JtznjD7rUTdTDHMbPTMPL8fjWxBNkmYGrNYeWJJh3+cTo8i00
 malNFpdJj1/EXXmUUTG/rOC2o+WwHzlkxegov9nMTEbXjsf3lMkvrd9k4K2Qr9dy9ZTgsB/Wsr/
 m60fgPmjJcp2Lc6nLii9I+EZpvxTIKBk1Kwhvyccma2OMS1owrX1BZZQITHJAUXqkDBz0Frc36Z
 nAfwCE6keFFAl/z6lddXRHm+OKahTSgbePBXfpFFCqahqSPkFEM8kCEbyt51lHGHVe7SDgBj3zs
 HgR0D39qxiucQqIsx+hYz14eqNXnIIe4eiwLI1pHqNBy2Awd27nnljCqsspCaV6KyTtfoSKpsMc
 orGXJRhSzdEfWrTOwGbUSj54vaAHIvnPSwXz858h2/t3l58G90lAmqvvVn0u3sbMh3i6Xu7r0k+
 itoftJ6uG3UMj8MFqu/hovDRCsk6OrfJDeg5LwIO/on8E6qO8p+UFQjhFFSH6Tp8WZ5HGK/ynMR
 6CZpbjsJSPGd1frFykN5DGv4jp8hn8STquj2AR8tTmfPDbXXFmLVbLlc5Jqu/VoAqSvyzdQocNO
 D4PbkTRjFymgKFOOAPqcJ2vQjTnCvpIgzhUI32RtgBqCVfsZ5i20ceLJf9uzslQymJ2LfhlQ7OJ
 mVaTLstzRbFcbAw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the i3c_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/i3c/internals.h | 2 +-
 drivers/i3c/master.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 908a807badaf..4d99a3524171 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -10,7 +10,7 @@
 
 #include <linux/i3c/master.h>
 
-extern struct bus_type i3c_bus_type;
+extern const struct bus_type i3c_bus_type;
 
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 3afa530c5e32..f32c591ae325 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -335,7 +335,7 @@ static void i3c_device_remove(struct device *dev)
 	i3c_device_free_ibi(i3cdev);
 }
 
-struct bus_type i3c_bus_type = {
+const struct bus_type i3c_bus_type = {
 	.name = "i3c",
 	.match = i3c_device_match,
 	.probe = i3c_device_probe,

---
base-commit: 4fa0888f6f3e6a67cac5afafb23e33f8222cfdd0
change-id: 20240213-bus_cleanup-i3c-f15a6a2ee30a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


