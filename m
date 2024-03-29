Return-Path: <linux-kernel+bounces-125094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FF891FFC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FE628ABA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC0149E09;
	Fri, 29 Mar 2024 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MJDecyS0"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E7130E5D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711723426; cv=none; b=OJzCQyNOvg9gB255dMtnMTRSpXCAOxtLMDQ//iZmAfaRrGdqHpIofWMs2ahgdYGPLc3fo9CHXxKTcMPHJj051KOTeked772NwrY3PVfO29ngpsORg0XAa9IAeUjNBqFuqHwWUZkN6YM4SZydfVbG+ZRElLCuuyBKeT1tcMjJgqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711723426; c=relaxed/simple;
	bh=HWn+ubBw+z7uWmy+kR+A6/4Pj3cMxxSNFvxf72ie888=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ABRdo7h81o602bRhOrb1V37pyypYeQqJ3ppoM6qHJOarTbjbTYgnlrR2keb5FU7N5EdPrUkB5dbqFCPmcKzR/PmIcoqB/8Nc6hQH68zSRiZ4yeZWxoJ7z1fNepeMxq1ZTK9xyxCjf7k/gBrIHVvm68Knyp6lQpbsnqP5MBZf3n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MJDecyS0; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e6a1d24770so1144478a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711723421; x=1712328221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VW51Lxzr9d+EH5PFrrI1HHmktk5YypVM0IZEzVB3Xc=;
        b=MJDecyS0be5LMcFaU6sbe2riez+grgF+Cb6Rd8YrVbWVUkhnduQiFSiMJe8eW0HKDi
         cZJBTT4DIzQjdUOmIuTt7rk+Sq81irAuXaSQhy7pVeplRGFDF5Ofe7wkoWp2a3r0CMco
         BqIP3lhjwyVuc8NgwJP1Y6ydFUUHQkgB+Xm3Xl7nTriCBf2mhWKFePDL7K761f/8Tl7O
         y/47K0CtpCapGbFWNPbAQPo5pdBl+R0bZngS7YzZWZBvqjobuaSQi+wGJKshoyr0sv8w
         x/L2IFUum+X1cdYkSSwLyJZUNnnBfhIxTYaIJ3SFO9W7XcXKzuSbLWgVYokbbHWcSFM0
         xq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711723421; x=1712328221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VW51Lxzr9d+EH5PFrrI1HHmktk5YypVM0IZEzVB3Xc=;
        b=rMKsbyGv6GGSrK4lHygGy5sQxirHvjkBVjvr6z5PMuPQB7E+4rRuWebwiJfgsqL7Mm
         X4SUYTMvglyVOYz+CiFKWNnE/xf8NQK7S98mvUC8dvlPe12R10efnyq0b9bXPGiKAbcj
         3PyRuDgnfulB5c0UXGgi2yihp9kkaupRSH/ODNz1t0lUnhrPtXpu/0OUyQcLpl7rptha
         UJfwQ8LARluZWTIr22kQ0Sl9AYgk9MRgcXXtzxetBZgIHgbr45IwFDRKQjQkxlv622QP
         5GcfHK+1+p0TAQfmJ3KupNVF7JOCaNxkoY0YvFHGsTIFonrX2l1BgtzgbBZoD817iBrS
         Rghw==
X-Forwarded-Encrypted: i=1; AJvYcCWPSgJI409EgIwgRI+AA0dm4G5P665JibNckS+t61Kim2SxfEGv/HDUBhscwdPIAl8f1Hro4jEnyfO1GnJyvi2+W25VTs7Sd+eaMscn
X-Gm-Message-State: AOJu0YxQf0s9zONAmq7tPgIO5Iz1D5qY/ChTkct2ROEfkMslYDcclKq8
	d7wIJA0yGLaddHTAwEq2MFzlZKA8+ZK3wkK7yvHJTTu1B2eCJL65/evvrw4vFY5DxDe/oHNWtUR
	8
X-Google-Smtp-Source: AGHT+IEjgbOCLxJSazq7Ph5qiPfP/D7Ytvy6s1ZfqZgKWOcT5fLpOo9CuYAo+RfvsUzjixtQixMAow==
X-Received: by 2002:a05:6830:1301:b0:6e6:d359:23e9 with SMTP id p1-20020a056830130100b006e6d35923e9mr2460279otq.36.1711723421455;
        Fri, 29 Mar 2024 07:43:41 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id r2-20020a056830120200b006e6f836aac1sm661687otp.9.2024.03.29.07.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:43:40 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: David Lechner <dlechner@baylibre.com>,
	Kent Gibson <warthog618@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: gpio: fix typo
Date: Fri, 29 Mar 2024 09:43:16 -0500
Message-ID: <20240329144318.376939-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EOPNOTSUPP has two 'P's.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
index 56b975801b6a..6615d6ced755 100644
--- a/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
+++ b/Documentation/userspace-api/gpio/gpio-v2-get-line-ioctl.rst
@@ -81,7 +81,7 @@ Only one event clock flag, ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_xxx``, may be set.
 If none are set then the event clock defaults to ``CLOCK_MONOTONIC``.
 The ``GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE`` flag requires supporting hardware
 and a kernel with ``CONFIG_HTE`` set.  Requesting HTE from a device that
-doesn't support it is an error (**EOPNOTSUP**).
+doesn't support it is an error (**EOPNOTSUPP**).
 
 The :c:type:`debounce_period_us<gpio_v2_line_attribute>` attribute may only
 be applied to lines with ``GPIO_V2_LINE_FLAG_INPUT`` set. When set, debounce
-- 
2.43.2


