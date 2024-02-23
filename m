Return-Path: <linux-kernel+bounces-77600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D238607F5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2DE81C20FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EB3946C;
	Fri, 23 Feb 2024 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTTfxjb9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25B3236
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650289; cv=none; b=Ijh5FSrvUFHqcIoxwGnNoyYWcSGu2uiXRXviRp7Ie2YSJ2DAt4ZQ64VoN8/iWFDBKjJslLX4P+ALyz64nGcOnkMkgaZCO/zVL4hB95U1i4sGuzJslfnsxsENXNDhqsB7qPkjIH2wZMgsmAnLBLRkfntvYvfrDi54H8WGqHT8K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650289; c=relaxed/simple;
	bh=nvAuz9UzgKoncPeSdokbrQXILRb6mH2TQsf+GAANErY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BqZpCGtUoRTtU882CEpugFGCcvo+IhfeiUpgWrXIfPjp1Jnby8qwK2oEKNjjNeWnhhW144Ay2GlI1rE4pO60ZDGRo7fav5wLFbaU2jG/4S6nNgGJVjgV9/R1F6tFN1YJDPPhyJIGqV/r19Gk2L6/d8hjlVXo+foeMxEsK1VN3rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTTfxjb9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso662136276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708650287; x=1709255087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecR9Yq2XGMBdsPqm9MOr3GK/cKUBzc4WS3OoSv0tI2U=;
        b=UTTfxjb9nM4EulgwvEI0eP85eJzeV9/bqJBeRDRbA29SBm/B96y0EVtQn3BRWxpya6
         1srwyu/zxQp5fETQT/LlJGXCKYju0N1GREtz5frbg2ZJyibrjAjR9iv4rt4FdY4Z3suy
         +NpMMU+61OOxVyTfX+fxA/VYWYvf5LysQ0vgEi8iRj94E9KkhzNZtYuyZeA3aPtZ8bMG
         DZ4E+CG3t+9lOV46ihkqfKa+reB4t9LHzagI3MOCj5PNtlvSsaE9rt0jIWpX4xHCfw+R
         1R77GIpNzLbdkBbnMRB+rwhdEeashIkrn7G7nkZY2cB7m6mxK2A9eUl+CIg/kkO3OzPY
         9JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708650287; x=1709255087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecR9Yq2XGMBdsPqm9MOr3GK/cKUBzc4WS3OoSv0tI2U=;
        b=cFO3341t+1Gz4+33q01BHUwU7O6tg4cG0W/zl+Y3TFXzDlCSoo/1AJD167yX7zm7fX
         jtEmnzl0Gk5+AQlaWv+qoiz+nSOzfc+cl29GEhbbd+GBprg90mPtVEfE92yzu4Qrx/5Q
         hu9KG+GF1l3U9xXSi44+TXytef+1W71TYnGzksbz9DaoVMrgFeaky3HvXbPso+fas1Yr
         Yu7HkrfOXIPDuluZnQKhJlM5iVxQn9DQ+8jZ46Gq7rHbUHTqD87W8E98AHSY9429rVWc
         BNptlYnEQwbSQon/qf4q1slSji6IVJgipMXkzC6mrnHNCr8gbc+bQZvIRL3cE/5Pb81m
         oKXA==
X-Forwarded-Encrypted: i=1; AJvYcCXodWvmY/ixsSw74L33kM98D4oXwsoF+hfy7PFBfA+ymguICVtXZVcJo0ndEn7E5HnbroXia9tJr964q+/qG/OF476sMVv36hSHjCdB
X-Gm-Message-State: AOJu0Yxhl86LY1XseLRK1EFTeCajHAiInPuIjZmhBM+z+kF0Q/jNbe97
	Tz+2bGH5jY03Ly5HcvZFUPCicSxhboSJRpRKxtOSS9vGmayKZsrvcQho+d7X+UA04m0Ds3oRH6T
	aPg==
X-Google-Smtp-Source: AGHT+IG+i/pZMbkDJkdAV+U/Yo9AGXeegjARexK6Pjm6uLvStHaCI/FpK5AuUCsjtdaUVtBx5gYYkRSwCY8=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:6085:0:b0:dc7:9218:df47 with SMTP id
 u127-20020a256085000000b00dc79218df47mr214908ybb.5.1708650287345; Thu, 22 Feb
 2024 17:04:47 -0800 (PST)
Date: Fri, 23 Feb 2024 01:03:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223010328.2826774-1-jthies@google.com>
Subject: [PATCH 0/4] usb: typec: ucsi: Expand SOP/SOP' Discovery
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

These have been tested on a v6.6 kernel build running a usermode ppm
with a Realtek EVB. Let me know if you have any questions.

Thanks,
Jameson

Jameson Thies (4):
  usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
  usb: typec: ucsi: Register cables based on GET_CABLE_PROPERTY
  usb: typec: ucsi: Register SOP/SOP' Discover Identity Responses
  usb: typec: ucsi: Register SOP' alternate modes with cable plug

 drivers/usb/typec/ucsi/ucsi.c | 206 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  40 ++++++-
 2 files changed, 244 insertions(+), 2 deletions(-)


base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
-- 
2.44.0.rc0.258.g7320e95886-goog


