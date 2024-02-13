Return-Path: <linux-kernel+bounces-63694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67785335A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB591F22B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986757890;
	Tue, 13 Feb 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="o4iwT3yz"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45321DFD1
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835252; cv=none; b=Jv02kBqZ8ZQLnFCPcNVu4bELwV2m0o/vIF3svbBiE6p6/xQoOjEKESRCIW5bJLj/lj+blMJrlIaDhE1Re2hx3H1THcK6E5tF0T7BM5I4yrBGVUOzAXp4rh20keU1dgagl9QCy2gEqAqcJ8RlfOzYIxWQH/VTJzdezRo74UiaMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835252; c=relaxed/simple;
	bh=9wr1dY/KF1EMO7RfHDenVXuKa3LL028Ys5gjvGlxZg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e+aBuCgRbKmE+mYCsWq3st+VwBf7oYr/0UGwV50dWIf64DNF+9iCh5Fa1ELT4i3APr6CnK7zJeZirpvGouvKOf0wA1YaocIy07JItNVQV1jMRZC+mMDZoW7GlKIcvNmXmKSgtoqsCQUegUkUv+BkuM5kMdcKNcjyoqJuwPkHUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=o4iwT3yz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso35509565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835250; x=1708440050;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGhFLWDt9P653uYYjvnNppxSBgBEq+mV75IitCasdPI=;
        b=A/B9N4Sfrv6s85n4sZrf5Caq6t//5dMl9MLiDG939UkYbaqaaOaaruuRfyzbzxFh1C
         OWzvO1/hDDjBrxTl1Xypy8Rdfd9LcfCNvk5DTRdpsj+HwkVKnBpRI3iaUsSvlgqly/hQ
         rhD4X/5AarSUT58sDH1UObwrf1ULzz5O+Y/0B4EU3/MIP/yfmemqfzpWShcWa9rDY2dk
         /uQOwWaPBCddAa5wGCho83G5a1Jq5tgBjrjPGtqxKXwHoFxE/K/tGEX4+2W+JAWgAMaj
         5eoV2qmsGaNdbWzL6N9YiQYdhLhlb/15d4L6Grl1tKl+vh29cknHCx1957hgITI/oneD
         dfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOgxXPcFT518CO8uysTLpzIKwswlXH8uDPW7YCzAX7STL2wklh6kS3b3A2WlJJ+QySCVhoTUgfL6pJeAKkJ8LY/QgzSzHt7ETExNN4
X-Gm-Message-State: AOJu0YypANqZruGEmxDkMk3ELe5Lb8LrfIFuGEKHuOUr9O0vMnFWS9k4
	CghNoaaHzjIXLsjIwtX0tP0GOXNu9MkkejUL3ZzFkVGFibk2E+mnaYQeGrZGciPSWQ==
X-Google-Smtp-Source: AGHT+IEvi+fP04X+P68cjc0JGIFEo5a6eZF1WWuTxWEnQ6bOrr7K/2nd2I4krYUBelnamXggzk27Dg==
X-Received: by 2002:a17:902:e88b:b0:1db:4f20:3ada with SMTP id w11-20020a170902e88b00b001db4f203adamr197322plg.49.1707835250132;
        Tue, 13 Feb 2024 06:40:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/iQDkEygH1QiPaJNqM5Mh4Ch0FQ1C2CBoIYZfnHNEaB3gmkyqb4QOl7PWDuSWnGQVe/PNnmv7SWBq/HgQZZrG/QkPO02xqxvCkFF2CC/6W3vD4EatO5zaT/F8qxZX95PJOMZhsssfpQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lg7-20020a170902fb8700b001da2f9c6e01sm2184362plb.136.2024.02.13.06.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:40:49 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jGhFLWDt9P653uYYjvnNppxSBgBEq+mV75IitCasdPI=;
	b=o4iwT3yzbXd+mkE6O8JXRIR6hZypZ5x0Af8gQoXyk8CpM8h3c1QhafSWMhLW+05Jvd9FGU
	KL+r1ul8SFgcWyWxdUDwatHqF2C5TM2hCuiM98vJqeG+65670NsUeRVwJod4g5Equ3Qije
	2GaqA46njbxtMqBZuAfc1xZOyp8VtmhgOhmox6IzXWy+s/DuyGtPGt6YLwyWvl9/Hwg1/l
	/2LLYpfq8Pmk1bFUmhbzJaDxqy7lgoFcU5WfciROJmLU7gf/aK6oA33SHJ3HGVVXL8aKtx
	RRuE1zfzQuGsozU9YSIdmrkKA1pZ0XKFwySJVE5bbIUnUbus+4i+86d/h/wUxA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:41:25 -0300
Subject: [PATCH] zorro: make zorro_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-zorro-v1-1-388ceed8e7bd@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJR/y2UC/x3MQQqAIBBA0avErBNyalFdJSIypxoIjZEiEu+et
 HyL/yMEEqYAfRFB6ObA3mXosoBln91Gim02YIVNhbpW5grTctDsrlO9XsSrDlvTGY22bizk7hR
 a+fmfw5jSBzfawDBjAAAA
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=9wr1dY/KF1EMO7RfHDenVXuKa3LL028Ys5gjvGlxZg0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly3+YZ+6itBtgGcn+ayT7cPIzI1TiuPy0D93qw
 weRl+tqvVCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZct/mAAKCRDJC4p8Y4ZY
 pkoeD/9IAMZO1Vf9XjA42IyUi3c8QxczV+6rzkVQn9gAeKXXfOgAOgumyDNFL9cPF26/1d+WMHD
 mzPsQfzYxXJSCZbaX/2m7bIqPyG5SIKzU5ZIK/eVGEBAMFt1dL6LGw21LLAr20f+uqi6IxHmu1o
 n/pop2FrTnxSSTMDh+SpeAfwBRgkZyRkabt09pNu+3j9aUb15P+e/Omo2fFX7PLKYrZDlu4GNU6
 hseq0IOJepl3PWj4iFY9jZ8cj0W3odlgek/dPG6uqHg1FwXFtEM9irUWcAVKrh/sNMbPbtyp7jX
 NDP8v1chhtvj7/qowqOXli+/rRV/GjrYjGpxRzAKDrjencVEuL+E50io055BbUR0V+RxYLq1Cu1
 PbrxS2RGc9UA9kZXI+EmbH/7qWtjj8t+A6CKWoJzSK1yGgaDRONBwGPaSfTsC4zAwf+2zDxfJRi
 1Wmkgt7sREOS/WWhxyjG8bbqiu/vvXBGQss8FMvKM6GAcwe6xM7ocvTgc8zm4/aLhePaV0ADtCV
 seCWQCVAdZkd18yXhjFl/vJjmpY6sxptmFrUvgvC0hsoVHitixcpW/CjomFWMd+RYc13SidhqL/
 WdSkA+Xt7ALsFswiYzVX1bwC4nXmqf0LyyNYWayZQOVmpVVIXdP5UPwNMvPxgVQnfjbTTh+7lwq
 DJbHkcBXMuSdDhQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the zorro_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/zorro/zorro-driver.c | 2 +-
 drivers/zorro/zorro.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/zorro/zorro-driver.c b/drivers/zorro/zorro-driver.c
index 025edfccedcf..f49d19977e82 100644
--- a/drivers/zorro/zorro-driver.c
+++ b/drivers/zorro/zorro-driver.c
@@ -150,7 +150,7 @@ static int zorro_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct bus_type zorro_bus_type = {
+const struct bus_type zorro_bus_type = {
 	.name		= "zorro",
 	.dev_name	= "zorro",
 	.dev_groups	= zorro_device_attribute_groups,
diff --git a/drivers/zorro/zorro.h b/drivers/zorro/zorro.h
index f84df9fb4c20..df44e35203fd 100644
--- a/drivers/zorro/zorro.h
+++ b/drivers/zorro/zorro.h
@@ -4,7 +4,7 @@
      *  Zorro bus
      */
 
-extern struct bus_type zorro_bus_type;
+extern const struct bus_type zorro_bus_type;
 
 
 #ifdef CONFIG_ZORRO_NAMES

---
base-commit: 6b9c045b0602cf64b33ea6da5e6aa6f81dd47ae8
change-id: 20240213-bus_cleanup-zorro-928b9b12d34d

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


