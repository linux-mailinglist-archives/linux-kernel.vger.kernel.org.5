Return-Path: <linux-kernel+bounces-151966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FC8AB653
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48721F21415
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E27E56C;
	Fri, 19 Apr 2024 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojdTzgMg"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343F92B9DF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713561420; cv=none; b=L298NoF+HLBgf1T624gnHBGLdiPKRVgRgA7UxEjyx8PeJwYZ0OTpb8cNmcCh0ZgYzL5SLHC2lkEwoddxNl5m9hfrSMcH8lARr7oPE9qwnxUgj697tQxg+A2A1Sp7VauRqo4G5xQpX0ARNmKny8g0V4EWlcPWg6pd6xf2zGsXEAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713561420; c=relaxed/simple;
	bh=bJMl96BXd7Fcmqs2yLxX7XV6jZ8I2SETuRHX5I79h/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ni1QzThQ+RdbHX+dZ8EZQNf6AwilbI+OQLd/VupHeDRdwxKpprxlGA87qsuZNxlHOU1qDNQQAl4QoyaKzEnxb3wyeaEiuPAiywgOR0haFw5vDt+ojNs55O82eJGporLVe4t49rOxNybCiZ6vkYuaBapjYNOvu54moCUMlvvUNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojdTzgMg; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so4366509276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713561418; x=1714166218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jfW324GVea+1ib21HzTSsw48Lyt5jRPQcBMMMk4fg5o=;
        b=ojdTzgMgNMfQHPyN1Fr9v+PGXjZYEFEuw7QV2MOPaZ6EuOTilndbFk1kY6U4l1C+qt
         umQWsLGi84eZ9SRrBvQacg+PlVcPm9EoK14436T7D0axb2hRkllZvEmsnerp41UgV3xp
         EIhX+SXIYxtI+zOhYyw7JZlQUAh9cgj7ejTrigJwSjLC+Omi/w0y1eaWuGnWcUpUDRFE
         tIJjLS1nNapmqqd59AZ0lobjgY3AhXbpx6tjatcjrxhEWXVCMj3i4YX03K+33yuedX7+
         5XDJKmNLULX5GLmui/1wpNVoXlfFGJGwWRlBzNYngXmpdSCWSTp0chVRw7G7JfNdaW/h
         oEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713561418; x=1714166218;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jfW324GVea+1ib21HzTSsw48Lyt5jRPQcBMMMk4fg5o=;
        b=OOXauXqYyvUGsyhvVpW3thcHzxWfQx/VdJKVrIsSYbA5meyIZ43I1WXFULR8tlLFMl
         ySZLbIyh+r5NOoJhzZ1n08bS4ExTPbgd5JkEk9lez26Pqs0Yzk28qahUYddXDU1AAuOZ
         rAZqg+OsdqI48ZmCeXfdnY3qrSzLBIAQapgwdqNYB3dTbZ48M1tcbOZ+eBpjmeh7X/yq
         Os9ZHObGkIATSbernN8/7S0pkONWvBZK2TiMG2jcaA81Mg1UYJXelkfMtEVo3pdF8YD7
         ScgjMArtJmDYFYOd3owj5vn4+hOQ7H3sIWbkYd3+V99IlWCN624tNkrmc0T9pIvuX0PC
         zF0A==
X-Forwarded-Encrypted: i=1; AJvYcCWEE6wpYdrqozl1qtZ3gBnzhnwy2YH2SjzVXbQxvgbiLNBosjLEAh1OgCAH2rE+/ElPC2lUFSBu35Po0DdvPPwLtiUYeKZpH7dyrysw
X-Gm-Message-State: AOJu0Yw5gNV19jN+rfx4E2hGkM0eFxZQ/VnJGzl8TS5z8PFmpuR9iK4h
	3pG+GoCU+hzlHohdFngx1zARSFqn7l+8s2qNMcCvVS7FO/jkVF3wMpdCW8Ajls2lv9wXIlDNjG4
	50g==
X-Google-Smtp-Source: AGHT+IGAINjRLDY/NhYxY44MhrmawjhbwznQN2FlhlwcGn+GJxcFB+KKhotvf1x8ZknWYc19PfSQHkwXg3E=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:1884:b0:dc6:b813:5813 with SMTP id
 cj4-20020a056902188400b00dc6b8135813mr264420ybb.9.1713561418084; Fri, 19 Apr
 2024 14:16:58 -0700 (PDT)
Date: Fri, 19 Apr 2024 21:16:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419211650.2657096-1-jthies@google.com>
Subject: [PATCH v1 0/4] usb: typec: ucsi: Update UCSI alternate mode
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

Abhishek Pandit-Subedi (2):
  usb: typec: ucsi: Fix null deref in trace
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


base-commit: 684e9f5f97eb4b7831298ffad140d5c1d426ff27
-- 
2.44.0.769.g3c40516874-goog


