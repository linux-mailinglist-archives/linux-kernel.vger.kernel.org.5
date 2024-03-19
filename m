Return-Path: <linux-kernel+bounces-108023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF6D8804EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD75B242E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2612F39851;
	Tue, 19 Mar 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYipdIwP"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1A37153
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873262; cv=none; b=rmDHmv78MVF9dr8xHDHhFJPYNJFjzejBM0lgo9EjfoToZwZVvqq6jWPGuQkGHNDKc3RKN8f4/kOVNwEbfHvRzbSe6c5Wac2P2AepGx4E2JGk7G1xyKR/6sib0nl8hfT54VbxwDmydr4SnGcxrjtYtPfmDjcL8LXMCbdZZIJHsdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873262; c=relaxed/simple;
	bh=AOCZORgoJ7C9jn0a7E4jO0nFuKKTYWjWvdGanNlW3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QET5hueQw7tFtliyeYbxZgANqHgpA5CW0KXBuSnVRIJ+8HnJ16+e4S8CeXEIwnzUuTU4bpY55V83dx666pScNUSDGKMAoR2JWFJS0pP48ZOqxefV2g238fy48YXKaH0KqFeFnnWvYgqsrrYp6Zpv39pCIHt+txD1Fcg46WdKjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mYipdIwP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e695470280so1224123a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710873258; x=1711478058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMCunOrrvuHT9lUNidkuFxv/99o3JWCs+pUE4M3Ym4A=;
        b=mYipdIwPpAa9tBYwg63/NVXe+W6tmcJ6K683elpwfcPr+7S6vjLTBgAWSKY3FuEnJc
         Si69YF7qcknnU32jUEWHfOIBe76gaGArD2dw7aIOe0Ce4kEzNfdvfvppsVzN6UVF2KHD
         mhz0pQLSfDhPzCNnBkGSC1qQZAQS5VEUHCwtn+rmiODYhNr5bqwjRA8Ko8DCI8JT20b9
         qd+KREt1I4M3ezszJ0HSCnscnXycVYB9GbKjlnmmRorijaeailI1wvU9AQv0t7/ldWSO
         IJP4XGX9MUYUkPULy/Z2y2fV4g6x73zVUsdS3E27Dyndd/V1/OmaxN5G4wjqFxXkwGEu
         ZhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710873258; x=1711478058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMCunOrrvuHT9lUNidkuFxv/99o3JWCs+pUE4M3Ym4A=;
        b=gpzC8iTsSZfMLlQltwUFmk2uuJxCEfL34NbjUJN066ZQZjJUBTEug4zsxH4paIwZ+O
         plz5nkuVx5MK47p1BZaMbApxMHnwhwG4tynYRChp424kiRD4GdQHJdhwNUG5Vnaqp9vD
         NP+q0PWr+HK3h/beA4HWg/Xv13u59irb5bF1j8rwaTJvjaEGwhJNptm2PZ/ijRCzXjM/
         GPBljfqrZRi57OcczLttp2s/+zduAAJ+H7I+UHQf+tbXyfkK3Ro2czvULh7HriiS/Zqw
         riiKHY8bbUFHwWmJmUShQjAHz/BOJIom4IYjiTzmLUJpfHMjdQ8ivQj/gdHDv751vhTX
         ejqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCr9/bQnWb8C/f9qBM0+TyvP6hvcKENYZHTSqJ3nquaY+kjSJILmqwk1ryf1VEURG3aloXw/5DzBL7Zq2jTNnxECr4o7TVEzf++814
X-Gm-Message-State: AOJu0Yz0VVuz048lv0fGBjre4g1Lcmiy8Uez3hrjdGxqqNsOdBPGhO47
	3QJcl0W9RdEtNCb9TSYM1keL+0nNml56FD/JZoTnY2CNo0VPwJglTvFhzPRs8l0=
X-Google-Smtp-Source: AGHT+IGQyjgLHdHNEoImqpElpwjpRsWQc/yx4zVnNI2z658yNvjA2SPImFwda38BJhCoR5ARMwTfcQ==
X-Received: by 2002:a05:6830:d7:b0:6e5:3134:1108 with SMTP id x23-20020a05683000d700b006e531341108mr13951597oto.38.1710873258589;
        Tue, 19 Mar 2024 11:34:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id n5-20020a0568301e8500b006e53e81bab3sm2169804otr.14.2024.03.19.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:34:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: docs: spidev: fix echo command format
Date: Tue, 19 Mar 2024 13:33:42 -0500
Message-ID: <20240319183344.2106335-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two example echo commands for binding the spidev driver were being
rendered as one line in the HTML output. This patch makes use of the
restructured text :: to format the commands as a code block instead
which preserves the line break.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/spi/spidev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index 369c657ba435..e08b301ad24a 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -61,7 +61,7 @@ the spidev driver failing to probe.
 
 Sysfs also supports userspace driven binding/unbinding of drivers to
 devices that do not bind automatically using one of the tables above.
-To make the spidev driver bind to such a device, use the following:
+To make the spidev driver bind to such a device, use the following::
 
     echo spidev > /sys/bus/spi/devices/spiB.C/driver_override
     echo spiB.C > /sys/bus/spi/drivers/spidev/bind
-- 
2.43.2


