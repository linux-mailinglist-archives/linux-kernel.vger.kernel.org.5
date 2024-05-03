Return-Path: <linux-kernel+bounces-167109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD738BA49D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42FC28507A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB60B65A;
	Fri,  3 May 2024 00:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXFAUOP8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647368C05
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696776; cv=none; b=q1g9s78kK/wWNA0ob3xgXFD+P4cEcr32QKVUKE70rcxmxPX3U6qVY1OTQzk74+SmHAKdmT7KlrKtXfZjKI7x483Isx1XaN2kpDD6xivHyVYmvERyDXg/j3Ok4F2zcuZjFmHbY5xhJTtQdZgTFS8kLYti3tuIWhEWXuif1U9gT9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696776; c=relaxed/simple;
	bh=bgdAnVbgDmbC1/5loPNCdA9VLFftj+18FQzdZvq14Wo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tKfgwOXKed5y0WzCzECQD2SejYMd9AKht02FXNYNkxnl2+1Z8oCMSy3WN3msG+55k+FKHjfA11zyCmXxpEL3iybfX92ZISAgkvX4k3CPWXrRQo+rNNe0xMrnvph9l1ylLpp3X2pJ9MwRK81iHD71BcFqlgDRPaVLELWjTe4RiTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXFAUOP8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61d21cf3d3bso59785677b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714696774; x=1715301574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1eBfGoRBUd7s9enVeYkpuVFZwxor84bkYLgLwuj8TD8=;
        b=jXFAUOP8EhSvmwivBypNubklagY4VvBHPIlmTMIrmWxj5GqCfX+3lKsNfp7aUaXs3K
         kfnWe+CBVRh1G49yQPIcaw3kkfc7Q/ZesfRBHELxBawRoYcpe244Rx71GTqbsrUgo1cn
         oh12VHSjiyfOOnartYlfpYyYgNZ6f1iWSOB5DGfpSRytL67D1NPeCl3ERwA9QldWdJRw
         /xo2a4MrWweuilEDEYgH7v1PQuSdl3DtvKHu20qRj+7xJMBxoWxt7RiSZqmPp62PjWeS
         oGay4ADgQiIvSBUwPZu+EiGzOKZRBuXBoc6ZXGTRbK6Tx/Y2MWrnv0a66fEAOIFO+XkO
         B4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696774; x=1715301574;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1eBfGoRBUd7s9enVeYkpuVFZwxor84bkYLgLwuj8TD8=;
        b=l+femyVR9TzU9sbOjHFTblEq8/2s762FcUhHYaNnubGLqo1spvnik0wPqFO+SVD3R5
         0zmCmg95OPuqoUJp2UalZfOApUOklwV25ZiaaeqXUb6FO0shxbnzk/Vc5gIi9H/57qW1
         /EJ/XQRwWPuyx3eLjg00z8S06M69RD+q82ckYgyj6Ll3eofq1OGaotwf/UOKAXgwvJZz
         3NIy3GfGYZsy3WW4G6TjUZZCaHlvpelHZWpJ9FPZMaf4aoMwttginrpbY6cwNbWbYmCT
         v1t1cVsrghn4zXPRKLMaEOkiZyFBDXPjg1X2uR5oLnA9Pr2f5TeX5TOBy+k7SyNiG4ii
         tF5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYHT8Vai+NYdOQdznyft2Jp3/quQwqS0NUywLUHfFyYVVy7nAMqFhQMxWRlQIpAhioj1N4aSLRqqTcUJxRvdSYgnnqpoBYldP/7wBk
X-Gm-Message-State: AOJu0YxBEhmSXDDBhQZIc8bXNj+XZM49ZT31t4E6e0rWB8KOJtBKaMFM
	v9yCoePuj5oEAkGgAmp0/LpT97uXIfcIgEjrn2RSrYcz28J/R1x0t2LuH0uQFQn/GwTvZoa7Y2c
	qzQ==
X-Google-Smtp-Source: AGHT+IH20g0fH8fZpK5P7Wc9vTiXL/MJtoTLJq2vpFQQVID7qrE7sX8vyvTU1sbJbOuL9XjvcnLm4n0QC6U=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:2b85:b0:dcc:8927:7496 with SMTP id
 fj5-20020a0569022b8500b00dcc89277496mr207784ybb.5.1714696774355; Thu, 02 May
 2024 17:39:34 -0700 (PDT)
Date: Fri,  3 May 2024 00:39:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503003920.1482447-1-jthies@google.com>
Subject: [PATCH v3 0/4] usb: typec: ucsi: Update UCSI alternate mode
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Heikki,

This series appliess some changes to the UCSI driver to help support AP
driven alternate mode entry. This includes...

1. An update to the altmode sysfs group after registration to make
"active" writable.
2. A change to the ucsi_partner_task delay when queuing
ucsi_check_altmodes to prevent it from running before other discovery
functions.
3. An update to always define a number of alternate modes for partners
and plugs.

Not related to AP driven altmode entry, there is an additional fix for a
null derefrence in this series.

I tested the series on a ChromeOS v6.8 kernel merged with usb-testing.
That build had some additinal patches to enable a PPM in ChromeOS. Let
me know if you have any questions.

Thanks,
Jameson

Changes in V3:
- Returns typec_port_register_altmode call from
ucsi_register_displayport when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Changes in V2:
- Checks for error response from ucsi_register_displayport when
registering DisplayPort alternate mode.

Abhishek Pandit-Subedi (2):
  usb: typec: ucsi: Fix null pointer dereference in trace
  usb: typec: Update sysfs when setting ops

Jameson Thies (2):
  usb: typec: ucsi: Delay alternate mode discovery
  usb: typec: ucsi: Always set number of alternate modes

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 drivers/usb/typec/ucsi/ucsi.c            | 18 +++++++++++++-----
 drivers/usb/typec/ucsi/ucsi.h            |  2 +-
 include/linux/usb/typec.h                |  3 +++
 6 files changed, 36 insertions(+), 9 deletions(-)


base-commit: 080e73c9411b9ebc4c22e8ee8a12a9f109b85819
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


