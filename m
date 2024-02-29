Return-Path: <linux-kernel+bounces-87689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3CB86D7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A01284AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E73975815;
	Thu, 29 Feb 2024 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpoBlpQY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0923FBA6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709249253; cv=none; b=sl0C0+HF9WrGf7CHBY5vQITs0vdMSqFOAlFL4kSil2O6T3bBdUzSdjvGktEHzLs+UwN/w7v6HzjYIyIBqOCm8AK+4yc3zABrrpFRD1mPUOfmLJVEkMplDyRBvrQqRm9ZzUf86V/VdkMyNIbmhEkbYAq3UYbospv1lqh4is2NURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709249253; c=relaxed/simple;
	bh=ISWg/oe1f8dYAZu6cHD2G2F1GdLrz/na84uCJb+byxE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oIV56mt+k/sK7lIRQXsebXeOLISaAwXVOtOugT58bTU1AYRdeu2Y+ne38PhNY0RvPgKpFqFgZs4YYLAvAUyNelBIbxniCCc7a8gYEtvkaihubsl0LNS9TUtSsNz1zDqfgwsbt2I04gLqu5zkV0PoQHTQNjtvJBYgEMEUVMLaXxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpoBlpQY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ab197437so24626717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709249251; x=1709854051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsUgvdSeCrdxpdzq+m+mUZROesc9NAMn0iliKNmZmmk=;
        b=LpoBlpQYOLM3nEjDv/J5FLsrJ/f8X1Vq6n9dDcDTLIjS2W4Q8beGnJGWqx/mgHEWkW
         NgMqIGUuaQhyDZy1wInsD2ds6GqeLu2NVM2Sz6y2GPrrXfXjTeohBAAmKZ/NZBA7N+/V
         0y9JFDuPZAvA9bDr74bQTGlRAbaJ5qw7SVNAlFaYNmfAWxKt/D0zrabGqxAehfAEuDVL
         Q3uIACvpkueUpXC5gpt302p+AdYCaOB82iMx2tJc7sFCYUyDThWMQyCj0sSUfousDEpd
         IqWVpMFkR8MKenFEAB+VeduWTiBzKKZeZeL55JkvJhngcp7p+AiUXFYSBZW/9yfF2cyt
         14qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709249251; x=1709854051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsUgvdSeCrdxpdzq+m+mUZROesc9NAMn0iliKNmZmmk=;
        b=UEwOFwgiAXA+GVaXZX+yd7oEMN+T6rhqUT2V+0aw6XBuAxwQ3v4AqG1ehhUF2bsfhl
         37XjafE+XRy0Z63WGkq5WFBt0vruoJu97/Z21tZGdLsyG375gLlzgBpwzAdg4ZNiGbHk
         0jUZyA1/Axmv0199ldgW1a7ou1aAFwGQdSLXcx1nEyZ6IrQswXkaBdc+E+KpNeLBW5gb
         vrOPDg4VX3/ZcB8FsyDwD6qj5tMzHkZUW0d56Spe/4YJkTRX8FYHQkmMb8pVMKIe+Sor
         c2KkvxV7IvswTvxM58Fs669vz9Mv3Ly4PCRB2qudmcssR0thKpAVydEZzyRtWcXlJZ7o
         hOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUBhf5uK5nhKUAWxU4q6Sr9G86R0YVCMuI1ohjEZ06hvs3h9y6kGaUkI0eebgSVHPryDgRA2MmwUVtI15F7JbOInUV1xJdKg/925TSs
X-Gm-Message-State: AOJu0Yw9ont1cE3/X3e96I3tU3MA/RwCks2oWESrEW//AQtL2SW+nlJL
	AzGu1fh1I3zwwOTK8eSpVU7cleH0t+/n2tI1sCo1aOacAOLS3iMrzNNn0Ni7ITj4R6xGuEkrYbI
	Fjg==
X-Google-Smtp-Source: AGHT+IFbr/yyESjYNWBhyBP1Aw6rOlKUH20ZERsV3gNR227qqI5UhWNFECb0Gg9Z93sjFCCObyBryMiIMFM=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a05:6902:100d:b0:dc7:5aad:8965 with SMTP id
 w13-20020a056902100d00b00dc75aad8965mr950831ybt.0.1709249251470; Thu, 29 Feb
 2024 15:27:31 -0800 (PST)
Date: Thu, 29 Feb 2024 23:26:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229232625.3944115-1-jthies@google.com>
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

 drivers/usb/typec/ucsi/ucsi.c | 258 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h |  40 +++++-
 2 files changed, 296 insertions(+), 2 deletions(-)


base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
-- 
2.44.0.rc1.240.g4c46232300-goog


