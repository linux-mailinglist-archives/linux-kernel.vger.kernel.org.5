Return-Path: <linux-kernel+bounces-58608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E284E8CF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D6D1F3005E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD7037157;
	Thu,  8 Feb 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="EVZrxks5"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4836B0E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419848; cv=none; b=SXyBCKeCe1tbvlPwks/Y5TRhVDn4bbP5iw8F1FXhjE5P83P8ubClvMLa/VMtTuQBsKwU6jBZQz5GSLsqxcxeMYqYEoAdURxeh2GUjpSv1pzYCB/yc9RaEkvne+sb2K2/ncJ49e8P9DTWP2kbjYN1IJVGSiAsKuvn/69wn3fpCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419848; c=relaxed/simple;
	bh=9cNNhlkh8Qz2Cmmyb82krEPKz/SNHddqSojZKEbTrIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uf2xLy+ACQBoWbFxXhe2iUFSewy0foEezxyEv2YjkEacKjzj60zn0bPqWSU14CoyzZBywR8y0/+iz5rts+o2R4HmwVZ/pV8Qvk9X4PRL7t4spWLWjEsoze2NQc/nGsqUWjWvsBTB+csHdiuhPMHv52k732DbYvfBHlEDQYgCQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=EVZrxks5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so193246b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707419846; x=1708024646;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sreg/nLMHjq+iQy8A5DInSHIYJrri4bRObJLJzGOHm8=;
        b=K7bWTyrbtMsF18rokLBMFae4kldzl/HfCatsmDd6TpZGLKhuvGIinrQyS2QmGi8rNa
         shr++Ukl9HnXv3PQgJdhqk8BofqH5wC+uBXpuWlP9t8sCKIFyANmCucat0TIYOWlV1Cd
         lgzEFV92iwSA/37pLVrnF/fSVE3cMngzZfnIHkNE43VugoXYt3yRqGgeQtUnvBeTE5Qv
         HxzvltDWRaeUREM5mGDEJB5ZZBSI3G4txLmOMN5MXGenS5CpBglFiardwJh5x+zd+bn+
         VD+gNY9eiTaHNL6348HgWq07qbaKGfgC36i1u46G5skUCKdIXSSoiokBa5o3huRntyWR
         knSg==
X-Forwarded-Encrypted: i=1; AJvYcCVlqpEm0ddpIO1dtwtdNKqmWWvzgj+tYq/x4S320ZnOfdMo8xcVarEkTwNT2o2zvHsk8L+VYOM3WYK25zkcF5SebUwcrcw/82DXUKSW
X-Gm-Message-State: AOJu0YznYewpG9J21ON1Xg2fT3wxHVOQNdFvqWs3eH8Y7KuFdbOmlApM
	33MLuZDkY99d9Wy8YDjGmkFQVpoIFuRYCgKdzGGDky71ZzD2CuRR6X8ucOLcBAhf+w==
X-Google-Smtp-Source: AGHT+IFAZc4PZltUqL0FnqQ/LlmQm/h47cW7se6PRIqYHEYfRe0NMJ53amNgXdvAl2sxtU5H299UMw==
X-Received: by 2002:a05:6a21:3409:b0:19e:986d:7a6a with SMTP id yn9-20020a056a21340900b0019e986d7a6amr473014pzb.7.1707419845971;
        Thu, 08 Feb 2024 11:17:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWw1LvNt5maBy7bJyCukB1p0DCZEK5YiXYWUVQ4UIONJ36yLJG/slxxmXpRmWVSg2Q9jxDHi265QdALR+EC0wcThl6+2m+yPujF+BHJpw88ikaA19NOQ7PYguSJ9ydolzx11Pz4PnyneAy8g5wKD25QLS2B5QtIWw3FF+U+fz6nCR4BrFAT5FcOby4HtfFSgLoF85EiklqvJU9b0FshrUNUXnASVBURdfvJMjltP8s8WLE4Ew3qfNNIWrTmq1tpdCW6m3vaiHUwEDgLpw6mxBAPOSHfUw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n50-20020a056a000d7200b006e0503f467bsm98003pfv.39.2024.02.08.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:17:25 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707419843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Sreg/nLMHjq+iQy8A5DInSHIYJrri4bRObJLJzGOHm8=;
	b=EVZrxks5I47CVRDMg84D5SQASNnFBGLFAgxv8Mzb/luMjH9MC3wxcGG0LjZBNHqPP8u0oe
	P4KfUqMXFvbou/VUX1DW4Uk4Mgo83fMtTfbc922wDJ9xptlaJPW/oTJBlLFBPSWWLdfYY/
	6nFfaSoviHF8R8UGrOE1asQAowbdbThlceXdVuh5HajDR4gf5bnbc3WkkolrRjw/9pbKID
	LBxyvFegZzp0ftqfh1QX9dbf6Daa/mHZ+YqS1HJV8qilqEECL7n4oDcE1F65Ognrc6vnOb
	xo1asbEYx7TdXmr1ToG9tVY88n46pUVBVAAnIjEeZMFwVYScXKyaCLcfuK4Jzw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] staging: struct bus_type cleanup
Date: Thu, 08 Feb 2024 16:17:50 -0300
Message-Id: <20240208-bus_cleanup-staging2-v1-0-cfe906133a2c@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN8oxWUC/x3MQQqAIBBA0avErBMmidCuEhGWkw2EhVMRRHdPW
 r7F/w8IJSaBtngg0cXCW8yoygKmxcVAin02aNQ1ajRqPGWYVnLx3JUcLnAMWnljsRnRzpVHyOm
 eaOb733b9+34idUN5ZgAAAA==
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=9cNNhlkh8Qz2Cmmyb82krEPKz/SNHddqSojZKEbTrIA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxSjk0lUI+Szg7cK31L67bGEkflVZVQjlODBBm
 jxpGp4y/HiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcUo5AAKCRDJC4p8Y4ZY
 psCjD/40tiSMChC32uLtdr/zyTwVOGHSFCv1BqsR/L6+a5XucBwWL5yS80w1qFvytoiDAboatus
 us2yXTgwo5QewkZgYXVuXewzuj9CkJL5I0KdN6Y5k12VVtlTodX44I00j3d+xxLGtQjrRtfemtC
 RyYmU28Gz9lKgIe76JkeKFtPOIl+2hpujrNkqq9t3SqujwI3i2qZkqb13ESZ/h+7pYXhP/so2dG
 wEpNHlydggdQK8rMpGjLh/n4isgfH/R/CS5B5dbF8gH8DBaBDr+8gvtXNFL/QIHUWVrVkpyKMTl
 DapfHSdwdiIrb8CzSGeukW1JnyuB1vz87o+86hZlb2KXniNxTJ+cP0EyAIraK/noSKbJSqvDBHK
 ncrWtHhcuajzQ/VzCCW2NyFlFO+UL5dXWKqYS+k46UUDYfiu3B+Oor3Wt0jXeu6Pj3jV9BvWSF9
 dDKKw5feWN29tHTc2H1w2YQ1jvazOLAevsNJO8rn19esXCjhxFVukd6KzIKR+fLQZsqhvjEPt6Q
 3Lk7ElqxWbZCcU+OzyfmKINPa0vYDzasVCpux9iM4cHj3R2qnBex+Cs0V3zCh7wFn38DLUu0leM
 X/cEn0ng7w1vobGuF8MN88iAdFN7Ek6N+chjHRPh4vYJPmCf8HbrvT9pYbhVyXdSZut8kQVti9B
 5OfJqD/pMPXIRUA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core.

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (2):
      staging: vc04_services: vchiq_arm: make vchiq_bus_type const
      staging: vme: make vme_bus_type const

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h | 2 +-
 drivers/staging/vme_user/vme.c                                | 2 +-
 drivers/staging/vme_user/vme.h                                | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: ce54e9342124ededf0a00ed4e8a8aee535bfbf00
change-id: 20240208-bus_cleanup-staging2-d8906b09f1d0

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


