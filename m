Return-Path: <linux-kernel+bounces-85996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DF986BE43
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6788A1C213D7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8122E62C;
	Thu, 29 Feb 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aau/WyFf"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B052D046
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709170180; cv=none; b=uEbJuxpEOPCtF7OM9xEB5IeTV+e3W6/VTnfh12oTdCNcPSnp6+J3wsiGKOWXBmxeqlI6rkPABf+JchVJG6aGg8DmY9SbhtX38acLSoqr7jnb1ZMQTq1RyI8KaEDyDiZ0khLU7pDG/ccGDWnA8M9lEvzGVk+JpmD2qLJD+lW5cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709170180; c=relaxed/simple;
	bh=llgycK0vel+ByZjq2S4bsIYLpr53VlV1dYeH2+0LRo8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MRXnBJ1h/ZOwWdCsychvIIIhBPwbQjZnHCBmpbndrRdby+T8aNXiTaptkSQ0/b5xYq7uTfo7i0wNEFdQxvfMwGTeJAP+0nVL9z229PwJHH+HJoi/hXD2GCBQm3ylGZulFquvhCPhhA5Du1bI3mq0UJ2SQOXSQvrRsYqtqm6MTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aau/WyFf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607e613a1baso7435097b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709170178; x=1709774978; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HO7sM+79J6T6oYs6iAIAH4cbr3Ct/U7/pkBJr2RsBIQ=;
        b=Aau/WyFfgTze7Ys0WKXUOHDcaw+D/kRiQW9u5mna5u1/omAtu2Key38j21vQN/hJkv
         yfnjaLCHnhdTlcNwE1y+dZRGn87XjNbep++yN3LFFTjjn5P1BxM0c8YdolYMEv6qkkOR
         ko+LTVY/LT/qIBypg9202D4dPyoxf/Rl0vBZi4plvcEVLqJpluL5ynnFlX35WHKIA8Ej
         1Tw9JODBfsaOdQhDa53TPb21cXpgNppbDXuRN+abLJxh3J/OduDP+G9KIaj7/9MyLkjK
         YHfPCnvRQIFgYxqojOj17KOKKES2LEO7QNHI2+i75o8rKFsrga5PinS0rYLIGZqRErWp
         WkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709170178; x=1709774978;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HO7sM+79J6T6oYs6iAIAH4cbr3Ct/U7/pkBJr2RsBIQ=;
        b=Z2ebnTRySCFLvooA7CIGG10ekUUPt4adUjcac2xjsl28lsvCwS+xWHo16gwav8uZuu
         Z5eB/myfK2scQIQqpWYPJkBTVTA6/WOjJ+6YNBIwH1MzhUIlMUX7PNOTbvJjl6/Q9OP4
         O8SxR0f+8q58rNVKZJWMHVF+f5uTRb/X2ACOgLCt0zbSvpWQnvaTLjuMSQjZBF9hIdy9
         0deAi4MyB8MqjOaqao/JlrZqlhErEDD4A5tgEAnx07duzGRPF9k0oPIWNHmEYsYHnTj3
         Jxhbj1DW2E7UvhNsmfZs33nccPS0i91JLTVL9Y1h1lO2Q4lZNY/NjLbWmr8p2EvjQ0iK
         iC9g==
X-Forwarded-Encrypted: i=1; AJvYcCWuiV4Dr9ls4X7EI8VGEJNLTUtW3KIbSIvwg7Ev/oTfPV5/jTn9Svo4r6Fm6+OB1jDePd4bPFfF1TW8vKgzy49OMwq9nzKDmIgkWQxy
X-Gm-Message-State: AOJu0Yy2t++dPBSevQMTihSdLHWcjBSg3mJsTBZPcVj5Z9kRwUwJMejh
	HCmz4RqdFK0VJyBKT+gCKH0LPJ4qcUwmNJt9WVoi2ZwfALbDATJRA99WG5RzMoyxLrg3mizxx6p
	TgA==
X-Google-Smtp-Source: AGHT+IHAW0GcwvXl7ty+h3b4veLMGBLsR+JYhHrZjaoUwLnx5kWFpxkZrOKkIVQntygOusU16/Q3kY2Eds4=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:690c:c0d:b0:609:3834:e0f4 with SMTP id
 cl13-20020a05690c0c0d00b006093834e0f4mr192674ywb.7.1709170178031; Wed, 28 Feb
 2024 17:29:38 -0800 (PST)
Date: Thu, 29 Feb 2024 01:28:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229012858.3663833-1-jthies@google.com>
Subject: [PATCH v3 0/4] usb: typec: ucsi: Expand SOP/SOP' Discovery
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

Changes in v3:
- Fixed CC stable.

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

 drivers/usb/typec/ucsi/ucsi.c | 258 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  40 +++++-
 2 files changed, 296 insertions(+), 2 deletions(-)


base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
-- 
2.44.0.rc1.240.g4c46232300-goog


