Return-Path: <linux-kernel+bounces-58637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E484E933
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A29C1F30288
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41C38394;
	Thu,  8 Feb 2024 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lY5zrXFe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15911381C8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422195; cv=none; b=nx3axjQ6zHHZ76mipcEknkG4LFojMqiVUs347YOW8bT5Ak4kRjb7/N8cS2PxBgbhQIZd0bo1Fhau2DM9O328Or6aEr5gm7tltJdVMSkI4nOcarIllZctQa+/Ql58eZMiiUmFM6gIoAhfheaNfiq+HAkexIlxD+MqC7tUQ3obZF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422195; c=relaxed/simple;
	bh=S+nef6BW4eUAN+y4fvovGg6BjjxT7V8KN4eL+oI6qoE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Oh3saGiv09dKEKP6wHORDktOuH4x+DXpob3Xor1Se1PIxAqHQPM8qxLkAln0yP3OIlBNsdi0HhEyJgI9JzS3pplRX+L3Wb+Rl+QwNfSjHNqMZKseVsVVYIcFuO4QLm4zCF1WWRVXjTRd8A+k+C2BKtUykeOflIUOZPRa4bl0Mkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lY5zrXFe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603cbb4f06dso4950307b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707422193; x=1708026993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OOleo//MfjGDgS1GOiwnSqETbwNldE5AFFRWOVg3YKQ=;
        b=lY5zrXFeuGzoS1mERCmWRyIqxSaP4DezPfh5HgWKtHpQpoHD5tqINSsdMUX7pFNUWc
         XIeY/4SK043WYoN+rNneAgu2HoUvZLK9CLsCG2Q7CN9OxzsmXSn92wkIU8dFqG/QOjdA
         UXu89R2ftFTp7m5P5MvQMshQ7mGGGyooR13ZEe+4qFWxHIlN13lZm5QIf5o2rh1pvmMd
         eRhZHHdrpyF870DX5KjW1AWi262EmVwA6Iz1NNBKJSFEmYBq0ewiybhux6e8NPBo12kD
         EKscB+E2Yn+0mBZi/oasJBY3hOQlRGL4kcSURyOc/y5FaqfwaeWOwySUtSsxPzkwofX8
         B2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707422193; x=1708026993;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOleo//MfjGDgS1GOiwnSqETbwNldE5AFFRWOVg3YKQ=;
        b=TTcR9RggOO7N8n2e49icBYC5u4oii3Wg0EZ/PhI14KII1386O7C9tDxZgsZeXe3buJ
         bUiSN/dr6k2YB666t/weimqiwsLzpwSCiWJlyfjLg0EJ6bzeEjNP8xptzdqEpemmrI5Y
         n1bCG8B5QTCkaKG/hDkfZQAZf0X5J9MS7z79uLSG372heOD4RRvYqsqBbE0EGAAgxV0F
         /oIPjjCrlt8IFuePz3alQzILCzABZNnsAh5CVMOSkUssUrfvW+6qdhK0e32JGUTt61Gj
         BNP9YPKXvzDOvgUV5RgN345QrP53NkUI1JkdK5H0FAOrE7eYFqwFnrHwXOVrzBCDz1xU
         XChQ==
X-Gm-Message-State: AOJu0YyFJWA9TCByPzHrekqM20U2aj0qVEvKM7TvqVqJabWNGMLC/ZK9
	8oB4DJ7RbeYE9f+fDdwBC4ebKTZReVpfoDp/BP326HCeUQZzIH5Wr3TDrksQXGi292agONCXTOu
	pM6Ksa3SYug==
X-Google-Smtp-Source: AGHT+IEDtyllxSQ5oXK2OSS+ogL5bGMHhgSMOjUEKukTnJdIU1KZS70X4AgDSph5UECU7bn0H7BCyM77iH/j6Q==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a05:690c:e1e:b0:602:d398:5176 with SMTP
 id cp30-20020a05690c0e1e00b00602d3985176mr90276ywb.4.1707422192989; Thu, 08
 Feb 2024 11:56:32 -0800 (PST)
Date: Thu,  8 Feb 2024 19:56:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240208195622.758765-1-pranavpp@google.com>
Subject: [PATCH v2 0/2] alarmtimer: Rework the suspend flow in alarmtimer
From: Pranav Prasad <pranavpp@google.com>
To: tglx@linutronix.de, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, 
	Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

During the driver suspend phase of kernel suspend, alarmtimer's suspend
callback is invoked and it identifies the earliest next wakeup alarm and
programs that into the HW real time clock (RTC). However, there is an
exception to this process. If the next alarm is within the next 2 seconds,
the alarmtimer driver fails to suspend. In this case, a non-trivial amount
of power is spent to freeze and unfreeze all userspace processes and to
suspend and resume a number of devices. In the vast majority of cases, the
imminent alarm that caused the failure was likely already scheduled before
suspend even started. This provides an opportunity to reduce power
consumption if the suspend failure decision is made earlier in the suspend
flow, before the unnecessary extra work is done.

This patch series aims to achieve a kernel suspend flow in which the check
for an imminent alarm is performed early during the suspend prepare phase.

Changes from v1:

- Moved the pm_wakeup_event call to the PM notifier
- Added a check for RTC device in the PM notifier

Pranav Prasad (2):
  alarmtimer: Create alarmtimer sysfs to make duration of kernel suspend
    check configurable
  alarmtimer: Modify alarmtimer suspend callback to check for imminent
    alarm using PM notifier

 kernel/time/alarmtimer.c | 183 ++++++++++++++++++++++++++++++---------
 1 file changed, 143 insertions(+), 40 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


