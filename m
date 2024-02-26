Return-Path: <linux-kernel+bounces-80482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7F48668E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F89B20E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03119BBA;
	Mon, 26 Feb 2024 03:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="M5BnBVYe"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF6FC18
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919790; cv=none; b=rjv3I0zrinZyg4nyFXrx+PRdW+AuXPFlv/yKOfLVLEVq/TlN3h56q3RgV0mLgAAQMXJY+l34/QOFS+lKG3uqNeydZuniDJpHwBfC+2dOziBLX4yNqFVl9F/T8SNBw1+BSq9tG6NSpCvqhpoWP24Zs5By+Sx99DXR1nXH5LwtVKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919790; c=relaxed/simple;
	bh=Akvks8mysTGqZ3S0NHAgtT01VFH4LkGymJmxDNEerl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zf4P9YK9virjj+RB/tXvQ0QF2hwGDwASt2l6XfK2ExWFFOzCLI1t5Mo3IAhwUFKntkzXSH7vBmU5mY0Wr/o8Gw+D0mCZagotO9TU+Y/ZmneIQl2HfBeya/nzuby12KfX9PskzZvtrblJihjq+te0wHJthvPmVKNO+/4UsaQvLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=M5BnBVYe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8da50bffaso12131745ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919787; x=1709524587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXRMbMGYCa9+7pITYo8YHSxedJ9Dm/1lTly2Fj7Ci9A=;
        b=M5BnBVYenvUo4cy8e8McC6vKf+TdW6w+U+5+9wm8z7eDAV4haLEGuf7xpzYLlgjAVE
         tsDTVSC+EA3n4K9XT6u+Y2nzHXnJ4G1BACeWoOJvzx67Q97wDvdvFlEeRW2nzDy9N9+6
         Gfx5tclor2zFeDRbJN2a8j8PPFe2r8gEDcDCns9lEmWfHz91XBIkbglZHbdE517TR+8/
         h1nTqFf+GapiuFilU4r5NAPv6MYlRdMq6Z+K69nWM+RgERT5ASqHCr1lS5KkOiKgF84j
         nXI+SQC+VJkEDCwAEU5yGgQIqH7fnQd+qFJ2yOh9WzxP1SDopaDefEv8EXDR6c/uaD7g
         BsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919787; x=1709524587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXRMbMGYCa9+7pITYo8YHSxedJ9Dm/1lTly2Fj7Ci9A=;
        b=DOyktNPwhKtrnykP1MfWhzlskCAHGNmqS02wMCg+Zv1dJGSdOQlSVyXPDirbmVsZfc
         JkRWXArClLXExCObuX5TV3VG9bWBnCslx2AwWplfgti//SemSN1LrVspWSf/Rix2PYvh
         fybR8fxREElZLf9P1QzMKPHkZLMNDgwIWHK8RrYs0/U6FhR3Yii2doBCQSaQpOB2OYSo
         ptVPDnvpXSVaoc+lrPlv6sYEyZGbsR69YlQDYZAtmuES9y4n0Xf+gGk1RaB8vK4JzeNg
         1Y3o4KgzxA8irUc6teo02rAIVWliXuWTXm1HO1INec6aGoXUOfDLy3wPI/8yzP+OaP4i
         bClQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVl3FjEpgQ47ZwVRDY2LlynqqedMojHXQZuawIkecMiz7PQeftHUDaO8UFzbqYcTt5uYJ6scRi9hfMoEp5Wxbfuem1HxMxB+DWa18l
X-Gm-Message-State: AOJu0YyXLg0CzHsVcgNcOud7khULgEcc10Pgd7O9tHfh5v91pTDpaM/x
	NB1PiSppChH0flkyOabydIXaJeKeDN+ZnZ/sY89Nws0+pjGFl4vgbmO7lc4Ra8MmFl4yr4ccHDa
	h
X-Google-Smtp-Source: AGHT+IELyXa3g9jmLECyXHKmyyOk/LaUxz0KsP7lM23d1DJLzWPodlN6L1byaxDaUzXSSNZP+U6zBA==
X-Received: by 2002:a17:902:e806:b0:1dc:5ad6:b6e4 with SMTP id u6-20020a170902e80600b001dc5ad6b6e4mr6846108plg.4.1708919787233;
        Sun, 25 Feb 2024 19:56:27 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:26 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/20] Staging: rtl8192e: Fix checkpatch warning for rtllib_softmac.c
Date: Sun, 25 Feb 2024 19:56:04 -0800
Message-Id: <20240226035624.370443-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series attacks checkpatch camelcase variables warnings found in
rtllib_softmac.c.
Thank you in advance to reviewers.
~ Tree Davies


Tree Davies (20):
  Staging: rtl8192e: Rename function rtllib_rx_ADDBAReq()
  Staging: rtl8192e: Rename variable NumRecvDataInPeriod
  Staging: rtl8192e: Rename function SecIsInPMKIDList()
  Staging: rtl8192e: Rename variable PMKIDList
  Staging: rtl8192e: Rename variable Turbo_Enable
  Staging: rtl8192e: Rename variable osCcxRmCap
  Staging: rtl8192e: Rename variable bCkipSupported
  Staging: rtl8192e: Rename variable bCcxRmEnable
  Staging: rtl8192e: Rename variable CcxRmCapBuf
  Staging: rtl8192e: Rename variable BssCcxVerNumber
  Staging: rtl8192e: Rename variable CcxVerNumBuf
  Staging: rtl8192e: Rename variable asRsn
  Staging: rtl8192e: Rename variable AironetIeOui
  Staging: rtl8192e: Rename variable osCcxAironetIE
  Staging: rtl8192e: Rename variable CcxAironetBuf
  Staging: rtl8192e: Rename varoable osCcxVerNum
  Staging: rtl8192e: Rename varoable asSta
  Staging: rtl8192e: Rename reference AllowAllDestAddrHandler
  Staging: rtl8192e: Rename boolean variable bHalfWirelessN24GMode
  Staging: rtl8192e: Rename function MgntQuery_MgntFrameTxRate

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |   6 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c     |   2 +-
 drivers/staging/rtl8192e/rtllib.h             |  22 +--
 drivers/staging/rtl8192e/rtllib_rx.c          |  30 ++--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 128 +++++++++---------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
 7 files changed, 97 insertions(+), 97 deletions(-)

-- 
2.39.2


