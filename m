Return-Path: <linux-kernel+bounces-167503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096AA8BAA84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD81C21E05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CDC14F9FF;
	Fri,  3 May 2024 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZMWvkr9Y"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3CC14F9DF
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731063; cv=none; b=NqcSyJb6VpIJz3WF+qdl7M5Pou/zk9aAKlAYy6G3kyQBFSr9CmD83TL3JVXeLIOAudk3lnF7x8zCMSe1iNM/yygQGgluradAR0z0c0vm0aMmgDp9utSXQ2iQxs7envilQIb8ezyaJG34FI4lw7vsKn9vQ1lVRq+Bc0MQPAe940A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731063; c=relaxed/simple;
	bh=G37NFLjrXCTNfbfi/IPR1kIIDGRAFb95nMoZ3qFDmtU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Hg4vF9tr8RI37BAe3j6iFMPw+hTvrsjij+58Fjg0mvz2G8yyV6G+1dLuUkmVxfP6O/uZTdHo0xNdMby+3VAKWRuWqdc1Rl/drvx/xZf97NsT/mSHFTC76dgQxqWWrqU/23d4NiKOS5W8fowmJs8nyzdVuFdhTLj+kCwmsNi4bDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZMWvkr9Y; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41c7ac6f635so33160835e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 03:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714731060; x=1715335860; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDYasZY7tfrJdmcMvpk06e76IGIlcbBma1RQJtY8biQ=;
        b=ZMWvkr9YC1L3E9CzagJ4fOXf7cXTE9bwfRLCJLCpORPdHgxX+05Oy4+OIYIl1qIZJ/
         aVvoJ7thfiUaCNgIkl2AHbBzpjdIBXYLe/C/AFsLaOOIjv0fdKy8DnEZIbfPzrMzx7tc
         sIKUi/G98AIOlHkhvIRYzkg+BPciJ9ioQmw1adFuIQdmrLS16IQxNA+hM0KqpggNezBP
         37Ebd7C1rTE59DRNGnesl7I4lsiYLD89uuyHBNIQ0BTFonDtBBZYBAT5BQPrgItcEzF+
         ZPGA1gR3B2uWK5sZF8A1SJasR1sDmPMJgdevBAq9bGJ9eEIsefnDphk5cpLesRLNQ+M3
         GWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731060; x=1715335860;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDYasZY7tfrJdmcMvpk06e76IGIlcbBma1RQJtY8biQ=;
        b=IDv4d2m75pfudY+eY4mgggOq3PIOF5XJNDgfASFM+XSZYZ0mvbEeq4HwLSAW4j/ym7
         5S/UN91+EWE/MUErrAJDTtPqkwCg4WkKU7Y9rp3fjixeQLedM1whQ6HTy4PAS/hoUnSF
         DCsYJQYvf34Wc/JyrSk9ZTuzrHEMzjiioN4w1tJzCzbAoPIWM8wY2rbov/dmg4Jx5YRE
         pRPcWa9nOPdxr+VjlMOl7CqkcwdIST4pxc5iJgu2dPQk11hChsx0jKacZB4AwMOFsdos
         0dzusOnKbFL1mSuZQ19nmQs/D+wl+3Q1tXLaRrJcufVjXzxoo+4m4Zw7IkFYM5WdQ/0n
         hB7g==
X-Forwarded-Encrypted: i=1; AJvYcCWK+VvBNToB9wgcaZ9bukoRcYi24iwo5Q4Gx2sNdJc0vAZLDVpmFh5VMLe8q3RjCzOJ6eE6WD+DjHlYm4NLWRHmIPMZCcJYkw9oxuDL
X-Gm-Message-State: AOJu0YwYeWtR0HPrGzPHgQHS2IH5kjqjV/mFVOi5rvp7ZbWRP8CcJEqM
	4OaG6ZuZ0KBnkJWaoPGxrNl0s848Hsh/xAZQkiQq6Q+YTCuvDuXx1aXxnEW7t4U9qo9mRzIfYMK
	Kzao=
X-Google-Smtp-Source: AGHT+IFGsHqDv5COzgPwoVBTAXw3+qcWQu7fZMvlprn2KTc2HT/ztL06LAuiA3H4XVLxjg/nfd2Hjg==
X-Received: by 2002:a05:600c:1f95:b0:41c:13f6:1eec with SMTP id je21-20020a05600c1f9500b0041c13f61eecmr2002783wmb.3.1714731059900;
        Fri, 03 May 2024 03:10:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm8832702wms.7.2024.05.03.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:10:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/2] USB: store owner from modules with
 usb_serial_register_drivers()
Date: Fri, 03 May 2024 12:10:51 +0200
Message-Id: <20240503-module-owner-usb-serial-v2-0-7887769dbeff@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACu4NGYC/4WNQQ6CMBBFr0Jm7ZhSsaAr72FYtDCFJtiaqaCG9
 O4WLuDyveS/v0IkdhThWqzAtLjogs8gDwV0o/YDoeszgxSyEifZ4CP080QY3p4Y52hwC+gJGy1
 UbZWUphaQ108m6z57+d5mHl18Bf7uR0u52f/NpUSBpqtUd7HW2LO6Tc5rDsfAA7QppR9IPcXWv
 wAAAA==
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3690;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=G37NFLjrXCTNfbfi/IPR1kIIDGRAFb95nMoZ3qFDmtU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmNLgvpopEGdV6Q9Mj5rYhGObBHsIo7Ce8dDM55
 jnpeUhRN3GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZjS4LwAKCRDBN2bmhouD
 18QtD/9M8kO5E+XLesW2AbIVczZVPklF2sOo8a0cZnbUAJ6q+iiRw05jzWaoPX4taLEGKCPQAAK
 tXzAPsNvuPgOtx0C4P7bNxzVCV5onCgutf4r/3eCiP0HI8oFcVaCRqyrPFpvMW5bvOfk1Rf9bi4
 PBQAykCYWQ9wP93Rv/2Vv4GK9J1v7PUhKPkP+whrPHZS2gQIqE0e+rCWt6cA0bOlYyRu4zRujgU
 hg7amozEYn+GOD4JfNuT7T361kKK9ujD/M3y1p6PY7aGgxtwOtcYEfIWbxbLsxdG5ko1bnL18mZ
 wClb/3lEyrTOj/6hM7n2DXZcw+8uqXDVwIcIp+7NrirwJfo11H+VdX5J8uflfwalZhuRTtDZSou
 wub/p3916aGV0r6/BKypAvJF0H5uoxTycHh8OdfjpnVagp+GPynHJGrjwijilp/WGmJ8LIi2ZKE
 pOSBLXCGMuzewiNqj7ToLW9UHPxuG7ykIzGR4whMP5tm8vdPP+7ez0Hc2SSKWKHfB9OqJnWyb4x
 dZBRRXomIoHpLkB4wkGZnBGmE7IeX9oDJ5Z/xUhgeaO6efEARDYsyZcHksb7cMsSqbZvZ1PlIqH
 CPL+TEDznKjsUha2wwnO4GCNnivrzlDl9ycVcP30MnqG5G/FmLH9WCOkLrGPKGxtMhEj1MPkAOt
 nCPRKwk4PMvKO8A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Changes in v2:
- Squash .owner removalr patches into one (Johan)
- Drop owner from f81534 driver
- kerneldoc "module/owner" -> module (Johan)
- Fix amba->usb copypasta
- Link to v1: https://lore.kernel.org/r/20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org

Description
===========
Modules registering driver with usb_serial_register_drivers() might
forget to set .owner field.

Solve the problem by moving this task away from the drivers to the core
USB code, just like we did for platform_driver in commit
9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      USB: serial: store owner from modules with usb_serial_register_drivers()
      USB: serial: drop driver owner initialization

 drivers/usb/serial/aircable.c          |  1 -
 drivers/usb/serial/ark3116.c           |  1 -
 drivers/usb/serial/belkin_sa.c         |  1 -
 drivers/usb/serial/ch341.c             |  1 -
 drivers/usb/serial/cp210x.c            |  1 -
 drivers/usb/serial/cyberjack.c         |  1 -
 drivers/usb/serial/cypress_m8.c        |  3 ---
 drivers/usb/serial/digi_acceleport.c   |  2 --
 drivers/usb/serial/empeg.c             |  1 -
 drivers/usb/serial/f81232.c            |  2 --
 drivers/usb/serial/f81534.c            |  1 -
 drivers/usb/serial/ftdi_sio.c          |  1 -
 drivers/usb/serial/garmin_gps.c        |  1 -
 drivers/usb/serial/generic.c           |  1 -
 drivers/usb/serial/io_edgeport.c       |  4 ----
 drivers/usb/serial/io_ti.c             |  2 --
 drivers/usb/serial/ipaq.c              |  1 -
 drivers/usb/serial/ipw.c               |  1 -
 drivers/usb/serial/ir-usb.c            |  1 -
 drivers/usb/serial/iuu_phoenix.c       |  1 -
 drivers/usb/serial/keyspan.c           |  4 ----
 drivers/usb/serial/keyspan_pda.c       |  2 --
 drivers/usb/serial/kl5kusb105.c        |  1 -
 drivers/usb/serial/kobil_sct.c         |  1 -
 drivers/usb/serial/mct_u232.c          |  1 -
 drivers/usb/serial/metro-usb.c         |  1 -
 drivers/usb/serial/mos7720.c           |  1 -
 drivers/usb/serial/mos7840.c           |  1 -
 drivers/usb/serial/mxuport.c           |  1 -
 drivers/usb/serial/navman.c            |  1 -
 drivers/usb/serial/omninet.c           |  1 -
 drivers/usb/serial/opticon.c           |  1 -
 drivers/usb/serial/option.c            |  1 -
 drivers/usb/serial/oti6858.c           |  1 -
 drivers/usb/serial/pl2303.c            |  1 -
 drivers/usb/serial/qcaux.c             |  1 -
 drivers/usb/serial/qcserial.c          |  1 -
 drivers/usb/serial/quatech2.c          |  1 -
 drivers/usb/serial/safe_serial.c       |  1 -
 drivers/usb/serial/sierra.c            |  1 -
 drivers/usb/serial/spcp8x5.c           |  1 -
 drivers/usb/serial/ssu100.c            |  1 -
 drivers/usb/serial/symbolserial.c      |  1 -
 drivers/usb/serial/ti_usb_3410_5052.c  |  2 --
 drivers/usb/serial/upd78f0730.c        |  1 -
 drivers/usb/serial/usb-serial-simple.c |  1 -
 drivers/usb/serial/usb-serial.c        | 12 +++++++-----
 drivers/usb/serial/usb_debug.c         |  2 --
 drivers/usb/serial/visor.c             |  3 ---
 drivers/usb/serial/whiteheat.c         |  2 --
 drivers/usb/serial/wishbone-serial.c   |  1 -
 drivers/usb/serial/xr_serial.c         |  1 -
 drivers/usb/serial/xsens_mt.c          |  1 -
 include/linux/usb/serial.h             |  7 +++++--
 54 files changed, 12 insertions(+), 76 deletions(-)
---
base-commit: 0a5adf0bc8a1c2a6439d632e49471f64f84d3cef
change-id: 20240328-module-owner-usb-serial-8a067f622b70

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


