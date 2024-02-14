Return-Path: <linux-kernel+bounces-64969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F1854543
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701931C27A6D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456E12E41;
	Wed, 14 Feb 2024 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhV9QM6Z"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764E0171AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903015; cv=none; b=jGRtXUL//I+wpKXsK3nJNq109QQYR8OfDsX+CfYfuFPD6/UywY0ASuswQawzZWIJZzOl9Da0agbdHbsw/ar2MRQqVwV2j1ZWsxIVKt9yTfpPlXDbq4Gnq3S2F0ILDWBJTgfHUx02GXAH8YwNMBlVZWwtHaeckqe8VS11eZAMnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903015; c=relaxed/simple;
	bh=MZXc/+oEg/fprLTqq3So8SjUVzpTcPO4Doree43jGjc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KHcaOgO9SZ7FOBjzh7Csoql/+SnfEZXff0XeENiZDrsN7leQQkB71qPPm2SuHEl59fEfw0vHYZ8AkvcrojuSMKKTm8/bxl8kdbu6TuqHOCtkTJB7F5Usz8uI5rX5U5CyK/gBnn50RLRW1WSV2Kfjd55RI0ssb6PjT7qmkJDWJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VhV9QM6Z; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pranavpp.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-296f78bdb40so5374348a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707903014; x=1708507814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mma7wfUNF3QcF2/p2Wj8oZ4dYl748XCEjPWFOwBXlAc=;
        b=VhV9QM6ZO8Ts8KYK1gtL1nLchEU2B5loY/O0XscC8dJmHCjANqOx61cHuDyWGggptv
         Ozgc3Q8juYncUaokDuBtiQgWw1M4s3Tp32eod4vcYlfrXtHwCSVImEyqAK2zLFeDWyf5
         0eDkAkgLUr8p+XCaycGFN16KqUVrzGIoT0GyO4qTotUn17A43qEp4NjNo6+Oo55weFNT
         t85s5mPaeniGNGpTJ1GOljUs+DhXj+01XrRL6GZs3b6buptLMRuCmvJFFPIR0owPy8qz
         Xn9qQZNJBmhs8y5Ol20NrGRRPE3zXiFGGON+IR6Kwks/9iVtdyWA8qJffO3mAW1vBySy
         Hv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903014; x=1708507814;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mma7wfUNF3QcF2/p2Wj8oZ4dYl748XCEjPWFOwBXlAc=;
        b=lICZcZE6/gC/mx1Il+TadNjnAh+t40wP9AUmKriiox+zDVEyMkbPBncbk2d4/a0TAR
         iv/sXW1stvX+lGICnuEyGPUxRQivNptnpB+cD9ameQLlRWYza1c5rF1T44U90b2yxla1
         wiVJCvjxcbZKsLjPKmVRBHuw8wi7tdImy/z2EQ6NfhJB/fa1itAGuaog2V3oH7WPrYab
         wXKr6FUXn9YmG39n55mivGe020MzWWtXW4h68TcazrYPcCX2T+97byeXpckUDuRLMKJG
         ZrIciA/puNFS+ZbxfV//Nm2+kZAH1qLU3e2hsFIsydOYT7oIIJ+U5Oz7KK771PQAVdGe
         d1yQ==
X-Gm-Message-State: AOJu0YxtglrYrzRZH89NIXM4aPuj9awb17ZITDhfTElDDY3gcpd4r9wV
	ITaOSA4psg6wNeJQzXNao+M5ETzNCNg/hk7chKLjOQJDetJbTfxG4DSwwYNSaOSUqNngfgf388k
	cxAF/UlMq3w==
X-Google-Smtp-Source: AGHT+IGRKESMA0B0TRhzFdh10tIyCqIc3D8jr37bx5O6YOpfxPPYiE9sIs7cfsFqXftIWqHEZSuF35lDARhwuw==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a17:90b:5288:b0:295:efdc:6abc with SMTP
 id si8-20020a17090b528800b00295efdc6abcmr23368pjb.5.1707903013898; Wed, 14
 Feb 2024 01:30:13 -0800 (PST)
Date: Wed, 14 Feb 2024 09:29:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240214092902.1908443-1-pranavpp@google.com>
Subject: [PATCH v3 0/2] alarmtimer: Rework the suspend flow in alarmtimer
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

Changes in v3 from v2:

- Reversed the order of patches
- Formatted variable declarations
- Moved the RTC device check out of alarmtimer_get_soonest()
- Reinstated the check for pending alarm in alarmtimer_suspend()

Changes in v2 from v1:

- Moved the pm_wakeup_event call to the PM notifier
- Added a check for RTC device in the PM notifier

Pranav Prasad (2):
  alarmtimer: Add PM notifier to check early for imminent alarm
  alarmtimer: Create sysfs to make alarm check window configurable

 kernel/time/alarmtimer.c | 164 +++++++++++++++++++++++++++++++++------
 1 file changed, 140 insertions(+), 24 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


