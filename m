Return-Path: <linux-kernel+bounces-9140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D44181C135
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B0E1F252A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4FD77635;
	Thu, 21 Dec 2023 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="DRrLoZa1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B978E72
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bb7376957eso918915b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703199114; x=1703803914; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqXo/hOcM+qx4dUwhqDqLKByD8sfA5/BJTEwAur9cms=;
        b=DRrLoZa1J7r+kh+8Jswby0jwq02NNb96h4V//v2TesiURHv4WR3E64yQwgcq/Sarh3
         iwHDFYHRv9l3wYRyvBjXOgXXWVc7+EzTYwnCb2U+xISAh71AqXzIeDH8FstLk3XhyxxG
         RtYIdkCjRdP0RYgkkBLVf8Aqp/7owcaXomwtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703199114; x=1703803914;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqXo/hOcM+qx4dUwhqDqLKByD8sfA5/BJTEwAur9cms=;
        b=nloZ/Cl54xp4Qf4H0bRtDdzrywBq3JzBV+egb4kxBfK4txwzIMP/WyRXyls6WeGxre
         kkNGeuPx52vhUmWTE8LFjG+u1wusLo4C2tu3cxWfCVxLqCxu/jkcQLc/4gBHLtwJRbpU
         mVLoa3wf9eXUODvNjcyziAeh/zTTvxYOElEDABhL4bKwt5dFd7MGYskaQu7MYyaXkLqx
         zScDUGdBl4lDvS3eURU0Jkpmf6CJyx8p95f0DNG4adkuP7YX0tslVT78kcxymP3Tm67Y
         opSqemurogeMPWdcekHz2Nx4TtZ3KAmD9SI+/EIzpCiKKZa4nadKW+BttInuYM/VVIhy
         BmUw==
X-Gm-Message-State: AOJu0YyvqOstXkn44Qxqpc4ycYye7Ua1xHhfQE3HQJD6Yx5p2ggjcYe+
	fu8uYEYTuthFhR2l/jju8vyagvqQb4tWlQ==
X-Google-Smtp-Source: AGHT+IHnAzzZRn/dA0BuVaCYR1hvqJdOIFrlaKhJX+g+dRc5gK1nXkGsJohHmECy/noeaAAYmP44UQ==
X-Received: by 2002:a05:6808:3985:b0:3b9:e8d0:6df5 with SMTP id gq5-20020a056808398500b003b9e8d06df5mr602024oib.23.1703199114242;
        Thu, 21 Dec 2023 14:51:54 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id a15-20020a0cefcf000000b0067f812c4a58sm782733qvt.60.2023.12.21.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 14:51:53 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Ivor Wanders <ivor@iwanders.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 0/1] clarify intent of fan min and max attributes
Date: Thu, 21 Dec 2023 17:51:48 -0500
Message-Id: <20231221225149.11295-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In [1] I got the feedback that fan min and max attributes are intended for
writing to the device and not merely providing constants to userspace.
This patch clarifies this intent in the documentation such that future
contributers don't make incorrect assumptions about them.

[1]: https://lore.kernel.org/linux-hwmon/ab8a1ff3-6d01-4331-ba5d-d677d1ad80b5@roeck-us.net/

Ivor Wanders (1):
  hwmon: clarify intent of fan min/max

 Documentation/hwmon/submitting-patches.rst |  4 +++-
 Documentation/hwmon/sysfs-interface.rst    | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.17.1


