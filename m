Return-Path: <linux-kernel+bounces-7644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3F81AB2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F46D282FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9C4B143;
	Wed, 20 Dec 2023 23:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iwanders.net header.i=@iwanders.net header.b="G4yaldpv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444E487B4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iwanders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iwanders.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7811548d0b7so8797385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iwanders.net; s=google; t=1703115868; x=1703720668; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujwXnb/57SrShdbFiFg1ZNindUc/Du0wOxKx0/yrEAo=;
        b=G4yaldpv7JATsIFkuWh8NtNsFj/l31VoO0tfWqL6FJB54bFBQu/TLs/ndTVElcwnVg
         XoVenSjzLendHWIhVUEt7KJVyIBVdKO8fCgEYqlaRe7e0sS6rVL6unhhSLqpTkhNYbVM
         qt00Rws23MWUjQEyP013cijuWP9q1pVU1R8Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115868; x=1703720668;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujwXnb/57SrShdbFiFg1ZNindUc/Du0wOxKx0/yrEAo=;
        b=FOZ+0IZ+fY4Q5oJPcXwyUJIRU+FRVyid7Citg+8eVE8nQ9Piu4c8mw/B+IlCbU19Mh
         eN45kUqsUSbVAhlcEhIyeIw2A31XpdqFLPSL4b0xr3UhO0uomzIlrRekGiDJGFoeEAlC
         SWG680u4zs0Mlu2AmTDTY8StRhQ6yp97yvQQ5xKeidNG69aPW9QKkWYnCbiekaYJspbs
         Sm7prgwFUPQ7s1+IgXusPrKfsTUhYZvcRUJP8QqhJK06IWwC3SuiFGcplYZJO/qJzd8a
         jnxH3inGd11mt6bk/f4usxPOxEk+zY+r8oLGXiyz/hggH9H58lDEmuCWwZy4ZwCL9JZO
         6RcQ==
X-Gm-Message-State: AOJu0YxwMHRMv5DrIFAnUruGF/97PGYtPaRpCztDJEcDBRX8SWqaXJql
	m581SxTDPIUx058RGgUTe8zrHg==
X-Google-Smtp-Source: AGHT+IEwsd//PAEBVv5GwsrPY7oyDghqDlu+Q6mS9iIdom5t8bH14OgzkaVJ4k9xOq01CZZ+HZwa+w==
X-Received: by 2002:a05:620a:27c9:b0:77f:38f3:3d4a with SMTP id i9-20020a05620a27c900b0077f38f33d4amr22092324qkp.25.1703115868166;
        Wed, 20 Dec 2023 15:44:28 -0800 (PST)
Received: from eagle.lan (24-246-30-234.cable.teksavvy.com. [24.246.30.234])
        by smtp.gmail.com with ESMTPSA id qj6-20020a05620a880600b0077f1645282csm276742qkn.22.2023.12.20.15.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:44:26 -0800 (PST)
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
Subject: [PATCH 0/2] Surface fan monitoring driver
Date: Wed, 20 Dec 2023 18:44:13 -0500
Message-Id: <20231220234415.5219-1-ivor@iwanders.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently, there is no way to obtain the fan's current speed on Microsoft
Surface Series devices, this patch series adds a new module that provides
read-only access to the fan's current speed through the hwmon system.

This new module relies on the Surface System Aggregator Module which is the
system responsible for communication with the EC on these devices. The
first commit adds an entry into the SSAM registry for the fan's speed
functionality (for the Surface Pro 9), the second commit adds the new
module and documentation. Both patches can be applied independently of each
other. Tested on a Microsoft Surface Pro 9.

A full development log can be found on [1]. Fan control is always handled
by the EC and cannot be influenced directly. It was identified during the
development of this module that there are fan profiles between which can be
switched. I'm currently developing improvements to the Surface platform
profile module in [2] that will be submitted in the future.


[1]: https://github.com/linux-surface/kernel/pull/144
[2]: https://github.com/linux-surface/kernel/pull/145

Ivor Wanders (2):
  hwmon: add fan speed monitoring driver for Surface devices
  platform/surface: aggregator_registry: add entry for fan speed

 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/surface_fan.rst           |  27 ++++
 MAINTAINERS                                   |   8 ++
 drivers/hwmon/Kconfig                         |  13 ++
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/surface_fan.c                   | 125 ++++++++++++++++++
 .../surface/surface_aggregator_registry.c     |   7 +
 7 files changed, 182 insertions(+)
 create mode 100644 Documentation/hwmon/surface_fan.rst
 create mode 100644 drivers/hwmon/surface_fan.c

-- 
2.17.1


