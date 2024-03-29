Return-Path: <linux-kernel+bounces-123914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E10890FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76A7B23AEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2338825;
	Fri, 29 Mar 2024 00:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htT1WoMc"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD32594;
	Fri, 29 Mar 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711672840; cv=none; b=GOyvSGwb4apu0HNewb7eUcKQo+OcLqbsemx47YG1ATRoiFJmHqYNDXGQ31P53lNK5tu5zg2C8KPJs0fW5wy7f+rakx7BDE/jPYGDvDoyYwBwLy+zHHnUwF2PRwTc01txnQjC0QJ2KypNEn74C62KOVOesHAmDtUs9xlUlb5P09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711672840; c=relaxed/simple;
	bh=hpvJ2HBcaJFKGwVdv6opHFUHySRelIHpGSB1VcSvK2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ux/xu8+KhY0sG+0M0CWK7QmrGyTylLP0rNadvXFkJGJ8PR31Fmfdb5FR2v0TRCMeg9RYNzO13zNkZQeNHKy5Vy+KJOiSYKsIlKWTpXUIRvAvaTBgKiy5LFz232vdTrOT9LPkO4iFKlb+Co+1OmqQSygUl1p9qJZNPlIoZTm4T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htT1WoMc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1699973a12.3;
        Thu, 28 Mar 2024 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711672837; x=1712277637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUHyFmc7M4D0CgkbIGDfkYXVWM7YYXdWWeW52NOm5l0=;
        b=htT1WoMcwjDronvgIvAqyeNIw8NwjV+DYWvZCojuuoEdx5qOstdVoi679Ve5FDY9M1
         l2SnT6JFhO7StDQ15P2A9O81z5WWB7Zi7dr35TOoQUG1veifH7Kdjzxwl5W3MU4sfphT
         P2uiLSj3nF6Riuze8KS7Bwhg9QZiSbpzLqQmJ+P36Qr7yx72SAeMRBSbXhPKHJQTSieb
         qmLR1dv5hnDKS1wyQQIf5GxRs0LDdtDBZJ179U3FsngG6gcwLqkx3k+HFfNxntyX1Lal
         wZbQOSpCmF03E1jIqnduw86fvZOAwEryMGTbxAUikNW3HXqK0WI0GjlUaXqtJvjF/aTa
         g0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711672837; x=1712277637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUHyFmc7M4D0CgkbIGDfkYXVWM7YYXdWWeW52NOm5l0=;
        b=EAlc4Bnk6DEvQGHATLGshevmkEQBFyFNx1gFPY17ptU9BNm4YiuFpe6MUhmvCQLzP1
         c+mwGaWdDXyw8uSVwFRew6ckROvsqOINEJ8IhyIbKSE3r1aliBD9RGNOF7ny7jq79T+L
         +AQevSyWh9yHmoCLuIuNxHI7wTDwTzrx4HStjXi2Vg0ggxXp0pkzh1YdCHHANf3IMdXD
         SmIFPoR/sc2323knFFvEF5UqRXwohgUXKX8D3kOlVgXF40aAYXVa1zhXCaFbCkjxN6M+
         ImaiKaZkH88rG8ZkGPRAlmcnb8TNkBUsJC+JVJQ8raGTkR3LU4k0aA4aySqt0R5fzRVj
         htBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVCTt479TFIrIqqOova2M0a4TYKCqqEPoRuUcvpofsFU4DxkF4h/Kn6Cr4dDPdt1aLLfOlUo1Uq6RuX2HbgG840xWrjJ7SWw/TUIs0PA3E+2mQi/08gKumBf6sOqVJwLhiAsrkUyicSQ==
X-Gm-Message-State: AOJu0YxUxNCGJ1R4Z0cs3a/ou1/XPinlzv3nQD5B3qm75190Wu0vJ+cr
	IzFuF6YYmfXgxGDA2ifd0GS5CqH54fdX1oUzPkK86b8dah+VZKEr
X-Google-Smtp-Source: AGHT+IEWuEHY8c/53G2oXl2jlSEzZZANVCZXndGgINV/JJADa8a7169cF9Dqik2OyV2eIo41OUycFw==
X-Received: by 2002:a50:a40c:0:b0:568:be6d:e5e5 with SMTP id u12-20020a50a40c000000b00568be6de5e5mr553432edb.37.1711672836887;
        Thu, 28 Mar 2024 17:40:36 -0700 (PDT)
Received: from 13a4f82a8f12.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id h7-20020a0564020e0700b00568e3d3337bsm1391679edh.18.2024.03.28.17.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 17:40:36 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 0/7]  iio: accel: adxl345: Add spi-3wire feature
Date: Fri, 29 Mar 2024 00:40:23 +0000
Message-Id: <20240329004030.16153-1-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass a function setup() as pointer from SPI/I2C specific modules to the
core module. Implement setup() to pass the spi-3wire bus option, if
declared in the device-tree.

In the core module, then update data_format register configuration bits
instead of overwriting it. The changes allow to remove a data_range field.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
V1 -> V2: Split into spi-3wire and refactoring
V2 -> V3: Split further, focus on needed changesets
V3 -> V4: Drop "Remove single info instances";
          split "Group bus configuration" into separat
          comment patch; reorder patch set
V4 -> V5: Refrase comments; Align comments to 75; rebuild FORMAT_MASK by
          available flags; fix indention
V5 -> V6: Remove FORMAT_MASK by a local variable on call site;
          Refrase comments;
          Remove unneeded include


Lothar Rubusch (7):
  iio: accel: adxl345: Make data_range obsolete
  iio: accel: adxl345: Group bus configuration
  iio: accel: adxl345: Move defines to header
  dt-bindings: iio: accel: adxl345: Add spi-3wire
  iio: accel: adxl345: Pass function pointer to core
  iio: accel: adxl345: Add comment to probe
  iio: accel: adxl345: Add spi-3wire option

 .../bindings/iio/accel/adi,adxl345.yaml       |  2 +
 drivers/iio/accel/adxl345.h                   | 36 +++++++++-
 drivers/iio/accel/adxl345_core.c              | 72 +++++++++----------
 drivers/iio/accel/adxl345_i2c.c               |  2 +-
 drivers/iio/accel/adxl345_spi.c               | 12 +++-
 5 files changed, 84 insertions(+), 40 deletions(-)

-- 
2.25.1


