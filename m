Return-Path: <linux-kernel+bounces-91588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8B8713FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6051C213D6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D6529425;
	Tue,  5 Mar 2024 02:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jVwP7x2I"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C18046
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 02:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607503; cv=none; b=cOGba+eUV8Ry6dQ9S21Q/V3232gqeKViPu4eeDj/siSiVwEgqjYuZA0D2mHbCcNoo4K9t9dMBXQs90OqQ3rdNwo/oQY5e6kWJ2OocoheGKGKj9iw4DG4Se1IvOunhvnD9koKs2J9RpUz4bUMeqzOEnkrbOaIlJJu81An9cjFAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607503; c=relaxed/simple;
	bh=oNftph5EzpMR8yP1faN1LwNXcXXa0MWKbcv0UYRquWw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ozgFJzfiZRuojUMXDvltAec4mWIqe//P2ACHG6zJJk+tY6G3wEN4U2jX+/hyfd5A+pWOqCzMWDDijFf1aEHOx3G/P8TQbBvnOFj9u3nmftojr6oxjVBDMihWtG/KsyUqtOTEJWRX42emp28/mAYL6f2gWRTXXV8ED1wZJrrc+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jVwP7x2I; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so81160417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 18:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709607500; x=1710212300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4w24FvPZfR/PRRHr0+XjzHX4GZ+6wb3j1dS/myLXi1M=;
        b=jVwP7x2I1gCv06CyQYZQ+ldANjDYpKJAsM3S70EYGlzm6grjJjutVhgv3HcwP/gdUZ
         of5zHcvqY8zl/zf8u66v8QqzFs8HP43AmdmQ1tqKvQKgVQbVwg0AHsLZBAAE21Iy6RwK
         kOS3ElsmDatnoZeu20HJ/IUoH+RUK9vGRUk2yMtRL3cCaqlOWpWRgNGGk1mSnsApDsb2
         z/cuqkX00lcjHPfbGXf19JYUnyQ6mGYVDKHeP5wiBEaiGlmt3GGUZdJGU5OZIGV2YkSc
         ttFlJysdsQf8FtSDWkiC9/cmCl58W3Pd3WyWKIKmDvg3hCGYHF06s89+skEgIKhdKI3/
         JnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607500; x=1710212300;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4w24FvPZfR/PRRHr0+XjzHX4GZ+6wb3j1dS/myLXi1M=;
        b=DTO9eSBHJQkPB25czIJ1lsjxq8EG1KnCIQTpp39upCrHLNK77um0H2e7+juJIJ6js5
         q3/2b6nNZ1bmeDtht4dHuFb/RgX3RWin5riXyFL1DDCVfYSJ+ey8NPNalAtoqqjydnuJ
         s/t0ZG0SuIMPuxxZoA6GKGHQKvj6uM9XiWDGR0HFj/bPbR0sVtCnU1RGs7m5qHyBP33Z
         bVEl1zoLOc1RMEua/UdAJcAw7iY0xx0gLOtiwUun7T5oLcnQwItCDLELVel0+5DfFHQX
         dMpoXut6rSpUMFDhz51qnb3Jbdzao5EF66GZhwI7mHGfvE5l9nabPE3ulOB8ObGfRTfv
         Z2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkoJRa6sQP/V36hpLDF52rf/a+ICTwfJj2btLmXoBfblpk3bX7OoO9AR3qmL3/stEOqyeiqusjzva9p+jJ7ORIsYMPQeRKvyvskt4Z
X-Gm-Message-State: AOJu0Yx2BAnzIVEpJOOn5goUAN5ZJiGcA9W/dIVaEDaxASBN+xYYP2Mi
	aYrsQmkQ0Pr3jWaOzj3nwmp4Vhe5oxVNZjozV+uk39LeHJrMTxV2oh9NJr2H/4nuPW1AbM8ReRj
	ykw==
X-Google-Smtp-Source: AGHT+IE4GXRFRo5uQf/2ak/hIu+BWrbsCH/gpgpTN5h9/1NtRfCm8i89FtojvR3HII95GHpOFH61v3UU0zE=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:e18:b0:609:247a:bdc5 with SMTP id
 cp24-20020a05690c0e1800b00609247abdc5mr3070607ywb.4.1709607500787; Mon, 04
 Mar 2024 18:58:20 -0800 (PST)
Date: Tue,  5 Mar 2024 02:58:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305025804.1290919-1-jthies@google.com>
Subject: [PATCH v4 0/4] usb: typec: ucsi: Expand SOP/SOP' Discovery
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

This patch series expands support for partner and cable discover in the
UCSI driver. There are a few pieces here.

1. Some cleanup of the GET_CABLE_PROP definitions in ucsi.h.
2. Cable discovery and registration with the USB Type-C connector class.
3. Partner/Cable identity registration with the USB Type-C connector
class.
4. SOP' alternate mode registration with the USB-C connector class using
a cable plug.

These have been tested on a the usb-testing branch merged with a
chromeOS 6.8-rc2 kernel. Let me know if you have any questions.

Thanks,
Jameson

Changes in v4:
- Cleaned up redundent ucsi_send_command calls for discovering identity.

Changes in v3:
- Fixed CC stable and email threading issue.

Changes in v2:
- Re-ordered memset call and null assignment when unregistering partners
and cables.
- Supports registering partner and cable identity with UCSI versions
before v2.0.
- Shortened lines to within 80 characters with the exception of two
error log lines with three indentations.
- Tested on usb-testing branch merged with chromeOS 6.8-rc2 kernel.

Jameson Thies (4):
  usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
  usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
  usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
  usb: typec: ucsi: Register SOP' alternate modes with cable plug

 drivers/usb/typec/ucsi/ucsi.c | 245 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  40 +++++-
 2 files changed, 283 insertions(+), 2 deletions(-)


base-commit: a14e6fd1b67799da7da9cc344023bd16aaf0d17d
-- 
2.44.0.rc1.240.g4c46232300-goog


