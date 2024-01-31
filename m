Return-Path: <linux-kernel+bounces-45553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03120843253
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E632899E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1615C8;
	Wed, 31 Jan 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="Gs3/kGy+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA67EB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662743; cv=none; b=GqVqlAFLlk979fhwOQuvRr9eLP/+97ol1fP8LL5SUE6zODG24Z+qSKxZILAHXu7XrNmyKSxAW2/b4R/a9Loe/K6Le4WGYRG0IC6uRjVrSj2nz11xD2w8HD3ZbvWoxcYfTZgRXvtlPjyT6Wqh3RTFMcf4t6uHfeWQ7piK1qmUPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662743; c=relaxed/simple;
	bh=QfBbzX85e6nFzmW1qFHgs2po2/nDytRsoCO0GDboz/k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QQPTT5W1j8181eLInHpF3YjTLWVU2d7Z4i8JLQd79VfJgbKKWPksrmSEyvTnXQlTU/sDikPXjZLAvq+Fa+BJa/i7nuwHnBD90RcSZPDMjJWqhn0EyhAGV5n9Cr/nDSNHov1aktzLYQ48GsLOJR5231bwQV5Ii57o9L0871Bsm1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net; spf=pass smtp.mailfrom=iwanders.net; dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b=Gs3/kGy+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ffee6e8770so54319967b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1706662740; x=1707267540; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPv2vZK/ahua8U6na2hpRBqLQcV3hwENVO3BpyQ9lBQ=;
        b=Gs3/kGy+AXFHMcUEsVkvexvsSfM0UK/whGL5+kQU/6vz6BxxBDJXYRU7H/mgq5nVuW
         vcodvH0S66fWPwiaYO7rt9E3nq5z8czRGKOrFs6Iu7MRlZMzvZelXcpeYyldSpycRwDD
         KsY1JASWUpcZOqmsY4RHm+E3/jVCTBuUnnYj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662740; x=1707267540;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPv2vZK/ahua8U6na2hpRBqLQcV3hwENVO3BpyQ9lBQ=;
        b=g6YOgRy9rC/UstObSfDKWShvnyiYT7I93DbjqQW4E+KnPDsRgs0BP/4LmLn8a3+Azj
         WtrPy3Ezp/950Y+sNZAeJchNCFLZVB46j69qaDf1Q5ADVv+ma4PRtmnXzjDk/pYJ0gZU
         6kueRPvZcrDYerHzqxLqLwf0DcLHZuONTrPN++13p0wFWSWgYKfjgub6ThX/DGk3PmQy
         xEWiKI1tvX4L08h+/7uoRLK/xMZDulLtm7fsQxKQRN1Kr+2PjPShkhQ9JOgJFjYJerkE
         A+jjvh9f9Z0MN9DixP9FQUZIgIFWKZtIDXg22msDBNfHjLwtAL8177kebvJIOOi+vuht
         6EOg==
X-Gm-Message-State: AOJu0YwAlg0YasSzJMLnVWb8km4eM9FcP8hz4kFpOI+WaJ8IlnjJteHT
	l1kzSqq4VhzWLDCy7yCcclZx9TXyBNeCLRR4tKdQFuuUYQW1MIGwLU8VrV/JNGM=
X-Google-Smtp-Source: AGHT+IEshXNzxr9glGTU0/bPOFOf7HBTxhrhxrOvMktIB6o/f6kYH3dRIKLP83IuduyykDIAbaA7fQ==
X-Received: by 2002:a81:ae04:0:b0:5fc:111d:abc2 with SMTP id m4-20020a81ae04000000b005fc111dabc2mr367ywh.49.1706662740070;
        Tue, 30 Jan 2024 16:59:00 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b006869e0eed00sm4969090qvb.26.2024.01.30.16.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 16:58:59 -0800 (PST)
From: Ivor Wanders <ivor@iwanders.net>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Ivor Wanders <ivor@iwanders.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Mark Gross <markgross@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 0/2] Surface fan monitoring driver
Date: Tue, 30 Jan 2024 19:58:54 -0500
Message-Id: <20240131005856.10180-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Fifth version of a hwmon driver to monitor the fan's rpm on Microsoft 
Surface devices, originally submitted in [1], [2], [3], v4 at [4].
Only change since v4 is rebasing on mainline kernel tree's master.

Changes in v5:
  - Rebased on mainline kernel tree's master branch.
Changes in v4:
  - Return 0 from surface_fan_hwmon_read instead of ret.
  - Use PTR_ERR_OR_ZERO in probe instead of if statement.
Changes in v3:
  - Removed type and attr checks in read and is_visible.
  - Removed assigning sdev to ssam_device drvdata.
  - Propagate return from __ssam_fan_rpm_get.
  - Renamed hwmon chip name from 'fan' to 'surface_fan'.
  - Removed unnecessary platform_device header.
Changes in v2:
  - Removed all unsupported sysfs attributes from the hwmon driver, leaving
    the fan input as the only supported attribute.

[1] https://lore.kernel.org/linux-hwmon/20231220234415.5219-1-ivor@iwanders.net/T/
[2] https://lore.kernel.org/linux-hwmon/20231228003444.5580-1-ivor@iwanders.net/T/
[3] https://lore.kernel.org/linux-hwmon/20240113183306.9566-1-ivor@iwanders.net/T/
[4] https://lore.kernel.org/linux-hwmon/20240130230654.4218-1-ivor@iwanders.net/T/

Ivor Wanders (2):
  hwmon: add fan speed monitoring driver for Surface devices
  platform/surface: aggregator_registry: add entry for fan speed

 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/surface_fan.rst           | 25 +++++
 MAINTAINERS                                   |  8 ++
 drivers/hwmon/Kconfig                         | 13 +++
 drivers/hwmon/Makefile                        |  1 +
 drivers/hwmon/surface_fan.c                   | 91 +++++++++++++++++++
 .../surface/surface_aggregator_registry.c     |  7 ++
 7 files changed, 146 insertions(+)
 create mode 100644 Documentation/hwmon/surface_fan.rst
 create mode 100644 drivers/hwmon/surface_fan.c

-- 
2.17.1


