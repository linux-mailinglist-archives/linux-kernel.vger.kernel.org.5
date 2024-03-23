Return-Path: <linux-kernel+bounces-112513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69290887B10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EF21F215E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335D5B699;
	Sat, 23 Mar 2024 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mB3GqoRB"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468785CB5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235602; cv=none; b=S5u3TEH4ffSYz6y0C2V6xU1QX1iANlbUlsrhWv9G2vPEAvpqDKTLsm51onJfJbrE+3fOJoEEGDGWR2uSg542wqM1ttn1pBYmZDK7NVl1ICkdZUaIh/TGnVwM2w48qCapkyWn4Bz+G2as+o0YzHmUDrh8IxipC40eI9NlbS2rJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235602; c=relaxed/simple;
	bh=ZPC6ktX2TCrg59RaXz0iIzaoH8xhxfDs8I7d0Jgi3uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwX0oXG8DqOXksM4alYPWmK85NMAIdJ7CN4Ljx78jp2X/IYc/95aVNpX5C1aApcN7YmQpU5oz4YXzq+A/haCsq0wnDYQ241MmHK4mEpYcBsh+2QkaqLt6efmNTgTdr/2GXBtVPkrcdy+/7/DjVIsxTRL2uKUv+ptedtsXgHHcMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mB3GqoRB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so4243055a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711235599; x=1711840399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrvorSrj3R5tK1f69H+evaaHvKOK8nrgbhXtF6WO724=;
        b=mB3GqoRBYTPaRTc10uZYQT8SP45W0RQXW1+1CGKRk+iLJLfslPIRaD+yxyUTCxfd/H
         ngd165CKc31VyuJf2XpNPxh0hw8B31RWgTTtoz/ORraeLu4ggb91nVBv7u7L7J3o9rnB
         NKqVnLT3WVHfCUpzDGI2Um9ZprEVoN9CXbSVDwxqzTeb9K2s5FydXIWIb6fXHWWXKk5E
         9xIkzn5biHFX8FphrUKu//J2ZBcX/d9Cj/Orac1rRIeiA9rjBv900cQyovF1VduIEvTk
         dzx8abaaxhAP/RsJjsfvPXoojmPpR/q3PJiv5aKD7UetUb/zKf+rI5wC7//tO6BnP78B
         PNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711235599; x=1711840399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrvorSrj3R5tK1f69H+evaaHvKOK8nrgbhXtF6WO724=;
        b=UwOvPv9eu8SsEAuFci7BiFE53P63dnkI9bjypVNuDkPKksgFnhSstrDvBqwRhx64jB
         fbyue+ZF57j4s5QbvPuTHsKIOb3X/QF3eK47L9aOCmpUK6F6QyqNf/8mhW5eKizWzZLi
         TB2bk02MwxMLpLkkm1fTK5QG8GPQ8bjA1Qk4BfXKLdS05wToEXBjy4ifSJC77cBFu0DX
         +WDcM2PlK72nAJJ7A/ErFg/MesMQ1fTJWt0g2G8H8M3Thfa4/NXkt3RvKvoBccSaE+Jv
         y0KDZza9cxYNkYM2XGnkxalxsWOniQogYt4l+g+BUktUXffYpzEsL4wcx1v9gI7nBjIf
         q8lA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ/0TCNkzjDew8fEC3WEVnASqF18ylvpnyl3byBk7JbPMX4MDNMShZMZibpTZgwSva6EE4tCG9TBHpDJcYlglRWrPG38jL2qXF4Wal
X-Gm-Message-State: AOJu0YzqFqorcQ2GxdvjpNX5CgH12QU2E9ZKIX9HOE5iO2NGnTDp4nOU
	8+ekKI9W50nWDtk/u2l8x1z9izNqxJfxB5wGsXRRJhfW8L8gMl7b
X-Google-Smtp-Source: AGHT+IH+AojyL9v3CgNuAW307hxoTEiHQ1ED/2Gfk0FRPouGHy9fr+IiL2v5goSA+sKwaMRelHoSqA==
X-Received: by 2002:a17:906:1416:b0:a46:b76d:dc30 with SMTP id p22-20020a170906141600b00a46b76ddc30mr2106551ejc.44.1711235599307;
        Sat, 23 Mar 2024 16:13:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c22-6fc3-1a00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:6fc3:1a00::e63])
        by smtp.googlemail.com with ESMTPSA id h10-20020a170906590a00b00a46196a7faesm1375116ejq.57.2024.03.23.16.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 16:13:18 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gnstark@salutedevices.com,
	neil.armstrong@linaro.org,
	lars@metafoo.de,
	jic23@kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/3] iio: adc: meson: a few improvements
Date: Sun, 24 Mar 2024 00:13:06 +0100
Message-ID: <20240323231309.415425-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains three improvements to the meson SAR ADC driver.
None of them are meant to change the existing behavior. The goal is
to make the driver code easier to read and understand.


Martin Blumenstingl (3):
  iio: adc: meson: fix voltage reference selection field name typo
  iio: adc: meson: consistently use bool/enum in struct
    meson_sar_adc_param
  iio: adc: meson: simplify MESON_SAR_ADC_REG11 register access

 drivers/iio/adc/meson_saradc.c | 78 ++++++++++++++++------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

-- 
2.44.0


